package org.jeecgframework.web.cgform.controller.generate;

import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.jeecgframework.codegenerate.database.JeecgReadTable;
import org.jeecgframework.codegenerate.generate.CgformCodeGenerate;
import org.jeecgframework.codegenerate.generate.onetomany.CgformCodeGenerateOneToMany;
import org.jeecgframework.codegenerate.pojo.CreateFileProperty;
import org.jeecgframework.codegenerate.pojo.onetomany.CodeParamEntity;
import org.jeecgframework.codegenerate.pojo.onetomany.SubTableEntity;
import org.jeecgframework.codegenerate.util.CodeResourceUtil;
import org.jeecgframework.codegenerate.util.CodeStringUtils;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.enums.OnlineGenerateEnum;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.cgform.entity.button.CgformButtonEntity;
import org.jeecgframework.web.cgform.entity.button.CgformButtonSqlEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormFieldEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.entity.enhance.CgformEnhanceJavaEntity;
import org.jeecgframework.web.cgform.entity.enhance.CgformEnhanceJsEntity;
import org.jeecgframework.web.cgform.entity.generate.GenerateEntity;
import org.jeecgframework.web.cgform.entity.generate.GenerateSubListEntity;
import org.jeecgframework.web.cgform.service.build.DataBaseService;
import org.jeecgframework.web.cgform.service.button.CgformButtonServiceI;
import org.jeecgframework.web.cgform.service.button.CgformButtonSqlServiceI;
import org.jeecgframework.web.cgform.service.config.CgFormFieldServiceI;
import org.jeecgframework.web.cgform.service.enhance.CgformEnhanceJsServiceI;
import org.jeecgframework.web.cgform.service.impl.generate.TempletContextWord;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/**
 * 
 * @Title:CgGenerateController
 * @description:智能表单代码生成器[根据智能表单配置+代码生成设置->生成代码]
 * @author 赵俊夫
 * @date Sep 7, 2013 12:19:32 PM
 * @version V1.0
 */
