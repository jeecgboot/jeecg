package org.jeecgframework.web.system.controller.core;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.web.system.pojo.base.TSFunction;
import org.jeecgframework.web.system.pojo.base.TSIcon;
import org.jeecgframework.web.system.pojo.base.TSOperation;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.service.UserService;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.ComboTree;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.model.json.TreeGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.datatable.SortDirection;
import org.jeecgframework.tag.vo.easyui.ComboTreeModel;
import org.jeecgframework.tag.vo.easyui.TreeGridModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * 菜单权限处理类
 * 
 * @author 张代浩
 * 
 */
@Controller
@RequestMapping("/functionController")
public class FunctionController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(FunctionController.class);
	private UserService userService;
	private SystemService systemService;
	private String message = null;

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

	/**
	 * 权限列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "function")
	public ModelAndView function() {
		return new ModelAndView("system/function/functionList");
	}

	/**
	 * 操作列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "operation")
	public ModelAndView operation(HttpServletRequest request, String functionId) {
		// ----------------------------------------------------------------
		// ----------------------------------------------------------------
		request.setAttribute("functionId", functionId);
		// ----------------------------------------------------------------
		// ----------------------------------------------------------------
		return new ModelAndView("system/operation/operationList");
	}

	/**
	 * easyuiAJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(HttpServletRequest request,
			HttpServletResponse response, DataGrid dataGrid) {
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
	 * @param user
	 */

	@RequestMapping(params = "opdategrid")
	public void opdategrid(HttpServletRequest request,
			HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSOperation.class, dataGrid);
		// ----------------------------------------------------------------
		// ----------------------------------------------------------------
		String functionId = oConvertUtils.getString(request
				.getParameter("functionId"));
		cq.eq("TSFunction.id", functionId);
		cq.add();
		// ----------------------------------------------------------------
		// ----------------------------------------------------------------
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除权限
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(TSFunction function, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		function = systemService.getEntity(TSFunction.class, function.getId());
		message = "权限: " + function.getFunctionName() + "被删除成功";
		systemService
				.updateBySqlString("delete from t_s_role_function where functionid='"
						+ function.getId() + "'");

		systemService.delete(function);
		systemService.addLog(message, Globals.Log_Type_DEL,
				Globals.Log_Leavel_INFO);

		// // 删除权限时先删除权限与角色之间关联表信息
		// List<TSRoleFunction> roleFunctions =
		// systemService.findByProperty(TSRoleFunction.class, "TSFunction.id",
		// function.getId());
		//
		// if (roleFunctions.size() > 0) {
		// j.setMsg("菜单已分配无法删除");
		//
		// }
		// else {
		// userService.delete(function);
		// systemService.addLog(message, Globals.Log_Type_DEL,
		// Globals.Log_Leavel_INFO);
		// }

		return j;
	}

	/**
	 * 删除操作
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "delop")
	@ResponseBody
	public AjaxJson delop(TSOperation operation, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		operation = systemService.getEntity(TSOperation.class,
				operation.getId());
		message = "操作: " + operation.getOperationname() + "被删除成功";
		userService.delete(operation);
		systemService.addLog(message, Globals.Log_Type_DEL,
				Globals.Log_Leavel_INFO);

		return j;
	}

	/**
	 * 权限录入
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "saveFunction")
	@ResponseBody
	public AjaxJson saveFunction(TSFunction function, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		// ----------------------------------------------------------------
		// ----------------------------------------------------------------
		String functionOrder = function.getFunctionOrder();
		if (StringUtils.isEmpty(functionOrder)) {
			function.setFunctionOrder("0");
		}
		// ----------------------------------------------------------------
		// ----------------------------------------------------------------
		if (function.getTSFunction().getId().equals("")) {
			function.setTSFunction(null);
		} else {
			TSFunction parent = systemService.getEntity(TSFunction.class,
					function.getTSFunction().getId());
			function.setFunctionLevel(Short.valueOf(parent.getFunctionLevel()
					+ 1 + ""));
		}
		if (StringUtil.isNotEmpty(function.getId())) {
			message = "权限: " + function.getFunctionName() + "被更新成功";
			userService.saveOrUpdate(function);
			systemService.addLog(message, Globals.Log_Type_UPDATE,
					Globals.Log_Leavel_INFO);
			// ----------------------------------------------------------------
			// ----------------------------------------------------------------

			systemService.flushRoleFunciton(function.getId(), function);

			// ----------------------------------------------------------------
			// ----------------------------------------------------------------

		} else {
			if (function.getFunctionLevel().equals(Globals.Function_Leave_ONE)) {
				List<TSFunction> functionList = systemService.findByProperty(
						TSFunction.class, "functionLevel",
						Globals.Function_Leave_ONE);
				// int ordre=functionList.size()+1;
				// function.setFunctionOrder(Globals.Function_Order_ONE+ordre);
				function.setFunctionOrder(function.getFunctionOrder());
			} else {
				List<TSFunction> functionList = systemService.findByProperty(
						TSFunction.class, "functionLevel",
						Globals.Function_Leave_TWO);
				// int ordre=functionList.size()+1;
				// function.setFunctionOrder(Globals.Function_Order_TWO+ordre);
				function.setFunctionOrder(function.getFunctionOrder());
			}
			message = "权限: " + function.getFunctionName() + "被添加成功";
			userService.save(function);
			systemService.addLog(message, Globals.Log_Type_INSERT,
					Globals.Log_Leavel_INFO);

		}

		return j;
	}

	/**
	 * 操作录入
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "saveop")
	@ResponseBody
	public AjaxJson saveop(TSOperation operation, HttpServletRequest request) {
		String pid = request.getParameter("TSFunction.id");
		if (pid.equals("")) {
			operation.setTSFunction(null);
		}
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(operation.getId())) {
			message = "操作: " + operation.getOperationname() + "被更新成功";
			userService.saveOrUpdate(operation);
			systemService.addLog(message, Globals.Log_Type_UPDATE,
					Globals.Log_Leavel_INFO);
		} else {
			message = "操作: " + operation.getOperationname() + "被添加成功";
			userService.save(operation);
			systemService.addLog(message, Globals.Log_Type_INSERT,
					Globals.Log_Leavel_INFO);

		}

		return j;
	}

	/**
	 * 权限列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(TSFunction function, HttpServletRequest req) {
		String functionid = req.getParameter("id");
		List<TSFunction> fuinctionlist = systemService
				.getList(TSFunction.class);
		req.setAttribute("flist", fuinctionlist);
		List<TSIcon> iconlist = systemService.getList(TSIcon.class);
		req.setAttribute("iconlist", iconlist);
		if (functionid != null) {
			function = systemService.getEntity(TSFunction.class, functionid);
			req.setAttribute("function", function);
		}
		if (function.getTSFunction() != null
				&& function.getTSFunction().getId() != null) {
			function.setFunctionLevel((short) 1);
			function.setTSFunction((TSFunction) systemService.getEntity(
					TSFunction.class, function.getTSFunction().getId()));
			req.setAttribute("function", function);
		}
		return new ModelAndView("system/function/function");
	}

	/**
	 * 操作列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdateop")
	public ModelAndView addorupdateop(TSOperation operation,
			HttpServletRequest req) {
		List<TSIcon> iconlist = systemService.getList(TSIcon.class);
		req.setAttribute("iconlist", iconlist);
		if (operation.getId() != null) {
			operation = systemService.getEntity(TSOperation.class,
					operation.getId());
			req.setAttribute("operation", operation);
		}
		String functionId = oConvertUtils.getString(req
				.getParameter("functionId"));
		req.setAttribute("functionId", functionId);
		return new ModelAndView("system/operation/operation");
	}

	/**
	 * 权限列表
	 */
	@RequestMapping(params = "functionGrid")
	@ResponseBody
	public List<TreeGrid> functionGrid(HttpServletRequest request,
			TreeGrid treegrid) {
		CriteriaQuery cq = new CriteriaQuery(TSFunction.class);
		String selfId = request.getParameter("selfId");
		if(selfId != null){
			cq.notEq("id", selfId);
		}
		if (treegrid.getId() != null) {
			cq.eq("TSFunction.id", treegrid.getId());
		}
		if (treegrid.getId() == null) {
			cq.isNull("TSFunction");
		}
		cq.addOrder("functionOrder", SortDirection.asc);
		cq.add();
		List<TSFunction> functionList = systemService.getListByCriteriaQuery(
				cq, false);
		List<TreeGrid> treeGrids = new ArrayList<TreeGrid>();
		TreeGridModel treeGridModel = new TreeGridModel();
		treeGridModel.setIcon("TSIcon_iconPath");
		treeGridModel.setTextField("functionName");
		treeGridModel.setParentText("TSFunction_functionName");
		treeGridModel.setParentId("TSFunction_id");
		treeGridModel.setSrc("functionUrl");
		treeGridModel.setIdField("id");
		treeGridModel.setChildList("TSFunctions");
		// 添加排序字段
		treeGridModel.setOrder("functionOrder");
		treeGrids = systemService.treegrid(functionList, treeGridModel);
		return treeGrids;
	}

	/**
	 * 权限列表
	 */
	@RequestMapping(params = "functionList")
	@ResponseBody
	public void functionList(HttpServletRequest request,
			HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSFunction.class, dataGrid);
		String id = oConvertUtils.getString(request.getParameter("id"));
		cq.isNull("TSFunction");
		if (id != null) {
			cq.eq("TSFunction.id", id);
		}
		cq.add();
		List<TSFunction> functionList = systemService.getListByCriteriaQuery(
				cq, false);
		List<TreeGrid> treeGrids = new ArrayList<TreeGrid>();
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 父级权限下拉菜单
	 */
	@RequestMapping(params = "setPFunction")
	@ResponseBody
	public List<ComboTree> setPFunction(HttpServletRequest request,
			ComboTree comboTree) {
		CriteriaQuery cq = new CriteriaQuery(TSFunction.class);
		if(null != request.getParameter("selfId")){
			cq.notEq("id", request.getParameter("selfId"));
		}
		if (comboTree.getId() != null) {
			cq.eq("TSFunction.id", comboTree.getId());
		}
		if (comboTree.getId() == null) {
			cq.isNull("TSFunction");
		}
		cq.add();
		List<TSFunction> functionList = systemService.getListByCriteriaQuery(
				cq, false);
		List<ComboTree> comboTrees = new ArrayList<ComboTree>();
		ComboTreeModel comboTreeModel = new ComboTreeModel("id",
				"functionName", "TSFunctions");
		comboTrees = systemService
				.ComboTree(functionList, comboTreeModel, null);
		return comboTrees;
	}
}
