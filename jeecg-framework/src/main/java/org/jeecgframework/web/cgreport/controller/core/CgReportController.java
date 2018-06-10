package org.jeecgframework.web.cgreport.controller.core;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.enums.SysThemesEnum;
import org.jeecgframework.core.online.def.CgReportConstant;
import org.jeecgframework.core.online.exception.CgReportNotFoundException;
import org.jeecgframework.core.online.util.CgReportQueryParamUtil;
import org.jeecgframework.core.online.util.FreemarkerHelper;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.DynamicDBUtil;
import org.jeecgframework.core.util.SqlInjectionUtil;
import org.jeecgframework.core.util.SqlUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.SysThemesUtil;
import org.jeecgframework.web.cgreport.service.core.CgReportServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
/**
 * 
 * @Title:CgReportController
 * @description:动态报表展示控制器
 * @author 赵俊夫
 * @date Jul 29, 2013 9:39:40 PM
 * @version V1.0
 */
@Controller
@RequestMapping("/cgReportController")
public class CgReportController extends BaseController {
	@Autowired
	private CgReportServiceI cgReportService;
	/**
	 * 动态报表展现入口
	 * @param id 动态配置ID-code
	 * @param request
	 * @param response
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "list")
	public void list(String id, HttpServletRequest request,
			HttpServletResponse response) {
		//step.1 根据id获取该动态报表的配置参数
		Map<String, Object>  cgReportMap = null;
		try{
			cgReportMap = cgReportService.queryCgReportConfig(id);
		}catch (Exception e) {
			throw new CgReportNotFoundException("动态报表配置不存在!");
		}
		//step.2 获取列表ftl模板路径
		FreemarkerHelper viewEngine = new FreemarkerHelper();
		//step.3 组合模板+数据参数，进行页面展现
		loadVars(cgReportMap,request);

		//step.4 页面css js引用
		cgReportMap.put(CgReportConstant.CONFIG_IFRAME, getHtmlHead(request));

		String html = viewEngine.parseTemplate("/org/jeecgframework/web/cgreport/engine/core/cgreportlist.ftl", cgReportMap);
		PrintWriter writer = null;
		try {
			response.setContentType("text/html");
			response.setHeader("Cache-Control", "no-store");
			writer = response.getWriter();
			writer.println(html);
			//System.out.println(html);
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

		SysThemesEnum sysThemesEnum = SysThemesUtil.getSysTheme(request);
		sb.append("<script type=\"text/javascript\" src=\"plug-in/jquery/jquery-1.8.3.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/dataformat.js\"></script>");
		sb.append(SysThemesUtil.getEasyUiTheme(sysThemesEnum));
		sb.append(SysThemesUtil.getEasyUiMainTheme(sysThemesEnum));
		sb.append(SysThemesUtil.getEasyUiIconTheme(sysThemesEnum));
//		sb.append("<link rel=\"stylesheet\" href=\"plug-in/easyui/themes/icon.css\" type=\"text/css\"></link>");
		sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"plug-in/accordion/css/accordion.css\">");
		sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"plug-in/accordion/css/icons.css\">");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/easyui/jquery.easyui.min.1.3.2.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/easyui/locale/zh-cn.js\"></script>");
		sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/syUtil.js\"></script>");
		sb.append(SysThemesUtil.getCommonTheme(sysThemesEnum));
		sb.append(SysThemesUtil.getLhgdialogTheme(sysThemesEnum));
		sb.append(SysThemesUtil.getBootstrapTabTheme(sysThemesEnum));
		sb.append(SysThemesUtil.getValidformStyleTheme(sysThemesEnum));
		sb.append(SysThemesUtil.getValidformTablefrom(sysThemesEnum));

		sb.append("<script type=\"text/javascript\" src=\"plug-in/layer/layer.js\"></script>");

		sb.append(StringUtil.replace("<script type=\"text/javascript\" src=\"plug-in/tools/curdtools_{0}.js\"></script>", "{0}", lang));
		sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/easyuiextend.js\"></script>");
		return sb.toString();
	}
	
	/**
	 * popup入口
	 * @param id 动态配置ID-code
	 * @param request
	 * @param response
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "popup")
	public void popup(String id, HttpServletRequest request,
			HttpServletResponse response) {
		//step.1 根据id获取该动态报表的配置参数
		Map<String, Object>  cgReportMap = null;
		try{
			cgReportMap = cgReportService.queryCgReportConfig(id);
		}catch (Exception e) {
			throw new CgReportNotFoundException("动态报表配置不存在!");
		}
		//step.2 获取列表ftl模板路径
		FreemarkerHelper viewEngine = new FreemarkerHelper();
		//step.3 组合模板+数据参数，进行页面展现
		loadVars(cgReportMap,request);

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
	private void loadVars(Map<String, Object> cgReportMap,HttpServletRequest request) {
		Map mainM = (Map) cgReportMap.get(CgReportConstant.MAIN);
		List<Map<String,Object>> fieldList = (List<Map<String, Object>>) cgReportMap.get(CgReportConstant.ITEMS);
		List<String> paramList = (List<String>)cgReportMap.get(CgReportConstant.PARAMS);
		List<Map<String,Object>> queryList = new ArrayList<Map<String,Object>>(0);
		for(Map<String,Object> fl:fieldList){
			fl.put(CgReportConstant.ITEM_FIELDNAME, ((String)fl.get(CgReportConstant.ITEM_FIELDNAME)).toLowerCase());
			String isQuery = (String) fl.get(CgReportConstant.ITEM_ISQUERY);
			if(CgReportConstant.BOOL_TRUE.equalsIgnoreCase(isQuery)){
				cgReportService.loadDic(fl);
				queryList.add(fl);
			}
		}
		StringBuilder sb = new StringBuilder("");
		if(paramList!=null&&paramList.size()>0){
			queryList = new ArrayList<Map<String,Object>>(0);
			for(String param:paramList){
				sb.append("&").append(param).append("=");
				String value = request.getParameter(param);
    			if(StringUtil.isNotEmpty(value)){
    				sb.append(value);
    			}
			}
		}
		cgReportMap.put(CgReportConstant.CONFIG_ID, mainM.get("code"));
		cgReportMap.put(CgReportConstant.CONFIG_NAME, mainM.get("name"));
		cgReportMap.put(CgReportConstant.CONFIG_FIELDLIST, fieldList);
		cgReportMap.put(CgReportConstant.CONFIG_QUERYLIST, queryList);
		//获取传递参数
		cgReportMap.put(CgReportConstant.CONFIG_PARAMS, sb.toString());
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
			cgReportMap = cgReportService.queryCgReportConfig(configId);
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
		List<String> paramList = (List<String>) cgReportMap.get(CgReportConstant.PARAMS);
		Map queryparams =  new LinkedHashMap<String,Object>();
		if(paramList!=null&&paramList.size()>0){
			for(String param :paramList){
				String value = request.getParameter(param);
				value = value==null?"":value;

				SqlInjectionUtil.filterContent(value);

				querySql = querySql.replace("${"+param+"}", value);
			}
		}else{
			for(Map<String,Object> item:items){
				String isQuery = (String) item.get(CgReportConstant.ITEM_ISQUERY);
				if(CgReportConstant.BOOL_TRUE.equalsIgnoreCase(isQuery)){
					//step.3 装载查询条件
					CgReportQueryParamUtil.loadQueryParams(request, item, queryparams);
				}
			}
		}
		//step.4 进行查询返回结果
		int p = page==null?1:Integer.parseInt(page);
		int r = rows==null?99999:Integer.parseInt(rows);

        String dbKey=(String)configM.get("db_source");
        List<Map<String, Object>> result=null;
        Long size=0l;
        if(StringUtils.isNotBlank(dbKey)){
            result= DynamicDBUtil.findList(dbKey,SqlUtil.jeecgCreatePageSql(dbKey,querySql,queryparams,p,r));

            Map map=(Map)DynamicDBUtil.findOne(dbKey,SqlUtil.getCountSql(querySql,queryparams));

            if(map.get("COUNT(*)") instanceof BigDecimal){
            	BigDecimal count = (BigDecimal)map.get("COUNT(*)");
            	size = count.longValue();
            }else{
            	size=(Long)map.get("COUNT(*)");
            }
        }else{
            result= cgReportService.queryByCgReportSql(querySql, queryparams, p, r);
            size = cgReportService.countQueryByCgReportSql(querySql, queryparams);
        }

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
	public Object getSqlFields(String sql,String dbKey){
		List<String> fields = null;
		List<String> params = null;
		Map reJson = new HashMap<String, Object>();
		try{
			fields = cgReportService.getFields(sql, dbKey);
			params = cgReportService.getSqlParams(sql);
		}catch (Exception e) {
			e.printStackTrace();
			String errorInfo = "解析失败!<br><br>失败原因：";

			//无法直接捕捉到:java.net.ConnectException异常
			int i = e.getMessage().indexOf("Connection refused: connect");
			
			if (i != -1) {//非链接异常
				errorInfo += "数据源连接失败.";
			}else{
				errorInfo += "SQL语法错误.";
			}

			reJson.put("status", "error");
			reJson.put("datas", errorInfo);
			return reJson;
		}
		reJson.put("status", "success");
		reJson.put("fields", fields);
		reJson.put("params", params);
		return reJson;
	}
	
}
