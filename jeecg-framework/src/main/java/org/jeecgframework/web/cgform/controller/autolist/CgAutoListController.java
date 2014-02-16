package org.jeecgframework.web.cgform.controller.autolist;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.web.cgform.common.CgAutoListConstant;
import org.jeecgframework.web.cgform.common.SysVar;
import org.jeecgframework.web.cgform.engine.FreemarkerHelper;
import org.jeecgframework.web.cgform.entity.config.CgFormFieldEntity;
import org.jeecgframework.web.cgform.service.autolist.CgTableServiceI;
import org.jeecgframework.web.cgform.service.autolist.ConfigServiceI;
import org.jeecgframework.web.cgform.service.config.CgFormFieldServiceI;
import org.jeecgframework.web.cgform.util.QueryParamUtil;
import org.jeecgframework.web.system.service.SystemService;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * 
 * @Title:CgAutoListController
 * @description:动态列表控制器[根据表名读取配置文件，进行动态数据展现]
 * @author 赵俊夫
 * @date Jul 5, 2013 2:55:36 PM
 * @version V1.0
 */
@Controller
@RequestMapping("/cgAutoListController")
public class CgAutoListController extends BaseController{
	@Autowired
	private ConfigServiceI configService;
	@Autowired
	private CgTableServiceI cgTableService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private CgFormFieldServiceI cgFormFieldService;
	private static Logger log = Logger.getLogger(CgAutoListController.class);
	/**
	 * 动态列表展现入口
	 * @param id 动态配置ID
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "list")
	public void list(String id, HttpServletRequest request,
			HttpServletResponse response) {
		long start = System.currentTimeMillis();
		//step.1 根据表名获取该表单的配置参数
		String jversion = cgFormFieldService.getCgFormVersionByTableName(id);
		Map<String, Object> configs = configService.queryConfigs(id,jversion);
		//step.2 获取列表ftl模板路径
		FreemarkerHelper viewEngine = new FreemarkerHelper();
		Map<String, Object> paras = new HashMap<String, Object>();
		//step.3 封装页面数据
		loadVars(configs,paras,request);
		//step.4 组合模板+数据参数，进行页面展现
		String html = viewEngine.parseTemplate("/org/jeecgframework/web/cgform/engine/autolist/autolist.ftl", paras);
		try {
			response.setContentType("text/html");
			response.setHeader("Cache-Control", "no-store");
			PrintWriter writer = response.getWriter();
			writer.println(html);
			writer.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		long end = System.currentTimeMillis();
		log.debug("动态列表生成耗时："+(end-start)+" ms");
	}

	/**
	 * 动态列表数据查询
	 * @param configId 配置id 修正使用id会造成主键查询的冲突
	 * @param page 分页页面
	 * @param rows 分页大小
	 * @param request 
	 * @param response
	 * @param dataGrid
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "datagrid")
	public void datagrid(String configId,String page,String field,String rows,String sort,String order, HttpServletRequest request,
			HttpServletResponse response, DataGrid dataGrid) {
		long start = System.currentTimeMillis();
		//step.1 获取动态配置
		String jversion = cgFormFieldService.getCgFormVersionByTableName(configId);
		Map<String, Object>  configs = configService.queryConfigs(configId,jversion);
		String table = (String) configs.get(CgAutoListConstant.TABLENAME);
		Map params =  new HashMap<String,Object>();
		//step.2 获取查询条件以及值
		List<CgFormFieldEntity> beans = (List<CgFormFieldEntity>) configs.get(CgAutoListConstant.FILEDS);
		for(CgFormFieldEntity b:beans){
//			if(CgAutoListConstant.BOOL_TRUE.equals(b.getIsQuery())){
				QueryParamUtil.loadQueryParams(request,b,params);
//			}
		}
		int p = page==null?1:Integer.parseInt(page);
		int r = rows==null?99999:Integer.parseInt(rows);
		//step.3 进行查询返回结果
		List<Map<String, Object>> result=cgTableService.querySingle(table, field.toString(), params,sort,order, p,r );
		Long size = cgTableService.getQuerySingleSize(table, field, params);
		dealDic(result,beans);
		response.setContentType("application/json");
		response.setHeader("Cache-Control", "no-store");
		PrintWriter writer;
		try {
			writer = response.getWriter();
			writer.println(QueryParamUtil.getJson(result,size));
			writer.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		long end = System.currentTimeMillis();
		log.debug("动态列表查询耗时："+(end-start)+" ms");
	}
	/**
	 * 处理数据字典
	 * @param result 查询的结果集
	 * @param beans 字段配置
	 */
	@SuppressWarnings("unchecked")
	private void dealDic(List<Map<String, Object>> result,
			List<CgFormFieldEntity> beans) {
		for(CgFormFieldEntity bean:beans){
			String dicT = bean.getDictTable();//字典表
			String dicF = bean.getDictField();//字典字段
			String dicText= bean.getDictText();//字典文本
			if(StringUtil.isEmpty(dicT)&& StringUtil.isEmpty(dicF)){
				//不需要处理字典
				continue;
			}else{
				if(!bean.getShowType().equals("popup")){
					List<Map<String, Object>> dicDatas = queryDic(dicT, dicF,dicText);
					for(Map r:result){
						String value = String.valueOf(r.get(bean.getFieldName()));
						for(Map m:dicDatas){
							String typecode = String.valueOf(m.get("typecode"));
							String typename = String.valueOf(m.get("typename"));
							if(value.equalsIgnoreCase(typecode)){
								r.put(bean.getFieldName(),typename);
							}
						}
					}
				}
			}
		}
	}

