package org.jeecgframework.web.cgreport.controller.excel;

import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.online.def.CgReportConstant;
import org.jeecgframework.core.online.exception.CgReportNotFoundException;
import org.jeecgframework.core.online.util.CgReportQueryParamUtil;
import org.jeecgframework.core.util.DynamicDBUtil;
import org.jeecgframework.core.util.SqlUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.params.ExcelExportEntity;
import org.jeecgframework.poi.excel.entity.vo.MapExcelConstants;
import org.jeecgframework.web.cgreport.service.core.CgReportServiceI;

import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
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
	/**
	 * 将报表导出为excel
	 * @param request
	 * @param response
	 */
	@SuppressWarnings("all")
	@RequestMapping(params = "exportXls")
	public String exportXls(HttpServletRequest request,
			HttpServletResponse response,ModelMap modelMap) {
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

            String dbKey=(String)configM.get("db_source");
            List<Map<String, Object>> result=null;
            if(StringUtils.isNotBlank(dbKey)){
                result= DynamicDBUtil.findList(dbKey, SqlUtil.getFullSql(querySql,queryparams));
            }else{
                result= cgReportService.queryByCgReportSql(querySql, queryparams, -1, -1);
            }
			//--author：JueYue---------date:20150620--------for: 导出替换成EasyPoi
			List<ExcelExportEntity> entityList = new ArrayList<ExcelExportEntity>();
			for (int i = 0;i< fieldList.size();i++){
				entityList.add(new ExcelExportEntity(fieldList.get(i).get("field_txt").toString(),fieldList.get(i).get("field_name")));
			}
			modelMap.put(MapExcelConstants.ENTITY_LIST,entityList);
			modelMap.put(MapExcelConstants.MAP_LIST,result);
			modelMap.put(MapExcelConstants.FILE_NAME,codedFileName);
			modelMap.put(MapExcelConstants.PARAMS,new ExportParams(null,sheetName));
			return MapExcelConstants.JEECG_MAP_EXCEL_VIEW;
			//--author：JueYue---------date:20150620--------for: 导出替换成EasyPoi

		} else {
			throw new BusinessException("参数错误");
		}
	}
}
