package org.jeecgframework.web.cgform.controller.build;

import java.io.BufferedWriter;
import java.io.IOException;
import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.enums.SysThemesEnum;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.LogUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.SysThemesUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.cgform.common.CgAutoListConstant;
import org.jeecgframework.web.cgform.common.CommUtils;
import org.jeecgframework.web.cgform.engine.FreemarkerHelper;
import org.jeecgframework.web.cgform.engine.TempletContext;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.entity.template.CgformTemplateEntity;
import org.jeecgframework.web.cgform.entity.upload.CgUploadEntity;
import org.jeecgframework.web.cgform.exception.BusinessException;
import org.jeecgframework.web.cgform.service.build.DataBaseService;
import org.jeecgframework.web.cgform.service.config.CgFormFieldServiceI;
import org.jeecgframework.web.cgform.service.template.CgformTemplateServiceI;
import org.jeecgframework.web.cgform.util.TemplateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * @ClassName: formBuildController
 * @Description: 读取模板生成填报表单（添加、修改）-执行表单数据添加和修改操作
 * @author 周俊峰
 */
@Scope("prototype")
@Controller
@RequestMapping("/cgFormBuildController")
public class CgFormBuildController extends BaseController {
	private static final Logger logger = Logger.getLogger(CgFormBuildController.class);
	private String message;
	
	@Autowired
	private TempletContext templetContext;
	@Autowired
	private DataBaseService dataBaseService;
	@Autowired
	private CgformTemplateServiceI cgformTemplateService;
	@Autowired
	private CgFormFieldServiceI cgFormFieldService;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	//update-begin--Author:许国杰  Date:20151219 for：#813 【online表单】扩展出三个请求：独立的添加、查看、编辑请求，原来的保留
	@RequestMapping(params = "goAddFtlForm")
	public void goAddFtlForm(HttpServletRequest request,HttpServletResponse response) {
		 ftlForm(request,response);
	}
	@RequestMapping(params = "goUpdateFtlForm")
	public void goUpdateFtlForm(HttpServletRequest request,HttpServletResponse response) {
		 ftlForm(request,response);
	}
	@RequestMapping(params = "goDatilFtlForm")
	public void goDatilFtlForm(HttpServletRequest request,HttpServletResponse response) {
		 ftlForm(request,response);
	}
	//update-end--Author:许国杰  Date:20151219 for：#813 【online表单】扩展出三个请求：独立的添加、查看、编辑请求，原来的保留
	
	//add-start--Author:scott Date:20160301 for：online表单移动样式单独配置
	/**
	 * Online表单移动端，访问页面
	 */
	@RequestMapping(params = "mobileForm")
	public void mobileForm(HttpServletRequest request,HttpServletResponse response) {
		String tableName =request.getParameter("tableName");
		String sql = "select form_template_mobile from cgform_head where table_name = '"+tableName+"'";
		Map<String, Object> mp = cgFormFieldService.findOneForJdbc(sql);
		if(mp.containsKey("form_template_mobile") && oConvertUtils.isNotEmpty(mp.get("form_template_mobile"))){
			String urlTemplateName=request.getParameter("olstylecode");
			if(oConvertUtils.isEmpty(urlTemplateName)){
				request.setAttribute("olstylecode", mp.get("form_template_mobile").toString().trim());
			}
		}
		ftlForm(request,response);
	}
	//add-end--Author:scott Date:20160301 for：online表单移动样式单独配置
	
