package org.jeecgframework.web.cgform.controller.autoform;

import com.alibaba.fastjson.JSONObject;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.codegenerate.database.JeecgReadTable;
import org.jeecgframework.codegenerate.pojo.Columnt;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.*;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.cgform.common.CgAutoListConstant;
import org.jeecgframework.web.cgform.entity.autoform.*;
import org.jeecgframework.web.cgform.service.autoform.AutoFormDbServiceI;
import org.jeecgframework.web.system.pojo.base.DynamicDataSourceEntity;
import org.jeecgframework.web.system.service.DynamicDataSourceServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.*;
import java.util.regex.Matcher;
import java.util.regex.Pattern;


/**   
 * @Title: Controller
 * @Description: 表单数据源
 * @author onlineGenerator
 * @date 2015-06-17 19:36:59
 * @version V1.0   
 *
 */
@Scope("prototype") 
@Controller
@RequestMapping("/autoFormDbController")
public class AutoFormDbController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(AutoFormDbController.class);

	@Autowired
	private AutoFormDbServiceI autoFormDbService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private DynamicDataSourceServiceI dynamicDataSourceServiceI;


	/**
	 * 表单数据源列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "autoFormDb")
	public ModelAndView autoFormDb(HttpServletRequest request) {
		String autoFormId = request.getParameter("autoFormId");
		if(oConvertUtils.isNotEmpty(autoFormId)){
			request.setAttribute("autoFormId", autoFormId);
		}
		return new ModelAndView("jeecg/cgform/autoform/autoFormDbList");
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
	public void datagrid(AutoFormDbEntity autoFormDb,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(AutoFormDbEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, autoFormDb);
		try{
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.autoFormDbService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除表单数据源
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(AutoFormDbEntity autoFormDb, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		autoFormDb = systemService.getEntity(AutoFormDbEntity.class, autoFormDb.getId());
		String message = "表单数据源删除成功";
		try{
			autoFormDbService.delMain(autoFormDb);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "表单数据源删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 批量删除表单数据源
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		String message = "表单数据源删除成功";
		try{
			for(String id:ids.split(",")){
				AutoFormDbEntity autoFormDb = systemService.getEntity(AutoFormDbEntity.class,
				id
				);
				autoFormDbService.delMain(autoFormDb);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "表单数据源删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 添加表单数据源
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(AutoFormDbEntity autoFormDb,AutoFormDbPage autoFormDbPage, HttpServletRequest request) {
		List<AutoFormDbFieldEntity> autoFormDbFieldList =  autoFormDbPage.getAutoFormDbFieldList();
		List<AutoFormParamEntity> autoFormParamList =  autoFormDbPage.getAutoFormParamList();
		AjaxJson j = new AjaxJson();
		String message = "添加成功";
		try{
			autoFormDbService.addMain(autoFormDb, autoFormDbFieldList, autoFormParamList);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "表单数据源添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	/**
	 * 更新表单数据源
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(AutoFormDbEntity autoFormDb,AutoFormDbPage autoFormDbPage, HttpServletRequest request) {
		List<AutoFormDbFieldEntity> autoFormDbFieldList =  autoFormDbPage.getAutoFormDbFieldList();
		List<AutoFormParamEntity> autoFormParamList =  autoFormDbPage.getAutoFormParamList();
		AjaxJson j = new AjaxJson();
		String message = "更新成功";
		try{
			autoFormDbService.updateMain(autoFormDb, autoFormDbFieldList, autoFormParamList);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "更新表单数据源失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 表单数据源新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(AutoFormDbEntity autoFormDb, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(autoFormDb.getId())) {
			autoFormDb = autoFormDbService.getEntity(AutoFormDbEntity.class, autoFormDb.getId());
		}
		req.setAttribute("autoFormDbPage", autoFormDb);
		Collection<DynamicDataSourceEntity> dynamicDataSourceEntitys = DynamicDataSourceEntity.DynamicDataSourceMap.values();
		req.setAttribute("dynamicDataSourceEntitys", dynamicDataSourceEntitys);
		try {
			List<String> tableNames = new JeecgReadTable().readAllTableNames();
			req.setAttribute("tableNames", tableNames);
		} catch (SQLException e) {
			logger.info(e.getMessage());
		}
		return new ModelAndView("jeecg/cgform/autoform/autoFormDb-add");
	}
	
	/**
	 * 表单数据源编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(AutoFormDbEntity autoFormDb, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(autoFormDb.getId())) {
			autoFormDb = autoFormDbService.getEntity(AutoFormDbEntity.class, autoFormDb.getId());
			List<String> tableNames = null;
			if(StringUtils.isNotBlank(autoFormDb.getDbKey()) && "table".equals(autoFormDb.getDbType())){
				DynamicDataSourceEntity dynamicDataSourceEntity = dynamicDataSourceServiceI.getDynamicDataSourceEntityForDbKey(autoFormDb.getDbKey());
				if(dynamicDataSourceEntity!=null){
					tableNames = DynamicDBUtil.findList(autoFormDb.getDbKey(),SqlUtil.getAllTableSql(dynamicDataSourceEntity.getDbType(), "'"+dynamicDataSourceEntity.getDbName()+"'"),String.class);
				}
					
			}
			Collection<DynamicDataSourceEntity> dynamicDataSourceEntitys = DynamicDataSourceEntity.DynamicDataSourceMap.values();
			req.setAttribute("dynamicDataSourceEntitys", dynamicDataSourceEntitys);
			//数据源类型
			String dbKey = null;
			if(CgAutoListConstant.DB_TYPE_TABLE.equals(autoFormDb.getDbType())){
				dbKey = autoFormDb.getDbKey();
			}else if(CgAutoListConstant.DB_TYPE_SQL.equals(autoFormDb.getDbType())){
				dbKey = autoFormDb.getTbDbKey();
			}
			if(StringUtils.isBlank(dbKey)){
				//默认当前平台数据源
				try {
					tableNames = new JeecgReadTable().readAllTableNames();
				} catch (SQLException e) {
				}
			}else{
				//个性化配置多数据源
				DynamicDataSourceEntity dynamicDataSourceEntity = dynamicDataSourceServiceI.getDynamicDataSourceEntityForDbKey(dbKey);
				if(dynamicDataSourceEntity!=null){
					tableNames = DynamicDBUtil.findList(dbKey,SqlUtil.getAllTableSql(dynamicDataSourceEntity.getDbType(), "'" + dynamicDataSourceEntity.getDbName() + "'"),String.class);
				}
			}
			req.setAttribute("tableNames", tableNames);
			req.setAttribute("autoFormDbPage", autoFormDb);
			
		}
		return new ModelAndView("jeecg/cgform/autoform/autoFormDb-update");
	}
	
	
	/**
	 * 加载明细列表[表单数据源属性]
	 * 
	 * @return
	 */
	@RequestMapping(params = "autoFormDbFieldList")
	public ModelAndView autoFormDbFieldList(AutoFormDbEntity autoFormDb, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(autoFormDb.getId())) {
			//===================================================================================
			//查询-表单数据源属性
		    String hql0 = "from AutoFormDbFieldEntity where 1 = 1 AND aUTO_FORM_DB_ID = ? ";
		    try{
		    	List<AutoFormDbFieldEntity> autoFormDbFieldEntityList = systemService.findHql(hql0,autoFormDb.getId());
				req.setAttribute("autoFormDbFieldList", autoFormDbFieldEntityList);
			}catch(Exception e){
				logger.info(e.getMessage());
			}
		}
		return new ModelAndView("jeecg/cgform/autoform/autoFormDbFieldList");
	}
	/**
	 * 加载明细列表[表单参数]
	 * 
	 * @return
	 */
	@RequestMapping(params = "autoFormParamList")
	public ModelAndView autoFormParamList(AutoFormDbEntity autoFormDb, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(autoFormDb.getId())) {
			//===================================================================================
			//查询-表单参数
		    String hql1 = "from AutoFormParamEntity where 1 = 1 AND aUTO_FORM_DB_ID = ? ";
		    try{
		    	List<AutoFormParamEntity> autoFormParamEntityList = systemService.findHql(hql1,autoFormDb.getId());
				req.setAttribute("autoFormParamList", autoFormParamEntityList);
			}catch(Exception e){
				logger.info(e.getMessage());
			}
		}
		return new ModelAndView("jeecg/cgform/autoform/autoFormParamList");
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
		List<String> files = null;
		List<String> params = null;
		
		Map reJson = new HashMap<String, Object>();
		try{
			files = autoFormDbService.getSqlFields(sql);
			params = autoFormDbService.getSqlParams(sql);
		}catch (Exception e) {
			//e.printStackTrace();
			LogUtil.error(e.toString());
			String errorInfo = "解析失败!<br><br>失败原因：";
			errorInfo += e.getMessage();
			reJson.put("status", "error");
			reJson.put("datas", errorInfo);
			return reJson;
		}
		reJson.put("status", "success");
		reJson.put("files", files);
		reJson.put("params", params);
		return reJson;
	}
	/**
	 * 加载明细列表[表属性]
	 * 
	 * @return
	 */
	@RequestMapping(params = "autoFormDbFieldForTableList")
	public ModelAndView autoFormDbFieldForTableList(AutoFormDbEntity autoFormDb, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(autoFormDb.getId())) {
			//===================================================================================
			//查询-表单数据源属性
		    String hql0 = "from AutoFormDbFieldEntity where 1 = 1 AND aUTO_FORM_DB_ID = ? ";
		    try{
		    	List<AutoFormDbFieldEntity> autoFormDbFieldEntityList = systemService.findHql(hql0,autoFormDb.getId());
				req.setAttribute("autoFormDbFieldList", autoFormDbFieldEntityList);
			}catch(Exception e){
				logger.info(e.getMessage());
			}
		}
		return new ModelAndView("jeecg/cgform/autoform/autoFormDbFieldForTableList");
	}
	/**
	 * 根据数据源获取所有表
	 * @param db_key
	 * @return
	 */
	@RequestMapping(params="getAllTableNames")
	@ResponseBody
	public Object getAllTableNames(String dbKey){
		Map reJson = new HashMap<String, Object>();
		List<String> tableNames = null;
		try{
			if(StringUtils.isNotBlank(dbKey)){
				DynamicDataSourceEntity dynamicDataSourceEntity = dynamicDataSourceServiceI.getDynamicDataSourceEntityForDbKey(dbKey);
				if(dynamicDataSourceEntity!=null){
					tableNames = DynamicDBUtil.findList(dbKey,SqlUtil.getAllTableSql(dynamicDataSourceEntity.getDbType(), "'" + dynamicDataSourceEntity.getDbName() + "'"),String.class);
				}
			}else{
				tableNames = new JeecgReadTable().readAllTableNames();
			}
		}catch (Exception e){
			reJson.put("status", "error");
			reJson.put("datas", "表查询失败！");
			reJson.put("tableNames", new ArrayList<String>());
		}
		reJson.put("status", "success");
		reJson.put("tableNames", tableNames);
		
		return reJson;
	}
	/**
	 * 根据数据源和表获取所有属性
	 * @param sql
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params = "getTableFields", method = RequestMethod.POST)
	@ResponseBody
	public Object getTableFields(String dbKey,String tableName){
		Map reJson = new HashMap<String, Object>();
		List<String> columnsNames = null;
		if(StringUtils.isNotBlank(dbKey)){
			DynamicDataSourceEntity dynamicDataSourceEntity = dynamicDataSourceServiceI.getDynamicDataSourceEntityForDbKey(dbKey);
			if(dynamicDataSourceEntity!=null){
				columnsNames = DynamicDBUtil.findList(dbKey,SqlUtil.getAllCloumnSql(dynamicDataSourceEntity.getDbType(), "'" + tableName + "'", "'" + dynamicDataSourceEntity.getDbName() + "'"),String.class);
			}
		}else{
			try {
				List<Columnt> columns = new JeecgReadTable().readOriginalTableColumn(tableName);
				columnsNames = new ArrayList<String>();
				
				for(Columnt column:columns){
					columnsNames.add(column.getFieldDbName());
				}
			} catch (Exception e) {
				reJson.put("status", "error");
				reJson.put("datas", "列查询失败！");
			}
		}
		
		reJson.put("status", "success");
		reJson.put("files", columnsNames);
		
		return reJson;
	}
	/**
	 * 数据源展示
	 * @param id
	 * @return
	 */
	@RequestMapping(params="goView")
	public ModelAndView goView(@RequestParam String id, HttpServletRequest req) {
		if(StringUtil.isNotEmpty(id)){
			AutoFormDbEntity autoFormDbEntity = autoFormDbService.getEntity(AutoFormDbEntity.class, id);
			if(autoFormDbEntity!=null){
				//查询-表单参数
			    String hql1 = "from AutoFormParamEntity where 1 = 1 AND aUTO_FORM_DB_ID = ? ";
			    try{
			    	List<AutoFormParamEntity> autoFormParamEntityList = systemService.findHql(hql1,id);
					req.setAttribute("autoFormParamList", autoFormParamEntityList);
				}catch(Exception e){
					logger.info(e.getMessage());
				}
			}
			
			req.setAttribute("autoFormDbEntity", autoFormDbEntity);
		}
		return new ModelAndView("jeecg/cgform/autoform/autoFormDb-view");
	}
	/**
	 * 数据展示
	 * @param id
	 * @return
	 */
	@RequestMapping(params="view",method=RequestMethod.POST)
	@ResponseBody
	public AjaxJson view(AutoFormDbEntity autoFormDb,HttpServletRequest req) {
		AjaxJson j = new AjaxJson();
		String msg = "";
		Map<String,String[]> paramMap = req.getParameterMap();
		
		List<Map<String, Object>>  map = null;
		String dbKey = autoFormDb.getDbKey();//数据源key
		String dbType = autoFormDb.getDbType();//数据源类型
		String dbTableName = autoFormDb.getDbTableName();//数据库表名
		String dbDynSql = autoFormDb.getDbDynSql();
		if("table".equals(dbType)){
			//如果数据源类型为表类型，通过属性表里面的属性拼出SQL
			String hqlField = "from AutoFormDbFieldEntity where 1 = 1 AND aUTO_FORM_DB_ID = ? ";
		    try{
		    	List<AutoFormDbFieldEntity> autoFormDbFieldEntityList = systemService.findHql(hqlField,autoFormDb.getId());
		    	
		    	if(autoFormDbFieldEntityList.size()>0){
		    		StringBuffer hqlTable = new StringBuffer().append("select ");
		    		for(AutoFormDbFieldEntity autoFormDbFieldEntity:autoFormDbFieldEntityList){
		    			hqlTable.append(autoFormDbFieldEntity.getFieldName()+",");
			    	}
		    		hqlTable.deleteCharAt(hqlTable.length()-1).append(" from "+dbTableName);
					if("".equals(dbKey)){
						//当前上下文中的DB环境，获取数据库表中的所有数据
						map = systemService.findForJdbc(hqlTable.toString());
					}
					else{
						DynamicDataSourceEntity dynamicDataSourceEntity = dynamicDataSourceServiceI.getDynamicDataSourceEntityForDbKey(dbKey);
						if(dynamicDataSourceEntity!=null){
							map = DynamicDBUtil.findList(dbKey,hqlTable.toString());
						}
					}
					j.setObj(map);
					msg = "表数据查询成功！";
		    	}else{
		    		j.setSuccess(false);
		    		msg = "表属性配置有误！";
		    	}
		    	
			}catch(Exception e){
				logger.info(e.getMessage());
			}
		}else if("sql".equals(dbType)){
			//如果数据源类型为SQL类型，直接通过替换SQL里面的参数变量解析出可执行的SQL
			List<String> params = autoFormDbService.getSqlParams(dbDynSql);
			for(String param:params){
				String[] paramValue = paramMap.get("#"+param);
				dbDynSql = dbDynSql.replaceAll("\\$\\{"+param+"\\}", paramValue[0]);
			}
			
			//判断sql中是否还有没有被替换的变量，如果有，抛出错误！
			if(dbDynSql.contains("\\$")){
				j.setSuccess(false);
				msg = "动态SQL数据查询失败！";
			}else{
				try {
					map = systemService.findForJdbc(dbDynSql);
					msg = "动态SQL数据查询成功！";
					j.setObj(map);
				} catch (Exception e) {
					logger.info(e.getMessage());
					j.setSuccess(false);
					msg = "动态SQL数据查询失败！";
				}
				
			}
		}else{
			//预留给CLAZZ类型
		}
		j.setMsg(msg);
		return j;
	}
	/**
	 * 判断数据源名称是否重复
	 */
	@ResponseBody
	@RequestMapping(params="checkDbName")
	public JSONObject checkDbName(HttpServletRequest req,String cVal){
		JSONObject jsonObject = new JSONObject();

		String param = req.getParameter("param");
		if(StringUtils.isNotBlank(cVal)&&cVal.equals(param)){
			jsonObject.put("info", "验证通过！");
			jsonObject.put("status", "y");
			return jsonObject;
		}
		List<AutoFormStyleEntity> list = new ArrayList<AutoFormStyleEntity>();
		String hql = "from AutoFormDbEntity t where t.dbName = ?";
			list = this.systemService.findHql(hql, param);

		if(list.size()>0){
			jsonObject.put("status", "n");
    		jsonObject.put("info", "数据源名称重复，请重新输入！");
    		return jsonObject;
		}
		jsonObject.put("info", "验证通过！");
		jsonObject.put("status", "y");
    	return jsonObject;
	}

	
}
