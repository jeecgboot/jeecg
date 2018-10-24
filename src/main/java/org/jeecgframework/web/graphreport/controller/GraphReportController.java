package org.jeecgframework.web.graphreport.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.jeecgframework.web.cgreport.service.core.CgReportServiceI;
import org.jeecgframework.web.graphreport.service.core.GraphReportServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.service.CommonExcelServiceI;
import org.jeecgframework.core.enums.SysThemesEnum;
import org.jeecgframework.core.online.def.CgReportConstant;
import org.jeecgframework.core.online.exception.CgReportNotFoundException;
import org.jeecgframework.core.online.util.CgReportQueryParamUtil;
import org.jeecgframework.core.online.util.FreemarkerHelper;
import org.jeecgframework.core.util.BrowserUtils;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.SysThemesUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * @Title:CgReportController
 * @description:Online 图表配置控制器
 * @author 钟世云
 * @date 2015.4.11
 * @version V1.0
 */
@Controller
@RequestMapping("/graphReportController")
public class GraphReportController extends BaseController {
	@Autowired
	private GraphReportServiceI graphReportService;
	@Autowired
	private CgReportServiceI cgReportService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private CommonExcelServiceI cgReportExcelService;
	
	/**
	 * 动态报表展现入口
	 * @param id 动态配置ID-code
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "list")
	public void list(String id, HttpServletRequest request,
			HttpServletResponse response) {
		//step.1 根据id获取该动态报表的配置参数
		Map<String, Object>  cgReportMap = null;
		try{
			cgReportMap = graphReportService.queryCgReportConfig(id);
		}catch (Exception e) {
			throw new CgReportNotFoundException("动态报表配置不存在!");
		}
		//step.2 获取列表ftl模板路径
		FreemarkerHelper viewEngine = new FreemarkerHelper();
		//step.3 组合模板+数据参数，进行页面展现
		loadVars(cgReportMap);

		//step.4 页面css js引用
		cgReportMap.put(CgReportConstant.CONFIG_IFRAME, getHtmlHead(request));

		String html = viewEngine.parseTemplate("/org/jeecgframework/web/graphreport/engine/core/graphreportlist.ftl", cgReportMap);
		PrintWriter writer = null;
		try {
			response.setContentType("text/html");
			response.setHeader("Cache-Control", "no-store");
			writer = response.getWriter();
			writer.println(html);
			writer.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				writer.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	
	private String getHtmlHead(HttpServletRequest request){
		HttpSession session = ContextHolderUtils.getSession();
		String lang = (String)session.getAttribute("lang");
		StringBuilder sb= new StringBuilder("");

		sb.append("<meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"/>");

		SysThemesEnum sysThemesEnum = SysThemesUtil.getSysTheme(request);
		sb.append(SysThemesUtil.getReportTheme(sysThemesEnum));
		sb.append(SysThemesUtil.getCommonTheme(sysThemesEnum));
		sb.append("<script type=\"text/javascript\" src=\"plug-in/jquery/jquery-1.8.3.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/jquery-plugs/i18n/jquery.i18n.properties.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/dataformat.js\"></script>");
		sb.append(SysThemesUtil.getEasyUiTheme(sysThemesEnum));
		sb.append("<link rel=\"stylesheet\" href=\"plug-in/easyui/themes/icon.css\" type=\"text/css\"></link>");
		sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"plug-in/accordion/css/accordion.css\">");
		sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"plug-in/accordion/css/icons.css\">");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/easyui/jquery.easyui.min.1.3.2.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/easyui/locale/zh-cn.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/syUtil.js\"></script>");
		sb.append(SysThemesUtil.getLhgdialogTheme(sysThemesEnum));

		sb.append("<script type=\"text/javascript\" src=\"plug-in/layer/layer.js\"></script>");

		sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/curdtools.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/easyuiextend.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/easyui/extends/datagrid-scrollview.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/My97DatePicker/WdatePicker.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/graphreport/highcharts3.0.6.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/graphreport/spin.min.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/graphreport/report.js\"></script>");
		return sb.toString();
	}
	
	
	/**
	 * popup入口
	 * @param id 动态配置ID-code
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "popup")
	public void popup(String id, HttpServletRequest request,
			HttpServletResponse response) {
		//step.1 根据id获取该动态报表的配置参数
		Map<String, Object>  cgReportMap = null;
		try{
			cgReportMap = graphReportService.queryCgReportConfig(id);
		}catch (Exception e) {
			throw new CgReportNotFoundException("动态报表配置不存在!");
		}
		//step.2 获取列表ftl模板路径
		FreemarkerHelper viewEngine = new FreemarkerHelper();
		//step.3 组合模板+数据参数，进行页面展现
		loadVars(cgReportMap);

		//step.4 页面css js引用
		cgReportMap.put(CgReportConstant.CONFIG_IFRAME, getHtmlHead(request));

		String html = viewEngine.parseTemplate("/org/jeecgframework/web/cgreport/engine/core/cgreportlistpopup.ftl", cgReportMap);
		PrintWriter writer = null;
		try {
			response.setContentType("text/html");
			response.setHeader("Cache-Control", "no-store");
			writer = response.getWriter();
			writer.println(html);
			writer.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				writer.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	/**
	 * 组装模版参数
	 * @param cgReportMap
	 */
	@SuppressWarnings("unchecked")
	private void loadVars(Map<String, Object> cgReportMap) {
		Map mainM = (Map) cgReportMap.get(CgReportConstant.MAIN);

		List<Map<String,Object>> fieldList2 = (List<Map<String, Object>>) cgReportMap.get(CgReportConstant.ITEMS);
		List<Map<String,Object>> fieldList = new ArrayList<Map<String,Object>>();
		for (Map<String, Object> map : fieldList2) {
			Map<String, Object> temp = new HashMap<String, Object>();
			for (Entry<String, Object> entry : map.entrySet()) {
				String key = entry.getKey();
				temp.put(key.toLowerCase(), entry.getValue());
			}
			fieldList.add(temp);
		}

		List<Map<String,Object>> queryList = new ArrayList<Map<String,Object>>(0);
		//图表数据
		List<Map<String,Object>> graphList = new ArrayList<Map<String,Object>>(0);
		//tab数据
		Set<String> tabSet = new HashSet<String>();
		List<String> tabList = new ArrayList<String>();
		
		for(Map<String,Object> fl:fieldList){
			fl.put(CgReportConstant.ITEM_FIELDNAME, ((String)fl.get(CgReportConstant.ITEM_FIELDNAME)).toLowerCase());
			String isQuery = (String) fl.get(CgReportConstant.ITEM_ISQUERY);
			if(CgReportConstant.BOOL_TRUE.equalsIgnoreCase(isQuery)){
				cgReportService.loadDic(fl);
				queryList.add(fl);
			}
			if("y".equals(fl.get("is_graph")) || "Y".equals(fl.get("is_graph"))) {
				graphList.add(fl);
				String tabName = (fl.get("tab_name") == null ? "" : fl.get("tab_name").toString());
				if(!tabSet.contains(tabName)) {
					tabList.add(tabName);
					tabSet.add(tabName);
				}
			}
		}
		cgReportMap.put(CgReportConstant.CONFIG_ID, mainM.get("code"));
		cgReportMap.put(CgReportConstant.CONFIG_NAME, mainM.get("name"));
		cgReportMap.put(CgReportConstant.CONFIG_FIELDLIST, fieldList);
		cgReportMap.put(CgReportConstant.CONFIG_QUERYLIST, queryList);
		cgReportMap.put("graphList", graphList);
		cgReportMap.put("tabList", tabList);
	}


	
	/**
	 * 动态报表数据查询(不分页)
	 * @param configId 配置id-code
	 * @param request 
	 * @param response
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "datagridGraph")
	public void datagridGraph(String configId, HttpServletRequest request, HttpServletResponse response) {
		//step.1 根据id获取该动态报表的配置参数
		Map<String, Object>  cgReportMap = null;
		try{
			cgReportMap = graphReportService.queryCgReportConfig(configId);
			if(cgReportMap.size()<=0){
				throw new CgReportNotFoundException("动态报表配置不存在!");
			}
		}catch (Exception e) {
			throw new CgReportNotFoundException("查找动态报表配置失败!"+e.getMessage());
		}
		PrintWriter writer = null;
		try {
			//step.2 获取该配置的查询SQL
			Map configM = (Map) cgReportMap.get(CgReportConstant.MAIN);
			String querySql = (String) configM.get("CGR_SQL");
			List<Map<String,Object>> items = (List<Map<String, Object>>) cgReportMap.get(CgReportConstant.ITEMS);
			//页面参数查询字段（占位符的条件语句）
			Map pageSearchFields =  new LinkedHashMap<String,Object>();

			//获取查询条件数据
			Map<String,Object> paramData = new HashMap<String, Object>();
			for(Map<String,Object> item:items){
				String isQuery = (String) item.get(CgReportConstant.ITEM_ISQUERY);
				if(CgReportConstant.BOOL_TRUE.equalsIgnoreCase(isQuery)){
					//step.3 装载查询条件
					CgReportQueryParamUtil.loadQueryParams(request, item, pageSearchFields,paramData);
				}
			}
			//step.4 进行查询返回结果
			List<Map<String, Object>> result= graphReportService.queryByCgReportSql(querySql, pageSearchFields,paramData, -1, -1);

			cgReportService.dealDic(result,items);
			cgReportService.dealReplace(result,items);
			
			//导出execel
			List<String> fields = new ArrayList<String>();
			List<Map<String, Object>> configItems = (List<Map<String, Object>>) cgReportMap.get(CgReportConstant.ITEMS);
			for (Map<String, Object> map : configItems) {
				if("Y".equals(map.get("is_show"))) {
					fields.add(map.get("field_txt").toString());
					fields.add(map.get("field_name").toString());
				}
			}
			if(exportExecel(request, response, configM.get("content").toString(), configM.get("content").toString(), fields.toArray(new String[fields.size()]), result, null)) {
				return;
			}
			
			response.setContentType("application/json");
			response.setHeader("Cache-Control", "no-store");
		
			writer = response.getWriter();
			writer.println(CgReportQueryParamUtil.getJson(result, -1L));
			writer.flush();
		} catch (IOException e) {
			e.printStackTrace();
			throw new RuntimeException(e);
		}finally{
			try {
				writer.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	/**
	 * 动态报表数据查询
	 * @param configId 配置id-code
	 * @param page 分页页面
	 * @param rows 分页大小
	 * @param request 
	 * @param response
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "datagrid")
	public void datagrid(String configId,String page,String field,String rows, HttpServletRequest request,
			HttpServletResponse response) {
		//step.1 根据id获取该动态报表的配置参数
		Map<String, Object>  cgReportMap = null;
		try{
			cgReportMap = graphReportService.queryCgReportConfig(configId);
			if(cgReportMap.size()<=0){
				throw new CgReportNotFoundException("动态报表配置不存在!");
			}
		}catch (Exception e) {
			throw new CgReportNotFoundException("查找动态报表配置失败!"+e.getMessage());
		}
		//step.2 获取该配置的查询SQL
		Map configM = (Map) cgReportMap.get(CgReportConstant.MAIN);
		String querySql = (String) configM.get(CgReportConstant.CONFIG_SQL);
		List<Map<String,Object>> items = (List<Map<String, Object>>) cgReportMap.get(CgReportConstant.ITEMS);
		//页面参数查询字段（占位符的条件语句）
		Map pageSearchFields =  new LinkedHashMap<String,Object>();
		//获取查询条件数据
		Map<String,Object> paramData = new HashMap<String, Object>();
		for(Map<String,Object> item:items){
			String isQuery = (String) item.get(CgReportConstant.ITEM_ISQUERY);
			if(CgReportConstant.BOOL_TRUE.equalsIgnoreCase(isQuery)){
				//step.3 装载查询条件
				CgReportQueryParamUtil.loadQueryParams(request, item, pageSearchFields,paramData);
			}
		}
		//step.4 进行查询返回结果
		int p = page==null?1:Integer.parseInt(page);
		int r = rows==null?99999:Integer.parseInt(rows);
		List<Map<String, Object>> result= graphReportService.queryByCgReportSql(querySql, pageSearchFields, paramData, p, r);
		long size = graphReportService.countQueryByCgReportSql(querySql, pageSearchFields);
		cgReportService.dealDic(result,items);
		cgReportService.dealReplace(result,items);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-store");
		PrintWriter writer = null;
		try {
			writer = response.getWriter();
			writer.println(CgReportQueryParamUtil.getJson(result,size));
			writer.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				writer.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
	}
	/**
	 * 解析SQL，返回字段集
	 * @param sql
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "getFields", method = RequestMethod.POST)
	@ResponseBody
	public Object getSqlFields(String sql){
		List<String> result = null;
		Map reJson = new HashMap<String, Object>();
		try{
			result = graphReportService.getSqlFields(sql);
		}catch (Exception e) {
			e.printStackTrace();
			String errorInfo = "解析失败!<br><br>失败原因：";
			errorInfo += e.getMessage();
			reJson.put("status", "error");
			reJson.put("datas", errorInfo);
			return reJson;
		}
		reJson.put("status", "success");
		reJson.put("datas", result);
		return reJson;
	}
	
	
	/**
	 * 导出execel
	 */
	private boolean exportExecel(HttpServletRequest request, HttpServletResponse response, 
			String title, String tagName, String[] fields, List<Map<String, Object>> list, Map<String, Object> params) {
		if(!"1".equals(request.getParameter("export"))) {
			return false;
		}
		
		if(params == null) {
			params = new HashMap<String, Object>();
		}
		if(StringUtil.isEmpty(tagName)) {
			tagName = title;
		}
		
		response.setContentType("application/vnd.ms-excel");
		OutputStream fOut = null;
		try {
			//step.4 根据浏览器进行转码，使其支持中文文件名
			String browse = BrowserUtils.checkBrowse(request);
			if ("MSIE".equalsIgnoreCase(browse.substring(0, 4))) {
				response.setHeader("content-disposition",
						"attachment;filename=" + java.net.URLEncoder.encode(title, "UTF-8") + ".xls");
			} else {
				String newtitle = new String(title.getBytes("UTF-8"), "ISO8859-1");
				response.setHeader("content-disposition",
						"attachment;filename=" + newtitle + ".xls");
			}
			//step.5 产生工作簿对象
			HSSFWorkbook workbook = null;
			
			
			List<Map<String, Object>> fieldList = new ArrayList<Map<String, Object>>();
			for (int i = 0; i < fields.length; i++,i++) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("field_txt", fields[i]);
				map.put("field_name", fields[i + 1]);
				fieldList.add(map);
			}
			
			workbook = cgReportExcelService.exportExcel(tagName, fieldList, list);
			fOut = response.getOutputStream();
			workbook.write(fOut);
			//TODO 增加操作日志
			//systemService.addLog(MsgUtil.getOperationLogMsg("导出成功", title, params), Globals.Log_Type_EXPORT,
			//		Globals.Log_Leavel_INFO);
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				fOut.flush();
				fOut.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return true;
	}
}
