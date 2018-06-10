package org.jeecgframework.web.system.controller.core;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.ComboTree;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.model.json.TreeGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil;
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.datatable.SortDirection;
import org.jeecgframework.tag.vo.easyui.ComboTreeModel;
import org.jeecgframework.tag.vo.easyui.TreeGridModel;
import org.jeecgframework.web.system.pojo.base.TSFunction;
import org.jeecgframework.web.system.pojo.base.TSIcon;
import org.jeecgframework.web.system.pojo.base.TSInterfaceDdataRuleEntity;
import org.jeecgframework.web.system.pojo.base.TSInterfaceEntity;
import org.jeecgframework.web.system.pojo.base.TSOperation;
import org.jeecgframework.web.system.pojo.base.TSRoleFunction;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.service.TSInterfaceServiceI;
import org.jeecgframework.web.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * 接口授权类
 * 
 * @author baiyu
 */
@Controller
@RequestMapping("/interfaceController")
public class TSInterfaceController extends BaseController {
	/**
	 * Logger for this class
	 */
	@SuppressWarnings("unused")
	private static final Logger logger = Logger.getLogger(TSInterfaceController.class);
	private UserService userService;
	private SystemService systemService;

	@Autowired
	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}

	public UserService getUserService() {
		return userService;

	}

	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	@Autowired
	TSInterfaceServiceI tsService;
	

	/**
	 * 权限列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "interface")
	public ModelAndView function(ModelMap model) {
		return new ModelAndView("system/tsinterface/interfaceList");
	}

	/**
	 * 操作列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "operation")
	public ModelAndView operation(HttpServletRequest request, String functionId) {
		request.setAttribute("functionId", functionId);
		return new ModelAndView("system/operation/operationList");
	}

	/**
	 * 数据规则列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "dataRule")
	public ModelAndView operationData(HttpServletRequest request, String interfaceId) {
		request.setAttribute("interfaceId", interfaceId);
		return new ModelAndView("system/tsinterface/ruleDataList");
	}

	/**
	 * easyuiAJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSFunction.class, dataGrid);
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * easyuiAJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 */
	@RequestMapping(params = "opdategrid")
	public void opdategrid(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSOperation.class, dataGrid);
		String functionId = oConvertUtils.getString(request.getParameter("functionId"));
		cq.eq("TSFunction.id", functionId);
		cq.add();
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除权限
	 * 
	 * @param interface
	 * @return
	 */
 
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(TSInterfaceEntity tsInterface, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();

		tsInterface = systemService.getEntity(TSInterfaceEntity.class, tsInterface.getId());
		List<TSInterfaceEntity> ts = tsInterface.getTSInterfaces();
		if(ts!=null&&ts.size()>0){
			 message = MutiLangUtil.getLang("common.menu.del.fail");
		}else{
			String hql =" from TSInterfaceDdataRuleEntity where TSInterface.id = ?";
			List<Object> findByQueryString = systemService.findHql(hql,tsInterface.getId());
			if(findByQueryString!=null&&findByQueryString.size()>0){
				 message = MutiLangUtil.getLang("common.menu.del.fail");
			}else{
				String sql = "delete from t_s_interface where id = ?";
				systemService.executeSql(sql, tsInterface.getId());
				message = MutiLangUtil.paramDelSuccess("common.menu");
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}

		j.setMsg(message);
		return j;
	}

	/**
	 * 删除操作 
	 * 
	 * @param operation
	 * @return
	 */
	@RequestMapping(params = "delop")
	@ResponseBody
	public AjaxJson delop(TSOperation operation, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		operation = systemService.getEntity(TSOperation.class, operation.getId());
		message = MutiLangUtil.paramDelSuccess("common.operation");
		userService.delete(operation);
		String operationId = operation.getId();
		String hql = "from TSRoleFunction rolefun where rolefun.operation like '%" + operationId + "%'";
		List<TSRoleFunction> roleFunctions = userService.findByQueryString(hql);
		for (TSRoleFunction roleFunction : roleFunctions) {
			String newOper = roleFunction.getOperation().replace(operationId + ",", "");
			if (roleFunction.getOperation().length() == newOper.length()) {
				newOper = roleFunction.getOperation().replace(operationId, "");
			}
			roleFunction.setOperation(newOper);
			userService.updateEntitie(roleFunction);
		}
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		j.setMsg(message);
		return j;
	}

	/**
	 * 递归更新子权限的InterfaceLevel
	 * 
	 * @param subFunction
	 * @param parent
	 */
	private void updateSubFunction(List<TSInterfaceEntity> subInterface, TSInterfaceEntity parent) {
		if (subInterface.size() == 0) {// 没有子权限是结束
			return;
		} else {
			for (TSInterfaceEntity tsInterface : subInterface) {
				tsInterface.setInterfaceLevel(Short.valueOf(parent.getInterfaceLevel() + 1 + ""));
				systemService.saveOrUpdate(tsInterface);
				List<TSInterfaceEntity> subInterface1 = systemService.findByProperty(TSInterfaceEntity.class, "tSInterface.id",
						tsInterface.getId());
				updateSubFunction(subInterface1, tsInterface);
			}
		}
	}

	/**
	 * 权限录入
	 * 
	 * @param function
	 * @return
	 */
	@RequestMapping(params = "saveInterface")
	@ResponseBody
	public AjaxJson saveInterface(TSInterfaceEntity tsInterface, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		// ----------------------------------------------------------------
		tsInterface.setInterfaceUrl(tsInterface.getInterfaceUrl().trim());
		String functionOrder = tsInterface.getInterfaceOrder();
		if (StringUtils.isEmpty(functionOrder)) {
			tsInterface.setInterfaceOrder("0");
		}
		if (tsInterface.gettSInterface().getId().equals("")) {
			tsInterface.settSInterface(null);
		} else {
			TSInterfaceEntity parent = systemService.getEntity(TSInterfaceEntity.class, tsInterface.gettSInterface().getId());
			tsInterface.setInterfaceLevel(Short.valueOf(parent.getInterfaceLevel() + 1 + ""));
		}
		if (StringUtil.isNotEmpty(tsInterface.getId())) {
			message = MutiLangUtil.paramUpdSuccess("common.menu");
			TSInterfaceEntity t = systemService.getEntity(TSInterfaceEntity.class, tsInterface.getId());
			try {
				MyBeanUtils.copyBeanNotNull2Bean(tsInterface, t);
				userService.saveOrUpdate(t);
			} catch (Exception e) {
				e.printStackTrace();
			}
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			List<TSInterfaceEntity> subinterface = systemService.findByProperty(TSInterfaceEntity.class, "tSInterface.id",
					tsInterface.getId());
			updateSubFunction(subinterface, tsInterface);
		} else {
			if (tsInterface.getInterfaceLevel().equals(Globals.Function_Leave_ONE)) {
				@SuppressWarnings("unused")
				List<TSInterfaceEntity> interfaceList = systemService.findByProperty(TSInterfaceEntity.class, "interfaceLevel",
						Globals.Function_Leave_ONE);
				tsInterface.setInterfaceOrder(tsInterface.getInterfaceOrder());
			} else {
				@SuppressWarnings("unused")
				List<TSInterfaceEntity> interfaceList = systemService.findByProperty(TSInterfaceEntity.class, "interfaceLevel",
						Globals.Function_Leave_TWO);
				tsInterface.setInterfaceOrder(tsInterface.getInterfaceOrder());
			}
			message = MutiLangUtil.paramAddSuccess("common.menu");
			systemService.save(tsInterface);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 操作录入
	 * 
	 * @param operation
	 * @return
	 */
	@RequestMapping(params = "saveop")
	@ResponseBody
	public AjaxJson saveop(TSOperation operation, HttpServletRequest request) {
		String message = null;
		String pid = request.getParameter("TSFunction.id");
		if (pid.equals("")) {
			operation.setTSFunction(null);
		}
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(operation.getId())) {
			message = MutiLangUtil.paramUpdSuccess("common.operation");
			userService.saveOrUpdate(operation);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} else {
			message = MutiLangUtil.paramAddSuccess("common.operation");
			userService.save(operation);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}

		j.setMsg(message);
		return j;
	}

	/**
	 * 权限列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(TSInterfaceEntity tsInterface, HttpServletRequest req) {
		String interfaceid = req.getParameter("id");
		List<TSInterfaceEntity> interfacelist = systemService.getList(TSInterfaceEntity.class);
		req.setAttribute("flist", interfacelist);
		if (interfaceid != null) {
			tsInterface = systemService.getEntity(TSInterfaceEntity.class, interfaceid);
			req.setAttribute("tsInterface", tsInterface);
		}
		if (tsInterface.gettSInterface() != null && tsInterface.gettSInterface().getId() != null) {
			tsInterface.setInterfaceLevel((short) 1);
			tsInterface.settSInterface(
					(TSInterfaceEntity) systemService.getEntity(TSInterfaceEntity.class, tsInterface.gettSInterface().getId()));
			req.setAttribute("tsInterface", tsInterface);
		}
		return new ModelAndView("system/tsinterface/interface");
	}

	/**
	 * 操作列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdateop")
	public ModelAndView addorupdateop(TSOperation operation, HttpServletRequest req) {
		List<TSIcon> iconlist = systemService.getList(TSIcon.class);
		req.setAttribute("iconlist", iconlist);
		if (operation.getId() != null) {
			operation = systemService.getEntity(TSOperation.class, operation.getId());
			req.setAttribute("operation", operation);
		}
		String functionId = oConvertUtils.getString(req.getParameter("functionId"));
		req.setAttribute("functionId", functionId);
		return new ModelAndView("system/operation/operation");
	}

	/**
	 * 权限列表
	 */
	@RequestMapping(params = "interfaceGrid")
	@ResponseBody
	public List<TreeGrid> interfaceGrid(HttpServletRequest request, TreeGrid treegrid, Integer type) {
		CriteriaQuery cq = new CriteriaQuery(TSInterfaceEntity.class);
		String selfId = request.getParameter("selfId");
		if (selfId != null) {
			cq.notEq("id", selfId);
		}
		if (treegrid.getId() != null) {
			cq.eq("tSInterface.id", treegrid.getId());
		}
		if (treegrid.getId() == null) {
			cq.isNull("tSInterface");
		}
		cq.addOrder("interfaceOrder", SortDirection.asc);
		cq.add();

		// 获取装载数据权限的条件HQL
		cq = HqlGenerateUtil.getDataAuthorConditionHql(cq, new TSInterfaceEntity());
		cq.add();

		List<TSInterfaceEntity> interfaceList = systemService.getListByCriteriaQuery(cq, false);
		List<TreeGrid> treeGrids = new ArrayList<TreeGrid>();
		TreeGridModel treeGridModel = new TreeGridModel();
		treeGridModel.setTextField("interfaceName");
		treeGridModel.setParentText("TSInterface_interfaceName");
		treeGridModel.setParentId("TSInterface_id");
		treeGridModel.setSrc("interfaceUrl");
		treeGridModel.setIdField("id");
		treeGridModel.setChildList("tSInterfaces");
		Map<String, Object> fieldMap = new HashMap<String, Object>();
		fieldMap.put("interfaceCode", "interfaceCode");
		fieldMap.put("interfaceMethod", "interfaceMethod");
		treeGridModel.setFieldMap(fieldMap);
		// 添加排序字段
		treeGridModel.setOrder("interfaceOrder");
		treeGrids = systemService.treegrid(interfaceList, treeGridModel);
		MutiLangUtil.setMutiTree(treeGrids);
		return treeGrids;
	}
	
	

	/**
	 * 父级权限下拉菜单
	 */
	@RequestMapping(params = "setPInterface")
	@ResponseBody
	public List<ComboTree> setPInterface(HttpServletRequest request, ComboTree comboTree) {
		CriteriaQuery cq = new CriteriaQuery(TSInterfaceEntity.class);
		if (null != request.getParameter("selfId")) {
			cq.notEq("id", request.getParameter("selfId"));
		}
		if (comboTree.getId() != null) {
			cq.eq("tSInterface.id", comboTree.getId());
		}
		if (comboTree.getId() == null) {
			cq.isNull("tSInterface");
		}
		cq.add();
		List<TSInterfaceEntity> interfaceList = systemService.getListByCriteriaQuery(cq, false);
		List<ComboTree> comboTrees = new ArrayList<ComboTree>();
		ComboTreeModel comboTreeModel = new ComboTreeModel("id", "interfaceName", "tsInterfaces");
		comboTrees = systemService.ComboTree(interfaceList, comboTreeModel, null, false);
		MutiLangUtil.setMutiTree(comboTrees);
		return comboTrees;
	}

	/**
	 * 添加修改权限数据
	 */
	@RequestMapping(params = "addorupdaterule")
	public ModelAndView addorupdaterule(TSInterfaceDdataRuleEntity operation, HttpServletRequest req) {
		if (operation.getId() != null) {
			operation = systemService.getEntity(TSInterfaceDdataRuleEntity.class, operation.getId());
			req.setAttribute("operation", operation);
		}
		String interfaceId = oConvertUtils.getString(req.getParameter("interfaceId"));
		req.setAttribute("interfaceId", interfaceId);
		return new ModelAndView("system/tsinterface/ruleData");
	}

	/**
	 * 接口权限规则的列表界面 
	 */
	@RequestMapping(params = "ruledatagrid")
	public void ruledategrid(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSInterfaceDdataRuleEntity.class, dataGrid);
		String interfaceId = oConvertUtils.getString(request.getParameter("interfaceId"));
		cq.eq("TSInterface.id", interfaceId);
		cq.add();
		//TODO
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 *删除接口权限规则 operation 
	 */
	@RequestMapping(params = "delrule")
	@ResponseBody
	public AjaxJson delrule(TSInterfaceDdataRuleEntity operation, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		operation = systemService.getEntity(TSInterfaceDdataRuleEntity.class, operation.getId());
		message = MutiLangUtil.paramDelSuccess("common.operation");
		userService.delete(operation);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		j.setMsg(message);
		return j;
	}

	/**
	 * saverule保存规则权限值  
	 */
	@RequestMapping(params = "saverule")
	@ResponseBody
	public AjaxJson saverule(TSInterfaceDdataRuleEntity operation, HttpServletRequest request)throws Exception {
		String message = null;
		AjaxJson j = new AjaxJson();
		TSInterfaceEntity interfaceEntity = systemService.get(TSInterfaceEntity.class, operation.getTSInterface().getId());
		if(interfaceEntity!=null){
			if (StringUtil.isNotEmpty(operation.getId())) {
				message = MutiLangUtil.paramUpdSuccess("common.operation");
				userService.saveOrUpdate(operation);
				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			} else {
				if (justHaveDataRule(operation) == 0) {
					message = MutiLangUtil.paramAddSuccess("common.operation");
					userService.save(operation);
					systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
				} else {
					message = "操作字段规则已存在";
				}
			}
		}else{
			message = "操作失败";
		}
		j.setMsg(message);
		return j;
	}

	public int justHaveDataRule(TSInterfaceDdataRuleEntity dataRule) {

		String column = dataRule.getRuleColumn();
		if(oConvertUtils.isEmpty(column)){
			return 0;
		}
		String sql = "SELECT count(1) FROM t_s_interface_datarule WHERE interface_id = ? AND rule_column = ? AND rule_conditions = ?";
		Long count = this.systemService.getCountForJdbcParam(sql, dataRule.getTSInterface().getId(),column,dataRule.getRuleConditions());
		return count.intValue();

	}

}
