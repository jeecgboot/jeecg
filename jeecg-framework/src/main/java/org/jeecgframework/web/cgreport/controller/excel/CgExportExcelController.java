package org.jeecgframework.web.cgreport.controller.excel;

import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.web.cgreport.common.CgReportConstant;
import org.jeecgframework.web.cgreport.exception.CgReportNotFoundException;
import org.jeecgframework.web.cgreport.service.core.CgReportServiceI;
import org.jeecgframework.web.cgreport.service.excel.CgReportExcelServiceI;
import org.jeecgframework.web.cgreport.util.CgReportQueryParamUtil;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.util.BrowserUtils;
import org.jeecgframework.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
/**
 * 
 * @Title:ExportExcelController
 * @description:报表excel导出
 * @author 赵俊夫
 * @date Aug 1, 2013 10:52:26 AM
 * @version V1.0
 */
@Controller
@RequestMapping("/cgExportExcelController")
public class CgExportExcelController extends BaseController {
	@Autowired
	private CgReportServiceI cgReportService;
	@Autowired
	private CgReportExcelServiceI cgReportExcelService;
	/**
	 * 将报表导出为excel
	 * @param request
	 * @param response
	 */
	@SuppressWarnings("all")
	@RequestMapping(params = "exportXls")
	public void exportXls(HttpServletRequest request,
			HttpServletResponse response) {
		//step.1 设置，获取配置信息
		String codedFileName = "报表";
		String sheetName="导出信息";
		if (StringUtil.isNotEmpty(request.getParameter("configId"))) {
			String configId = request.getParameter("configId");
			Map<String, Object> cgReportMap = null;
			try{
				cgReportMap = cgReportService.queryCgReportConfig(configId);
			}catch (Exception e) {
				throw new CgReportNotFoundException("动态报表配置不存在!");
			}
			List<Map<String,Object>> fieldList = (List<Map<String, Object>>) cgReportMap.get(CgReportConstant.ITEMS);
			Map configM = (Map) cgReportMap.get(CgReportConstant.MAIN);
			codedFileName = configM.get("name")+codedFileName;
			String querySql = (String) configM.get(CgReportConstant.CONFIG_SQL);
			List<Map<String,Object>> items = (List<Map<String, Object>>) cgReportMap.get(CgReportConstant.ITEMS);
			Map queryparams =  new LinkedHashMap<String,Object>();
			for(Map<String,Object> item:items){
				String isQuery = (String) item.get(CgReportConstant.ITEM_ISQUERY);
				if(CgReportConstant.BOOL_TRUE.equalsIgnoreCase(isQuery)){
					//step.2 装载查询条件
					CgReportQueryParamUtil.loadQueryParams(request, item, queryparams);
				}
			}
			//step.3 进行查询返回结果
			List<Map<String, Object>> result= cgReportService.queryByCgReportSql(querySql, queryparams, -1, -1);
			
			response.setContentType("application/vnd.ms-excel");
			OutputStream fOut = null;
			try {

				//step.4 根据浏览器进行转码，使其支持中文文件名
				String browse = BrowserUtils.checkBrowse(request);
				if ("MSIE".equalsIgnoreCase(browse.substring(0, 4))) {
					response.setHeader("content-disposition",
							"attachment;filename="
									+ java.net.URLEncoder.encode(codedFileName,
											"UTF-8") + ".xls");
				} else {
					String newtitle = new String(codedFileName.getBytes("UTF-8"),
							"ISO8859-1");
					response.setHeader("content-disposition",
							"attachment;filename=" + newtitle + ".xls");
				}
				//step.5 产生工作簿对象
				HSSFWorkbook workbook = null;
				workbook = cgReportExcelService.exportExcel(codedFileName, fieldList, result);
				fOut = response.getOutputStream();
				workbook.write(fOut);
			} catch (UnsupportedEncodingException e1) {

			} catch (Exception e) {

			} finally {
				try {
					fOut.flush();
					fOut.close();
				} catch (IOException e) {

				}
			}
		} else {
			throw new BusinessException("参数错误");
		}
	}
}