	/**
	 * form表单页面跳转
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "ftlForm")
	public void ftlForm(HttpServletRequest request,HttpServletResponse response) {
		try {
			long start = System.currentTimeMillis();
			String tableName =request.getParameter("tableName");
	        Map<String, Object> data = new HashMap<String, Object>();
	        String id = request.getParameter("id");
			//update-begin--Author:张忠亮  Date:20150707 for：online表单风格加入录入、编辑、列表、详情页面设置
			String mode=request.getParameter("mode");
			String templateName=tableName+"_";
			//update-begin--Author:张忠亮  Date:20151019 for：url中加入olstylecode 可指定风格
			TemplateUtil.TemplateType templateType=TemplateUtil.TemplateType.LIST;
			if(StringUtils.isBlank(id)){
				templateName+=TemplateUtil.TemplateType.ADD.getName();
				templateType=TemplateUtil.TemplateType.ADD;
			}else if("read".equals(mode)){
				templateName+=TemplateUtil.TemplateType.DETAIL.getName();
				templateType=TemplateUtil.TemplateType.DETAIL;
			}else{
				templateName+=TemplateUtil.TemplateType.UPDATE.getName();
				templateType=TemplateUtil.TemplateType.UPDATE;
			}
			//获取版本号
	        String version = cgFormFieldService.getCgFormVersionByTableName(tableName);
	        //装载表单配置
	    	Map configData = cgFormFieldService.getFtlFormConfig(tableName,version);
	    	data = new HashMap(configData);
	    	//如果该表是主表查出关联的附表
	    	CgFormHeadEntity head = (CgFormHeadEntity)data.get("head");
	        Map<String, Object> dataForm = new HashMap<String, Object>();
	        if(StringUtils.isNotEmpty(id)){
	        	dataForm = dataBaseService.findOneForJdbc(tableName, id);
	        }
	      //update-begin--Author:zhoujf  Date:20151223 for：恢复--------------------
	        Iterator it=dataForm.entrySet().iterator();
		    while(it.hasNext()){
		    	Map.Entry entry=(Map.Entry)it.next();
		        String ok=(String)entry.getKey();
		        Object ov=entry.getValue();
		        data.put(ok, ov);
		    }
	      //update-begin--Author:zhoujf  Date:20151223 for：恢复--------------------
	        Map<String, Object> tableData  = new HashMap<String, Object>();
	        //获取主表或单表表单数据
	        tableData.put(tableName, dataForm);
	        //获取附表表表单数据
	    	if(StringUtils.isNotEmpty(id)){
		    	if(head.getJformType()==CgAutoListConstant.JFORM_TYPE_MAIN_TALBE){
			    	String subTableStr = head.getSubTableStr();
			    	if(StringUtils.isNotEmpty(subTableStr)){
			    		 String [] subTables = subTableStr.split(",");
			    		 List<Map<String,Object>> subTableData = new ArrayList<Map<String,Object>>();
			    		 for(String subTable:subTables){
				    			subTableData = cgFormFieldService.getSubTableData(tableName,subTable,id);
				    			tableData.put(subTable, subTableData);
			    		 }
			    	}
		    	}
	    	}
	    	//装载单表/(主表和附表)表单数据
	    	data.put("data", tableData);
	    	data.put("id", id);
	    	//update-begin--Author:钟世云  Date:20150610 for：online支持树配置--------------------
	    	data.put("head", head);
			//update-end--Author:钟世云  Date:20150610 for：online支持树配置----------------------
	    	
	    	//页面样式js引用
	    	data.put(CgAutoListConstant.CONFIG_IFRAME, getHtmlHead(request));
	    	//装载附件信息数据
	    	pushFiles(data, id);
	    	pushImages(data, id);
			String content =null;
			response.setContentType("text/html;charset=utf-8");
			//update-begin--Author:张忠亮  Date:20151019 for：url中加入olstylecode 可指定风格
			String urlTemplateName = request.getParameter("olstylecode");
			//update-begin---author:scott---date:20160301-----for:online表单移动样式单独配置-----
			if(oConvertUtils.isEmpty(urlTemplateName)){
				urlTemplateName = (String) request.getAttribute("olstylecode");
			}
			//update-end---author:scott---date:20160301-----for:online表单移动样式单独配置-----
			
			if(StringUtils.isNotBlank(urlTemplateName)){
				data.put("this_olstylecode",urlTemplateName);
				LogUtil.info("-------------urlTemplateName-----------"+urlTemplateName);
				content=getUrlTemplate(urlTemplateName,templateType,data);
			}else{
				data.put("this_olstylecode",head.getFormTemplate());
				LogUtil.info("-------------formTemplate-----------"+head.getFormTemplate());
				content=getTableTemplate(templateName,request,data);
			}
			//update-end--Author:张忠亮  Date:20151019 for：url中加入olstylecode 可指定风格
			response.getWriter().print(content);
			long end = System.currentTimeMillis();
			logger.debug("自定义表单生成耗时："+(end-start)+" ms");
		} catch (IOException e) {
			e.printStackTrace();
		}

	}
//update-begin--Author:张忠亮  Date:20151020 for：url中加入olstylecode 可指定风格 代码优化
	/**
	 * 获取url指定模板
	 * @param templateName
	 * @param templateType
	 * @param dataMap
	 * @return
	 */
	private String getUrlTemplate(String templateName,TemplateUtil.TemplateType templateType,Map dataMap){
		String content=null;
		CgformTemplateEntity entity=cgformTemplateService.findByCode(templateName);
		if(entity!=null){
			FreemarkerHelper viewEngine = new FreemarkerHelper();
			//update-begin---author:scott---date:20160301-----for:解决传递stylecode解析模板报错问题-----
			dataMap.put("DictData", ApplicationContextUtil.getContext().getBean("dictDataTag"));
			//update-end---author:scott---date:20160301-----for:解决传递stylecode解析模板报错问题-----
			content = viewEngine.parseTemplate(TemplateUtil.getTempletPath(entity,0, templateType), dataMap);
		}
		return content;
	}

