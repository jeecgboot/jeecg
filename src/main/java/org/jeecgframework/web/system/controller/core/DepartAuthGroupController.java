package org.jeecgframework.web.system.controller.core;

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

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.ComboTree;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.NumberComparator;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.jeecgframework.p3.core.page.SystemTools;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.easyui.ComboTreeModel;
import org.jeecgframework.web.system.dao.DepartAuthGroupDao;
import org.jeecgframework.web.system.pojo.base.TSDataRule;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.pojo.base.TSDepartAuthGroupEntity;
import org.jeecgframework.web.system.pojo.base.TSDepartAuthgFunctionRelEntity;
import org.jeecgframework.web.system.pojo.base.TSDepartAuthgManagerEntity;
import org.jeecgframework.web.system.pojo.base.TSFunction;
import org.jeecgframework.web.system.pojo.base.TSOperation;
import org.jeecgframework.web.system.pojo.base.TSRole;
import org.jeecgframework.web.system.pojo.base.TSRoleFunction;
import org.jeecgframework.web.system.pojo.base.TSRoleUser;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.pojo.base.TSUserOrg;
import org.jeecgframework.web.system.service.DepartAuthGroupService;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.util.OrgConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**   
 * @Title: Controller  
 * @Description: 部门管理员功能
 * @author LiShaoQing
 * @date 2017-12-01 18:00:33
 * @version V1.0   
 *
 */
@Controller
@RequestMapping("/departAuthGroupController")
public class DepartAuthGroupController extends BaseController {
	
	private static final Logger logger = Logger.getLogger(DepartAuthGroupController.class);
	
	@Autowired
	private SystemService systemService;
	@Autowired
	private DepartAuthGroupService departAuthGroupService;
	@Autowired
	private DepartAuthGroupDao departAuthGroupDao;
	
	/**
	 * 部门管理员设置页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		//获取当前登录的用户名
		String userName = ResourceUtil.getSessionUser().getUserName();
		request.setAttribute("userName", userName);
		return new ModelAndView("system/authGroup/depart_role");
	}
	
	/**
	 * 管理员授权页面
	 */
	@RequestMapping(params = "departGroupUserList")
	public ModelAndView departGroupUserList(HttpServletRequest request) {
		String groupId = request.getParameter("id");
		request.setAttribute("groupId", groupId);
		return new ModelAndView("system/authGroup/departGroupUserList");
	}
	
	/**
	 * 跳转选择用户界面
	 * @return
	 */
	@RequestMapping(params = "addUserSelect")
	public ModelAndView addUserSelect(HttpServletRequest request) {
		String groupId = request.getParameter("groupId");
		request.setAttribute("groupId", groupId);
		return new ModelAndView("system/authGroup/addUserSelect");
	}
	
	/**
	 * 用户选择角色跳转页面
	 * 
	 * @return
	 */
	@RequestMapping(params = "openSelectRole")
	public ModelAndView openSelectRole(HttpServletRequest request) {
		ModelAndView mv = new ModelAndView("system/authGroup/usersRole");
		String userId = request.getParameter("userId");
		String sql = "select r.id,r.rolename from t_s_role r where r.id in (select roleid from t_s_role_user ru where ru.userid = ?)";
		List<Map<String,Object>> maps = systemService.findForJdbc(sql, userId);
		net.sf.json.JSONArray array = net.sf.json.JSONArray.fromObject(maps);
		mv.addObject("roles", array);
		return mv;
	}
	
