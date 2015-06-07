package org.jeecgframework.web.sms.controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.sms.entity.TSSmsEntity;
import org.jeecgframework.web.sms.service.TSSmsServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;



/**   
 * @Title: Controller
 * @Description: 消息发送记录表
 * @author onlineGenerator
 * @date 2014-09-18 00:01:53
 * @version V1.0   
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("/tSSmsController")
public class TSSmsController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(TSSmsController.class);

	@Autowired
	private TSSmsServiceI tSSmsService;
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
	 * 消息发送记录表列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "tSSms")
	public ModelAndView tSSms(HttpServletRequest request) {
		return new ModelAndView("org/jeecgframework/web/sms/tSSmsList");
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
	public void datagrid(TSSmsEntity tSSms,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSSmsEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, tSSms, request.getParameterMap());
		try{
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.tSSmsService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除消息发送记录表
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(TSSmsEntity tSSms, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		tSSms = systemService.getEntity(TSSmsEntity.class, tSSms.getId());
		message = "消息发送记录表删除成功";
		try{
			tSSmsService.delete(tSSms);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "消息发送记录表删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除消息发送记录表
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		message = "消息发送记录表删除成功";
		try{
			for(String id:ids.split(",")){
				TSSmsEntity tSSms = systemService.getEntity(TSSmsEntity.class, 
				id
				);
				tSSmsService.delete(tSSms);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "消息发送记录表删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加消息发送记录表
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(TSSmsEntity tSSms, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "消息发送记录表添加成功";
		try{
			tSSmsService.save(tSSms);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "消息发送记录表添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 更新消息发送记录表
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(TSSmsEntity tSSms, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		message = "消息发送记录表更新成功";
		TSSmsEntity t = tSSmsService.get(TSSmsEntity.class, tSSms.getId());
		try {
			MyBeanUtils.copyBeanNotNull2Bean(tSSms, t);
			tSSmsService.saveOrUpdate(t);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "消息发送记录表更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	

	/**
	 * 消息发送记录表新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(TSSmsEntity tSSms, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(tSSms.getId())) {
			tSSms = tSSmsService.getEntity(TSSmsEntity.class, tSSms.getId());
			req.setAttribute("tSSmsPage", tSSms);
		}
		return new ModelAndView("org/jeecgframework/web/sms/tSSms-add");
	}
	/**
	 * 消息发送记录表编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(TSSmsEntity tSSms, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(tSSms.getId())) {
			tSSms = tSSmsService.getEntity(TSSmsEntity.class, tSSms.getId());
			req.setAttribute("tSSmsPage", tSSms);
		}
		return new ModelAndView("org/jeecgframework/web/sms/tSSms-update");
	}
	
	/**
	 * 导入功能跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		return new ModelAndView("org/jeecgframework/web/sms/tSSmsUpload");
	}
	
	/**
	 * 导出excel
	 * 
	 * @param request
	 * @param response

	@RequestMapping(params = "exportXls")
	public void exportXls(TSSmsEntity tSSms,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid) {
		response.setContentType("application/vnd.ms-excel");
		String codedFileName = null;
		OutputStream fOut = null;
		try {
			codedFileName = "消息发送记录表";
			// 根据浏览器进行转码，使其支持中文文件名
			if (BrowserUtils.isIE(request)) {
				response.setHeader(
						"content-disposition",
						"attachment;filename="
								+ java.net.URLEncoder.encode(codedFileName,
										"UTF-8") + ".xls");
			} else {
				String newtitle = new String(codedFileName.getBytes("UTF-8"),
						"ISO8859-1");
				response.setHeader("content-disposition",
						"attachment;filename=" + newtitle + ".xls");
			}
			// 产生工作簿对象
			HSSFWorkbook workbook = null;
			CriteriaQuery cq = new CriteriaQuery(TSSmsEntity.class, dataGrid);
			org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, tSSms, request.getParameterMap());
			
			List<TSSmsEntity> tSSmss = this.tSSmsService.getListByCriteriaQuery(cq,false);
			workbook = ExcelExportUtil.exportExcel(new ExportParams("消息发送记录表列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
					"导出信息"), TSSmsEntity.class, tSSmss);
			fOut = response.getOutputStream();
			workbook.write(fOut);
		} catch (Exception e) {
		} finally {
			try {
				fOut.flush();
				fOut.close();
			} catch (IOException e) {

			}
		}
	}	 */
	/**
	 * 导出excel 使模板
	 * 
	 * @param request
	 * @param response
	 
	@RequestMapping(params = "exportXlsByT")
	public void exportXlsByT(TSSmsEntity tSSms,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid) {
		response.setContentType("application/vnd.ms-excel");
		String codedFileName = null;
		OutputStream fOut = null;
		try {
			codedFileName = "消息发送记录表";
			// 根据浏览器进行转码，使其支持中文文件名
			if (BrowserUtils.isIE(request)) {
				response.setHeader(
						"content-disposition",
						"attachment;filename="
								+ java.net.URLEncoder.encode(codedFileName,
										"UTF-8") + ".xls");
			} else {
				String newtitle = new String(codedFileName.getBytes("UTF-8"),
						"ISO8859-1");
				response.setHeader("content-disposition",
						"attachment;filename=" + newtitle + ".xls");
			}
			// 产生工作簿对象
			HSSFWorkbook workbook = null;
			workbook = ExcelExportUtil.exportExcel(new ExportParams("消息发送记录表列表", "导出人:"+ResourceUtil.getSessionUserName().getRealName(),
					"导出信息"), TSSmsEntity.class, null);
			fOut = response.getOutputStream();
			workbook.write(fOut);
		} catch (Exception e) {
		} finally {
			try {
				fOut.flush();
				fOut.close();
			} catch (IOException e) {

			}
		}
	}
	*/
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "importExcel", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson importExcel(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();
		
//		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
//		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
//		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
//			MultipartFile file = entity.getValue();// 获取上传文件对象
//			ImportParams params = new ImportParams();
//			params.setTitleRows(2);
//			params.setSecondTitleRows(1);
//			params.setNeedSave(true);
//			try {
//				List<TSSmsEntity> listTSSmsEntitys = 
//					(List<TSSmsEntity>)ExcelImportUtil.importExcelByIs(file.getInputStream(),TSSmsEntity.class,params);
//				for (TSSmsEntity tSSms : listTSSmsEntitys) {
//					tSSmsService.save(tSSms);
//				}
//				j.setMsg("文件导入成功！");
//			} catch (Exception e) {
//				j.setMsg("文件导入失败！");
//				logger.error(ExceptionUtil.getExceptionMessage(e));
//			}finally{
//				try {
//					file.getInputStream().close();
//				} catch (IOException e) {
//					e.printStackTrace();
//				}
//			}
//		}
		return j;
	}
}