	/**
	 * 获取表配置中存储的风格模板
	 * @param templateName
	 * @param request
	 * @param data
	 * @return
	 */
	private String getTableTemplate(String templateName,HttpServletRequest request,Map data){
		StringWriter stringWriter = new StringWriter();
		BufferedWriter writer = new BufferedWriter(stringWriter);
		//update--begin-------author:scott------date:20151118----for:online表单缓存问题---------------
		String ftlVersion =request.getParameter("ftlVersion");
//		String ftlVersion = oConvertUtils.getString(data.get("version"));
		//update--begin-------author:scott------date:20151118----for:online表单缓存问题---------------
		Template template = templetContext.getTemplate(templateName, ftlVersion);
		try {
			//update-begin---author:scott---date:20150118-----for:修改linux时间格式不对问题-------------
			template.setDateTimeFormat("yyyy-MM-dd HH:mm:ss");  
			template.setDateFormat("yyyy-MM-dd");  
			template.setTimeFormat("HH:mm:ss");
			//update-end---author:scott---date:20150118-----for:修改linux时间格式不对问题---------------
			template.process(data, writer);
		} catch (TemplateException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return stringWriter.toString();
	}
//update-end--Author:张忠亮  Date:20151020 for：url中加入olstylecode 可指定风格 代码优化
	private String getHtmlHead(HttpServletRequest request){
		HttpSession session = ContextHolderUtils.getSession();
		String lang = (String)session.getAttribute("lang");
		StringBuilder sb= new StringBuilder("");
		SysThemesEnum sysThemesEnum = SysThemesUtil.getSysTheme(request);
		sb.append("<script type=\"text/javascript\" src=\"plug-in/jquery/jquery-1.8.3.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/dataformat.js\"></script>");
		sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"plug-in/accordion/css/accordion.css\">");
		sb.append(SysThemesUtil.getEasyUiTheme(sysThemesEnum));
		sb.append("<link rel=\"stylesheet\" href=\"plug-in/easyui/themes/icon.css\" type=\"text/css\"></link>");
		sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"plug-in/accordion/css/icons.css\">");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/easyui/jquery.easyui.min.1.3.2.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/easyui/locale/zh-cn.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/syUtil.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/My97DatePicker/WdatePicker.js\"></script>");
//		sb.append("<link rel=\"stylesheet\" href=\"plug-in/tools/css/common.css\" type=\"text/css\"></link>");
		//common.css
		sb.append(SysThemesUtil.getCommonTheme(sysThemesEnum));