@Controller
@RequestMapping("/generateController")
public class GenerateController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(GenerateController.class);
	
	@Autowired
	private CgFormFieldServiceI cgFormFieldService;
	@Autowired
	private CgformButtonServiceI cgformButtonService;
	@Autowired
	private CgformButtonSqlServiceI cgformButtonSqlService;
	@Autowired
	private CgformEnhanceJsServiceI cgformEnhanceJsService;
	@Autowired
	private TempletContextWord templetContextWord;
	@Autowired
	private DataBaseService dataBaseService;
	/**
	 * 代码生成配置页面
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "gogenerate")
	public ModelAndView gogenerate( CgFormHeadEntity cgFormHead,HttpServletRequest request) {
		if (StringUtil.isNotEmpty(cgFormHead.getId())) {
			cgFormHead = cgFormFieldService.getEntity(
					CgFormHeadEntity.class, cgFormHead.getId());
		}else{
			throw new RuntimeException("表单配置不存在");
		}
		String returnModelAndView = null;
		Map<String,String> entityNameMap = new HashMap<String,String>(0);
		if(cgFormHead.getJformType()==1 || cgFormHead.getJformType()==3){
			//如果是单表或者附表，则进入单表模型
			request.setAttribute("jspModeList", getOnlineGenerateEnum("single"));// 表单风格
			returnModelAndView = "jeecg/cgform/generate/single";
		}else{
			//如果是主表，则进入一对多模型
			List<CgFormHeadEntity> subTableList = new ArrayList<CgFormHeadEntity>();
			if(StringUtil.isNotEmpty(cgFormHead.getSubTableStr())){
				String[] subTables = cgFormHead.getSubTableStr().split(",");
				for(String subTable :subTables){
					CgFormHeadEntity subHead = cgFormFieldService.getCgFormHeadByTableName(subTable);
					subTableList.add(subHead);
					entityNameMap.put(subHead.getTableName(), JeecgReadTable.formatFieldCapital(subHead.getTableName()));
				}
			}
			request.setAttribute("jspModeList", getOnlineGenerateEnum("onetomany"));// 表单风格
			request.setAttribute("subTableList", subTableList);
			returnModelAndView = "jeecg/cgform/generate/one2many";
		}
		String projectPath = CodeResourceUtil.getProject_path();
		try{
		    Cookie[] cookies=request.getCookies();
		    if(cookies!=null){
		    for(int i=0;i<cookies.length;i++){
		        if(cookies[i].getName().equals("cookie_projectPath")){
		        String value =  cookies[i].getValue();
		        if(value!=null&&!"".equals(value)){
		        	projectPath=cookies[i].getValue();
		        	projectPath= URLDecoder.decode(projectPath, "UTF-8"); 
		            }
		         }
		        request.setAttribute("projectPath",projectPath);
		    }
		    }
		}catch(Exception e){
		    e.printStackTrace();
		}
		String entityName = JeecgReadTable.formatFieldCapital(cgFormHead.getTableName());
		entityNameMap.put(cgFormHead.getTableName(), entityName);
		request.setAttribute("cgFormHeadPage", cgFormHead);
		request.setAttribute("entityNames",entityNameMap );
		return new ModelAndView(returnModelAndView);
	}
	
	private List<OnlineGenerateEnum> getOnlineGenerateEnum(String type){
		List<OnlineGenerateEnum> list = new ArrayList<OnlineGenerateEnum>();
		for(OnlineGenerateEnum item : OnlineGenerateEnum.values()) {
			if(item.getFormType().equals(type)) {
				list.add(item);
			}
		}
		return list;
	}
	/**
	 * 代码生成执行-单表
	 * @param generateEntity
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	@RequestMapping(params = "dogenerate")
	public void dogenerate(CgFormHeadEntity cgFormHead,GenerateEntity generateEntity,CreateFileProperty createFileProperty,
			HttpServletRequest request,HttpServletResponse response) throws Exception {
		//step.1 准备好智能表单的配置
		if (StringUtil.isNotEmpty(cgFormHead.getId())) {
			cgFormHead = cgFormFieldService.getEntity(
					CgFormHeadEntity.class, cgFormHead.getId());
			getCgformConfig(cgFormHead, generateEntity);
		}else{
			throw new RuntimeException("表单配置不存在");
		}
		AjaxJson j =  new AjaxJson();
		String tableName = generateEntity.getTableName();
		String ftlDescription = generateEntity.getFtlDescription();
		try {
			//step.2 判断表是否存在
			boolean tableexist = new JeecgReadTable().checkTableExist(tableName);
			if(tableexist){

				OnlineGenerateEnum modeEnum = OnlineGenerateEnum.toEnum(createFileProperty.getJspMode());
				if(modeEnum!=null){
					if("system".equals(modeEnum.getVersion())){

						//step.3 判断是不是用用户自定义界面
						CgformCodeGenerate generate = new CgformCodeGenerate(createFileProperty,generateEntity);
						if(createFileProperty.getJspMode().equals("04")){
							String formhtml = templetContextWord.autoFormGenerateHtml(tableName, null, null);
							generate.setCgformJspHtml(formhtml);
						}

						//step.4 调用代码生成器
						generate.generateToFile();
					}else if("ext".equals(modeEnum.getVersion())){
						CgformCodeGenerate generate = new CgformCodeGenerate(createFileProperty,generateEntity);
						generate.generateToFileUserDefined();
					}
					j.setMsg(ftlDescription+"：功能生成成功，请刷新项目重启，菜单访问路径："+CodeStringUtils.getInitialSmall(generateEntity.getEntityName())+"Controller.do?list");
				}else{
					j.setMsg("代码生成器不支持该页面风格");
				}

			}else{
				j.setMsg("表["+tableName+"] 在数据库中，不存在");
			}
			
		} catch (Exception e1) {
			e1.printStackTrace();
			j.setMsg(e1.getMessage());
			throw new RuntimeException(e1.getMessage());
		}
		try {
			String projectPath = URLEncoder.encode(generateEntity.getProjectPath(), "UTF-8");
			Cookie cookie = new Cookie("cookie_projectPath",projectPath );				
			cookie.setMaxAge(60*60*24*30); //cookie 保存30天
			response.addCookie(cookie);
			response.getWriter().print(j.getJsonStr());
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				response.getWriter().close();
			} catch (Exception e2) {
			}
		}
	}
	
	
	
	
	/**
	 * 代码生成执行-一对多
	 * @param generateEntity
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "dogenerateOne2Many")
	@ResponseBody
	public void dogenerateOne2Many(CodeParamEntity codeParamEntityIn,GenerateSubListEntity subTableListEntity,String jspMode,HttpServletRequest request,HttpServletResponse response){
		AjaxJson j =  new AjaxJson();
		//step.1 设置主表
		//从前台获取：codeParamEntityIn
		//step.2 设置子表集合
		//从前台获取：subTabParamIn,并设置外键字段
		try{
			//step.3 填充主表的所有智能表单配置
			String mainTable = codeParamEntityIn.getTableName();
			//主表的智能表单配置
			GenerateEntity mainG = new GenerateEntity();
			mainG.setProjectPath(subTableListEntity.getProjectPath());
			mainG.setPackageStyle(subTableListEntity.getPackageStyle());
			CgFormHeadEntity mCgFormHead = cgFormFieldService.getCgFormHeadByTableName(mainTable);
			getCgformConfig(mCgFormHead, mainG);
			//step.4 填充子表的所有智能表单配置
			Map<String,GenerateEntity> subsG = new HashMap<String,GenerateEntity>();
			List<SubTableEntity>  subTabParamIn = subTableListEntity.getSubTabParamIn();
			for(SubTableEntity po:subTabParamIn){
				String sTableName = po.getTableName();
				CgFormHeadEntity cgSubHead = cgFormFieldService.getCgFormHeadByTableName(sTableName);
				List<CgFormFieldEntity> colums = cgSubHead.getColumns();
				String[] foreignKeys =getForeignkeys(colums);
				po.setForeignKeys(foreignKeys);
				GenerateEntity subG = new GenerateEntity();
				getCgformConfig(cgSubHead, subG);
				subG.setEntityName(po.getEntityName());
				subG.setEntityPackage(po.getEntityPackage());
				subG.setFieldRowNum(1);
				subG.setFtlDescription(po.getFtlDescription());
				subG.setForeignKeys(foreignKeys);
				subG.setTableName(po.getTableName());
				subG.setProjectPath(subTableListEntity.getProjectPath());
				subG.setPackageStyle(subTableListEntity.getPackageStyle());
				subsG.put(sTableName, subG);
			}
			codeParamEntityIn.setSubTabParam(subTabParamIn);

			OnlineGenerateEnum modeEnum = OnlineGenerateEnum.toEnum(jspMode);
			if(modeEnum!=null){
				if("system".equals(modeEnum.getVersion())){
					//step.5 一对多(父子表)数据模型,代码生成

					if("06".equals(jspMode)){
						CgformCodeGenerateOneToMany.oneToManyCreateBootstap(subTabParamIn, codeParamEntityIn,mainG,subsG);
					}else{
						CgformCodeGenerateOneToMany.oneToManyCreate(subTabParamIn, codeParamEntityIn,mainG,subsG);
					}

					//j.setMsg("成功生成增删改查->功能："+codeParamEntityIn.getFtlDescription());
				}else if("ext".equals(modeEnum.getVersion())){
					CgformCodeGenerateOneToMany.oneToManyCreateUserDefined(jspMode,subTabParamIn, codeParamEntityIn,mainG,subsG);
				}
				j.setMsg(codeParamEntityIn.getFtlDescription()+"：功能生成成功，请刷新项目重启，菜单访问路径："+CodeStringUtils.getInitialSmall(codeParamEntityIn.getEntityName())+"Controller.do?list");
			}else{
				j.setMsg("代码生成器不支持该页面风格");
			}

		}catch (Exception e) {
			e.printStackTrace();
			j.setMsg(e.getMessage());
			throw new RuntimeException(e.getMessage());
		}
		try {
			String projectPath = URLEncoder.encode(subTableListEntity.getProjectPath(), "UTF-8");
			Cookie cookie = new Cookie("cookie_projectPath",projectPath );						
			cookie.setMaxAge(60*60*24*30); //cookie 保存30天
			response.addCookie(cookie);
			response.getWriter().print(j.getJsonStr());
			response.getWriter().flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				response.getWriter().close();
			} catch (Exception e2) {
			}
		}
	}
	/**
	 * 获取智能表单中外键：根据是否设置了主表以及主表字段来判断
	 * @param colums
	 * @return
	 */
	private String[] getForeignkeys(List<CgFormFieldEntity> colums) {
		List<String> fs = new ArrayList<String>(0);
		for(CgFormFieldEntity c : colums){
			if(StringUtil.isNotEmpty(c.getMainTable()) && StringUtil.isNotEmpty(c.getMainField())){
				fs.add(c.getFieldName().toUpperCase());
			}
		}
		String[] foreignkeys = (String[]) fs.toArray(new String[fs.size()]);
		return foreignkeys;
	}
	/**
	 * 获取智能表单的所有配置
	 * @param cgFormHead
	 * @param generateEntity
	 * @throws Exception 
	 */
	private void getCgformConfig(CgFormHeadEntity cgFormHead,
			GenerateEntity generateEntity) throws Exception {
		int filedNums = cgFormHead.getColumns().size();
		List<CgformButtonEntity> buttons = null;
		Map<String, String[]> buttonSqlMap = new LinkedHashMap<String, String[]>();
		//表单配置
		cgFormHead = cgFormFieldService.getEntity(
				CgFormHeadEntity.class, cgFormHead.getId());
		//按钮配置
		buttons = cgformButtonService.getCgformButtonListByFormId(cgFormHead.getId());
		//按钮SQL增强
		for(CgformButtonEntity cb:buttons){
			CgformButtonSqlEntity cbs = cgformButtonSqlService.getCgformButtonSqlByCodeFormId(cb.getButtonCode(), cgFormHead.getId());
			buttonSqlMap.put(cb.getButtonCode(), cbs==null?new String[]{}:cbs.getCgbSqlStr().replaceAll("(\r\n|\r|\n|\n\r)", "").split(";"));
		}
		CgformButtonSqlEntity cbsAdd = cgformButtonSqlService.getCgformButtonSqlByCodeFormId("add", cgFormHead.getId());
		buttonSqlMap.put("add", cbsAdd==null?new String[]{}:cbsAdd.getCgbSqlStr().replaceAll("(\r\n|\r|\n|\n\r)", "").split(";"));
		CgformButtonSqlEntity cbsUpdate = cgformButtonSqlService.getCgformButtonSqlByCodeFormId("update", cgFormHead.getId());
		buttonSqlMap.put("update", cbsUpdate==null?new String[]{}:cbsUpdate.getCgbSqlStr().replaceAll("(\r\n|\r|\n|\n\r)", "").split(";"));
		CgformButtonSqlEntity cbsDelete = cgformButtonSqlService.getCgformButtonSqlByCodeFormId("delete", cgFormHead.getId());
		buttonSqlMap.put("delete", cbsDelete==null?new String[]{}:cbsDelete.getCgbSqlStr().replaceAll("(\r\n|\r|\n|\n\r)", "").split(";"));
		//按钮java增强
		Map<String, CgformEnhanceJavaEntity> buttonJavaMap = new LinkedHashMap<String, CgformEnhanceJavaEntity>();
		List<CgformEnhanceJavaEntity> javaList = dataBaseService.getCgformEnhanceJavaEntityByFormId(cgFormHead.getId());
		if(javaList!=null&&javaList.size()>0){
			for(CgformEnhanceJavaEntity e:javaList){
				if(StringUtil.isNotEmpty(e.getCgJavaValue())){
					buttonJavaMap.put(e.getButtonCode(), e);
				}
			}
		}
		
		//JS增强-列表
		CgformEnhanceJsEntity listJs = 	cgformEnhanceJsService.getCgformEnhanceJsByTypeFormId("list", cgFormHead.getId());
		CgformEnhanceJsEntity listJsCopy = null;
		try{
			listJsCopy = listJs.deepCopy();
		}catch (Exception e) {
			logger.debug(e.getMessage());
		}
		//JS增强-表单
		CgformEnhanceJsEntity formJs = 	cgformEnhanceJsService.getCgformEnhanceJsByTypeFormId("form", cgFormHead.getId());
		CgformEnhanceJsEntity formJsCopy = null;
		try{
			formJsCopy = formJs.deepCopy();
		}catch (Exception e) {
			logger.debug(e.getMessage());
		}
		//将js中带有online字段名的 转换成java命名
		for(CgFormFieldEntity field : cgFormHead.getColumns()){
			String fieldName = field.getFieldName();
			if(listJsCopy!=null){
				listJsCopy.setCgJsStr(listJsCopy.getCgJsStr().replace(fieldName, JeecgReadTable.formatField(fieldName)));
			}
			if(formJsCopy!=null){
				formJsCopy.setCgJsStr(formJsCopy.getCgJsStr().replace(fieldName, JeecgReadTable.formatField(fieldName)));
			}
			//online代码生成，popup对应的字典字段进行java命名转换
			if("popup".equals(field.getShowType()) && oConvertUtils.isNotEmpty(field.getDictField())){
				field.setDictField(oConvertUtils.camelNames(field.getDictField()));
			}
		}
		generateEntity.setButtons(buttons);
		generateEntity.setButtonSqlMap(buttonSqlMap);
		generateEntity.setButtonJavaMap(buttonJavaMap);
		generateEntity.setCgFormHead(cgFormHead);
		generateEntity.setListJs(listJsCopy);
		generateEntity.setFormJs(formJsCopy);
	}
	/**
	 * 跳转到文件夹目录树
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "goFileTree")
	public ModelAndView goFileTree(HttpServletRequest request) {
		return new ModelAndView("jeecg/cgform/generate/fileTree");
	}
	/**
	 * 返回子目录json
	 * @param parentNode
	 * @return
	 */
	@RequestMapping(params = "doExpandFileTree")
	@ResponseBody
	public Object doExpandFileTree(String parentNode){
		JSONArray fjson = new JSONArray();
		try{
			if(StringUtil.isEmpty(parentNode)){
				//返回磁盘驱动器根目录
				File[] roots = File.listRoots();
				for(File r:roots){
					JSONObject item = new JSONObject();
					item.put("id", r.getAbsolutePath());
					item.put("text", r.getPath());
					item.put("iconCls", "icon-folder");
					if(hasDirs(r)){
						item.put("state", "closed");
					}else{
						item.put("state", "open");
					}
					fjson.add(item);
				}
			}else{
				try {
					parentNode =  new String(parentNode.getBytes("ISO-8859-1"), "UTF-8");
				} catch (UnsupportedEncodingException e1) {
					e1.printStackTrace();
				}
				//返回子目录集
				File parent = new File(parentNode);
				File[] chs = parent.listFiles();
				for(File r:chs){
					JSONObject item = new JSONObject();
					if(r.isDirectory()){
						item.put("id", r.getAbsolutePath());
						item.put("text", r.getPath());
						if(hasDirs(r)){
							item.put("state", "closed");
						}else{
							item.put("state", "open");
						}
						fjson.add(item);
					}else{
						
					}
				}
			}
		}catch (Exception e) {
			e.printStackTrace();
			throw new RuntimeException("该文件夹不可选择");
		}
		return fjson;
	}
	private boolean hasDirs(File dir){
		try{
			if(dir.listFiles().length==0){
	//			item.put("state", "open");
				return false;
			}else{
	//			item.put("state", "closed");
				return true;
			}
		}catch (Exception e) {
			logger.info(e.getMessage());
			return false;
		}
	}
}
