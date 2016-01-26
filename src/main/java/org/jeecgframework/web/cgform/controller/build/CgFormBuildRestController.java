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

import org.jeecgframework.web.cgform.common.CgAutoListConstant;
import org.jeecgframework.web.cgform.engine.TempletContext;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.entity.upload.CgUploadEntity;
import org.jeecgframework.web.cgform.service.build.DataBaseService;
import org.jeecgframework.web.cgform.service.config.CgFormFieldServiceI;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.enums.SysThemesEnum;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.SysThemesUtil;
import org.jeecgframework.web.cgform.util.TemplateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * @ClassName: cgFormBuildRestController
 * @Description: 读取模板生成填报表单（添加、修改）-执行表单数据添加和修改操作（rest风格）
 * @author 周俊峰、luobaoli
 */
@Scope("prototype")
@Controller
@RequestMapping("/cgform")
public class CgFormBuildRestController extends BaseController {
	private static final Logger logger = Logger.getLogger(CgFormBuildRestController.class);
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
	@RequestMapping(value="/form/{configId}",method=RequestMethod.GET)
	public void ftlForm(@PathVariable String configId,HttpServletRequest request,HttpServletResponse response) {
		ftlForm(configId,null,request,response);
	}
	/**
	 * form表单页面跳转
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value="/form/{configId}/{id}",method=RequestMethod.GET)
	public void ftlForm(@PathVariable String configId,@PathVariable String id,HttpServletRequest request,HttpServletResponse response) {
		try {
			long start = System.currentTimeMillis();
			String tableName = configId;
			String mode=request.getParameter("mode");
			String templateName=tableName+"_";
			if(StringUtils.isBlank(id)){
				templateName+= TemplateUtil.TemplateType.ADD.getName();
			}else if("read".equals(mode)){
				templateName+=TemplateUtil.TemplateType.DETAIL.getName();
			}else{
				templateName+=TemplateUtil.TemplateType.UPDATE.getName();
			}
			String ftlVersion =request.getParameter("ftlVersion");
			Template template = templetContext.getTemplate(templateName, ftlVersion);
			StringWriter stringWriter = new StringWriter();
			BufferedWriter writer = new BufferedWriter(stringWriter);
	        Map<String, Object> data = new HashMap<String, Object>();
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
	    	data.put("head", head);
	    	
	    	//页面样式js引用
	    	data.put(CgAutoListConstant.CONFIG_IFRAME, getHtmlHead(request));
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
	
	private String getHtmlHead(HttpServletRequest request){
		HttpSession session = ContextHolderUtils.getSession();
		String lang = (String)session.getAttribute("lang");
		StringBuilder sb= new StringBuilder("");
		sb.append("<base href=\""+request.getContextPath()+"/\"/>");
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
}