	/**
	 * 删除动态表
	 * @param configId 配置id
	 * @param id 主键
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(String configId,String id,
			HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String jversion = cgFormFieldService.getCgFormVersionByTableName(configId);
		String table = (String) configService.queryConfigs(configId,jversion).get(CgAutoListConstant.TABLENAME);
		cgTableService.delete(table, id);
		String message = "删除成功";
		systemService.addLog(message, Globals.Log_Type_DEL,
				Globals.Log_Leavel_INFO);
		j.setMsg(message);
		return j;
	}
	/**
	 * 删除动态表-批量
	 * @param configId 配置id
	 * @param id 主键
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "delBatch")
	@ResponseBody
	public AjaxJson delBatch(String configId,String ids,
			HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String jversion = cgFormFieldService.getCgFormVersionByTableName(configId);
		String table = (String) configService.queryConfigs(configId,jversion).get(CgAutoListConstant.TABLENAME);
		String message = "删除成功";
		try {
			String[] id = ids.split(",");
			cgTableService.deleteBatch(table, id);
		} catch (Exception e) {
			message = e.getMessage();
		}
		systemService.addLog(message, Globals.Log_Type_DEL,
				Globals.Log_Leavel_INFO);
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 装载要传入到ftl中的变量
	 * @param configs 从数据库中取出来的配置
	 * @param paras 要传入ftl的参数（需要对configs进行一些改造）
	 * @param request 
	 * @return 要传入ftl的参数（该方法直接操作paras容器，当然可以使用此返回值）
	 */
	@SuppressWarnings("unchecked")
	private Map loadVars(Map<String, Object> configs,Map<String, Object> paras, HttpServletRequest request) {
		paras.putAll(configs);
		List<Map> fieldList = new ArrayList<Map>();
		List<Map> queryList = new ArrayList<Map>();
		StringBuilder fileds = new StringBuilder();
		StringBuilder initQuery = new StringBuilder();
		for (CgFormFieldEntity bean : (List<CgFormFieldEntity>) configs.get(CgAutoListConstant.FILEDS)) {
			Map fm = new HashMap<String, Object>();
			fm.put(CgAutoListConstant.FILED_ID, bean.getFieldName());
			fm.put(CgAutoListConstant.FIELD_TITLE, bean.getContent());
			String isShowList = bean.getIsShowList();
			if(StringUtil.isEmpty(isShowList)){
				if("id".equalsIgnoreCase(bean.getFieldName())){
					isShowList = CgAutoListConstant.BOOL_FALSE;
				}else{
					isShowList = CgAutoListConstant.BOOL_TRUE;
				}
			}
			fm.put(CgAutoListConstant.FIELD_ISSHOW, isShowList);
			fm.put(CgAutoListConstant.FIELD_QUERYMODE, bean.getQueryMode());
			fm.put(CgAutoListConstant.FIELD_SHOWTYPE, bean.getShowType());
			fm.put(CgAutoListConstant.FIELD_TYPE, bean.getType());
			fm.put(CgAutoListConstant.FIELD_LENGTH, bean.getFieldLength()==null?"120":bean.getFieldLength());
			fm.put(CgAutoListConstant.FIELD_HREF, bean.getFieldHref()==null?"":bean.getFieldHref());
			loadDic(fm,bean);
			fieldList.add(fm);
			if (CgAutoListConstant.BOOL_TRUE.equals(bean.getIsQuery())) {
				Map fmq = new HashMap<String, Object>();
				fmq.put(CgAutoListConstant.FILED_ID, bean.getFieldName());
				fmq.put(CgAutoListConstant.FIELD_TITLE, bean.getContent());
				fmq.put(CgAutoListConstant.FIELD_QUERYMODE, bean.getQueryMode());
				fmq.put(CgAutoListConstant.FIELD_TYPE, bean.getType());
				fmq.put(CgAutoListConstant.FIELD_SHOWTYPE, bean.getShowType());
				fmq.put(CgAutoListConstant.FIELD_DICTFIELD, bean.getDictField());
				fmq.put(CgAutoListConstant.FIELD_DICTTABLE, bean.getDictTable());
				fmq.put(CgAutoListConstant.FIELD_ISQUERY,"Y");
				loadDefaultValue(fmq,bean,request);
				loadDic(fmq,bean);
				queryList.add(fmq);
			}
			loadUrlDataFilter(queryList,bean,request);
			loadInitQuery(initQuery,bean,request);
			fileds.append(bean.getFieldName()).append(",");
		}
		loadAuth(paras, request);
		loadIframeConfig(paras, request);
		paras.put(CgAutoListConstant.CONFIG_FIELDLIST, fieldList);
		paras.put(CgAutoListConstant.CONFIG_QUERYLIST, queryList);
		paras.put(CgAutoListConstant.FILEDS, fileds);
		paras.put(CgAutoListConstant.INITQUERY, initQuery);
		return paras;
	}
	/**
	 * 加载iframe设置
	 * @param paras
	 * @param request
	 */
	private void loadIframeConfig(Map<String, Object> paras,
			HttpServletRequest request) {
		//如果列表以iframe形式的话，需要加入样式文件
		StringBuilder sb= new StringBuilder("");
		if(request.getQueryString().contains("isIframe")){
			sb.append("<script type=\"text/javascript\" src=\"plug-in/jquery/jquery-1.8.3.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/dataformat.js\"></script>");
			sb.append("<link id=\"easyuiTheme\" rel=\"stylesheet\" href=\"plug-in/easyui/themes/default/easyui.css\" type=\"text/css\"></link>");
			sb.append("<link rel=\"stylesheet\" href=\"plug-in/easyui/themes/icon.css\" type=\"text/css\"></link>");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"plug-in/accordion/css/accordion.css\">");
			sb.append("<link rel=\"stylesheet\" type=\"text/css\" href=\"plug-in/accordion/css/icons.css\">");
			sb.append("<script type=\"text/javascript\" src=\"plug-in/easyui/jquery.easyui.min.1.3.2.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\"plug-in/easyui/locale/easyui-lang-zh_CN.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/syUtil.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\"plug-in/My97DatePicker/WdatePicker.js\"></script>");
			sb.append("<link rel=\"stylesheet\" href=\"plug-in/tools/css/common.css\" type=\"text/css\"></link>");
			sb.append("<script type=\"text/javascript\" src=\"plug-in/lhgDialog/lhgdialog.min.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/curdtools.js\"></script>");
			sb.append("<script type=\"text/javascript\" src=\"plug-in/tools/easyuiextend.js\"></script>");
		}else{
		}
		paras.put(CgAutoListConstant.CONFIG_IFRAME, sb.toString());
	}
	/**
	 * 加载按钮权限
	 * @param paras
	 * @param request
	 */
	private void loadAuth(Map<String, Object> paras, HttpServletRequest request) {
		List<String> nolist = (List<String>) request.getAttribute("noauto_operationCodes");
		if(ResourceUtil.getSessionUserName().getUserName().equals("admin")|| !Globals.BUTTON_AUTHORITY_CHECK){
			nolist = null;
		}
		String nolistStr = "";
		if(nolist!=null){
			for(String no:nolist){
				nolistStr+=no;
				nolistStr+=",";
			}
		}
		paras.put(CgAutoListConstant.CONFIG_NOLIST, nolist==null?new ArrayList<String>(0):nolist);
		paras.put(CgAutoListConstant.CONFIG_NOLISTSTR, nolistStr==null?"":nolistStr);
	}
	/**
	 * 加载列表初始查询条件-
	 * @param initQuery
	 * @param bean
	 * @param request
	 */
	private void loadInitQuery(StringBuilder initQuery, CgFormFieldEntity bean,
			HttpServletRequest request) {
		if(bean.getFieldName().equalsIgnoreCase("id")){
			return;
		}
		String paramV = request.getParameter(bean.getFieldName());
		String paramVbegin = request.getParameter(bean.getFieldName()+"_begin");
		String paramVend = request.getParameter(bean.getFieldName()+"_end");
		paramV = SysVar.getSysVar(paramV);
		paramVbegin = SysVar.getSysVar(paramVbegin);
		paramVend = SysVar.getSysVar(paramVend);
		if(!StringUtil.isEmpty(paramV)){
			initQuery.append("&"+bean.getFieldName()+"="+paramV);
		}
		if(!StringUtil.isEmpty(paramVbegin)){
			initQuery.append("&"+bean.getFieldName()+"_begin="+paramVbegin);
		}
		if(!StringUtil.isEmpty(paramVend)){
			initQuery.append("&"+bean.getFieldName()+"_end="+paramVend);
		}
	}

	/**
	 * 加载URL中的过滤参数[在未配置查询字段的情况下，作为hidden控件使用]
	 * @param queryList
	 * @param bean
	 * @param request
	 */
	@SuppressWarnings("unchecked")
	private void loadUrlDataFilter(List<Map> queryList, CgFormFieldEntity bean,
			HttpServletRequest request) {
		String paramV = request.getParameter(bean.getFieldName());
		String paramVbegin = request.getParameter(bean.getFieldName()+"_begin");
		String paramVend = request.getParameter(bean.getFieldName()+"_end");
		if(bean.getFieldName().equalsIgnoreCase("id")){
			return;
		}
		for(Map mq:queryList){
			if(mq.containsValue(bean.getFieldName())){
				return;
			}
		}
		if(!StringUtil.isEmpty(paramV) || !StringUtil.isEmpty(paramVbegin) ||!StringUtil.isEmpty(paramVend)){
			Map fmq = new HashMap<String, Object>();
			fmq.put(CgAutoListConstant.FILED_ID, bean.getFieldName());
			fmq.put(CgAutoListConstant.FIELD_TITLE, bean.getContent());
			fmq.put(CgAutoListConstant.FIELD_QUERYMODE, bean.getQueryMode());
			fmq.put(CgAutoListConstant.FIELD_TYPE, bean.getType());
			fmq.put(CgAutoListConstant.FIELD_ISQUERY,"N");
			paramV = SysVar.getSysVar(paramV);
			fmq.put(CgAutoListConstant.FIELD_VALUE, paramV);
			paramVbegin = SysVar.getSysVar(paramVbegin);
			paramVend = SysVar.getSysVar(paramVend);
			fmq.put(CgAutoListConstant.FIELD_VALUE_BEGIN, StringUtil.isEmpty(paramVbegin)?"":paramVbegin);
			fmq.put(CgAutoListConstant.FIELD_VALUE_END, StringUtil.isEmpty(paramVend)?"":paramVend);
			queryList.add(fmq);
		}
	}

	/**
	 * 加载URL中的过滤参数[在已配置查询字段的情况下，给该查询字段加上默认值]
	 * @param fmq
	 * @param bean
	 * @param request
	 */
	@SuppressWarnings("unchecked")
	private void loadDefaultValue(Map fmq, CgFormFieldEntity bean,
			HttpServletRequest request) {
		if(bean.getQueryMode().equalsIgnoreCase("single")){
			String paramV = request.getParameter(bean.getFieldName());
			if(!StringUtil.isEmpty(paramV)){
				paramV = SysVar.getSysVar(paramV);
				fmq.put(CgAutoListConstant.FIELD_VALUE, paramV);
			}
		}else if(bean.getQueryMode().equalsIgnoreCase("group")){
			String paramVbegin = request.getParameter(bean.getFieldName()+"_begin");
			String paramVend = request.getParameter(bean.getFieldName()+"_end");
			paramVbegin = SysVar.getSysVar(paramVbegin);
			paramVend = SysVar.getSysVar(paramVend);
			fmq.put(CgAutoListConstant.FIELD_VALUE_BEGIN, StringUtil.isEmpty(paramVbegin)?"":paramVbegin);
			fmq.put(CgAutoListConstant.FIELD_VALUE_END, StringUtil.isEmpty(paramVend)?"":paramVend);
		}
	}

	/**
	 * 装载数据字典
	 * @param m	要放入freemarker的数据
	 * @param bean 读取出来的动态配置数据
	 */
	@SuppressWarnings("unchecked")
	private void loadDic(Map m, CgFormFieldEntity bean) {
		String dicT = bean.getDictTable();//字典表
		String dicF = bean.getDictField();//字典字段
		String dicText = bean.getDictText();//字典文本
		if(StringUtil.isEmpty(dicT)&& StringUtil.isEmpty(dicF)){
			//如果这两个字段都为空，则没有数据字典
			m.put(CgAutoListConstant.FIELD_DICTLIST, new ArrayList(0));
			return;
		}
		if(!bean.getShowType().equals("popup")){
			List<Map<String, Object>> dicDatas = queryDic(dicT, dicF,dicText);
			m.put(CgAutoListConstant.FIELD_DICTLIST, dicDatas);
		}else{
			m.put(CgAutoListConstant.FIELD_DICTLIST, new ArrayList(0));
		}
	}
	/**
	 * 查询数据字典
	 * @param dicT 数据字典表
	 * @param dicF	数据字典字段
	 * @param dicText 数据字典显示文本
	 * @return
	 */
	private List<Map<String, Object>> queryDic(String dicT, String dicF,String dicText) {
		StringBuilder dicSql = new StringBuilder();
		if(StringUtil.isEmpty(dicT)){//step.1 如果没有字典表则使用系统字典表
			dicT = CgAutoListConstant.SYS_DIC;
			dicSql.append(" SELECT TYPECODE,TYPENAME FROM");
			dicSql.append(" "+dicT);
			dicSql.append(" "+"WHERE TYPEGROUPID = ");
			dicSql.append(" "+"(SELECT ID FROM "+CgAutoListConstant.SYS_DICGROUP+" WHERE TYPEGROUPCODE = '"+dicF+"' )");
		}else{//step.2 如果给定了字典表则使用该字典表，这个功能需要在表单配置追加字段
			//table表查询
			dicSql.append("SELECT DISTINCT ").append(dicF).append(" as typecode, ");
			if(dicText!=null&&dicText.length()>0){
				dicSql.append(dicText).append(" as typename ");
			}else{
				dicSql.append(dicF).append(" as typename ");
			}
			dicSql.append(" FROM ").append(dicT);
			dicSql.append(" ORDER BY ").append(dicF);
		}
		//step.3 字典数据
		List<Map<String, Object>> dicDatas = systemService.findForJdbc(dicSql.toString());
		return dicDatas;
	}
}