//		sb.append("<script type=\"text/javascript\" src=\"plug-in/lhgDialog/lhgdialog.min.js\"></script>");
		sb.append(SysThemesUtil.getLhgdialogTheme(sysThemesEnum));
		sb.append(StringUtil.replace("<script type=\"text/javascript\" src=\"plug-in/tools/curdtools_{0}.js\"></script>", "{0}", lang));
		sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/easyuiextend.js\"></script>");
		sb.append(SysThemesUtil.getEasyUiMainTheme(sysThemesEnum));
		sb.append("<link rel=\"stylesheet\" href=\"plug-in/uploadify/css/uploadify.css\" type=\"text/css\"></link>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/uploadify/jquery.uploadify-3.1.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/Map.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/Validform/js/Validform_Datatype_zh-cn.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/Validform/js/datatype_zh-cn.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js\"></script>");
		//style.css
		sb.append(SysThemesUtil.getValidformStyleTheme(sysThemesEnum));
		//tablefrom.css
		sb.append(SysThemesUtil.getValidformTablefrom(sysThemesEnum));
		//umedit
		sb.append("<link rel=\"stylesheet\" href=\"plug-in/umeditor/themes/default/css/umeditor.css\" type=\"text/css\"></link>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/umeditor/umeditor.config.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/umeditor/umeditor.min.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/umeditor/lang/zh-cn/zh-cn.js\"></script>");
		
		return sb.toString();
	}
	
	/**
	 * 如果表单带有附件，则查询出来传递到页面
	 * @param data 传往页面的数据容器
	 * @param id 表单主键，用户查找附件数据
	 */
	private void pushFiles(Map<String, Object> data, String id) {
		List<CgUploadEntity> uploadBeans = cgFormFieldService.findByProperty(CgUploadEntity.class, "cgformId", id);
		List<Map<String,Object>> files = new ArrayList<Map<String,Object>>(0);
		for(CgUploadEntity b:uploadBeans){
			String title = b.getAttachmenttitle();//附件名
			String fileKey = b.getId();//附件主键
			String path = b.getRealpath();//附件路径
			String field = b.getCgformField();//表单中作为附件控件的字段
			Map<String, Object> file = new HashMap<String, Object>();
			file.put("title", title);
			file.put("fileKey", fileKey);
			file.put("path", path);
			file.put("field", field==null?"":field);
			files.add(file);
		}
		data.put("filesList", files);
	}
//update-start--Author: jg_huangxg  Date:20160113 for：TASK #824 【online开发】控件类型扩展增加一个图片类型 image
	/**
	 * 如果表单带有 附件(图片),则查询出来传递到页面
	 * @param data 传往页面的数据容器
	 * @param id 表单主键,用户查找附件数据
	 */
	private void pushImages(Map<String, Object> data, String id) {
		List<CgUploadEntity> uploadBeans = cgFormFieldService.findByProperty(CgUploadEntity.class, "cgformId", id);
		List<Map<String,Object>> images = new ArrayList<Map<String,Object>>(0);
		for(CgUploadEntity b:uploadBeans){
			String title = b.getAttachmenttitle();//附件名
			String fileKey = b.getId();//附件主键
			String path = b.getRealpath();//附件路径
			String field = b.getCgformField();//表单中作为附件控件的字段
			Map<String, Object> image = new HashMap<String, Object>();
			image.put("title", title);
			image.put("fileKey", fileKey);
			image.put("path", path);
			image.put("field", field==null?"":field);
			images.add(image);
		}
		data.put("imageList", images);
	}
