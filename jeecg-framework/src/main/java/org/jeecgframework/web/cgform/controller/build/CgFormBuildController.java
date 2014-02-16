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

import org.jeecgframework.web.cgform.common.CgAutoListConstant;
import org.jeecgframework.web.cgform.common.CommUtils;
import org.jeecgframework.web.cgform.engine.TempletContext;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.entity.upload.CgUploadEntity;
import org.jeecgframework.web.cgform.exception.BusinessException;
import org.jeecgframework.web.cgform.service.build.DataBaseService;
import org.jeecgframework.web.cgform.service.config.CgFormFieldServiceI;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.util.DBTypeUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.UUIDGenerator;
import org.springframework.beans.factory.annotation.Autowired;
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
	private CgFormFieldServiceI cgFormFieldService;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}
	
	/**
	 * form表单页面跳转
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "ftlForm")
	public void ftlForm(HttpServletRequest request,HttpServletResponse response) {
		try {
			long start = System.currentTimeMillis();
			String tableName =request.getParameter("tableName");
			Template template = templetContext.getTemplate(tableName);
			StringWriter stringWriter = new StringWriter();
			BufferedWriter writer = new BufferedWriter(stringWriter);
	        Map<String, Object> data = new HashMap<String, Object>();
	        String id = request.getParameter("id");
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
	        Iterator it=dataForm.entrySet().iterator();
		    while(it.hasNext()){
		    	Map.Entry entry=(Map.Entry)it.next();
		        String ok=(String)entry.getKey();
		        Object ov=entry.getValue();
		        data.put(ok, ov);
		    }
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
	    	//装载附件信息数据
	    	pushFiles(data,id);
			template.process(data, writer);
			String content = stringWriter.toString();
			response.setContentType("text/html;charset=utf-8");
			response.getWriter().print(content);
			long end = System.currentTimeMillis();
			logger.debug("自定义表单生成耗时："+(end-start)+" ms");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (TemplateException e) {
			e.printStackTrace();
		}

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
					int num = dataBaseService.insertTable(tableName, data);
					if (num>0) {
						j.setSuccess(true);
						message = "添加成功";
					}else {
						j.setSuccess(false);
						message = "添加失败";
					}
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
						message = "更新成功";
					}else {
						j.setSuccess(false);
						message = "更新失败";
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
