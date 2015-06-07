package org.jeecgframework.web.system.controller.core;

import org.apache.log4j.Logger;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.*;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.*;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.easyui.ComboTreeModel;
import org.jeecgframework.tag.vo.easyui.TreeGridModel;
import org.jeecgframework.web.system.pojo.base.*;
import org.jeecgframework.web.system.service.MutiLangServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.*;

/**
 * 角色处理类
 * 
 * @author 张代浩
 * 
 */
@Scope("prototype")
@Controller
@RequestMapping("/roleController")
public class RoleController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(RoleController.class);
	private UserService userService;
	private SystemService systemService;
	private String message = null;

	@Autowired
	private MutiLangServiceI mutiLangService;

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
	 * 角色列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "role")
	public ModelAndView role() {
		return new ModelAndView("system/role/roleList");
	}

	/**
	 * easyuiAJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 */

	@RequestMapping(params = "roleGrid")
	public void roleGrid(TSRole role, HttpServletRequest request,
			HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSRole.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq,
				role);
		cq.add();
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
		;
	}

	/**
	 * 删除角色
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "delRole")
	@ResponseBody
	public AjaxJson delRole(TSRole role, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		int count = userService.getUsersOfThisRole(role.getId());
		if (count == 0) {
			// 删除角色之前先删除角色权限关系
			delRoleFunction(role);
            systemService.executeSql("delete from t_s_role_org where role_id=?", role.getId()); // 删除 角色-机构 关系信息
            role = systemService.getEntity(TSRole.class, role.getId());
			userService.delete(role);
			message = "角色: " + role.getRoleName() + "被删除成功";
			systemService.addLog(message, Globals.Log_Type_DEL,
					Globals.Log_Leavel_INFO);
		} else {
			message = "角色: 仍被用户使用，请先删除关联关系";
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 检查角色
	 * 
	 * @param role
	 * @return
	 */
	@RequestMapping(params = "checkRole")
	@ResponseBody
	public ValidForm checkRole(TSRole role, HttpServletRequest request,
			HttpServletResponse response) {
		ValidForm v = new ValidForm();
		String roleCode = oConvertUtils
				.getString(request.getParameter("param"));
		String code = oConvertUtils.getString(request.getParameter("code"));
		List<TSRole> roles = systemService.findByProperty(TSRole.class,
				"roleCode", roleCode);
		if (roles.size() > 0 && !code.equals(roleCode)) {
			v.setInfo("角色编码已存在");
			v.setStatus("n");
		}
		return v;
	}

	/**
	 * 删除角色权限
	 * 
	 * @param role
	 */
	protected void delRoleFunction(TSRole role) {
		List<TSRoleFunction> roleFunctions = systemService.findByProperty(
				TSRoleFunction.class, "TSRole.id", role.getId());
		if (roleFunctions.size() > 0) {
			for (TSRoleFunction tsRoleFunction : roleFunctions) {
				systemService.delete(tsRoleFunction);
			}
		}
		List<TSRoleUser> roleUsers = systemService.findByProperty(
				TSRoleUser.class, "TSRole.id", role.getId());
		for (TSRoleUser tsRoleUser : roleUsers) {
			systemService.delete(tsRoleUser);
		}
	}

	/**
	 * 角色录入
	 * 
	 * @param role
	 * @return
	 */
	@RequestMapping(params = "saveRole")
	@ResponseBody
	public AjaxJson saveRole(TSRole role, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(role.getId())) {
			message = "角色: " + role.getRoleName() + "被更新成功";
			userService.saveOrUpdate(role);
			systemService.addLog(message, Globals.Log_Type_UPDATE,
					Globals.Log_Leavel_INFO);
		} else {
			message = "角色: " + role.getRoleName() + "被添加成功";
			userService.save(role);
			systemService.addLog(message, Globals.Log_Type_INSERT,
					Globals.Log_Leavel_INFO);
		}

		return j;
	}

	/**
	 * 角色列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "fun")
	public ModelAndView fun(HttpServletRequest request) {
		String roleId = request.getParameter("roleId");
		request.setAttribute("roleId", roleId);
		return new ModelAndView("system/role/roleSet");
	}
	/**

	 * 角色所有用户信息列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "userList")
	public ModelAndView userList(HttpServletRequest request) {
		request.setAttribute("roleId", request.getParameter("roleId"));
		return new ModelAndView("system/role/roleUserList");
	}
	
	/**
	 * 用户列表查询 
	 * @param request
	 * @param response
	 * @param dataGrid
	 */
	@RequestMapping(params = "roleUserDatagrid")
	public void roleUserDatagrid(TSUser user,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSUser.class, dataGrid);
		//查询条件组装器
        String roleId = request.getParameter("roleId");
        List<TSRoleUser> roleUser = systemService.findByProperty(TSRoleUser.class, "TSRole.id", roleId);
        /*
        // zhanggm：这个查询逻辑也可以使用这种 子查询的方式进行查询
        CriteriaQuery subCq = new CriteriaQuery(TSRoleUser.class);
        subCq.setProjection(Property.forName("TSUser.id"));
        subCq.eq("TSRole.id", roleId);
        subCq.add();
        cq.add(Property.forName("id").in(subCq.getDetachedCriteria()));
        cq.add();
        */
		Criterion cc = null;
		if (roleUser.size() > 0) {
			for(int i = 0; i < roleUser.size(); i++){
				if(i == 0){
					cc = Restrictions.eq("id", roleUser.get(i).getTSUser().getId());
				}else{
					cc = cq.getor(cc, Restrictions.eq("id", roleUser.get(i).getTSUser().getId()));
				}
			}
		}else {
			cc =Restrictions.eq("id", "-1");
		}
		cq.add(cc);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, user);
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}
	
	/**
	 * 获取用户列表
	 * 
	 * @param user
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @return
	 */
	@RequestMapping(params = "getUserList")
	@ResponseBody
	public List<ComboTree> getUserList(TSUser user, HttpServletRequest request,
			ComboTree comboTree) {
		List<ComboTree> comboTrees = new ArrayList<ComboTree>();
		String roleId = request.getParameter("roleId");
		List<TSUser> loginActionlist = new ArrayList<TSUser>();
		if (user != null) {

			List<TSRoleUser> roleUser = systemService.findByProperty(TSRoleUser.class, "TSRole.id", roleId);
			if (roleUser.size() > 0) {
				for (TSRoleUser ru : roleUser) {
					loginActionlist.add(ru.getTSUser());
				}
			}
		}
		ComboTreeModel comboTreeModel = new ComboTreeModel("id", "userName", "TSUser");
		comboTrees = systemService.ComboTree(loginActionlist,comboTreeModel,loginActionlist, false);
		return comboTrees;
	}
	/**
	 * 角色树列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "roleTree")
	public ModelAndView roleTree(HttpServletRequest request) {
		request.setAttribute("orgId", request.getParameter("orgId"));
		return new ModelAndView("system/role/roleTree");
	}

	/**
	 * 获取 组织机构的角色树
	 * 
	 * @param request
	 *            request
	 * @return 组织机构的角色树
	 */
	@RequestMapping(params = "getRoleTree")
	@ResponseBody
	public List<ComboTree> getRoleTree(HttpServletRequest request) {
		ComboTreeModel comboTreeModel = new ComboTreeModel("id", "roleName", "");
		String orgId = request.getParameter("orgId");
		List<TSRole[]> orgRoleArrList = systemService
				.findHql(
						"from TSRole r, TSRoleOrg ro, TSDepart o WHERE r.id=ro.tsRole.id AND ro.tsDepart.id=o.id AND o.id=?",
						orgId);
		List<TSRole> orgRoleList = new ArrayList<TSRole>();
		for (Object[] roleArr : orgRoleArrList) {
			orgRoleList.add((TSRole) roleArr[0]);
		}

		List<Object> allRoleList = this.systemService.getList(TSRole.class);
		List<ComboTree> comboTrees = systemService.ComboTree(allRoleList,
				comboTreeModel, orgRoleList, false);

		return comboTrees;
	}

	/**
	 * 更新 组织机构的角色列表
	 * 
	 * @param request
	 *            request
	 * @return 操作结果
	 */
	@RequestMapping(params = "updateOrgRole")
	@ResponseBody
	public AjaxJson updateOrgRole(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			String orgId = request.getParameter("orgId");
			String roleIds = request.getParameter("roleIds");
			List<String> roleIdList = extractIdListByComma(roleIds);
			systemService.executeSql("delete from t_s_role_org where org_id=?",
					orgId);
			if (!roleIdList.isEmpty()) {
				List<TSRoleOrg> roleOrgList = new ArrayList<TSRoleOrg>();
				TSDepart depart = new TSDepart();
				depart.setId(orgId);
				for (String roleId : roleIdList) {
					TSRole role = new TSRole();
					role.setId(roleId);

					TSRoleOrg roleOrg = new TSRoleOrg();
					roleOrg.setTsRole(role);
					roleOrg.setTsDepart(depart);
					roleOrgList.add(roleOrg);
				}
				systemService.batchSave(roleOrgList);
			}
			j.setMsg("角色更新成功");
		} catch (Exception e) {
			logger.error(ExceptionUtil.getExceptionMessage(e));
			j.setMsg("角色更新失败");
		}
		return j;
	}

	/**
	 * 设置权限
	 * 
	 * @param role
	 * @param request
	 * @param comboTree
	 * @return
	 */
	@RequestMapping(params = "setAuthority")
	@ResponseBody
	public List<ComboTree> setAuthority(TSRole role,
			HttpServletRequest request, ComboTree comboTree) {
		CriteriaQuery cq = new CriteriaQuery(TSFunction.class);
		if (comboTree.getId() != null) {
			cq.eq("TSFunction.id", comboTree.getId());
		}
		if (comboTree.getId() == null) {
			cq.isNull("TSFunction");
		}
		cq.notEq("functionLevel", Short.parseShort("-1"));
		cq.add();
		List<TSFunction> functionList = systemService.getListByCriteriaQuery(
				cq, false);
		Collections.sort(functionList, new NumberComparator());
		List<ComboTree> comboTrees = new ArrayList<ComboTree>();
		String roleId = request.getParameter("roleId");
		List<TSFunction> loginActionlist = new ArrayList<TSFunction>();// 已有权限菜单
		role = this.systemService.get(TSRole.class, roleId);
		if (role != null) {
			List<TSRoleFunction> roleFunctionList = systemService
					.findByProperty(TSRoleFunction.class, "TSRole.id",
							role.getId());
			if (roleFunctionList.size() > 0) {
				for (TSRoleFunction roleFunction : roleFunctionList) {
					TSFunction function = (TSFunction) roleFunction
							.getTSFunction();
					loginActionlist.add(function);
				}
			}
		}
		ComboTreeModel comboTreeModel = new ComboTreeModel("id",
				"functionName", "TSFunctions");
		comboTrees = systemService.ComboTree(functionList, comboTreeModel,
				loginActionlist, false);

		MutiLangUtil.setMutiTree(comboTrees);
		return comboTrees;
	}

	/**
	 * 更新权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateAuthority")
	@ResponseBody
	public AjaxJson updateAuthority(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			String roleId = request.getParameter("roleId");
			String rolefunction = request.getParameter("rolefunctions");
			TSRole role = this.systemService.get(TSRole.class, roleId);
			List<TSRoleFunction> roleFunctionList = systemService
					.findByProperty(TSRoleFunction.class, "TSRole.id",
							role.getId());
			Map<String, TSRoleFunction> map = new HashMap<String, TSRoleFunction>();
			for (TSRoleFunction functionOfRole : roleFunctionList) {
				map.put(functionOfRole.getTSFunction().getId(), functionOfRole);
			}
			String[] roleFunctions = rolefunction.split(",");
			Set<String> set = new HashSet<String>();
			for (String s : roleFunctions) {
				set.add(s);
			}
			updateCompare(set, role, map);
			j.setMsg("权限更新成功");
		} catch (Exception e) {
			logger.error(ExceptionUtil.getExceptionMessage(e));
			j.setMsg("权限更新失败");
		}
		return j;
	}

	/**
	 * 权限比较
	 * 
	 * @param set
	 *            最新的权限列表
	 * @param role
	 *            当前角色
	 * @param map
	 *            旧的权限列表
	 */
	private void updateCompare(Set<String> set, TSRole role,
			Map<String, TSRoleFunction> map) {
		List<TSRoleFunction> entitys = new ArrayList<TSRoleFunction>();
		List<TSRoleFunction> deleteEntitys = new ArrayList<TSRoleFunction>();
		for (String s : set) {
			if (map.containsKey(s)) {
				map.remove(s);
			} else {
				TSRoleFunction rf = new TSRoleFunction();
				TSFunction f = this.systemService.get(TSFunction.class, s);
				rf.setTSFunction(f);
				rf.setTSRole(role);
				entitys.add(rf);
			}
		}
		Collection<TSRoleFunction> collection = map.values();
		Iterator<TSRoleFunction> it = collection.iterator();
		for (; it.hasNext();) {
			deleteEntitys.add(it.next());
		}
		systemService.batchSave(entitys);
		systemService.deleteAllEntitie(deleteEntitys);

	}

	/**
	 * 角色页面跳转
	 * 
	 * @param role
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(TSRole role, HttpServletRequest req) {
		if (role.getId() != null) {
			role = systemService.getEntity(TSRole.class, role.getId());
			req.setAttribute("role", role);
		}
		return new ModelAndView("system/role/role");
	}

	/**
	 * 权限操作列表
	 * 
	 * @param treegrid
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "setOperate")
	@ResponseBody
	public List<TreeGrid> setOperate(HttpServletRequest request,
			TreeGrid treegrid) {
		String roleId = request.getParameter("roleId");
		CriteriaQuery cq = new CriteriaQuery(TSFunction.class);
		if (treegrid.getId() != null) {
			cq.eq("TSFunction.id", treegrid.getId());
		}
		if (treegrid.getId() == null) {
			cq.isNull("TSFunction");
		}
		cq.add();
		List<TSFunction> functionList = systemService.getListByCriteriaQuery(
				cq, false);
		List<TreeGrid> treeGrids = new ArrayList<TreeGrid>();
		Collections.sort(functionList, new SetListSort());
		TreeGridModel treeGridModel = new TreeGridModel();
		treeGridModel.setRoleid(roleId);
		treeGrids = systemService.treegrid(functionList, treeGridModel);
		return treeGrids;

	}

	/**
	 * 操作录入
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "saveOperate")
	@ResponseBody
	public AjaxJson saveOperate(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String fop = request.getParameter("fp");
		String roleId = request.getParameter("roleId");
		// 录入操作前清空上一次的操作数据
		clearp(roleId);
		String[] fun_op = fop.split(",");
		String aa = "";
		String bb = "";
		// 只有一个被选中
		if (fun_op.length == 1) {
			bb = fun_op[0].split("_")[1];
			aa = fun_op[0].split("_")[0];
			savep(roleId, bb, aa);
		} else {
			// 至少2个被选中
			for (int i = 0; i < fun_op.length; i++) {
				String cc = fun_op[i].split("_")[0]; // 操作id
				if (i > 0 && bb.equals(fun_op[i].split("_")[1])) {
					aa += "," + cc;
					if (i == (fun_op.length - 1)) {
						savep(roleId, bb, aa);
					}
				} else if (i > 0) {
					savep(roleId, bb, aa);
					aa = fun_op[i].split("_")[0]; // 操作ID
					if (i == (fun_op.length - 1)) {
						bb = fun_op[i].split("_")[1]; // 权限id
						savep(roleId, bb, aa);
					}

				} else {
					aa = fun_op[i].split("_")[0]; // 操作ID
				}
				bb = fun_op[i].split("_")[1]; // 权限id

			}
		}

		return j;
	}

	/**
	 * 更新操作
	 * 
	 * @param roleId
	 * @param functionid
	 * @param ids
	 */
	public void savep(String roleId, String functionid, String ids) {
		// String hql = "from TSRoleFunction t where" + " t.TSRole.id=" +
		// oConvertUtils.getInt(roleId,0)
		// + " " + "and t.TSFunction.id=" + oConvertUtils.getInt(functionid,0);
		CriteriaQuery cq = new CriteriaQuery(TSRoleFunction.class);
		cq.eq("TSRole.id", roleId);
		cq.eq("TSFunction.id", functionid);
		cq.add();
		List<TSRoleFunction> rFunctions = systemService.getListByCriteriaQuery(
				cq, false);
		if (rFunctions.size() > 0) {
			TSRoleFunction roleFunction = rFunctions.get(0);
			roleFunction.setOperation(ids);
			systemService.saveOrUpdate(roleFunction);
		}
	}

	/**
	 * 清空操作
	 * 
	 * @param roleId
	 */
	public void clearp(String roleId) {
		List<TSRoleFunction> rFunctions = systemService.findByProperty(
				TSRoleFunction.class, "TSRole.id", roleId);
		if (rFunctions.size() > 0) {
			for (TSRoleFunction tRoleFunction : rFunctions) {
				tRoleFunction.setOperation(null);
				systemService.saveOrUpdate(tRoleFunction);
			}
		}
	}

	/**
	 * 按钮权限展示
	 * 
	 * @param request
	 * @param functionId
	 * @param roleId
	 * @return
	 */
	@RequestMapping(params = "operationListForFunction")
	public ModelAndView operationListForFunction(HttpServletRequest request,
			String functionId, String roleId) {
		CriteriaQuery cq = new CriteriaQuery(TSOperation.class);
		cq.eq("TSFunction.id", functionId);
		cq.eq("status", Short.valueOf("0"));
		cq.add();
		List<TSOperation> operationList = this.systemService
				.getListByCriteriaQuery(cq, false);
		Set<String> operationCodes = systemService
				.getOperationCodesByRoleIdAndFunctionId(roleId, functionId);
		request.setAttribute("operationList", operationList);
		request.setAttribute("operationcodes", operationCodes);
		request.setAttribute("functionId", functionId);
		return new ModelAndView("system/role/operationListForFunction");
	}

	/**
	 * 更新按钮权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateOperation")
	@ResponseBody
	public AjaxJson updateOperation(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String roleId = request.getParameter("roleId");
		String functionId = request.getParameter("functionId");
		String operationcodes = null;
		try {
			operationcodes = URLDecoder.decode(
					request.getParameter("operationcodes"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		CriteriaQuery cq1 = new CriteriaQuery(TSRoleFunction.class);
		cq1.eq("TSRole.id", roleId);
		cq1.eq("TSFunction.id", functionId);
		cq1.add();
		List<TSRoleFunction> rFunctions = systemService.getListByCriteriaQuery(
				cq1, false);
		if (null != rFunctions && rFunctions.size() > 0) {
			TSRoleFunction tsRoleFunction = rFunctions.get(0);
			tsRoleFunction.setOperation(operationcodes);
			systemService.saveOrUpdate(tsRoleFunction);
		}
		j.setMsg("按钮权限更新成功");
		return j;
	}
	
//chengchuan数据规则过滤代码
	
	/**
	 * 按钮权限展示
	 * 
	 * @param request
	 * @param functionId
	 * @param roleId
	 * @return
	 */
	@RequestMapping(params = "dataRuleListForFunction")
	public ModelAndView dataRuleListForFunction(HttpServletRequest request,
			String functionId, String roleId) {
		CriteriaQuery cq = new CriteriaQuery(TSDataRule.class);
		cq.eq("TSFunction.id", functionId);
		cq.add();
		List<TSDataRule> dataRuleList = this.systemService
				.getListByCriteriaQuery(cq, false);
		Set<String> dataRulecodes = systemService
				.getOperationCodesByRoleIdAndruleDataId(roleId, functionId);
		request.setAttribute("dataRuleList", dataRuleList);
		request.setAttribute("dataRulecodes", dataRulecodes);
		request.setAttribute("functionId", functionId);
		return new ModelAndView("system/role/dataRuleListForFunction");
	}
	
	
	/**
	 * 更新按钮权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateDataRule")
	@ResponseBody
	public AjaxJson updateDataRule(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String roleId = request.getParameter("roleId");
		String functionId = request.getParameter("functionId");
		String dataRulecodes = null;
		try {
			dataRulecodes = URLDecoder.decode(
					request.getParameter("dataRulecodes"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		CriteriaQuery cq1 = new CriteriaQuery(TSRoleFunction.class);
		cq1.eq("TSRole.id", roleId);
		cq1.eq("TSFunction.id", functionId);
		cq1.add();
		List<TSRoleFunction> rFunctions = systemService.getListByCriteriaQuery(
				cq1, false);
		if (null != rFunctions && rFunctions.size() > 0) {
			TSRoleFunction tsRoleFunction = rFunctions.get(0);
			tsRoleFunction.setDataRule(dataRulecodes);
			systemService.saveOrUpdate(tsRoleFunction);
		}
		j.setMsg("数据权限更新成功");
		return j;
	}
	
	
	
	/**
     * 添加 用户到角色 的页面  跳转
     * @param req request
     * @return 处理结果信息
     */
    @RequestMapping(params = "goAddUserToRole")
    public ModelAndView goAddUserToOrg(HttpServletRequest req) {
        return new ModelAndView("system/role/noCurRoleUserList");
    }
    
    /**
     * 获取 除当前 角色之外的用户信息列表
     * @param request request
     * @return 处理结果信息
     */
    @RequestMapping(params = "addUserToRoleList")
    public void addUserToOrgList(TSUser user, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        String roleId = request.getParameter("roleId");

        CriteriaQuery cq = new CriteriaQuery(TSUser.class, dataGrid);
        org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, user);

        // 获取 当前组织机构的用户信息
        CriteriaQuery subCq = new CriteriaQuery(TSRoleUser.class);
        subCq.setProjection(Property.forName("TSUser.id"));
        subCq.eq("TSRole.id", roleId);
        subCq.add();
        

        cq.add(Property.forName("id").notIn(subCq.getDetachedCriteria()));
        cq.add();

        this.systemService.getDataGridReturn(cq, true);
        TagUtil.datagrid(response, dataGrid);
    }
    /**
     * 添加 用户到角色
     * @param req request
     * @return 处理结果信息
     */
    @RequestMapping(params = "doAddUserToRole")
    @ResponseBody
    public AjaxJson doAddUserToOrg(HttpServletRequest req) {
        AjaxJson j = new AjaxJson();
        TSRole role = systemService.getEntity(TSRole.class, req.getParameter("roleId"));
        saveRoleUserList(req, role);
        message =  MutiLangUtil.paramAddSuccess("common.user");
//      systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
        j.setMsg(message);

        return j;
    }
    /**
     * 保存 角色-用户 关系信息
     * @param request request
     * @param depart depart
     */
    private void saveRoleUserList(HttpServletRequest request, TSRole role) {
        String userIds = oConvertUtils.getString(request.getParameter("userIds"));

        List<TSRoleUser> roleUserList = new ArrayList<TSRoleUser>();
        List<String> userIdList = extractIdListByComma(userIds);
        for (String userId : userIdList) {
            TSUser user = new TSUser();
            user.setId(userId);

            TSRoleUser roleUser = new TSRoleUser();
            roleUser.setTSUser(user);
            roleUser.setTSRole(role);

            roleUserList.add(roleUser);
        }
        if (!roleUserList.isEmpty()) {
            systemService.batchSave(roleUserList);
        }
    }
}
