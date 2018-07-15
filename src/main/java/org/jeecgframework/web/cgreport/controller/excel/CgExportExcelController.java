package org.jeecgframework.web.cgreport.controller.excel;

import java.util.ArrayList;
import java.util.HashMap;
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
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.SqlUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.params.ExcelExportEntity;
import org.jeecgframework.poi.excel.entity.vo.MapExcelConstants;
import org.jeecgframework.web.cgreport.service.core.CgReportServiceI;
import org.jeecgframework.web.system.pojo.base.TSType;
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
			List<String> paramList = (List<String>) cgReportMap.get(CgReportConstant.PARAMS);
			//页面参数查询字段（占位符的条件语句）
			Map pageSearchFields =  new LinkedHashMap<String,Object>();

			//获取查询条件数据
			Map<String,Object> paramData = new HashMap<String, Object>();
			if(paramList!=null&&paramList.size()>0){
				for(String param :paramList){
					String value = request.getParameter(param);
					value = value==null?"":value;
					querySql = querySql.replace("'${"+param+"}'", ":"+param);
					querySql = querySql.replace("${"+param+"}", ":"+param);
					paramData.put(param, value);
				}
			}
			for(Map<String,Object> item:items){
				String isQuery = (String) item.get(CgReportConstant.ITEM_ISQUERY);
				if(CgReportConstant.BOOL_TRUE.equalsIgnoreCase(isQuery)){
					//step.2 装载查询条件
					CgReportQueryParamUtil.loadQueryParams(request, item, pageSearchFields,paramData);
				}
			}

			//step.3 进行查询返回结果

            String dbKey=(String)configM.get("db_source");
            List<Map<String, Object>> result=null;
            if(StringUtils.isNotBlank(dbKey)){

            	if(paramData!=null&&paramData.size()>0){
            		result= DynamicDBUtil.findListByHash(dbKey,SqlUtil.getFullSql(querySql,pageSearchFields),(HashMap<String, Object>)paramData);
            	}else{
            		result= DynamicDBUtil.findList(dbKey, SqlUtil.getFullSql(querySql,pageSearchFields));
            	}

            }else{

                result= cgReportService.queryByCgReportSql(querySql, pageSearchFields,paramData, -1, -1);

            }
			//--author：JueYue---------date:20150620--------for: 导出替换成EasyPoi
			List<ExcelExportEntity> entityList = new ArrayList<ExcelExportEntity>();

			//配置字典的字段列表
			List<Map<String,Object>> dictFieldList=new ArrayList<Map<String,Object>>();
			//字典value值列表
			Map<String,String> dictMap = new HashMap<String, String>();
			for (int i = 0;i< fieldList.size();i++){
				entityList.add(new ExcelExportEntity(fieldList.get(i).get("field_txt").toString(),fieldList.get(i).get("field_name")));
				Object dictCode=fieldList.get(i).get("dict_code");
				if(oConvertUtils.isNotEmpty(dictCode)) {
					dictFieldList.add(fieldList.get(i));
					List<TSType> types = ResourceUtil.getCacheTypes(dictCode.toString().toLowerCase());
					for (TSType tsType : types) {
						dictMap.put(dictCode.toString()+"_"+tsType.getTypecode(), tsType.getTypename());
					}
				}
			}
			
			//循环字典字段，进行字典值翻译
			for (Map<String, Object> map : result) {
				for (Map<String,Object> dictField : dictFieldList) {
					String field_name = dictField.get("field_name").toString();
					if(oConvertUtils.isNotEmpty(map.get(field_name))) {
						String field_value = map.get(field_name).toString();
						field_value=dictMap.get(dictField.get("dict_code")+"_"+field_value);
						if(oConvertUtils.isNotEmpty(field_value))map.put(field_name, MutiLangUtil.doMutiLang(field_value, null));
					}
				}
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