	/**
	 * 部门角色管理页面
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "departRoleAuth")
	public ModelAndView departRoleAuth(HttpServletRequest request) {
		return new ModelAndView("system/authGroup/depart_role_auth");
	}
	
	/**
	 * 跳转部门角色组展示信息页面
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "showDepartRoleAuth")
	public ModelAndView showDepartRoleAuth(String id,HttpServletRequest request) {
		TSDepartAuthGroupEntity departAuthGroup = systemService.getEntity(TSDepartAuthGroupEntity.class, id);
		request.setAttribute("departAuthGroup", departAuthGroup);
		return new ModelAndView("system/authGroup/showDepartRoleAuth");
	}
	
	/**
	 * 部门角色管理页面
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "addDepartRoleAuth")
	public ModelAndView addDepartRoleAuth(String id, HttpServletRequest request) {
		TSDepartAuthGroupEntity departAuthGroup = systemService.getEntity(TSDepartAuthGroupEntity.class, id);
		request.setAttribute("departAuthGroup", departAuthGroup);
		return new ModelAndView("system/authGroup/addDepartRoleAuth");
	}
	
	/**
	 * 部门角色管理页面
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateDepartRoleAuth")
	public ModelAndView updateDepartRoleAuth(String id, HttpServletRequest request) {
		TSRole role = systemService.getEntity(TSRole.class, id);
		request.setAttribute("role", role);
		return new ModelAndView("system/authGroup/updateDepartRoleAuth");
	}
	
	/**
	 * 角色显示列表
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 */
	@RequestMapping(params = "datagridRole")
	public void datagridRole(TSRole tsRole, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSRole.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, tsRole);
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}
	
	/**
	 * 添加管理员组页面跳转,部门更新
	 * @param id
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "addOrUpdate",method = {RequestMethod.POST,RequestMethod.GET})
	public ModelAndView addOrUpdate(String id, HttpServletRequest req) {
		TSDepartAuthGroupEntity departAuthGroup = this.systemService.findUniqueByProperty(TSDepartAuthGroupEntity.class, "id", id);
		req.setAttribute("departAuthGroup", departAuthGroup);
		return new ModelAndView("system/authGroup/authGroupSet");
	}
	
	/**
	 * 组织机构树
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "departSelect")
    public String departSelect(HttpServletRequest req) {
		req.setAttribute("deptId", req.getParameter("deptId"));
		req.setAttribute("isRegister", req.getParameter("isRegister"));
        return "system/authGroup/authDeptSelect";
    }
	
	/**
	 * 部门权限授权页面跳转
	 * @param departAuthGroup
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "departAuthGroupRel")
	public ModelAndView departAuthGroupRel(String id,TSDepartAuthGroupEntity departAuthGroup, HttpServletRequest request) {
		departAuthGroup = systemService.getEntity(TSDepartAuthGroupEntity.class, id);
		request.setAttribute("departAuthGroup", departAuthGroup);
		return new ModelAndView("system/authGroup/departAuthGroupShow");
	}
	
	/**
	 * 角色页面跳转
	 * @param departAuthGroup
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "departRoleAuthGroupRel")
	public ModelAndView departRoleAuthGroupRel(String id, HttpServletRequest request) {
		TSRole role = systemService.getEntity(TSRole.class, id);
		request.setAttribute("role", role);
		return new ModelAndView("system/authGroup/departRoleAuthGroupShow");
	}
	
	/**
	 * 授权组列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "fun")
	public ModelAndView fun(HttpServletRequest request) {
		String id = request.getParameter("id");
		request.setAttribute("gid", id);
		request.setAttribute("pid", 0);
		return new ModelAndView("system/authGroup/departAuthorised");
	}
	
	/**
	 * 授权组列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "funDepartRoleAuth")
	public ModelAndView funDepartRoleAuth(HttpServletRequest request) {
		String id = request.getParameter("id");
		request.setAttribute("gid", id);
		String departAgId = request.getParameter("pid");
		request.setAttribute("departAgId", departAgId);
		return new ModelAndView("system/authGroup/departRoleAuthorised");
	}
	
	/**
	 * 部门用户角色授权页面
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "departAuthGroupAuthorizeSet")
	public ModelAndView departAuthGroupAuthorizeSet(HttpServletRequest request) {
		return new ModelAndView("system/authGroup/depart_role_user_auth");
	}
	
	/**
	 * 加载权限组管理(不查询子)
	 * @param departAuthGroup
	 * @param response
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params="getMainTreeData",method ={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public AjaxJson getMainTreeData(TSDepartAuthGroupEntity departAuthGroup,HttpServletResponse response,HttpServletRequest request ){
		AjaxJson j = new AjaxJson();
		try{
			List<Map<String,Object>> departAuthGroupList = new ArrayList<Map<String,Object>>();
			//获取当前登录用户账号
			String userName = ResourceUtil.getSessionUser().getUserName();
			List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
			List<Map<String,Object>> chkDepartAuthGroupList = new ArrayList<Map<String,Object>>();
			//超级用户可查看全部
			if(userName.equals("admin")) {

				MiniDaoPage<Map<String,Object>> list = this.departAuthGroupService.getDepartAuthGroupList(0, 50);
				departAuthGroupList= SystemTools.convertPaginatedList(list);
				chkDepartAuthGroupList = this.departAuthGroupService.chkDepartAuthGroupList(userName);
				recursiveGroup(dataList, departAuthGroupList,chkDepartAuthGroupList,"0");
			} else {
				MiniDaoPage<Map<String,Object>> list = this.departAuthGroupService.getDepartAuthGroupByUserId(0, 50, userName);
				departAuthGroupList = SystemTools.convertPaginatedList(list);
				chkDepartAuthGroupList = this.departAuthGroupService.chkDepartAuthGroupList(userName);

				recursiveGroup(dataList, departAuthGroupList,chkDepartAuthGroupList,"0");
			}
			j.setObj(dataList);
		}catch(Exception e){
			e.printStackTrace();
		}
		return j;
	}
	
	/**
	 * 加载部门角色
	 * @param departAuthGroup
	 * @param response
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(params="getDepartRoleTree",method ={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public AjaxJson getDepartRoleTree(TSDepartAuthGroupEntity departAuthGroup,HttpServletResponse response,HttpServletRequest request ){
		AjaxJson j = new AjaxJson();
		try{
			List<Map<String,Object>> departAuthGroupList = new ArrayList<Map<String,Object>>();
			//获取当前登录用户账号
			String userName = ResourceUtil.getSessionUser().getUserName();
			List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
			List<Map<String,Object>> chkDepartAuthGroupList = new ArrayList<Map<String,Object>>();
			//超级用户可查看全部
			if(userName.equals("admin")) {

				MiniDaoPage<Map<String,Object>> list = this.departAuthGroupService.getDepartAuthGroupList(0, 50);
				departAuthGroupList = SystemTools.convertPaginatedList(list);
				String chkSql = "select r.* from t_s_depart_auth_group dag,t_s_role r where dag.id = r.depart_ag_id";
				chkDepartAuthGroupList = this.systemService.findForJdbc(chkSql);
				recursiveGroup(dataList, departAuthGroupList,chkDepartAuthGroupList,"1");
			} else {
				MiniDaoPage<Map<String,Object>> list = this.departAuthGroupService.getDepartAuthRole(0, 50, userName);
				departAuthGroupList = SystemTools.convertPaginatedList(list);
				chkDepartAuthGroupList = this.departAuthGroupService.chkDepartAuthRole();

				recursiveGroup(dataList, departAuthGroupList,chkDepartAuthGroupList,"1");
			}
			j.setObj(dataList);
		}catch(Exception e){
			e.printStackTrace();
		}
		return j;
	}
	
	/**
	 * 加载授权部门角色信息
	 * @param departAuthGroup
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(params="getDepartGroupRoleTree",method ={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public AjaxJson getDepartGroupRoleTree(TSDepartAuthGroupEntity departAuthGroup, HttpServletResponse response, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			List<Map<String, Object>> departAuthGroupList = new ArrayList<Map<String, Object>>();
			List<Map<String, Object>> chkDepartAuthGroupList = new ArrayList<Map<String, Object>>();
			String userId = request.getParameter("userId");
			String departId = request.getParameter("departId");
			String sql = "SELECT r.id,r.rolecode,r.rolename FROM t_s_depart_auth_group dag,t_s_role r WHERE dag.id = r.depart_ag_id AND dag.dept_id =?";
			departAuthGroupList = this.systemService.findForJdbc(sql, departId);// 全部角色
			String chkSql = "SELECT ru.roleid FROM t_s_depart_auth_group dag,t_s_role r,t_s_role_user ru" +
					" WHERE dag.id = r.depart_ag_id AND r.ID = ru.roleid AND ru.userid = ? AND dag.dept_id = ?";
			chkDepartAuthGroupList = this.systemService.findForJdbc(chkSql, userId, departId);// 已拥有角色
			List<Map<String, Object>> dataList = recursiveGroup(departAuthGroupList, chkDepartAuthGroupList);
			j.setObj(dataList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return j;
	}

	private List<Map<String, Object>> recursiveGroup(List<Map<String, Object>> allRoles, List<Map<String, Object>> userRoles) {
		List<Map<String, Object>> dataList = new ArrayList<Map<String,Object>>();
		for (Map<String, Object> auth : allRoles) {
				Map<String, Object> role = new HashMap<String, Object>();
				role.put("chkDisabled", false);
				role.put("checked", false);
				//匹配用户和角色关联，选中角色
				for (Map<String, Object> userRole : userRoles) {
					if(userRole.get("roleid").equals(auth.get("id"))){
						role.put("checked", true);
						break;
					}
				}
				role.put("click", true);
				role.put("id", auth.get("id"));
				role.put("name", auth.get("rolename"));
				role.put("nocheck", false);
				role.put("struct", "TREE");
				role.put("title", auth.get("rolename"));
				role.put("level", 1);
				role.put("icon", "plug-in/ztree/css/img/diy/document.png");
				dataList.add(role);
		}
		
		return dataList;
	}
	
	/**
	 * 不递归查询子级节点
	 * @param dataList
	 * @param functionGroupList
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	private void recursiveGroup(List<Map<String,Object>> dataList,
			List<Map<String,Object>> departAuthGroupList,
			List<Map<String,Object>> chkDepartAuthGroupList,String value){
		Map<String, Object> map = null;
		Map<String, List> authMap = null;
		if ("1".equals(value) && chkDepartAuthGroupList != null && chkDepartAuthGroupList.size() > 0) {
			authMap = new HashMap<String, List>();
			for (Map<String, Object> auth : chkDepartAuthGroupList) {
				String key = auth.get("depart_ag_id").toString();
				List authList = authMap.get(key);
				if (authList == null) {
					authList = new ArrayList();
					authMap.put(key, authList);
				}
				map = new HashMap<String, Object>();
				map.put("chkDisabled", false);
				map.put("click", true);
				map.put("id", auth.get("id"));
				map.put("name", auth.get("rolename"));
				map.put("nocheck", false);
				map.put("struct", "TREE");
				map.put("title", auth.get("rolename"));
				map.put("level", 2);
				map.put("icon", "plug-in/ztree/css/img/diy/node.png");
				authList.add(map);
			}
		}
		// 给zTree赋值数据
		for (Map<String, Object> m : departAuthGroupList) {
			map = new HashMap<String, Object>();
			map.put("chkDisabled", false);
			map.put("click", true);
			map.put("id", m.get("id"));
			String deptName = m.get("dept_name").toString();

			map.put("name", deptName + "管理组 (" + m.get("group_name") + ")");

			map.put("nocheck", false);
			map.put("struct", "TREE");
			map.put("title", m.get("group_name"));
			map.put("level", m.get("level"));
			map.put("icon", "plug-in/ztree/css/img/diy/document.png");
			// 判断部门权限被选中
			if ("0".equals(value)) {
				if (chkDepartAuthGroupList != null && chkDepartAuthGroupList.size() > 0) {
					for (Map<String, Object> chkMap : chkDepartAuthGroupList) {
						if (chkMap.get("id").toString().equals(map.get("id").toString())) {
							map.put("checked", true);
						}
					}
				}
			} else {
				if (authMap != null && authMap.get(map.get("id").toString()) != null) {
					map.put("checked", true);
					map.put("children", authMap.get(map.get("id").toString()));
				}
			}
			dataList.add(map);
		}
	}
	
	/**
	 * 显示机构树
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "getDepartInfo")
	@ResponseBody
	public AjaxJson getDepartInfo(HttpServletRequest request, HttpServletResponse response){
		AjaxJson j = new AjaxJson();
		//根据登陆用户判断，二级管理员根据一级权限组查询
		TSUser sessionUser = ResourceUtil.getSessionUser();
		String userName = null;
		if(sessionUser!=null)userName=sessionUser.getUserName();
		String orgIds = request.getParameter("orgIds");
		String[] ids = new String[]{}; 
		if(StringUtils.isNotBlank(orgIds)){
			orgIds = orgIds.substring(0, orgIds.length()-1);
			ids = orgIds.split("\\,");
		}
		String isRegister=request.getParameter("isRegister");
		if(oConvertUtils.isEmpty(isRegister))isRegister="2";
		TSDepart dePart = null;
		List<TSDepart> tSDeparts = new ArrayList<TSDepart>();
		String parentid = request.getParameter("parentid");
		StringBuffer hql = new StringBuffer(" from TSDepart t where 1=1 ");
		if(StringUtils.isNotBlank(parentid)){
			dePart = this.systemService.getEntity(TSDepart.class, parentid);
			hql.append(" and TSPDepart = ? ");
			tSDeparts = this.systemService.findHql(hql.toString(), dePart);
		} else {
			//当用户名为空（注册时），或admin登陆查看所有组织机构树
			if(oConvertUtils.isEmpty(userName) || "admin".equals(userName)) {
				hql.append(" and TSPDepart is null ");
				//企业用户注册时不显示供应商节点

				if(isRegister.equals("1")){
					hql.append(" and orgCode!=?");
					tSDeparts = this.systemService.findHql(hql.toString(),OrgConstants.SUPPLIER_ORG_CODE);
				}else{
					tSDeparts = this.systemService.findHql(hql.toString());
				}

			} else {
				//当其他用户登陆的时候查询用户关联的管理员组的组织机构

				hql.append(" and id in (select deptId from TSDepartAuthGroupEntity where id in (select groupId from TSDepartAuthgManagerEntity where userId = ?))");
				tSDeparts = this.systemService.findHql(hql.toString(),userName);

			}
		}
		
		//拼装树形结构既设置节点checked属性
		List<Map<String,Object>> dateList = null;
		dateList = new ArrayList<Map<String,Object>>();
		if(tSDeparts.size()>0){
			Map<String,Object> map = null;
			String sql = null;
			 Object[] params = null;
			for(TSDepart depart:tSDeparts){
				map = new HashMap<String,Object>();
				map.put("id", depart.getId());
				map.put("name", depart.getDepartname());
				map.put("code",depart.getOrgCode());
				map.put("type", depart.getOrgType());
				//只显示供应商虚拟节点
				if(!depart.getOrgCode().equals("Z999")) {
					if(ids.length>0){
						for(String id:ids){
							if(id.equals(depart.getId())){
								map.put("checked", true);
							}
						}
					}
					if(StringUtils.isNotBlank(parentid)){
						map.put("pId", parentid);
					} else{
						map.put("pId", "1");
					}
					//根据id判断是否有子节点
					sql = "select count(1) from t_s_depart t where t.parentdepartid = ?";
					params = new Object[]{depart.getId()};
					long count = this.systemService.getCountForJdbcParam(sql, params);
					if(count>0){
						map.put("isParent",true);
					}
				}
				if ("1".equals(depart.getOrgType())) {
					map.put("icon", "plug-in/ztree/css/img/diy/company.png");
				} else if ("2".equals(depart.getOrgType())) {
					map.put("icon", "plug-in/ztree/css/img/diy/depart.png");
				} else if ("3".equals(depart.getOrgType())) {
					map.put("icon", "plug-in/ztree/css/img/diy/position.png");
				} else if ("4".equals(depart.getOrgType())) {
					map.put("icon", "plug-in/ztree/css/img/diy/gys.png");
				} else if ("9".equals(depart.getOrgType())) {
					map.put("icon", "plug-in/ztree/css/img/diy/gysroot.png");
				}
				dateList.add(map);
			}
		} 
		net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(dateList);
		j.setMsg(jsonArray.toString());
		return j;
	}
	
	/**
	 * 校验部门，部门与权限组一对一
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "checkDept", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson checkDept(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			String deptId = request.getParameter("deptId");
			String curId = request.getParameter("curId");
			if(StringUtils.isNotEmpty(curId)) {

				String sql = "select dept_id from t_s_depart_auth_group where id= ?";
				List<Map<String,Object>> deptIdMaps = systemService.findForJdbc(sql,curId);

				if(deptIdMaps.get(0).get("dept_id").equals(deptId)) {
					j.setSuccess(true);
				}
			}else {

				String sql = "select count(0) as count,group_name,dept_name from t_s_depart_auth_group where dept_id = ? group by group_name";
				List<Map<String,Object>> deptMaps = systemService.findForJdbc(sql,deptId);

				if(deptMaps.size() > 0) {
					j.setMsg(deptMaps.get(0).get("dept_name")+"已设置管理员组,请勿重复设置");
					j.setSuccess(false);
				} else {
					j.setSuccess(true);
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
			j.setMsg("操作失败");
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 新增或更新保存方法
	 * @param departAuthGroup
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(TSDepartAuthGroupEntity departAuthGroup, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			//判断是新增还是更新
			if(StringUtils.isEmpty(departAuthGroup.getId())) {
				departAuthGroup.setLevel(1);
				systemService.save(departAuthGroup);
			} else {
				systemService.saveOrUpdate(departAuthGroup);
			}
			j.setMsg("保存成功");
			j.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			j.setMsg("保存失败");
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 删除部门管理员组
	 * @param departAuthGroup
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(TSDepartAuthGroupEntity departAuthGroup, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try{
			departAuthGroup = systemService.getEntity(TSDepartAuthGroupEntity.class, departAuthGroup.getId());
			systemService.delete(departAuthGroup);
			j.setMsg("删除部门管理员组成功");
			j.setSuccess(true);
		} catch(Exception e) {
			e.getStackTrace();
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 显示设置菜单权限
	 * 
	 * @param request
	 * @param comboTree
	 * @return
	 */
	@RequestMapping(params = "setAuthority")
	@ResponseBody
	public List<ComboTree> setAuthority(HttpServletRequest request, ComboTree comboTree) {
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
		//获取pid,根据pid查出上级所拥有的权限
		String groupId = request.getParameter("gid");
		List<TSFunction> loginActionlist = new ArrayList<TSFunction>();// 已有权限菜单
		List<String> selectChild = new ArrayList<String>();
		selectChild = null;
		if (StringUtils.isNotEmpty(groupId)) {
			List<TSDepartAuthgFunctionRelEntity> functionGroupList = systemService.findByProperty(TSDepartAuthgFunctionRelEntity.class, "tsDepartAuthGroup.id",groupId);
			if (functionGroupList.size() > 0) {
				for (TSDepartAuthgFunctionRelEntity functionGroupRel : functionGroupList) {
					if(functionGroupRel.getTsFunction() == null) {
						continue;
					}
					TSFunction function = (TSFunction) functionGroupRel.getTsFunction();
					loginActionlist.add(function);
				}
			}
			functionGroupList.clear();
		}
		ComboTreeModel comboTreeModel = new ComboTreeModel("id","functionName", "TSFunctions");
		comboTrees = comboTree(functionList, comboTreeModel,loginActionlist, true, selectChild);
		MutiLangUtil.setMutiComboTree(comboTrees);
		functionList.clear();
		functionList = null;
		loginActionlist.clear();
		loginActionlist = null;
		return comboTrees;
	}
	
	private List<ComboTree> comboTree(List<TSFunction> all, ComboTreeModel comboTreeModel, List<TSFunction> in, boolean recursive,List<String> selectChild) {
		List<ComboTree> trees = new ArrayList<ComboTree>();
		for (TSFunction obj : all) {
			trees.add(comboTree(obj, comboTreeModel, in, recursive, selectChild));
		}
		all.clear();
		return trees;
	}
	private ComboTree comboTree(TSFunction obj, ComboTreeModel comboTreeModel, List<TSFunction> in, boolean recursive, List<String> selectChild) {
		ComboTree tree = new ComboTree();
		String id = oConvertUtils.getString(obj.getId());
		tree.setId(id);
		tree.setText(oConvertUtils.getString(obj.getFunctionName()));
		if (in == null) {
		} else {
			if (in.size() > 0) {
				for (TSFunction inobj : in) {
					String inId = oConvertUtils.getString(inobj.getId());
                    if (inId.equals(id)) {
						tree.setChecked(true);
					}
				}
			}
		}
		List<TSFunction> curChildList = obj.getTSFunctions();
		Collections.sort(curChildList, new Comparator<Object>(){
			@Override
	        public int compare(Object o1, Object o2) {
	        	TSFunction tsFunction1=(TSFunction)o1;  
	        	TSFunction tsFunction2=(TSFunction)o2;  
	        	int flag=tsFunction1.getFunctionOrder().compareTo(tsFunction2.getFunctionOrder());
	        	if(flag==0){
	        		return tsFunction1.getFunctionName().compareTo(tsFunction2.getFunctionName());
	        	}else{
	        		return flag;
	        	}
	        }             
	    });
		if (curChildList != null && curChildList.size() > 0) {
			tree.setState("closed");
            if (recursive) { // 递归查询子节点
                List<ComboTree> children = new ArrayList<ComboTree>();
                for (TSFunction childObj : curChildList) {
                	//判断上级节点的ID
					ComboTree t = comboTree(childObj, comboTreeModel, in, recursive,selectChild);
					if(selectChild==null||selectChild.contains(childObj.getId())) {
						children.add(t);
					}
                }
                tree.setChildren(children);
            }
        }
		if(obj.getFunctionType() == 1){
			if(curChildList != null && curChildList.size() > 0){
				tree.setIconCls("icon-user-set-o");
			}else{
				tree.setIconCls("icon-user-set");
			}
		}
		if(curChildList!=null){
			curChildList.clear();
		}
		return tree;
	}
	
	/**
	 * 列表操作权限展示
	 * 
	 * @param request
	 * @param functionId
	 * @return
	 */
	@RequestMapping(params = "operationListForFunction")
	public ModelAndView operationListForFunction(HttpServletRequest request,
			String functionId) {
		String gid = request.getParameter("groupId");
		CriteriaQuery cq = new CriteriaQuery(TSOperation.class);
		cq.eq("TSFunction.id", functionId);
		cq.eq("status", Short.valueOf("0"));
		cq.in("id", null);
		cq.add();
		List<TSOperation> operationList = this.systemService
				.getListByCriteriaQuery(cq, false);
		Set<String> operationCodes = systemService.getDepartAuthGroupOperationSet(gid, functionId,OrgConstants.GROUP_DEPART_ROLE_AUTH);
		request.setAttribute("operationList", operationList);
		request.setAttribute("operationcodes", operationCodes);
		request.setAttribute("functionId", functionId);
		return new ModelAndView("system/authGroup/operationListForFunction");
	}
	
	/**
	 * 数据权限展示
	 * 
	 * @param request
	 * @param functionId
	 * @return
	 */
	@RequestMapping(params = "dataRuleListForFunction")
	public ModelAndView dataRuleListForFunction(HttpServletRequest request,
			String functionId) {
		String gid = request.getParameter("groupId");
		CriteriaQuery cq = new CriteriaQuery(TSDataRule.class);
		cq.eq("TSFunction.id", functionId);
		cq.in("id", null);
		cq.add();
		List<TSDataRule> dataRuleList = this.systemService.getListByCriteriaQuery(cq, false);
		Set<String> dataRulecodes = systemService.getDepartAuthGroupDataRuleSet(gid, functionId,OrgConstants.GROUP_DEPART_ROLE_AUTH);
		request.setAttribute("dataRuleList", dataRuleList);
		request.setAttribute("dataRulecodes", dataRulecodes);
		request.setAttribute("functionId", functionId);
		return new ModelAndView("system/authGroup/dataRuleListForFunction");
	}
	
	/**
	 * 更新部门管理员组菜单权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateDepartAuthority")
	@ResponseBody
	public AjaxJson updateDepartAuthority(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			String groupId = request.getParameter("groupId");
			String function = request.getParameter("functions");
			TSDepartAuthGroupEntity functionGroup = this.systemService.get(TSDepartAuthGroupEntity.class, groupId);
			List<TSDepartAuthgFunctionRelEntity> functionGroupList = systemService.findByProperty(TSDepartAuthgFunctionRelEntity.class, "tsDepartAuthGroup.id",functionGroup.getId());
			Map<String, TSDepartAuthgFunctionRelEntity> map = new HashMap<String, TSDepartAuthgFunctionRelEntity>();
			for (TSDepartAuthgFunctionRelEntity functionofGroup : functionGroupList) {
				if(functionofGroup.getTsFunction()==null) {
					continue;
				}
				map.put(functionofGroup.getTsFunction().getId(), functionofGroup);
			}
			String[] functions = function.split(",");
			Set<String> set = new HashSet<String>();
			for (String s : functions) {
				set.add(s);
			}
			updateCompare(set, functionGroup, map);
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
	 * @param functionGroup
	 *            当前权限组
	 * @param map
	 *            旧的权限列表
	 */
	private void updateCompare(Set<String> set, TSDepartAuthGroupEntity functionGroup,
			Map<String, TSDepartAuthgFunctionRelEntity> map) {
		List<TSDepartAuthgFunctionRelEntity> entitys = new ArrayList<TSDepartAuthgFunctionRelEntity>();
		List<TSDepartAuthgFunctionRelEntity> deleteEntitys = new ArrayList<TSDepartAuthgFunctionRelEntity>();
		for (String s : set) {
			if (map.containsKey(s)) {
				map.remove(s);
			} else {
				TSDepartAuthgFunctionRelEntity functionGroupRel = new TSDepartAuthgFunctionRelEntity();
				TSFunction f = this.systemService.get(TSFunction.class, s);
				functionGroupRel.setTsFunction(f);
				functionGroupRel.setTsDepartAuthGroup(functionGroup);
				entitys.add(functionGroupRel);
			}
		}
		Collection<TSDepartAuthgFunctionRelEntity> collection = map.values();
		Iterator<TSDepartAuthgFunctionRelEntity> it = collection.iterator();
		for (; it.hasNext();) {
			deleteEntitys.add(it.next());
		}
		systemService.batchSave(entitys);
		systemService.deleteAllEntitie(deleteEntitys);
	}
	
	/**
	 * 更新部门管理员组页面操作权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateDepartOperation")
	@ResponseBody
	public AjaxJson updateDepartOperation(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String groupId = request.getParameter("groupId");
		String functionId = request.getParameter("functionId");
		String operationcodes = null;
		try {
			operationcodes = URLDecoder.decode(
					request.getParameter("operationcodes"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		CriteriaQuery cq1 = new CriteriaQuery(TSDepartAuthgFunctionRelEntity.class);
		cq1.eq("tsDepartAuthGroup.id", groupId);
		cq1.eq("tsFunction.id", functionId);
		cq1.add();
		List<TSDepartAuthgFunctionRelEntity> functionGroups = systemService.getListByCriteriaQuery(
				cq1, false);
		if (null != functionGroups && functionGroups.size() > 0) {
			TSDepartAuthgFunctionRelEntity tsfunctionGroup = functionGroups.get(0);
			tsfunctionGroup.setOperation(operationcodes);
			systemService.saveOrUpdate(tsfunctionGroup);
		}
		j.setMsg("页面操作权限更新成功");
		return j;
	}
	
	/**
	 * 更新部门管理员组数据权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateDepartDataRule")
	@ResponseBody
	public AjaxJson updateDepartDataRule(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String groupId = request.getParameter("groupId");
		String functionId = request.getParameter("functionId");
		String dataRulecodes = null;
		try {
			dataRulecodes = URLDecoder.decode(
					request.getParameter("dataRulecodes"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		CriteriaQuery cq1 = new CriteriaQuery(TSDepartAuthgFunctionRelEntity.class);
		cq1.eq("tsDepartAuthGroup.id", groupId);
		cq1.eq("tsFunction.id", functionId);
		cq1.add();
		List<TSDepartAuthgFunctionRelEntity> functionGroups = systemService.getListByCriteriaQuery(
				cq1, false);
		if (null != functionGroups && functionGroups.size() > 0) {
			TSDepartAuthgFunctionRelEntity tsFunctionGroup = functionGroups.get(0);
			tsFunctionGroup.setDatarule(dataRulecodes);
			systemService.saveOrUpdate(tsFunctionGroup);
		}
		j.setMsg("数据权限更新成功");
		return j;
	}
	
	/**
	 * 根据选中的部门管理员组返回用户数据
	 * @param user
	 * @param request
	 * @param response
	 * @param dataGrid
	 */
	@RequestMapping(params = "getDepartGroupUser", method = RequestMethod.POST)
	@ResponseBody
	public void getDepartGroupUser(TSUser user,HttpServletRequest request,HttpServletResponse response,DataGrid dataGrid){
		CriteriaQuery cq = new CriteriaQuery(TSUser.class, dataGrid);
		String groupId = request.getParameter("groupId");
		//根据GroupId查询关系表中所有UserId
		String hql = "select userId from TSDepartAuthgManagerEntity where groupId = ?";
		List<String> userList = systemService.findHql(hql, groupId);
        //查询条件组装器
		if(userList!=null && userList.size()>0){
			if(StringUtils.isNotEmpty(groupId)) {
				String[] users = new String[userList.size()];
				userList.toArray(users);
				org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, user);
				//用cq.in查到所有的User
		        cq.in("userName",users);
		        cq.add();
		        this.systemService.getDataGridReturn(cq, true);
			}
		}
		//查询角色
		Map<String,Map<String,Object>> extMap = new HashMap<String, Map<String,Object>>();
		List<TSUser> tsUserList = dataGrid.getResults();
		if(tsUserList != null && tsUserList.size() > 0) {
			for (TSUser temp : tsUserList) {
				Map<String,Object> m = new HashMap<String, Object>();
				//获取每个用户角色
				String sql = "select r.rolename from t_s_role r,t_s_role_user ru,t_s_depart_authg_manager dam,t_s_base_user bs " +
						"where r.ID=ru.roleid and dam.user_id = bs.username and ru.userid=bs.id and dam.group_id = ? and dam.user_id = ?";
				List<Map<String,Object>> roleList = systemService.findForJdbc(sql, groupId,temp.getUserName());
				StringBuffer sb = new StringBuffer();
				if(roleList!=null && roleList.size()>0) {
					for (Map<String,Object> s : roleList) {
						sb.append(s.get("rolename") + ",");
					}
				}
				m.put("roles", sb);
				extMap.put(temp.getId(), m);
			}
		}
		if(dataGrid.getResults() == null) {
			dataGrid.setResults(new ArrayList<TSUser>());
		}
        TagUtil.datagrid(response, dataGrid,extMap);
	}
	
	/**
	 * 查询用户显示在DataGrid中
	 * @param user
	 * @param request
	 * @param response
	 * @param dataGrid
	 */
	@RequestMapping(params = "getUserDataGrid", method = RequestMethod.POST)
	@ResponseBody
	public void getUserDataGrid(TSUser user,HttpServletRequest request,HttpServletResponse response,DataGrid dataGrid){
		CriteriaQuery cq = new CriteriaQuery(TSUser.class, dataGrid);
		// 查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, user);
		Short[] userstate = new Short[] { Globals.User_Normal, Globals.User_ADMIN, Globals.User_Forbidden };
		cq.in("status", userstate);
		cq.eq("deleteFlag", Globals.Delete_Normal);
		List<String> userLists = new ArrayList<String>();
		String groupId = request.getParameter("groupId");
		TSDepartAuthGroupEntity departAuthGroup = systemService.getEntity(TSDepartAuthGroupEntity.class, groupId);
		TSDepart tsDept = this.systemService.getEntity(TSDepart.class, departAuthGroup.getDeptId());
		//设定某个组织机构管理员时，可以设定当前组织机构下级部门的人员
		String deptHql = new String(" from TSUserOrg where tsDepart.orgCode like concat(?,'%')");
		List<TSUserOrg> userList = this.systemService.findHql(deptHql, tsDept.getOrgCode());
		if (userList != null && userList.size() > 0) {
			for (TSUserOrg u : userList) {
				if (u.getTsUser() != null) {
					if (StringUtils.isNotEmpty(u.getTsUser().getId())) {
						userLists.add(u.getTsUser().getId());
					}
				}
			}
		}
		String[] userArrays = new String[userLists.size()];
		userLists.toArray(userArrays);
		if (userArrays != null && userArrays.length > 0) {
			cq.in("id", userArrays);
		} else {
			cq.eq("id", "1");
		}
		cq.add();
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}
	
	/**
	 * 获取ID,GroupId保存数据
	 * @param functionGroupUser
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "saveByUser",method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveByUser(TSDepartAuthgManagerEntity functionGroupUser, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String groupId = request.getParameter("groupId");
		String userName = request.getParameter("userName");
		try {
			if(StringUtils.isNotEmpty(userName) && StringUtils.isNotEmpty(groupId)) {
				String hql = "from TSDepartAuthgManagerEntity where groupId = ?";
				List<TSDepartAuthgManagerEntity> groupList = systemService.findHql(hql, groupId);
				String arrayName[] = userName.split(",");
				for (int i = 0; i < arrayName.length; i++) {
					functionGroupUser = new TSDepartAuthgManagerEntity();
					String uName = arrayName[i];
					if(groupList!=null && groupList.size()>0) {
						for (TSDepartAuthgManagerEntity group : groupList) {
							if(group.getUserId().equals(uName)) {
								//判断如果存在数据先删除后添加
								systemService.delete(group);
							}
							functionGroupUser.setUserId(uName);
							functionGroupUser.setGroupId(groupId);
							systemService.save(functionGroupUser);
						}
					} else{
						functionGroupUser.setUserId(uName);
						functionGroupUser.setGroupId(groupId);
						systemService.save(functionGroupUser);
					}
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
			j.setMsg("添加用户失败");
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 根据Id删除关联表中的数据
	 * @param functionGroupUser
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "deleteByUser",method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson deleteByUser(TSDepartAuthgManagerEntity functionGroupUser,HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			String groupId = request.getParameter("groupId");
			String sql = "delete from t_s_depart_authg_manager where user_id = ? and group_id = ?";
			systemService.executeSql(sql, functionGroupUser.getUserId(),groupId);
			j.setMsg("删除用户成功");
			j.setSuccess(true);
		} catch(Exception e) {
			e.printStackTrace();
			j.setMsg("删除用户失败");
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 分配角色,userID,RoleId,存储Role_User关联表
	 * @param id
	 * @param roleId
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "saveUserRoleRel",method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveUserRoleRel(String id, String roleId,HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			//查询角色先删除后添加
			String hql = "select id from TSRoleUser where TSUser.id = ?";
			List<String> tsRoleUsers = systemService.findHql(hql, id);
			if (tsRoleUsers != null && tsRoleUsers.size() > 0) {
				for (String t : tsRoleUsers) {
					TSRoleUser tsRoleUser = new TSRoleUser();
					tsRoleUser.setId(t);
					systemService.delete(tsRoleUser);
				}
			}
			if (oConvertUtils.isNotEmpty(id) && oConvertUtils.isNotEmpty(roleId)) {
				TSRoleUser roleUser = null;
				String[] roleArray = roleId.split(",");
				for (String s : roleArray) {
					roleUser = new TSRoleUser();
					TSUser user = new TSUser();
					user.setId(id);
					roleUser.setTSUser(user);
					TSRole role = new TSRole();
					role.setId(s);
					roleUser.setTSRole(role);
					systemService.save(roleUser);
				}
				j.setMsg("角色分配成功");
				j.setSuccess(true);
			}
		} catch (Exception e) {
			e.printStackTrace();
			j.setMsg("分配角色数据失败");
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 保存角色信息
	 * @param groupId
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "saveDepartRoleAuth",method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveDepartRoleAuth(String groupId,String roleName,String roleCode, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			TSRole role = new TSRole();
			role.setDepartAgId(groupId);
			role.setRoleCode(roleCode);
			role.setRoleName(roleName);
			role.setRoleType(OrgConstants.DEPART_ROLE_TYPE);	//部门角色
			systemService.save(role);
			j.setMsg("添加角色信息成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setMsg("添加角色信息失败");
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 更新角色信息
	 * @param groupId
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "doUpdateDepartRoleAuth",method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson doUpdateDepartRoleAuth(TSRole role, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			role.setRoleType(OrgConstants.DEPART_ROLE_TYPE);
			systemService.saveOrUpdate(role);
			j.setMsg("更新角色信息成功");
		} catch (Exception e) {
			e.printStackTrace();
			j.setMsg("更新角色信息失败");
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 删除角色信息
	 * @param departAuthGroup
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "delDepartRoleAuth")
	@ResponseBody
	public AjaxJson delDepartRoleAuth(TSRole role, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try{
			List<TSRoleFunction> roleFunctions = systemService.findByProperty(TSRoleFunction.class, "TSRole.id", role.getId());
			if(roleFunctions.size()>0 && roleFunctions != null) {
				systemService.deleteAllEntitie(roleFunctions);
			}
			role = systemService.getEntity(TSRole.class, role.getId());
			if(role != null) {
				systemService.delete(role);
			}
			j.setMsg("删除角色成功");
			j.setSuccess(true);
		} catch(Exception e) {
			e.getStackTrace();
			j.setSuccess(false);
			j.setMsg("删除角色失败");
		}
		return j;
	}
	
	
	/**
	 * 显示设置菜单权限
	 * 
	 * @param request
	 * @param comboTree
	 * @return
	 */
	@RequestMapping(params = "setRoleAuthority")
	@ResponseBody
	public List<ComboTree> setRoleAuthority(HttpServletRequest request, ComboTree comboTree) {
		CriteriaQuery cq = new CriteriaQuery(TSFunction.class);
		if (comboTree.getId() != null) {
			cq.eq("TSFunction.id", comboTree.getId());
		}
		if (comboTree.getId() == null) {
			cq.isNull("TSFunction");
		}
		cq.notEq("functionLevel", Short.parseShort("-1"));
		cq.add();
		List<TSFunction> functionList = systemService.getListByCriteriaQuery(cq, false);
		Collections.sort(functionList, new NumberComparator());
		List<ComboTree> comboTrees = new ArrayList<ComboTree>();
		// 获取pid,根据pid查出上级所拥有的权限
		String pid = request.getParameter("pid");
		String groupId = request.getParameter("gid");
		List<TSFunction> loginActionlist = new ArrayList<TSFunction>();// 已有权限菜单
		List<String> selectChild = new ArrayList<String>();
		// 筛选条件
		if (!pid.equals("0")) {
			List<TSFunction> lists = new ArrayList<TSFunction>();
			List<TSDepartAuthgFunctionRelEntity> pFunction = systemService.findByProperty(TSDepartAuthgFunctionRelEntity.class, "tsDepartAuthGroup.id", pid);
			// 比较上级权限
			if (pFunction.size() > 0) {
				for (TSDepartAuthgFunctionRelEntity departGroupRel : pFunction) {
					TSFunction function = (TSFunction) departGroupRel.getTsFunction();

					if(function!=null){
						// 获取上级所有选中的ID
						selectChild.add(function.getId());
						for (TSFunction ts : functionList) {
							if (ts.getId().equals(function.getId())) {
								lists.add(ts);
							}
						}
					}

				}
				functionList = lists;
			} else {
				functionList.clear();
			}
		} else {
			selectChild = null;
		}
		if (StringUtils.isNotEmpty(groupId)) {
			List<TSRoleFunction> functionGroupList = systemService.findByProperty(TSRoleFunction.class, "TSRole.id", groupId);
			if (functionGroupList.size() > 0) {
				for (TSRoleFunction functionGroupRel : functionGroupList) {
					if (functionGroupRel.getTSFunction() == null) {
						continue;
					}
					TSFunction function = (TSFunction) functionGroupRel.getTSFunction();
					loginActionlist.add(function);
				}
			}
			functionGroupList.clear();
		}
		ComboTreeModel comboTreeModel = new ComboTreeModel("id", "functionName", "TSFunctions");
		comboTrees = comboTree(functionList, comboTreeModel, loginActionlist, true, selectChild);
		MutiLangUtil.setMutiComboTree(comboTrees);
		functionList.clear();
		functionList = null;
		loginActionlist.clear();
		loginActionlist = null;
		return comboTrees;
	}
	
	/**
	 * 列表操作权限展示
	 * 
	 * @param request
	 * @param functionId
	 * @return
	 */
	@RequestMapping(params = "roleOperationListForFunction")
	public ModelAndView roleOperationListForFunction(HttpServletRequest request, String functionId) {
		String gid = request.getParameter("groupId");
		TSRole role = systemService.getEntity(TSRole.class, gid);
		List<Map<String, Object>> pGroup = new ArrayList<Map<String, Object>>();
		if (role != null) {
			if (oConvertUtils.isNotEmpty(role.getDepartAgId())) {
				String pid = role.getDepartAgId();

				String groupSql = "select * from t_s_depart_authg_function_rel where group_id = ? and auth_id = ?";
				// 查询部门组记录赋值给pOperationArray
				pGroup = this.systemService.findForJdbc(groupSql, pid, functionId);

			}
		}
		String[] pOperationArray = null;
		String pOperation = "";
		if (pGroup.size() > 0 && pGroup != null) {
			for (Map<String, Object> ss : pGroup) {
				if (oConvertUtils.isNotEmpty(ss.get("operation"))) {
					pOperation = ss.get("operation").toString();
				}
				if (oConvertUtils.isNotEmpty(pOperation)) {
					pOperationArray = pOperation.split(",");
				}
			}
		}
		CriteriaQuery cq = new CriteriaQuery(TSOperation.class);
		cq.eq("TSFunction.id", functionId);
		cq.eq("status", Short.valueOf("0"));
		cq.in("id", pOperationArray);
		cq.add();
		List<TSOperation> operationList = this.systemService.getListByCriteriaQuery(cq, false);
		Set<String> operationCodes = systemService.getDepartAuthGroupOperationSet(gid, functionId, OrgConstants.GROUP_DEPART_ROLE);
		request.setAttribute("operationList", operationList);
		request.setAttribute("operationcodes", operationCodes);
		request.setAttribute("functionId", functionId);
		return new ModelAndView("system/authGroup/roleOperationListForFunction");
	}
	
	/**
	 * 数据权限展示
	 * 
	 * @param request
	 * @param functionId
	 * @return
	 */
	@RequestMapping(params = "roleDataRuleListForFunction")
	public ModelAndView roleDataRuleListForFunction(HttpServletRequest request, String functionId) {
		String gid = request.getParameter("groupId");
		TSRole role = systemService.getEntity(TSRole.class, gid);
		List<Map<String, Object>> pGroup = new ArrayList<Map<String, Object>>();
		if (role != null) {
			if (oConvertUtils.isNotEmpty(role.getDepartAgId())) {
				String pid = role.getDepartAgId();

				String groupSql = "select * from t_s_depart_authg_function_rel where group_id = ? and auth_id = ?";
				// 查询部门组记录赋值给pDataRuleArray
				pGroup = this.systemService.findForJdbc(groupSql, pid, functionId);

			}
		}
		String[] pDataRuleArray = null;
		String pDataRule = "";
		if (pGroup.size() > 0 && pGroup != null) {
			for (Map<String, Object> ss : pGroup) {
				if (oConvertUtils.isNotEmpty(ss.get("datarule"))) {
					pDataRule = ss.get("datarule").toString();
				}
				if (oConvertUtils.isNotEmpty(pDataRule)) {
					pDataRuleArray = pDataRule.split(",");
				}
			}
		}
		CriteriaQuery cq = new CriteriaQuery(TSDataRule.class);
		cq.eq("TSFunction.id", functionId);
		cq.in("id", pDataRuleArray);
		cq.add();
		List<TSDataRule> dataRuleList = this.systemService.getListByCriteriaQuery(cq, false);
		Set<String> dataRulecodes = systemService.getDepartAuthGroupDataRuleSet(gid, functionId, OrgConstants.GROUP_DEPART_ROLE);
		request.setAttribute("dataRuleList", dataRuleList);
		request.setAttribute("dataRulecodes", dataRulecodes);
		request.setAttribute("functionId", functionId);
		return new ModelAndView("system/authGroup/roleDataRuleListForFunction");
	}
	
	/**
	 * 更新角色菜单权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateDepartRoleAuthority")
	@ResponseBody
	public AjaxJson updateDepartRoleAuthority(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			String groupId = request.getParameter("groupId");
			String function = request.getParameter("functions");
			TSRole role = this.systemService.get(TSRole.class, groupId);
			List<TSRoleFunction> functionGroupList = systemService
					.findByProperty(TSRoleFunction.class, "TSRole.id",role.getId());
			Map<String, TSRoleFunction> map = new HashMap<String, TSRoleFunction>();
			for (TSRoleFunction functionofGroup : functionGroupList) {
				if(functionofGroup.getTSFunction()==null) {
					continue;
				}
				map.put(functionofGroup.getTSFunction().getId(), functionofGroup);
			}
			String[] functions = function.split(",");
			Set<String> set = new HashSet<String>();
			for (String s : functions) {
				set.add(s);
			}
			updateRoleCompare(set, role, map);
			j.setMsg("权限更新成功");
		} catch (Exception e) {
			logger.error(ExceptionUtil.getExceptionMessage(e));
			j.setMsg("权限更新失败");
		}
		return j;
	}

	/**
	 * 角色权限比较
	 * 
	 * @param set 最新的权限列表
	 * @param role 当前权限组
	 * @param map 旧的权限列表
	 */
	private void updateRoleCompare(Set<String> set, TSRole role,
			Map<String, TSRoleFunction> map) {
		List<TSRoleFunction> entitys = new ArrayList<TSRoleFunction>();
		List<TSRoleFunction> deleteEntitys = new ArrayList<TSRoleFunction>();
		for (String s : set) {
			if (map.containsKey(s)) {
				map.remove(s);
			} else {
				TSRoleFunction functionGroupRel = new TSRoleFunction();
				TSFunction f = this.systemService.get(TSFunction.class, s);
				functionGroupRel.setTSFunction(f);
				functionGroupRel.setTSRole(role);
				entitys.add(functionGroupRel);
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
	 * 更新角色页面操作权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateDepartRoleOperation")
	@ResponseBody
	public AjaxJson updateDepartRoleOperation(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String groupId = request.getParameter("groupId");
		String functionId = request.getParameter("functionId");
		String operationcodes = null;
		try {
			operationcodes = URLDecoder.decode(
					request.getParameter("operationcodes"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		CriteriaQuery cq1 = new CriteriaQuery(TSRoleFunction.class);
		cq1.eq("TSRole.id", groupId);
		cq1.eq("TSFunction.id", functionId);
		cq1.add();
		List<TSRoleFunction> functionGroups = systemService.getListByCriteriaQuery(
				cq1, false);
		if (null != functionGroups && functionGroups.size() > 0) {
			TSRoleFunction tsfunctionGroup = functionGroups.get(0);
			tsfunctionGroup.setOperation(operationcodes);
			systemService.saveOrUpdate(tsfunctionGroup);
		}
		j.setMsg("页面操作权限更新成功");
		return j;
	}
	
	/**
	 * 更新角色数据权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateDepartRoleDataRule")
	@ResponseBody
	public AjaxJson updateDepartRoleDataRule(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String groupId = request.getParameter("groupId");
		String functionId = request.getParameter("functionId");
		String dataRulecodes = null;
		try {
			dataRulecodes = URLDecoder.decode(
					request.getParameter("dataRulecodes"), "utf-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}
		CriteriaQuery cq1 = new CriteriaQuery(TSRoleFunction.class);
		cq1.eq("TSRole.id", groupId);
		cq1.eq("TSFunction.id", functionId);
		cq1.add();
		List<TSRoleFunction> functionGroups = systemService.getListByCriteriaQuery(
				cq1, false);
		if (null != functionGroups && functionGroups.size() > 0) {
			TSRoleFunction tsFunctionGroup = functionGroups.get(0);
			tsFunctionGroup.setDataRule(dataRulecodes);
			systemService.saveOrUpdate(tsFunctionGroup);
		}
		j.setMsg("数据权限更新成功");
		return j;
	}
	
	/**
	 * 查询用户显示在DataGrid中
	 * @param user
	 * @param request
	 * @param response
	 * @param dataGrid
	 */
	@RequestMapping(params = "departRoleUserDataGrid", method = RequestMethod.POST)
	@ResponseBody
	public void departRoleUserDataGrid(TSUser user, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		Map<String, Map<String, Object>> extMap = new HashMap<String, Map<String, Object>>();
		String departid = request.getParameter("orgIds");
		if(oConvertUtils.isNotEmpty(departid)) {
			//手工转换minidao查询规则
			if(oConvertUtils.isNotEmpty(user.getUserName())){
				user.setUserName(user.getUserName().replace("*","%"));
			}
			if(oConvertUtils.isNotEmpty(user.getRealName())){
				user.setRealName(user.getRealName().replace("*","%"));
			}
			
			if(oConvertUtils.isNotEmpty(departid)){
				TSDepart tsdepart = this.systemService.get(TSDepart.class,departid);
				MiniDaoPage<TSUser> list = departAuthGroupDao.getUserByDepartCode(dataGrid.getPage(), dataGrid.getRows(),tsdepart.getOrgCode(),user);
				dataGrid.setTotal(list.getTotal());
				dataGrid.setResults(list.getResults());
				
				//获取用户的部门名称
				for (TSUser u : list.getResults()) {
					if (oConvertUtils.isNotEmpty(u.getId())) {
						List<String> depNames = departAuthGroupDao.getUserDepartNames(u.getId());
						// 此为针对原来的行数据，拓展的新字段
						Map<String,Object> m = new HashMap<String,Object>();
						m.put("orgNames", depNames != null ? depNames.toArray() : null);
						extMap.put(u.getId(), m);
					}
				}
			}
		}
		TagUtil.datagrid(response, dataGrid,extMap);
	}
	
	/**
	 * 授权获取ID,RoleId保存数据
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "saveRoleUser",method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveUserGroup(String userId, String roleId, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			if(StringUtils.isNotEmpty(userId)) {
				CriteriaQuery cq = new CriteriaQuery(TSRoleUser.class);
				cq.eq("TSUser.id",userId);
				cq.add();
				List<TSRoleUser> functionList = systemService.getListByCriteriaQuery(cq,false);
				Map<String, TSRoleUser> map = new HashMap<String, TSRoleUser>();
				for (TSRoleUser function : functionList) {
					//部门角色
					if("1".equals(function.getTSRole().getRoleType())){
						map.put(function.getTSRole().getId(), function);
					}
				}
				Set<String> set = new HashSet<String>();
				if(StringUtil.isNotEmpty(roleId)){
					String[] groupArrays = roleId.split(",");
					for (String s : groupArrays) {
						set.add(s);
					}
				}
				updateGroupUser(set, userId, map);
				j.setMsg("授权角色信息更新成功");
			}
		} catch(Exception e) {
			e.printStackTrace();
			j.setMsg("授权角色信息更新失败");
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 权限比较
	 * 
	 * @param set 最新的角色信息
	 * @param userId 当前用户
	 * @param map 旧的角色信息表
	 */
	private void updateGroupUser(Set<String> set, String userId,
			Map<String, TSRoleUser> map) {
		List<TSRoleUser> entitys = new ArrayList<TSRoleUser>();
		List<TSRoleUser> deleteEntitys = new ArrayList<TSRoleUser>();
		for (String s : set) {
			if (map.containsKey(s)) {
				map.remove(s);
			} else {
				TSRole role = new TSRole();
				role.setId(s);
				TSUser user = new TSUser();
				user.setId(userId);
				TSRoleUser rf = new TSRoleUser();
				rf.setTSRole(role);
				rf.setTSUser(user);
				entitys.add(rf);
			}
		}
		Collection<TSRoleUser> collection = map.values();
		Iterator<TSRoleUser> it = collection.iterator();
		for (; it.hasNext();) {
			deleteEntitys.add(it.next());
		}
		if(entitys.size()>0){
			systemService.batchSave(entitys);
		}
		if(deleteEntitys.size()>0) {
			systemService.deleteAllEntitie(deleteEntitys);
		}
	}
	
	/**
	 * 根据供应商名称查询数据
	 * @param supplier
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "selectSupplier",method = RequestMethod.POST)
	@ResponseBody
	public List<Map<String,Object>> selectSupplier(String supplier,HttpServletResponse response,HttpServletRequest request) {
		String sql = "select * from t_s_depart_auth_group where group_name like CONCAT('%',?,'%') or dept_name like CONCAT('%',?,'%') ";
		List<Map<String,Object>> departAuthGroup = systemService.findForJdbc(sql, supplier,supplier);
		List<Map<String,Object>> resultMap=new ArrayList<Map<String,Object>>();
		if(departAuthGroup!=null && !departAuthGroup.isEmpty()){
			for (Map<String, Object> m : departAuthGroup) {
				Map<String,Object> map = new HashMap<String, Object>();
				map.put("chkDisabled", false);
				map.put("click", true);
				map.put("id", m.get("id"));

				String deptName = m.get("dept_name").toString();
				map.put("name", deptName + "管理组");

				map.put("nocheck", false);
				map.put("struct", "TREE");
				map.put("title", m.get("group_name"));
				map.put("level", 1);
				map.put("icon", "plug-in/ztree/css/img/diy/document.png");
				resultMap.add(map);
			}
		}
		return resultMap;
	}
}
