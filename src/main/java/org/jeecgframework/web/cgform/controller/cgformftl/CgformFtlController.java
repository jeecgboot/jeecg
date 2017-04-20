package org.jeecgframework.web.cgform.controller.cgformftl;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.common.UploadFile;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.DateUtils;
import org.jeecgframework.core.util.FileUtils;
import org.jeecgframework.core.util.FormUtil;
import org.jeecgframework.core.util.LogUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.cgform.common.OfficeHtmlUtil;
import org.jeecgframework.web.cgform.engine.TempletContext;
import org.jeecgframework.web.cgform.entity.cgformftl.CgformFtlEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.service.cgformftl.CgformFtlServiceI;
import org.jeecgframework.web.cgform.util.TemplateUtil;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Title: Controller
 * @Description: 上传Word转换为freemarker表单
 * @author 段其录
 * @date 2013-07-03 17:42:05
 * @version V1.0
 * 
 */
//@Scope("prototype")
@Controller
@RequestMapping("/cgformFtlController")
public class CgformFtlController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(CgformFtlController.class);

	@Autowired
	private CgformFtlServiceI cgformFtlService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private TempletContext templetContext;


	/**
	 * 模板展示
	 * 
	 * @author 安超
	 * @return
	 */
	@RequestMapping(params = "formEkeditor")
	public ModelAndView ckeditor(HttpServletRequest request, String id) {
		CgformFtlEntity t = systemService.get(CgformFtlEntity.class, id);
		request.setAttribute("cgformFtlEntity", t);
		if (t.getFtlContent() == null) {
			request.setAttribute("contents", "");
		} else {
			request.setAttribute("contents", new String(t.getFtlContent()));
		}
		//------longjb 20150513----for：修改增加新的编辑器ueditor页面------
		if(request.getParameter("editorType")==null){
			return new ModelAndView("jeecg/cgform/cgformftl/ckeditor");
		}else{
			return new ModelAndView("jeecg/cgform/cgformftl/"+request.getParameter("editorType"));
		}
	}

	/**
	 * 模板编辑保存
	 * 
	 * @author 安超
	 * @return
	 */
	@RequestMapping(params = "saveFormEkeditor")
	@ResponseBody
	public AjaxJson saveCkeditor(HttpServletRequest request,
			CgformFtlEntity cgformFtlEntity, String contents) {
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(cgformFtlEntity.getId())) {
			CgformFtlEntity t = systemService.get(CgformFtlEntity.class,
					cgformFtlEntity.getId());
			try {
				MyBeanUtils.copyBeanNotNull2Bean(cgformFtlEntity, t);
				t.setFtlContent(contents);
				systemService.saveOrUpdate(t);
				j.setSuccess(true);
				j.setMsg("更新成功");
			} catch (Exception e) {
				e.printStackTrace();
				j.setSuccess(false);
				j.setMsg("更新失败");
			}
		}
		return j;
	}

	/**
	 * Word转Ftl列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "cgformFtl")
	public ModelAndView cgformFtl(HttpServletRequest request) {
		String formid = request.getParameter("formid");
		request.setAttribute("formid", formid);
		return new ModelAndView("jeecg/cgform/cgformftl/cgformFtlList");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping(params = "datagrid")
	public void datagrid(CgformFtlEntity cgformFtl, HttpServletRequest request,
			HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(CgformFtlEntity.class, dataGrid);
		// 查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq,
				cgformFtl, request.getParameterMap());
		this.cgformFtlService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除Word转Ftl
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(CgformFtlEntity cgformFtl, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		cgformFtl = systemService.getEntity(CgformFtlEntity.class,
				cgformFtl.getId());
		message = "删除成功";
		cgformFtlService.delete(cgformFtl);
		systemService.addLog(message, Globals.Log_Type_DEL,
				Globals.Log_Leavel_INFO);

		j.setMsg(message);
		return j;
	}

	/**
	 * 激活Ftl
	 * 
	 * @return
	 */
	@RequestMapping(params = "active")
	@ResponseBody
	public AjaxJson active(CgformFtlEntity cgformFtl, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		try {
			// 判断有没有激活过的模板
			cgformFtl = systemService.getEntity(CgformFtlEntity.class,cgformFtl.getId());
			if (!cgformFtlService.hasActive(cgformFtl.getCgformId())) {
				cgformFtl.setFtlStatus("1");
				cgformFtlService.saveOrUpdate(cgformFtl);
				message = "激活成功";
				CgFormHeadEntity po = systemService.getEntity(CgFormHeadEntity.class, cgformFtl.getCgformId());
				templetContext.removeTemplateFromCache(po.getTableName()+"_"+TemplateUtil.TemplateType.ADD.getName());
				templetContext.removeTemplateFromCache(po.getTableName()+"_"+TemplateUtil.TemplateType.DETAIL.getName());
				templetContext.removeTemplateFromCache(po.getTableName()+"_"+TemplateUtil.TemplateType.UPDATE.getName());
				systemService.addLog(message, Globals.Log_Type_UPDATE,Globals.Log_Leavel_INFO);
				j.setSuccess(true);
				j.setMsg(message);
			} else {
				message = "已有激活模板，请取消后再进行激活";
				j.setSuccess(true);
				j.setMsg(message);
			}
		} catch (Exception e) {
			logger.info(e.getMessage());
			message = "激活失败";
			j.setSuccess(false);
			j.setMsg(message);
		}
		return j;
	}

	/**
	 * 取消激活Ftl
	 * 
	 * @return
	 */
	@RequestMapping(params = "cancleActive")
	@ResponseBody
	public AjaxJson cancleActive(CgformFtlEntity cgformFtl,
			HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		try {
			cgformFtl = systemService.getEntity(CgformFtlEntity.class,cgformFtl.getId());
			CgFormHeadEntity po = systemService.getEntity(CgFormHeadEntity.class, cgformFtl.getCgformId());
			templetContext.removeTemplateFromCache(po.getTableName()+"_"+TemplateUtil.TemplateType.ADD.getName());
			templetContext.removeTemplateFromCache(po.getTableName()+"_"+TemplateUtil.TemplateType.DETAIL.getName());
			templetContext.removeTemplateFromCache(po.getTableName()+"_"+TemplateUtil.TemplateType.UPDATE.getName());
			cgformFtl.setFtlStatus("0");
			cgformFtlService.saveOrUpdate(cgformFtl);
			message = "取消激活成功";
			systemService.addLog(message, Globals.Log_Type_UPDATE,
					Globals.Log_Leavel_INFO);
			j.setSuccess(true);
			j.setMsg(message);
		} catch (Exception e) {
			logger.info(e.getMessage());
			message = "取消激活失败";
			j.setSuccess(false);
			j.setMsg(message);
		}
		return j;
	}

	/**
	 * 添加Word转Ftl
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(CgformFtlEntity cgformFtl, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(cgformFtl.getId())) {
			message = "更新成功";
			CgformFtlEntity t = cgformFtlService.get(CgformFtlEntity.class,
					cgformFtl.getId());
			try {
				MyBeanUtils.copyBeanNotNull2Bean(cgformFtl, t);
				cgformFtlService.saveOrUpdate(t);
				systemService.addLog(message, Globals.Log_Type_UPDATE,
						Globals.Log_Leavel_INFO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			message = "添加成功";
			cgformFtlService.save(cgformFtl);
			systemService.addLog(message, Globals.Log_Type_INSERT,
					Globals.Log_Leavel_INFO);
		}

		return j;
	}

	/**
	 * 转Ftl列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(CgformFtlEntity cgformFtl,
			HttpServletRequest req) {
		if (StringUtil.isNotEmpty(cgformFtl.getId())) {
			cgformFtl = cgformFtlService.getEntity(CgformFtlEntity.class,
					cgformFtl.getId());
		}
		HttpSession session = ContextHolderUtils.getSession();
		String lang = (String)session.getAttribute("lang");
		StringBuffer sb = new StringBuffer();
		sb.append("<html xmlns:m=\"http://schemas.microsoft.com/office/2004/12/omml\"><head><title></title>");
		sb.append("<link href=\"plug-in/easyui/themes/default/easyui.css\" id=\"easyuiTheme\" rel=\"stylesheet\" type=\"text/css\" />");
		sb.append("<link href=\"plug-in/easyui/themes/icon.css\" rel=\"stylesheet\" type=\"text/css\" />");
		sb.append("<link href=\"plug-in/accordion/css/accordion.css\" rel=\"stylesheet\" type=\"text/css\" />");
		sb.append("<link href=\"plug-in/Validform/css/style.css\" rel=\"stylesheet\" type=\"text/css\" />");
		sb.append("<link href=\"plug-in/Validform/css/tablefrom.css\" rel=\"stylesheet\" type=\"text/css\" />");
		sb.append("<style type=\"text/css\">body{font-size:12px;}table{border: 1px solid #000000;padding:0; ");
		sb.append("margin:0 auto;border-collapse: collapse;width:100%;align:right;}td {border: 1px solid ");
		sb.append("#000000;background: #fff;font-size:12px;padding: 3px 3px 3px 8px;color: #000000;word-break: keep-all;}");
		sb.append("</style></head><script type=\"text/javascript\" src=\"plug-in/jquery/jquery-1.8.3.js\">");
		sb.append("</script><script type=\"text/javascript\" src=\"plug-in/tools/dataformat.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/easyui/jquery.easyui.min.1.3.2.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/easyui/locale/zh-cn.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/syUtil.js\"></script><script ");
		sb.append("type=\"text/javascript\" src=\"plug-in/My97DatePicker/WdatePicker.js\"></script><script ");
		sb.append("type=\"text/javascript\" src=\"plug-in/lhgDialog/lhgdialog.min.js\"></script>");

		sb.append("<script type=\"text/javascript\" src=\"plug-in/layer/layer.js\"></script>");

		sb.append(StringUtil.replace("<script type=\"text/javascript\" src=\"plug-in/tools/curdtools_{0}.js\"></script><script type=\"text/javascript\" ", 
				"{0}", lang));
		
		sb.append("src=\"plug-in/tools/easyuiextend.js\"></script><script type=\"text/javascript\" ");
		sb.append("src=\"plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js\"></script><script type=\"text/javascript\" ");
		sb.append("src=\"plug-in/Validform/js/Validform_Datatype_zh-cn.js\"></script><script type=\"text/javascript\" ");
		sb.append("src=\"plug-in/Validform/js/datatype_zh-cn.js\"></script><script type=\"text/javascript\" ");
		sb.append("src=\"plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js\"></script>");

		//表单提交 js
		sb.append("<script type=\"text/javascript\">$(function(){$(\"#formobj\").Validform({tiptype:1,");
		sb.append("btnSubmit:\"#btn_sub\",btnReset:\"#btn_reset\",ajaxPost:true,usePlugin:{passwordstrength:");
		sb.append("{minLen:6,maxLen:18,trigger:function(obj,error){if(error){obj.parent().next().");
		sb.append("find(\".Validform_checktip\").show();obj.find(\".passwordStrength\").hide();}");
		sb.append("else{$(\".passwordStrength\").show();obj.parent().next().find(\".Validform_checktip\")");
		sb.append(".hide();}}}},callback:function(data){if(data.success");
		sb.append("==true) {uploadFile(data);}else{ if (data.responseText == '' || data.responseText == undefined) {");
		sb.append(" $.messager.alert('错误', data.msg); $.Hidemsg();} else {");
		sb.append(" try { var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));");
		sb.append(" $.messager.alert('错误', emsg); $.Hidemsg();");
		sb.append(" } catch(ex) { $.messager.alert('错误', data.responseText + '');}}return false;}");
		sb.append("if (!neibuClickFlag) { var win = frameElement.api.opener;win.reloadTable(); }}});});</script><body>");

		
		sb.append("<div align=\"center\" id=\"sub_tr\" style=\"display: none;\"><input class=\"ui_state_highlight\" onclick=\"neibuClick()\" type=\"button\" value=\"提交\" /></div>");
		sb.append("</body>");
		sb.append("<script type=\"text/javascript\">$(function(){if(location.href.indexOf(\"mode=read\")!=-1){");
		sb.append("$('#formobj').find(':input').attr('disabled','disabled');}");
		sb.append("if(location.href.indexOf(\"mode=onbutton\")!=-1){$(\"#sub_tr\").show();} });");
		sb.append("var neibuClickFlag = false; function neibuClick() {neibuClickFlag = true;$('#btn_sub').trigger('click');}</script>");
		
		sb.append("<script type=\"text/javascript\">${js_plug_in?if_exists}</script></html>");
		
		
		req.setAttribute("cgformStr", sb);
		req.setAttribute("cgformFtlPage", cgformFtl);
		if("02".equals(cgformFtl.getEditorType())){
			return new ModelAndView("jeecg/cgform/cgformftl/cgformFtlUEditor");
		}else if("03".equals(cgformFtl.getEditorType())){
			return new ModelAndView("jeecg/cgform/cgformftl/cgformFtl");
		}else{
			return new ModelAndView("jeecg/cgform/cgformftl/cgformFtlEditor");
		}
	}

	/**
	 * 保存转换表单文件
	 * 
	 * @param ids
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params = "saveWordFiles", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveWordFiles(HttpServletRequest request,
			HttpServletResponse response, CgformFtlEntity cgformFtl) {
		String message = null;
		AjaxJson j = new AjaxJson();
		Map<String, Object> attributes = new HashMap<String, Object>();

		LogUtil.info("-------------------------step.1-------------------------------------");
		String fileKey = oConvertUtils.getString(request.getParameter("id"));// 文件ID
		String cgformId = oConvertUtils.getString(request
				.getParameter("cgformId"));// formid
		String cgformName = oConvertUtils.getString(request
				.getParameter("cgformName"));// formname
		String ftlStatus = oConvertUtils.getString(request
				.getParameter("ftlStatus"));// formStatus
		if (oConvertUtils.isEmpty(ftlStatus)) {
			ftlStatus = "0";
		}

		if (StringUtil.isNotEmpty(fileKey)) {
			cgformFtl.setId(fileKey);
			cgformFtl = systemService.getEntity(CgformFtlEntity.class, fileKey);
		} else {
			cgformFtl.setFtlVersion(cgformFtlService.getNextVarsion(cgformId));
		}
		LogUtil.info("-------------------------step.2-------------------------------------");
		cgformFtl.setCgformId(cgformId);
		cgformFtl.setCgformName(cgformName);
		cgformFtl.setFtlStatus(ftlStatus);

		UploadFile uploadFile = new UploadFile(request, cgformFtl);
		uploadFile.setCusPath("forms");
		message = null;
		try {

			uploadFile.getMultipartRequest().setCharacterEncoding("UTF-8");
			MultipartHttpServletRequest multipartRequest = uploadFile
					.getMultipartRequest();

			String uploadbasepath = uploadFile.getBasePath();// 文件上传根目录
			if (uploadbasepath == null) {
				uploadbasepath = ResourceUtil.getConfigByName("uploadpath");
			}
			Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
			// 文件数据库保存路径
			String path = uploadbasepath + "\\";// 文件保存在硬盘的相对路径
			String realPath = uploadFile.getMultipartRequest().getSession()
					.getServletContext().getRealPath("\\")
					+ path;// 文件的硬盘真实路径
			File file = new File(realPath);
			if (!file.exists()) {
				file.mkdir();// 创建根目录
			}
			if (uploadFile.getCusPath() != null) {
				realPath += uploadFile.getCusPath() + "\\";
				path += uploadFile.getCusPath() + "\\";
				file = new File(realPath);
				if (!file.exists()) {
					file.mkdir();// 创建文件自定义子目录
				}
			} else {
				realPath += DateUtils.getDataString(DateUtils.yyyyMMdd) + "\\";
				path += DateUtils.getDataString(DateUtils.yyyyMMdd) + "\\";
				file = new File(realPath);
				if (!file.exists()) {
					file.mkdir();// 创建文件时间子目录
				}
			}
			LogUtil.info("-------------------------step.3-------------------------------------");
			String fileName = "";
			for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
				MultipartFile mf = entity.getValue();// 获取上传文件对象
				fileName = mf.getOriginalFilename();// 获取文件名
				String extend = FileUtils.getExtend(fileName);// 获取文件扩展名
				String myfilename = "";
				String myhtmlfilename = "";
				String noextfilename = "";// 不带扩展名
				if (uploadFile.isRename()) {

					noextfilename = DateUtils
							.getDataString(DateUtils.yyyymmddhhmmss)
							+ StringUtil.random(8);// 自定义文件名称
					myfilename = noextfilename + "." + extend;// 自定义文件名称
				} else {
					myfilename = fileName;
				}

				String savePath = realPath + myfilename;// 文件保存全路径
				cgformFtl.setFtlWordUrl(fileName);
				File savefile = new File(savePath);
				FileCopyUtils.copy(mf.getBytes(), savefile);

				myhtmlfilename = realPath + noextfilename + ".html";
				String myftlfilename = realPath + noextfilename + ".ftl";
				LogUtil.info("-------------------------step.4-------------------------------------");
				// 开始转换表单文件
				OfficeHtmlUtil officeHtml = new OfficeHtmlUtil();

				// 方式一：jacob.jar方式word转html
				officeHtml.wordToHtml(savePath, myhtmlfilename);
				String htmlStr = officeHtml.getInfo(myhtmlfilename);
				htmlStr = officeHtml.doHtml(htmlStr);

				// 方式二：poi方式word转html
				// officeHtml.WordConverterHtml(savePath, myhtmlfilename);
				// String htmlStr = officeHtml.getInfo(myhtmlfilename);
				// htmlStr = officeHtml.doPoiHtml(htmlStr);

				officeHtml.stringToFile(htmlStr, myftlfilename);
				// js plugin start
				StringBuilder script = new StringBuilder("");
				script.append("<div align=\"center\" id=\"sub_tr\" style=\"display: none;\"><input class=\"ui_state_highlight\" onclick=\"neibuClick()\" type=\"button\" value=\"提交\" /></div>");
				script.append("</body>");
				script.append("<script type=\"text/javascript\">$(function(){if(location.href.indexOf(\"mode=read\")!=-1){");
				script.append("$('#formobj').find(':input').attr('disabled','disabled');}");
				script.append("if(location.href.indexOf(\"mode=onbutton\")!=-1){$(\"#sub_tr\").show();} });");
				script.append("var neibuClickFlag = false; function neibuClick() {neibuClickFlag = true;$('#btn_sub').trigger('click');}</script>");
				
				
				script.append("<script type=\"text/javascript\">");
				script.append("${js_plug_in?if_exists}");
				script.append("</script>");
				htmlStr = htmlStr.replace("</html>", script.toString()
						+ "</html>");
				// js plugin end
				cgformFtl.setFtlContent(htmlStr);
				cgformFtlService.saveOrUpdate(cgformFtl);
				LogUtil.info("-------------------------step.5-------------------------------------");
			}
		} catch (Exception e1) {
			LogUtil.error(e1.toString());
			message = e1.toString();
		}

		attributes.put("id", cgformFtl.getId());
		if (StringUtil.isNotEmpty(message))
			j.setMsg("Word 模板上传失败," + message);
		else
			j.setMsg("Word 模板上传成功");
		j.setAttributes(attributes);

		return j;
	}
	// for：放弃jacob和poi上传word，改用ckeditor
	@RequestMapping(params = "cgformFtl2")
	public ModelAndView cgformFtl2(HttpServletRequest request) {
		String formid = request.getParameter("formid");
		request.setAttribute("formid", formid);
		return new ModelAndView("jeecg/cgform/cgformftl/cgformFtlList2");
	}

	@RequestMapping(params = "saveEditor")
	@ResponseBody
	public AjaxJson saveEditor(CgformFtlEntity cgformFtl,
			HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String fileKey = oConvertUtils.getString(request.getParameter("id"));// 文件ID
		String cgformId = oConvertUtils.getString(request
				.getParameter("cgformId"));
		String cgformName = oConvertUtils.getString(request
				.getParameter("cgformName"));
		String ftlStatus = oConvertUtils.getString(request
				.getParameter("ftlStatus"));
		String ftlVersion = oConvertUtils.getString(request
				.getParameter("ftlVersion"));
		String ftlWordUrl = oConvertUtils.getString(request
				.getParameter("ftlWordUrl"));
		String createBy = oConvertUtils.getString(request
				.getParameter("createBy"));
		String createName = oConvertUtils.getString(request
				.getParameter("createName"));
		String createDate = oConvertUtils.getString(request
				.getParameter("createDate"));
		if (oConvertUtils.isEmpty(ftlStatus))
			ftlStatus = "0";

		cgformFtl.setCgformId(cgformId);
		cgformFtl.setCgformName(cgformName);
		cgformFtl.setFtlStatus(ftlStatus);
		if (StringUtil.isNotEmpty(fileKey)) {
			cgformFtl.setId(fileKey);
			if(StringUtil.isNotEmpty(ftlVersion))
				cgformFtl.setFtlVersion(Integer.valueOf(ftlVersion));
			if (StringUtil.isNotEmpty(ftlWordUrl))
				cgformFtl.setFtlWordUrl(ftlWordUrl);
			if (StringUtil.isNotEmpty(createBy))
				cgformFtl.setCreateBy(createBy);
			if (StringUtil.isNotEmpty(createName))
				cgformFtl.setCreateName(createName);
			if (StringUtil.isNotEmpty(createDate))
				cgformFtl.setCreateDate(DateUtils.str2Date(createDate, DateUtils.date_sdf));

			if (cgformFtl.getFtlContent()!=null&&cgformFtl.getFtlContent().indexOf("<form")<0){
				//!"<form".equalsIgnoreCase(cgformFtl.getFtlContent())) {
				String ls_form = "<form action=\"cgFormBuildController.do?saveOrUpdate\" id=\"formobj\" name=\"formobj\" method=\"post\">"
						+ "<input type=\"hidden\" name=\"tableName\" value=\"${tableName?if_exists?html}\" />"
						+ "<input type=\"hidden\" name=\"id\" value=\"${id?if_exists?html}\" />"
						+ "<input type=\"hidden\" id=\"btn_sub\" class=\"btn_sub\" />#{jform_hidden_field}<table";
				cgformFtl.setFtlContent(cgformFtl.getFtlContent().replace(
						"<table", ls_form));
				cgformFtl.setFtlContent(cgformFtl.getFtlContent().replace(
						"</table>", "</table></form>"));
			}
			cgformFtlService.saveOrUpdate(cgformFtl);
			j.setMsg("修改成功");
		} else {
			cgformFtl.setFtlVersion(cgformFtlService.getNextVarsion(cgformId));

			String ls_form = "<form action=\"cgFormBuildController.do?saveOrUpdate\" id=\"formobj\" name=\"formobj\" method=\"post\">"
					+ "<input type=\"hidden\" name=\"tableName\" value=\"${tableName?if_exists?html}\" />"
					+ "<input type=\"hidden\" name=\"id\" value=\"${id?if_exists?html}\" />"
					+ "<input type=\"hidden\" id=\"btn_sub\" class=\"btn_sub\" />#{jform_hidden_field}<table";
			cgformFtl.setFtlContent(cgformFtl.getFtlContent().replace("<table",
					ls_form));
			cgformFtl.setFtlContent(cgformFtl.getFtlContent().replace(
					"</table>", "</table></form>"));
			cgformFtlService.save(cgformFtl);
			j.setMsg("上传成功");
		}
		Map<String, Object> attributes = new HashMap<String, Object>();
		attributes.put("id", cgformFtl.getId());
		j.setAttributes(attributes);
		return j;
	}
	// for：放弃jacob和poi上传word，改用ckeditor
//----------longjb 20150602 ---for: html解析预览
	@RequestMapping(params = "parseUeditorOld")
	@ResponseBody
	public AjaxJson parseUeditorOld(String parseForm,String action,HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		try {
			JSONObject json = new JSONObject().fromObject(parseForm);
			//System.out.println(json.getString("parse"));
			//System.out.println(json.getString("data"));
			// 判断有没有激活过的模板
			message = FormUtil.GetHtml(json.getString("parse"),json.getString("data"), action);
			j.setMsg(message);
			j.setSuccess(true);
		} catch (Exception e) {
			logger.info(e.getMessage());
			e.printStackTrace();
			message = "解析异常"+e.getMessage();
			j.setSuccess(false);
			j.setMsg(message);
		}
		return j;
	}
	@RequestMapping(params = "parseUeditor")
	@ResponseBody
	public AjaxJson parseUeditor(String parseForm,String action,HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		try {
//			System.out.println(parseForm);
//			System.out.println(contentData);
//			JSONObject json = new JSONObject().fromObject(parseForm);
//			System.out.println(json.getString("parse"));
//			System.out.println(json.getString("data"));
//			// 判断有没有激活过的模板
//			message = FormUtil.GetHtml(json.getString("parse"),json.getString("data"), action);

			if(StringUtils.isNotBlank(parseForm)){
				TemplateUtil tool = new TemplateUtil();
				Map<String,Object> map = tool.processor(parseForm);
				j.setMsg(map.get("parseHtml").toString().replaceAll("\"", "&quot;"));
			} else {
				j.setMsg("");
			}

			j.setSuccess(true);
		} catch (Exception e) {
			logger.info(e.getMessage());
			e.printStackTrace();
			message = "解析异常"+e.getMessage();
			j.setSuccess(false);
			j.setMsg(message);
		}
		return j;
	}

}
