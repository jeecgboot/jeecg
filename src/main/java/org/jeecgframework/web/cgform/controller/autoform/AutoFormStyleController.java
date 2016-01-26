package org.jeecgframework.web.cgform.controller.autoform;

import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import org.springframework.context.annotation.Scope;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.cgform.entity.autoform.AutoFormStyleEntity;
import org.jeecgframework.web.cgform.service.autoform.AutoFormStyleServiceI;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.core.util.MyBeanUtils;

import com.alibaba.fastjson.JSONObject;



/**   
 * @Title: Controller
 * @Description: 表单样式表
 * @author onlineGenerator
 * @date 2015-06-15 20:58:08
 * @version V1.0   
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("/autoFormStyleController")
public class AutoFormStyleController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(AutoFormStyleController.class);

	@Autowired
	private AutoFormStyleServiceI autoFormStyleService;
	@Autowired
	private SystemService systemService;
	private String message;
	
	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}


	/**
	 * 表单样式表列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "autoFormStyle")
	public ModelAndView autoFormStyle(HttpServletRequest request) {
		return new ModelAndView("jeecg/cgform/autoform/autoFormStyleList");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(AutoFormStyleEntity autoFormStyle,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(AutoFormStyleEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, autoFormStyle, request.getParameterMap());
		try{
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.autoFormStyleService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除表单样式表
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(AutoFormStyleEntity autoFormStyle, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		autoFormStyle = systemService.getEntity(AutoFormStyleEntity.class, autoFormStyle.getId());
		message = "表单样式表删除成功";
		try{
			autoFormStyleService.delete(autoFormStyle);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "表单样式表删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除表单样式表
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		message = "表单样式表删除成功";
		try{
			for(String id:ids.split(",")){
				AutoFormStyleEntity autoFormStyle = systemService.getEntity(AutoFormStyleEntity.class, 
				id
				);
				autoFormStyleService.delete(autoFormStyle);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "表单样式表删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加表单样式表
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(AutoFormStyleEntity autoFormStyle, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "表单样式表添加成功";
		try{
			autoFormStyleService.save(autoFormStyle);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "表单样式表添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 更新表单样式表
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(AutoFormStyleEntity autoFormStyle, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "表单样式表更新成功";
		AutoFormStyleEntity t = autoFormStyleService.get(AutoFormStyleEntity.class, autoFormStyle.getId());
		try {
			MyBeanUtils.copyBeanNotNull2Bean(autoFormStyle, t);
			autoFormStyleService.saveOrUpdate(t);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "表单样式表更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	

	/**
	 * 表单样式表新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(AutoFormStyleEntity autoFormStyle, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(autoFormStyle.getId())) {
			autoFormStyle = autoFormStyleService.getEntity(AutoFormStyleEntity.class, autoFormStyle.getId());
			req.setAttribute("autoFormStylePage", autoFormStyle);
		}
		return new ModelAndView("jeecg/cgform/autoform/autoFormStyle-add");
	}
	/**
	 * 表单样式表编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(AutoFormStyleEntity autoFormStyle, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(autoFormStyle.getId())) {
			autoFormStyle = autoFormStyleService.getEntity(AutoFormStyleEntity.class, autoFormStyle.getId());
			req.setAttribute("autoFormStylePage", autoFormStyle);
		}
		return new ModelAndView("jeecg/cgform/autoform/autoFormStyle-update");
	}
	
	
	@ResponseBody
	@RequestMapping(params="checkStyleNm")
	public JSONObject checkStyleNm(AutoFormStyleEntity autoFormStyle,HttpServletRequest req){
		JSONObject jsonObject = new JSONObject();
		
		String param = req.getParameter("param");
		
		List<AutoFormStyleEntity> list = new ArrayList<AutoFormStyleEntity>();
		String hql = "";
		if(StringUtils.isNotBlank(autoFormStyle.getId())){
		    hql = "from AutoFormStyleEntity t where t.id != ? and t.styleDesc = ?";
		    list = this.systemService.findHql(hql, autoFormStyle.getId(),param); 
			
		} else {
			hql = "from AutoFormStyleEntity t where t.styleDesc = ?";
			list = this.systemService.findHql(hql, param); 
		}
		
		if(list.size()>0){
			jsonObject.put("status", "n");
    		jsonObject.put("info", "样式名称重复，请重新输入！");
    		return jsonObject;
		}
		jsonObject.put("status", "y");
    	return jsonObject;
	}
	
	/**
	 * 导入功能跳转
	 * 
	 * @return
	 *
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		req.setAttribute("controller_name","autoFormStyleController");
		return new ModelAndView("common/upload/pub_excel_upload");
	}
	
	/**
	 * 导出excel
	 * 
	 * @param request
	 * @param response
	 *
	@RequestMapping(params = "exportXls")
	public String exportXls(AutoFormStyleEntity autoFormStyle,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		CriteriaQuery cq = new CriteriaQuery(AutoFormStyleEntity.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, autoFormStyle, request.getParameterMap());
		List<AutoFormStyleEntity> autoFormStyles = this.autoFormStyleService.getListByCriteriaQuery(cq,false);
		modelMap.put(NormalExcelConstants.FILE_NAME,"表单样式表");
		modelMap.put(NormalExcelConstants.CLASS,AutoFormStyleEntity.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("表单样式表列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
			"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST,autoFormStyles);
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	/**
	 * 导出excel 使模板
	 * 
	 * @param request
	 * @param response
	 *
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(AutoFormStyleEntity autoFormStyle,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		modelMap.put(TemplateExcelConstants.FILE_NAME, "表单样式表");
		modelMap.put(TemplateExcelConstants.PARAMS,new TemplateExportParams("Excel模板地址"));
		modelMap.put(TemplateExcelConstants.MAP_DATA,null);
		modelMap.put(TemplateExcelConstants.CLASS,AutoFormStyleEntity.class);
		modelMap.put(TemplateExcelConstants.LIST_DATA,null);
		return TemplateExcelConstants.JEECG_TEMPLATE_EXCEL_VIEW;
	}
	
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "importExcel", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson importExcel(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();
		
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();// 获取上传文件对象
			ImportParams params = new ImportParams();
			params.setTitleRows(2);
			params.setHeadRows(1);
			params.setNeedSave(true);
			try {
				List<AutoFormStyleEntity> listAutoFormStyleEntitys = ExcelImportUtil.importExcel(file.getInputStream(),AutoFormStyleEntity.class,params);
				for (AutoFormStyleEntity autoFormStyle : listAutoFormStyleEntitys) {
					autoFormStyleService.save(autoFormStyle);
				}
				j.setMsg("文件导入成功！");
			} catch (Exception e) {
				j.setMsg("文件导入失败！");
				logger.error(ExceptionUtil.getExceptionMessage(e));
			}finally{
				try {
					file.getInputStream().close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return j;
	}*/
}
