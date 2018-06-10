package org.jeecgframework.web.system.controller.core;

import io.swagger.annotations.Api;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Validator;

import org.apache.log4j.Logger;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.ComboTree;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.model.json.ValidForm;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.LogUtil;
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.easyui.ComboTreeModel;
import org.jeecgframework.web.system.pojo.base.InterroleEntity;
import org.jeecgframework.web.system.pojo.base.InterroleInterfaceEntity;
import org.jeecgframework.web.system.pojo.base.InterroleUserEntity;
import org.jeecgframework.web.system.pojo.base.TSInterfaceDdataRuleEntity;
import org.jeecgframework.web.system.pojo.base.TSInterfaceEntity;
import org.jeecgframework.web.system.pojo.base.TSRoleUser;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.InterroleServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Title: Controller
 * @Description: t_s_interrole
 * @author onlineGenerator
 * @date 2017-11-30 11:38:39
 * @version V1.0
 *
 */
@Api(value = "Interrole", description = "t_s_interrole", tags = "interroleController")
@Controller
@RequestMapping("/interroleController")
public class InterroleController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(InterroleController.class);

	@Autowired
	private InterroleServiceI interroleService;
	@Autowired
	private SystemService systemService;
	@Autowired
	private Validator validator;
	@Autowired
	private UserService userService;

	/**
	 * t_s_interrole列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("system/interrole/interroleList");
	}

	/**
	 * easyuiAJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 */

	@RequestMapping(params = "roleGrid")
	public void roleGrid(InterroleEntity role, HttpServletRequest request, HttpServletResponse response,
			DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(InterroleEntity.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, role);
		// 自己写的工具类 ， 与HqlGenerateUtil 一样，改变实体类
		// InterfaceHqlUtil.installHql(cq, role);
		cq.add();
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 角色页面跳转
	 * 
	 * @param role
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(InterroleEntity role, HttpServletRequest req) {
		if (role.getId() != null) {
			role = systemService.getEntity(InterroleEntity.class, role.getId());
			req.setAttribute("role", role);
		}
		return new ModelAndView("system/interrole/interrole");
	}

	/**
	 * 角色录入
	 * 
	 * @param role
	 * @return
	 */
	@RequestMapping(params = "saveRole")
	@ResponseBody
	public AjaxJson saveRole(InterroleEntity role, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		try {
			if (StringUtil.isNotEmpty(role.getId())) {
				message = "角色: " + role.getRoleName() + "被更新成功";
				interroleService.saveOrUpdate(role);
				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			} else {
				message = "角色: " + role.getRoleName() + "被添加成功";
				interroleService.save(role);
				systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		logger.info(message);
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
	public ValidForm checkRole(InterroleEntity role, HttpServletRequest request, HttpServletResponse response) {
		ValidForm v = new ValidForm();
		String roleCode = oConvertUtils.getString(request.getParameter("param"));
		String code = oConvertUtils.getString(request.getParameter("code"));
		List<InterroleEntity> roles = systemService.findByProperty(InterroleEntity.class, "roleCode", roleCode);
		if (roles.size() > 0 && !code.equals(roleCode)) {
			v.setInfo("角色编码已存在");
			v.setStatus("n");
		}
		return v;
	}

	/**
	 * 删除角色
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "delRole")
	@ResponseBody
	public AjaxJson delRole(InterroleEntity role, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		// TODO 此处 先注释
		// int count = interroleService.getUsersOfThisRole(role.getId());
		// if (0 == 0) {
		// 删除角色之前先删除角色权限关系
		// delRoleFunction(role);
		// systemService.executeSql("delete from t_s_role_org where role_id=?",
		// role.getId()); // 删除 角色-机构 关系信息
		// role = systemService.getEntity(InterroleEntity.class, role.getId());
		// userService.delete(role);
		// message = "角色: " + role.getRoleName() + "被删除成功";
		// systemService.addLog(message,
		// Globals.Log_Type_DEL,Globals.Log_Leavel_INFO);
		// } else {
		// message = "角色: 仍被用户使用，请先删除关联关系";
		// }
		// int count = interroleService.getUsersOfThisRole(role.getId());

		String hql = " from InterroleInterfaceEntity  where  interrole_id= ?";
		List<InterroleInterfaceEntity> findByQueryString = systemService.findHql(hql,role.getId());

		role = systemService.getEntity(InterroleEntity.class, role.getId());
		if (findByQueryString.size() > 0 && findByQueryString != null) {
			// 删除角色之前先删除角色权限关系
			// delRoleFunction(role);
			// systemService.executeSql("delete from t_s_role_org where
			// role_id=?", role.getId()); // 删除 角色-机构 关系信息
			message = "接口角色:" + role.getRoleName() + "  仍被用户使用，请先删除关联关系";
		} else {
			userService.delete(role);
			message = "接口角色: " + role.getRoleName() + "被删除成功";
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}

		j.setMsg(message);
		logger.info(message);
		return j;
	}

	// TODO 存在关联关系 先删除关系，此处还没做 。
	/**
	 * 删除接口角色权限
	 * 
	 * @param role
	 */
	protected void delRoleFunction(InterroleEntity role) {
		List<InterroleInterfaceEntity> roleFunctions = systemService.findByProperty(InterroleInterfaceEntity.class,
				"interroleEntity.id", role.getId());
		if (roleFunctions.size() > 0) {
			for (InterroleInterfaceEntity tsRoleFunction : roleFunctions) {
				systemService.delete(tsRoleFunction);
			}
		}
		// TODO 用户关系
		List<TSRoleUser> roleUsers = systemService.findByProperty(TSRoleUser.class, "TSRole.id", role.getId());
		for (TSRoleUser tsRoleUser : roleUsers) {
			systemService.delete(tsRoleUser);
		}
	}

	/**
	 * 接口权限角色列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "fun")
	public ModelAndView fun(HttpServletRequest request) {
		String roleId = request.getParameter("roleId");
		request.setAttribute("roleId", roleId);
		return new ModelAndView("system/interrole/interroleSet");
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
	public List<ComboTree> setAuthority(InterroleEntity role, HttpServletRequest request, ComboTree comboTree) {
		CriteriaQuery cq = new CriteriaQuery(TSInterfaceEntity.class);
		if (comboTree.getId() != null) {
			cq.eq("tSInterface.id", comboTree.getId());
		}
		if (comboTree.getId() == null) {
			cq.isNull("tSInterface");
		}
		cq.notEq("interfaceLevel", Short.parseShort("-1"));
		cq.add();
		List<TSInterfaceEntity> interfaceList = systemService.getListByCriteriaQuery(cq, false);
		// Collections.sort(interfaceList, new NumberComparator());
		List<ComboTree> comboTrees = new ArrayList<ComboTree>();
		String roleId = request.getParameter("roleId");
		List<TSInterfaceEntity> loginActionlist = new ArrayList<TSInterfaceEntity>();// 已有权限菜单
		role = this.systemService.get(InterroleEntity.class, roleId);
		if (role != null) {
			List<InterroleInterfaceEntity> roleInterfaceList = systemService
					.findHql("from InterroleInterfaceEntity where interroleEntity.id = ?", role.getId());
			if (roleInterfaceList.size() > 0) {
				for (InterroleInterfaceEntity roleInterface : roleInterfaceList) {
					TSInterfaceEntity inter = (TSInterfaceEntity) roleInterface.getInterfaceEntity();
					loginActionlist.add(inter);
				}
			}
			roleInterfaceList.clear();
		}
		ComboTreeModel comboTreeModel = new ComboTreeModel("id", "interfaceName", "tSInterfaces");
		comboTrees = comboTree(interfaceList, comboTreeModel, loginActionlist, true);
		MutiLangUtil.setMutiComboTree(comboTrees);
		interfaceList.clear();
		interfaceList = null;
		loginActionlist.clear();
		loginActionlist = null;
		return comboTrees;
	}

	private List<ComboTree> comboTree(List<TSInterfaceEntity> all, ComboTreeModel comboTreeModel,
			List<TSInterfaceEntity> in, boolean recursive) {
		List<ComboTree> trees = new ArrayList<ComboTree>();
		for (TSInterfaceEntity obj : all) {
			trees.add(comboTree(obj, comboTreeModel, in, recursive));
		}
		all.clear();
		return trees;

	}

	/**
	 * 构建ComboTree
	 * 
	 * @param obj
	 * @param comboTreeModel
	 *            ComboTreeModel comboTreeModel = new
	 *            ComboTreeModel("id","functionName", "TSFunctions");
	 * @param in
	 * @param recursive
	 *            是否递归子节点
	 * @return
	 */

	private ComboTree comboTree(TSInterfaceEntity obj, ComboTreeModel comboTreeModel, List<TSInterfaceEntity> in,
			boolean recursive) {
		ComboTree tree = new ComboTree();
		String id = oConvertUtils.getString(obj.getId());
		tree.setId(id);
		tree.setText(oConvertUtils.getString(obj.getInterfaceName()));

		if (in == null) {
		} else {
			if (in.size() > 0) {
				for (TSInterfaceEntity inobj : in) {
					String inId = oConvertUtils.getString(inobj.getId());
					if (inId.equals(id)) {
						tree.setChecked(true);
					}
				}
			}
		}
		List<TSInterfaceEntity> curChildList = obj.getTSInterfaces();
		Collections.sort(curChildList, new Comparator<Object>() {
			@Override
			public int compare(Object o1, Object o2) {
				TSInterfaceEntity tsInterface1 = (TSInterfaceEntity) o1;
				TSInterfaceEntity tsInterface2 = (TSInterfaceEntity) o2;
				int flag = tsInterface1.getInterfaceOrder().compareTo(tsInterface2.getInterfaceOrder());
				if (flag == 0) {
					return tsInterface1.getInterfaceName().compareTo(tsInterface2.getInterfaceName());
				} else {
					return flag;
				}
			}
		});
		if (curChildList != null && curChildList.size() > 0) {
			tree.setState("closed");
			if (recursive) { // 递归查询子节点
				List<ComboTree> children = new ArrayList<ComboTree>();
				for (TSInterfaceEntity childObj : curChildList) {
					ComboTree t = comboTree(childObj, comboTreeModel, in, recursive);
					children.add(t);
				}
				tree.setChildren(children);
			}
		}

		/*
		 * if(obj.getFunctionType() == 1){ if(curChildList != null &&
		 * curChildList.size() > 0){ tree.setIconCls("icon-user-set-o"); }else{
		 * tree.setIconCls("icon-user-set"); } }
		 */

		if (curChildList != null) {
			curChildList.clear();
		}
		return tree;
	}

	/**
	 * 按钮权限展示 页面跳转
	 * 
	 * @param request
	 * @param functionId
	 * @param roleId
	 * @return
	 */
	@RequestMapping(params = "dataRuleListForInterface")
	public ModelAndView dataRuleListForInterface(HttpServletRequest request, String interfaceId, String roleId) {
		CriteriaQuery cq = new CriteriaQuery(TSInterfaceDdataRuleEntity.class);
		cq.eq("interfaceEntity.id", interfaceId);
		cq.add();
		// List<TSInterfaceDdataRuleEntity> dataRuleList =
		// this.systemService.getListByCriteriaQuery(cq, false);
		List<TSInterfaceDdataRuleEntity> dataRuleList = systemService
				.findHql("from TSInterfaceDdataRuleEntity where TSInterface.id = ?", interfaceId);

		Set<String> dataRulecodes = interroleService.getOperationCodesByRoleIdAndruleDataId(roleId, interfaceId);
		request.setAttribute("dataRuleList", dataRuleList);
		request.setAttribute("dataRulecodes", dataRulecodes);
		request.setAttribute("interfaceId", interfaceId);
		return new ModelAndView("system/interrole/dataRuleListForInterface");
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
			String roleinterface = request.getParameter("rolefunctions");
			InterroleEntity role = this.systemService.get(InterroleEntity.class, roleId);

			List<InterroleInterfaceEntity> roleInterfaceList = systemService
					.findByProperty(InterroleInterfaceEntity.class, "interroleEntity.id", role.getId());
			Map<String, InterroleInterfaceEntity> map = new HashMap<String, InterroleInterfaceEntity>();
			for (InterroleInterfaceEntity interfaceOfRole : roleInterfaceList) {
				map.put(interfaceOfRole.getInterfaceEntity().getId(), interfaceOfRole);
			}
			Set<String> set = new HashSet<String>();
			if (StringUtil.isNotEmpty(roleinterface)) {
				String[] roleInterfaces = roleinterface.split(",");
				for (String s : roleInterfaces) {
					set.add(s);
				}
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
	private void updateCompare(Set<String> set, InterroleEntity role, Map<String, InterroleInterfaceEntity> map) {
		List<InterroleInterfaceEntity> entitys = new ArrayList<InterroleInterfaceEntity>();
		List<InterroleInterfaceEntity> deleteEntitys = new ArrayList<InterroleInterfaceEntity>();
		for (String s : set) {
			if (map.containsKey(s)) {
				map.remove(s);
			} else {
				InterroleInterfaceEntity rf = new InterroleInterfaceEntity();
				TSInterfaceEntity f = this.systemService.get(TSInterfaceEntity.class, s);
				rf.setInterfaceEntity(f);
				rf.setInterroleEntity(role);
				entitys.add(rf);
			}
		}
		Collection<InterroleInterfaceEntity> collection = map.values();
		Iterator<InterroleInterfaceEntity> it = collection.iterator();
		for (; it.hasNext();) {
			deleteEntitys.add(it.next());
		}
		systemService.batchSave(entitys);
		systemService.deleteAllEntitie(deleteEntitys);

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
		String interfaceId = request.getParameter("interfaceId");
		String dataRulecodes = null;
		try {
			dataRulecodes = URLDecoder.decode(request.getParameter("dataRulecodes"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		CriteriaQuery cq1 = new CriteriaQuery(InterroleInterfaceEntity.class);
		cq1.eq("interroleEntity.id", roleId);
		cq1.eq("interfaceEntity.id", interfaceId);
		cq1.add();
		List<InterroleInterfaceEntity> rInterfaces = systemService.getListByCriteriaQuery(cq1, false);
		if (null != rInterfaces && rInterfaces.size() > 0) {
			InterroleInterfaceEntity tsRoleInterface = rInterfaces.get(0);
			tsRoleInterface.setDataRule(dataRulecodes);
			systemService.saveOrUpdate(tsRoleInterface);
		}
		j.setMsg("数据权限更新成功");
		return j;
	}

	
	
	// TODO 以下是用户的操作
	/**
	 * 接口角色所有用户信息列表页面跳转
	 * @return
	 */
	@RequestMapping(params = "userList")
	public ModelAndView userList(HttpServletRequest request) {
		request.setAttribute("roleId", request.getParameter("roleId"));
		return new ModelAndView("system/interrole/interroleUserList");
	}

	/**
	 * 用户列表查询
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 */
	@RequestMapping(params = "roleUserDatagrid")
	public void roleUserDatagrid(TSUser user, HttpServletRequest request, HttpServletResponse response,
			DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSUser.class, dataGrid);
		// 查询条件组装器
		String roleId = request.getParameter("roleId");
		// List<TSRoleUser> roleUser =
		// systemService.findByProperty(TSRoleUser.class, "TSRole.id", roleId);
		List<InterroleUserEntity> interRoleUser = systemService.findByProperty(InterroleUserEntity.class,
				"interroleEntity.id", roleId);
		/*
		 * // zhanggm：这个查询逻辑也可以使用这种 子查询的方式进行查询 CriteriaQuery subCq = new
		 * CriteriaQuery(TSRoleUser.class);
		 * subCq.setProjection(Property.forName("TSUser.id"));
		 * subCq.eq("TSRole.id", roleId); subCq.add();
		 * cq.add(Property.forName("id").in(subCq.getDetachedCriteria()));
		 * cq.add();
		 */
		Criterion cc = null;
		if (interRoleUser.size() > 0) {
			for (int i = 0; i < interRoleUser.size(); i++) {
				if (i == 0) {
					cc = Restrictions.eq("id", interRoleUser.get(i).getTSUser().getId());
				} else {
					cc = cq.getor(cc, Restrictions.eq("id", interRoleUser.get(i).getTSUser().getId()));
				}
			}
		} else {
			cc = Restrictions.eq("id", "-1");
		}
		cq.add(cc);
		cq.eq("deleteFlag", Globals.Delete_Normal);
		cq.add();
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, user);
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 添加 用户到角色 的页面 跳转
	 * 
	 * @param req
	 *            request
	 * @return 处理结果信息
	 */
	@RequestMapping(params = "goAddUserToRole")
	public ModelAndView goAddUserToRole(HttpServletRequest req) {
		return new ModelAndView("system/interrole/noCurInterRoleUserList");
	}

	/**
	 * 获取 除当前 角色之外的用户信息列表
	 * 
	 * @param request
	 *            request
	 * @return 处理结果信息
	 */
	@RequestMapping(params = "addUserToRoleList")
	public void addUserToOrgList(TSUser user, HttpServletRequest request, HttpServletResponse response,
			DataGrid dataGrid) {
		String roleId = request.getParameter("roleId");

		CriteriaQuery cq = new CriteriaQuery(TSUser.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, user);

		// 获取 当前组织机构的用户信息
		CriteriaQuery subCq = new CriteriaQuery(InterroleUserEntity.class);
		subCq.setProjection(Property.forName("TSUser.id"));
		subCq.eq("interroleEntity.id", roleId);
		subCq.add();
		cq.eq("userType", "2");
		cq.add(Property.forName("id").notIn(subCq.getDetachedCriteria()));
		cq.add();

		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 添加 用户到角色
	 * 
	 * @param req
	 *            request
	 * @return 处理结果信息
	 */
	@RequestMapping(params = "doAddUserToRole")
	@ResponseBody
	public AjaxJson doAddUserToRole(HttpServletRequest req) {
		String message = null;
		AjaxJson j = new AjaxJson();
		InterroleEntity role = systemService.getEntity(InterroleEntity.class, req.getParameter("roleId"));
		saveInterRoleUserList(req, role);
		message = MutiLangUtil.paramAddSuccess("common.user");
		systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		j.setMsg(message);

		return j;
	}

	/**
	 * 保存 角色-用户 关系信息
	 * 
	 * @param request
	 *            request
	 * @param depart
	 *            depart
	 */
	private void saveInterRoleUserList(HttpServletRequest request, InterroleEntity role) {
		String userIds = oConvertUtils.getString(request.getParameter("userIds"));

		List<InterroleUserEntity> interRoleUserList = new ArrayList<InterroleUserEntity>();
		List<String> userIdList = extractIdListByComma(userIds);
		for (String userId : userIdList) {
			TSUser user = new TSUser();
			user.setId(userId);

			InterroleUserEntity interRoleUser = new InterroleUserEntity();
			interRoleUser.setTSUser(user);
			interRoleUser.setInterroleEntity(role);

			interRoleUserList.add(interRoleUser);
		}
		if (!interRoleUserList.isEmpty()) {
			systemService.batchSave(interRoleUserList);
		}
	}

	/**
	 * 删除用户角色
	 * @param userid
	 * @param roleid
	 * @return
	 */
	@RequestMapping(params = "delUserRole")
	@ResponseBody
	public AjaxJson delUserRole(@RequestParam(required = true) String userid,
			@RequestParam(required = true) String roleid) {
		AjaxJson ajaxJson = new AjaxJson();
		try {
			// List<TSRoleUser> roleUserList =
			// this.systemService.findByProperty(TSRoleUser.class, "TSUser.id",
			// userid);
			List<InterroleUserEntity> interRoleUser = this.systemService.findByProperty(InterroleUserEntity.class,
					"interroleEntity.id", userid);
			if (interRoleUser.size() == 1) {
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg("不可删除用户的角色关系，请使用修订用户角色关系");
			} else {
				String sql = "delete from t_s_interrole_user where user_id = ? and interrole_id = ?";
				this.systemService.executeSql(sql, userid, roleid);
				ajaxJson.setMsg("成功删除用户对应的角色关系");
			}
		} catch (Exception e) {
			LogUtil.log("删除用户对应的角色关系失败", e.getMessage());
			ajaxJson.setSuccess(false);
			ajaxJson.setMsg(e.getMessage());
		}
		return ajaxJson;
	}


}