//update-end--Author: jg_huangxg  Date:20160113 for：TASK #824 【online开发】控件类型扩展增加一个图片类型 image
	/**
	 * 保存或更新
	 * 
	 * @param jeecgDemo
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "saveOrUpdate")
	@ResponseBody
	public AjaxJson saveOrUpdate(HttpServletRequest request) throws Exception{
		AjaxJson j = new AjaxJson();
		Map data = request.getParameterMap();
		if(data!=null){
			data = CommUtils.mapConvert(data);
			String tableName = (String)data.get("tableName");
			String id = (String)data.get("id");
			//打印测试
		    Iterator it=data.entrySet().iterator();
		    while(it.hasNext()){
		    	Map.Entry entry=(Map.Entry)it.next();
		        Object ok=entry.getKey();
		        Object ov=entry.getValue()==null?"":entry.getValue();
		        logger.debug("name:"+ok.toString()+";value:"+ov.toString());
		    }
		    if(StringUtils.isEmpty(id)){
			    //消除不是表的字段
			    String [] filterName = {"tableName","saveOrUpdate"};
			    data = CommUtils.attributeMapFilter(data,filterName);
			    //保存数据库
			    try {
			    	Object pkValue = null;
			    	pkValue = dataBaseService.getPkValue(tableName);
			    	data.put("id", pkValue);
			    	//--author：luobaoli---------date:20150615--------for: 处理service层抛出的异常
			    	try {
						dataBaseService.insertTable(tableName, data);
						j.setSuccess(true);
						message = "业务提交成功";
			    	}catch (Exception e) {
			    		j.setSuccess(false);
						message = "业务提交失败";
			    	}
			    	//--author：luobaoli---------date:20150615--------for: 处理service层抛出的异常
				} catch (Exception e) {
					e.printStackTrace();
					j.setSuccess(false);
					message = e.getMessage();
				}
			}else{
				//消除不是表的字段
			    String [] filterName = {"tableName","saveOrUpdate","id"};
			    data = CommUtils.attributeMapFilter(data,filterName);
			    //更新数据库
			    try {
					int num = dataBaseService.updateTable(tableName, id, data);
					if (num>0) {
						j.setSuccess(true);
						message = "业务更新成功";
					}else {
						j.setSuccess(false);
						message = "业务更新失败";
					}
					
				} catch (Exception e) {
					e.printStackTrace();
					j.setSuccess(false);
					message = e.getMessage();
				}
			}
		}
		j.setMsg(message);
		j.setObj(data);
		return j;
	}
	
	
	
	/**
	 * 保存或更新
	 * 
	 * @param jeecgDemo
	 * @param request
	 * @return
	 * @throws Exception 
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "saveOrUpdateMore")
	@ResponseBody
	public AjaxJson saveOrUpdateMore(HttpServletRequest request) throws Exception{
		AjaxJson j = new AjaxJson();
		Map data = request.getParameterMap();
		if(data!=null){
			data = CommUtils.mapConvert(data);
			String tableName = (String)data.get("tableName");
			String id = (String)data.get("id");
			//打印测试
		    Iterator it=data.entrySet().iterator();
		    while(it.hasNext()){
		    	Map.Entry entry=(Map.Entry)it.next();
		        Object ok=entry.getKey();
		        Object ov=entry.getValue()==null?"":entry.getValue();
		        logger.debug("name:"+ok.toString()+";value:"+ov.toString());
		    }
		    Map<String,List<Map<String,Object>>> mapMore =CommUtils.mapConvertMore(data, tableName);
		    if(StringUtils.isEmpty(id)){
		    	logger.info("一对多添加!!!!!");
		    	try {
		    		Map<String, Object> result = dataBaseService.insertTableMore(mapMore, tableName);
		    		data.put("id", result.get("id"));
		    		j.setSuccess(true);
					message = "添加成功";
				} catch (BusinessException e) {
					e.printStackTrace();
					j.setSuccess(false);
					message = e.getMessage();
				}
		    	
			}else{
				logger.info("一对多修改!!!!!");
				try {
					dataBaseService.updateTableMore(mapMore, tableName);
					j.setSuccess(true);
					message = "更新成功";
				} catch (BusinessException e) {
					e.printStackTrace();
					j.setSuccess(false);
					message = e.getMessage();
				}
			}
		}
		j.setMsg(message);
		j.setObj(data);
		return j;
	}
	
	
	/**
	 * 自定义按钮（触发对应的后台方法）
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "doButton")
	@ResponseBody
	public AjaxJson doButton(HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		try {
			String formId = request.getParameter("formId");
			String buttonCode = request.getParameter("buttonCode");
			String tableName = request.getParameter("tableName");
			String id = request.getParameter("id");
			Map<String,Object> data  = dataBaseService.findOneForJdbc(tableName, id);
			if(data!=null){
				//打印测试
			    Iterator it=data.entrySet().iterator();
			    while(it.hasNext()){
			    	Map.Entry entry=(Map.Entry)it.next();
			        Object ok=entry.getKey();
			        Object ov=entry.getValue()==null?"":entry.getValue();
			        logger.debug("name:"+ok.toString()+";value:"+ov.toString());
			    }
				data = CommUtils.mapConvert(data);
				dataBaseService.executeSqlExtend(formId, buttonCode, data);
				//update-start--Author:luobaoli  Date:20150630 for：  增加java增强逻辑处理
				dataBaseService.executeJavaExtend(formId, buttonCode, data);
				//update-end--Author:luobaoli  Date:20150630 for：  增加java增强逻辑处理
			}
			j.setSuccess(true);
			message = "操作成功";
		} catch (Exception e) {
			e.printStackTrace();
			message = "操作失败";
		}
		j.setMsg(message);
		return j;
	}
	
}
