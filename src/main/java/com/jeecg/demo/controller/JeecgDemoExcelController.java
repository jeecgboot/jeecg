package com.jeecg.demo.controller;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Validator;

import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.service.SystemService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.jeecg.demo.entity.JeecgDemoExcelEntity;
import com.jeecg.demo.service.JeecgDemoExcelServiceI;

import io.swagger.annotations.Api;

/**   
 * @Title: Controller  
 * @Description: excel导入导出测试表
 * @author onlineGenerator
 * @date 2018-06-15 15:46:09
 * @version V1.0   
 *
 */
@Controller
@RequestMapping("/jeecgDemoExcelController")
@Api(value="JeecgDemoExcel",description="excel导入导出测试表",tags="jeecgDemoExcelController")
public class JeecgDemoExcelController extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(JeecgDemoExcelController.class);

	@Autowired
	private JeecgDemoExcelServiceI jeecgDemoExcelService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private Validator validator;
	


	/**
	 * excel导入导出测试表列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/excel/jeecgDemoExcelList");
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
	public void datagrid(JeecgDemoExcelEntity jeecgDemoExcel,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(JeecgDemoExcelEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, jeecgDemoExcel, request.getParameterMap());
		try{
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.jeecgDemoExcelService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}
	
	/**
	 * 删除excel导入导出测试表
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(JeecgDemoExcelEntity jeecgDemoExcel, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		jeecgDemoExcel = systemService.getEntity(JeecgDemoExcelEntity.class, jeecgDemoExcel.getId());
		message = "excel导入导出测试表删除成功";
		try{
			jeecgDemoExcelService.delete(jeecgDemoExcel);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "excel导入导出测试表删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除excel导入导出测试表
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "excel导入导出测试表删除成功";
		try{
			for(String id:ids.split(",")){
				JeecgDemoExcelEntity jeecgDemoExcel = systemService.getEntity(JeecgDemoExcelEntity.class, 
				id
				);
				jeecgDemoExcelService.delete(jeecgDemoExcel);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "excel导入导出测试表删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加excel导入导出测试表
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(JeecgDemoExcelEntity jeecgDemoExcel, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "excel导入导出测试表添加成功";
		try{
			jeecgDemoExcelService.save(jeecgDemoExcel);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "excel导入导出测试表添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 更新excel导入导出测试表
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(JeecgDemoExcelEntity jeecgDemoExcel, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "excel导入导出测试表更新成功";
		JeecgDemoExcelEntity t = jeecgDemoExcelService.get(JeecgDemoExcelEntity.class, jeecgDemoExcel.getId());
		try {
			MyBeanUtils.copyBeanNotNull2Bean(jeecgDemoExcel, t);
			jeecgDemoExcelService.saveOrUpdate(t);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "excel导入导出测试表更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	

	/**
	 * excel导入导出测试表新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(JeecgDemoExcelEntity jeecgDemoExcel, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jeecgDemoExcel.getId())) {
			jeecgDemoExcel = jeecgDemoExcelService.getEntity(JeecgDemoExcelEntity.class, jeecgDemoExcel.getId());
			req.setAttribute("jeecgDemoExcelPage", jeecgDemoExcel);
		}
		return new ModelAndView("com/jeecg/demo/excel/jeecgDemoExcel-add");
	}
	/**
	 * excel导入导出测试表编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(JeecgDemoExcelEntity jeecgDemoExcel, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jeecgDemoExcel.getId())) {
			jeecgDemoExcel = jeecgDemoExcelService.getEntity(JeecgDemoExcelEntity.class, jeecgDemoExcel.getId());
			req.setAttribute("jeecgDemoExcelPage", jeecgDemoExcel);
		}
		return new ModelAndView("com/jeecg/demo/excel/jeecgDemoExcel-update");
	}
	
	/**
	 * 导入功能跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		req.setAttribute("controller_name","jeecgDemoExcelController");
		return new ModelAndView("common/upload/pub_excel_upload");
	}
	
	/**
	 * 导出excel
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXls")
	public String exportXls(JeecgDemoExcelEntity jeecgDemoExcel,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		CriteriaQuery cq = new CriteriaQuery(JeecgDemoExcelEntity.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, jeecgDemoExcel, request.getParameterMap());
		List<JeecgDemoExcelEntity> jeecgDemoExcels = this.jeecgDemoExcelService.getListByCriteriaQuery(cq,false);
		modelMap.put(NormalExcelConstants.FILE_NAME,"excel导入导出测试表");
		modelMap.put(NormalExcelConstants.CLASS,JeecgDemoExcelEntity.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("excel导入导出测试表列表", "导出人:"+ResourceUtil.getSessionUser().getRealName(),
			"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST,jeecgDemoExcels);
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	/**
	 * 导出excel 使模板
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(JeecgDemoExcelEntity jeecgDemoExcel,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
    	modelMap.put(NormalExcelConstants.FILE_NAME,"excel导入导出测试表");
    	modelMap.put(NormalExcelConstants.CLASS,JeecgDemoExcelEntity.class);
    	modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("excel导入导出测试表列表", "导出人:"+ResourceUtil.getSessionUser().getRealName(),
    	"导出信息"));
    	modelMap.put(NormalExcelConstants.DATA_LIST,new ArrayList());
    	return NormalExcelConstants.JEECG_EXCEL_VIEW;
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
				List<JeecgDemoExcelEntity> listJeecgDemoExcelEntitys = ExcelImportUtil.importExcel(file.getInputStream(),JeecgDemoExcelEntity.class,params);
				for (JeecgDemoExcelEntity jeecgDemoExcel : listJeecgDemoExcelEntitys) {
					jeecgDemoExcelService.save(jeecgDemoExcel);
				}
				j.setMsg("文件导入成功！");
			} catch (Exception e) {
				j.setMsg("文件导入失败！");
				logger.error(e.getMessage());
			}finally{
				try {
					file.getInputStream().close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return j;
	}
	

}
