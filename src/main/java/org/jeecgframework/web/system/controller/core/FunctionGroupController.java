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
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.hibernate.criterion.Property;
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
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.p3.core.utils.common.StringUtils;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.easyui.ComboTreeModel;
import org.jeecgframework.web.system.pojo.base.TSDataRule;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.pojo.base.TSFunction;
import org.jeecgframework.web.system.pojo.base.TSFunctionGroupEntity;
import org.jeecgframework.web.system.pojo.base.TSFunctionGroupRelEntity;
import org.jeecgframework.web.system.pojo.base.TSFunctionGroupUserEntity;
import org.jeecgframework.web.system.pojo.base.TSOperation;
import org.jeecgframework.web.system.pojo.base.TSRoleUser;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.pojo.base.TSUserOrg;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.CollectionUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**   
 * @Title: Controller  
 * @Description: 权限组功能
 * @author LiShaoQing
 * @date 2017-08-24 18:50:33
 * @version V1.0   
 *
 */
@Controller
@RequestMapping("/functionGroupController")
public class FunctionGroupController extends BaseController {
	
	private static final Logger logger = Logger.getLogger(FunctionGroupController.class);
	
	@Autowired
	private SystemService systemService;
	
	@Autowired
	private UserService userService;
	
	/**
	 * 权限组列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		//获取当前登录的用户名
		String userName = ResourceUtil.getSessionUser().getUserName();
		request.setAttribute("userName", userName);
		return new ModelAndView("system/authorize/functionGroupList");
	}
	/**
	 * 组织机构树
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "departSelect")
    public String departSelect(HttpServletRequest req) {
		req.setAttribute("deptId", req.getParameter("deptId"));
        return "system/authorize/deptSelect";
    }
	/**
	 * 管理员授权页面
	 */
	@RequestMapping(params = "groupUserList")
	public ModelAndView groupUserList(HttpServletRequest request) {
		String groupId = request.getParameter("id");
		request.setAttribute("groupId", groupId);
		return new ModelAndView("system/authorize/groupUserList");
	}
	/**
	 * 跳转选择用户界面
	 * @return
	 */
	@RequestMapping(params = "addUserSelect")
	public ModelAndView addUserSelect() {
		return new ModelAndView("system/authorize/addUserSelect");
	}
	/**
	 * 二级权限组管理配置页面
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "roleConfiguration")
	public ModelAndView roleConfiguration(HttpServletRequest request) {
		return new ModelAndView("system/authorize/roleConfiguration");
	}
	/**
	 * 二级权限组授权管理页面
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "groupAuthorizeSet")
	public ModelAndView groupAuthorizeSet(HttpServletRequest request) {
		return new ModelAndView("system/authorize/groupAuthorizeSet");
	}
	/**
	 * 权限组授权页面跳转
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "groupRel")
	public ModelAndView groupRel(TSFunctionGroupEntity functionGroup, HttpServletRequest request) {
		//获取当前登录的用户名
		String userName = ResourceUtil.getSessionUser().getUserName();
		request.setAttribute("userName", userName);
		//根据ID查询PID,前台根据PID做判断
		String hql = new String(" from TSFunctionGroupEntity t where id= ?");
		List<TSFunctionGroupEntity> functionGroupList = this.systemService.findHql(hql.toString(),functionGroup.getId());
		String pid = "";
		String groupName = "";
		for (TSFunctionGroupEntity ts : functionGroupList) {
			pid = ts.getPid();
			groupName = ts.getGroupName();
		}
		request.setAttribute("pid", pid);
		request.setAttribute("id", functionGroup.getId());
		request.setAttribute("groupName", groupName);
		return new ModelAndView("system/authorize/groupListShow");
	}
	
	/**
	 * 加载权限组管理zTree
	 * @param functionGroup
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(params="getTreeData",method ={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public AjaxJson getTreeData(TSFunctionGroupEntity functionGroup,HttpServletResponse response,HttpServletRequest request ){
		AjaxJson j = new AjaxJson();
		try{
			List<Map<String,Object>> functionGroupList = new ArrayList<Map<String,Object>>();
			//获取当前登录用户账号
			String userName = ResourceUtil.getSessionUser().getUserName();
			String sql = "";
			List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
			String chkUserName = request.getParameter("userName");
			List<Map<String,Object>> chkFunctionGroupList = new ArrayList<Map<String,Object>>();
			//超级用户可查看全部
			if(userName.equals("admin")) {
				sql = "select * from t_s_function_group fg";
				functionGroupList = this.systemService.findForJdbc(sql);
				String chkSql = "select fg.* from t_s_function_group as fg join t_s_function_group_user as fgu on fgu.group_id=fg.id where user_id = ?";
				chkFunctionGroupList = this.systemService.findForJdbc(chkSql,chkUserName);
				recursiveGroup(dataList, functionGroupList,false,chkFunctionGroupList);
			} else {
				sql = "select fg.* from t_s_function_group as fg join t_s_function_group_user as fgu on fgu.group_id=fg.id where user_id = ?";
				functionGroupList = this.systemService.findForJdbc(sql,userName);
				String chkSql = "select fg.* from t_s_function_group as fg join t_s_function_group_user as fgu on fgu.group_id=fg.id where user_id = ? and type = 1";
				chkFunctionGroupList = this.systemService.findForJdbc(chkSql,chkUserName);
				recursiveGroup(dataList, functionGroupList,true,chkFunctionGroupList);
			}
			j.setObj(dataList);
		}catch(Exception e){
			e.printStackTrace();
		}
		return j;
	}
	/**
	 * 递归查询子级节点
	 * @param dataList
	 * @param functionGroupList
	 */
	private void recursiveGroup(List<Map<String,Object>> dataList,List<Map<String,Object>> functionGroupList,boolean isChild,List<Map<String,Object>> chkFunctionGroupList){
		Map<String,Object> map = null;
		//给zTree赋值数据
		for (Map<String, Object> m : functionGroupList) {
			map = new HashMap<String,Object>();
			map.put("chkDisabled",false);
			map.put("click", true);
			map.put("id", m.get("id"));
			map.put("name", m.get("group_name"));
			map.put("nocheck", false);
			map.put("struct","TREE");
			map.put("title",m.get("group_name"));
			map.put("level", m.get("level"));
			if (m.get("pid") != null) {
				map.put("parentId",m.get("pid"));
			}else {
				map.put("parentId","0");
			}
			//判断授权权限组被选中
			if(chkFunctionGroupList != null && chkFunctionGroupList.size()>0) {
				for (Map<String, Object> chkMap : chkFunctionGroupList) {
					if(chkMap.get("id").toString().equals(map.get("id").toString())) {
						map.put("checked",true);
					} 
				}
			}
			dataList.add(map);
			//递归查询所有子节点
			if(isChild) {
				String sql = "select * from t_s_function_group where pid = ? ";
				List<Map<String,Object>> chileList = this.systemService.findForJdbc(sql,m.get("id"));
				recursiveGroup(dataList, chileList, isChild, chkFunctionGroupList);
			}
		}
	}
	
	/**
	 * 新增页面跳转，显示上级组织名称
	 * @param id
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "add")
	public ModelAndView add(String id, HttpServletRequest req) {
		List<TSFunctionGroupEntity> groupList = systemService.getList(TSFunctionGroupEntity.class);
		req.setAttribute("groupList", groupList);
		//获得id,根据id查询pid
		String hql = new String(" from TSFunctionGroupEntity t where id= ?");
		List<TSFunctionGroupEntity> functionGroupList = this.systemService.findHql(hql.toString(),id);
		String pGroupName = "";
		String deptId = "";
		String deptName = "";
		String deptCode = "";
		String pid = "";
		for(TSFunctionGroupEntity ts : functionGroupList) {
			pGroupName = ts.getGroupName();
			deptId = ts.getDeptId();
			deptName = ts.getDeptName();
			deptCode = ts.getDeptCode();
			pid = ts.getPid();
		}
		req.setAttribute("pGroupName", pGroupName);
		req.setAttribute("id", id);
		req.setAttribute("deptId",deptId);
		req.setAttribute("deptName", deptName);
		req.setAttribute("deptCode", deptCode);
		req.setAttribute("pid", pid);
		return new ModelAndView("system/authorize/authorize");
	}
	
	/**
	 * 新增或更新保存方法
	 * @param functionGroup
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(TSFunctionGroupEntity functionGroup, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			String pid = request.getParameter("selectId");
			String deptId = request.getParameter("deptId1");
			String deptName = request.getParameter("deptName1");
			String deptCode = request.getParameter("deptCode1");
			//判断是否有父节点
			if(StringUtils.isNotEmpty(pid)) {
				String sql = "select level from t_s_function_group where id = '"+pid+"'";
				Long level = systemService.getCountForJdbc(sql);
				//判断授权组是否有等级
				if(level == null) {
					functionGroup.setLevel(1);
				}else {
					functionGroup.setLevel((int)(level+1));
				}
			} else {
				if(!StringUtils.isNotEmpty(functionGroup.getPid())) {
					functionGroup.setLevel(1);
				}
			}
			//判断是新增还是更新
			if(!StringUtils.isNotEmpty(functionGroup.getId())) {
				if(!StringUtils.isNotEmpty(pid)) {
					functionGroup.setPid("0");
				} else {
					functionGroup.setPid(pid);
					functionGroup.setDeptId(deptId);
					functionGroup.setDeptCode(deptCode);
					functionGroup.setDeptName(deptName);
				}
				//添加UUID
				String randomSeed = UUID.randomUUID().toString().replaceAll("-", "").toUpperCase();
				functionGroup.setId(randomSeed);
				userService.save(functionGroup);
			} else {
				userService.saveOrUpdate(functionGroup);
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
	 * 更新页面跳转，显示上级组织名称
	 * @param functionGroup
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "update", method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public ModelAndView update(TSFunctionGroupEntity functionGroup, HttpServletRequest request) {
		//获取当前登录用户账号
		List<TSFunctionGroupEntity> groupList = systemService.getList(TSFunctionGroupEntity.class);
		request.setAttribute("groupList", groupList);
		if(StringUtils.isNotEmpty(functionGroup.getId())) {
			functionGroup = systemService.getEntity(TSFunctionGroupEntity.class, functionGroup.getId());
			//获得id,根据id查询pid
			String hql = new String(" from TSFunctionGroupEntity t where id= ?");
			List<TSFunctionGroupEntity> functionGroupList = this.systemService.findHql(hql.toString(),functionGroup.getId());
			String pid = "";
			for (TSFunctionGroupEntity ts : functionGroupList) {
				pid = ts.getPid();
			}
			//根据pid查询出所对应的权限组名称
			hql = new String(" from TSFunctionGroupEntity t where id = ?");
			functionGroupList = this.systemService.findHql(hql.toString(),pid);
			String pGroupName = "";
			for(TSFunctionGroupEntity ts : functionGroupList) {
				pGroupName = ts.getGroupName();
			}
			request.setAttribute("pGroupName", pGroupName);
			request.setAttribute("functionGroup", functionGroup);
		}
		return new ModelAndView("system/authorize/authorize");
	}
	
	/**
	 * 二级权限组管理页面
	 * @param functionGroup
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateRoleConfig", method = {RequestMethod.GET,RequestMethod.POST})
	@ResponseBody
	public ModelAndView updateRoleConfig(TSFunctionGroupEntity functionGroup, HttpServletRequest request) {
		//获取当前登录用户账号
		List<TSFunctionGroupEntity> groupList = systemService.getList(TSFunctionGroupEntity.class);
		request.setAttribute("groupList", groupList);
		if(StringUtils.isNotEmpty(functionGroup.getId())) {
			functionGroup = systemService.getEntity(TSFunctionGroupEntity.class, functionGroup.getId());
			//获得id,根据id查询pid
			String hql = new String(" from TSFunctionGroupEntity t where id= ?");
			List<TSFunctionGroupEntity> functionGroupList = this.systemService.findHql(hql.toString(),functionGroup.getId());
			String pid = "";
			for (TSFunctionGroupEntity ts : functionGroupList) {
				pid = ts.getPid();
			}
			//根据pid查询出所对应的权限组名称
			hql = new String(" from TSFunctionGroupEntity t where id = ?");
			functionGroupList = this.systemService.findHql(hql.toString(),pid);
			String pGroupName = "";
			for(TSFunctionGroupEntity ts : functionGroupList) {
				pGroupName = ts.getGroupName();
			}
			request.setAttribute("pGroupName", pGroupName);
			request.setAttribute("functionGroup", functionGroup);
		}
		return new ModelAndView("system/authorize/roleConfigInfo");
	}
	
	/**
	 * 删除组织
	 * @param functionGroup
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(TSFunctionGroupEntity functionGroup, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try{
			functionGroup = systemService.getEntity(TSFunctionGroupEntity.class, functionGroup.getId());
			systemService.delete(functionGroup);
			j.setMsg("删除权限组成功");
			j.setSuccess(true);
		} catch(Exception e) {
			e.getStackTrace();
			j.setSuccess(false);
		}
		return j;
	}
	
	/**
	 * 授权组列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "fun")
	public ModelAndView fun(HttpServletRequest request) {
		String id = request.getParameter("id");
		String pid = request.getParameter("pid");
		request.setAttribute("gid", id);
		request.setAttribute("pid", pid);
		return new ModelAndView("system/authorize/dataAuthorised");
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
		String pid = request.getParameter("pid");
		String groupId = request.getParameter("gid");
		List<TSFunction> loginActionlist = new ArrayList<TSFunction>();// 已有权限菜单
		List<String> selectChild = new ArrayList<String>();
		//筛选条件
		if(!pid.equals("0")) {
			List<TSFunction> lists = new ArrayList<TSFunction>();
			List<TSFunctionGroupRelEntity> pFunction = systemService.findByProperty(TSFunctionGroupRelEntity.class, "tsFunctionGroup.id",pid);
			//比较上级权限
			if (pFunction.size() > 0) {
				for (TSFunctionGroupRelEntity functionGroupRel : pFunction) {
					TSFunction function = (TSFunction) functionGroupRel.getTsFunction();
					//获取上级所有选中的ID
					selectChild.add(function.getId());
					for(TSFunction ts : functionList) {
						if(ts.getId().equals(function.getId())) {
							lists.add(ts);
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
			List<TSFunctionGroupRelEntity> functionGroupList = systemService.findByProperty(TSFunctionGroupRelEntity.class, "tsFunctionGroup.id",groupId);
			if (functionGroupList.size() > 0) {
				for (TSFunctionGroupRelEntity functionGroupRel : functionGroupList) {
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
		cq.add();
		List<TSOperation> operationList = this.systemService
				.getListByCriteriaQuery(cq, false);
		Set<String> operationCodes = systemService
				.getOperationsByGroupIdAndFunctionId(gid, functionId);
		request.setAttribute("operationList", operationList);
		request.setAttribute("operationcodes", operationCodes);
		request.setAttribute("functionId", functionId);
		return new ModelAndView("system/authorize/operationListForFunction");
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
		cq.add();
		List<TSDataRule> dataRuleList = this.systemService
				.getListByCriteriaQuery(cq, false);
		Set<String> dataRulecodes = systemService
				.getOperationCodesByGroupIdAndGroupDataId(gid, functionId);
		request.setAttribute("dataRuleList", dataRuleList);
		request.setAttribute("dataRulecodes", dataRulecodes);
		request.setAttribute("functionId", functionId);
		return new ModelAndView("system/authorize/dataRuleListForFunction");
	}
	
	/**
	 * 更新页面操作权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateOperation")
	@ResponseBody
	public AjaxJson updateOperation(HttpServletRequest request) {
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
		CriteriaQuery cq1 = new CriteriaQuery(TSFunctionGroupRelEntity.class);
		cq1.eq("tsFunctionGroup.id", groupId);
		cq1.eq("tsFunction.id", functionId);
		cq1.add();
		List<TSFunctionGroupRelEntity> functionGroups = systemService.getListByCriteriaQuery(
				cq1, false);
		if (null != functionGroups && functionGroups.size() > 0) {
			TSFunctionGroupRelEntity tsfunctionGroup = functionGroups.get(0);
			tsfunctionGroup.setOperation(operationcodes);
			systemService.saveOrUpdate(tsfunctionGroup);
		}
		j.setMsg("页面操作权限更新成功");
		return j;
	}
	
	/**
	 * 更新数据权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateDataRule")
	@ResponseBody
	public AjaxJson updateDataRule(HttpServletRequest request) {
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
		CriteriaQuery cq1 = new CriteriaQuery(TSFunctionGroupRelEntity.class);
		cq1.eq("tsFunctionGroup.id", groupId);
		cq1.eq("tsFunction.id", functionId);
		cq1.add();
		List<TSFunctionGroupRelEntity> functionGroups = systemService.getListByCriteriaQuery(
				cq1, false);
		if (null != functionGroups && functionGroups.size() > 0) {
			TSFunctionGroupRelEntity tsFunctionGroup = functionGroups.get(0);
			tsFunctionGroup.setDatarule(dataRulecodes);
			systemService.saveOrUpdate(tsFunctionGroup);
		}
		j.setMsg("数据权限更新成功");
		return j;
	}
	
	/**
	 * 更新菜单权限
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateAuthority")
	@ResponseBody
	public AjaxJson updateAuthority(HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			String groupId = request.getParameter("groupId");
			String function = request.getParameter("functions");
			TSFunctionGroupEntity functionGroup = this.systemService.get(TSFunctionGroupEntity.class, groupId);
			List<TSFunctionGroupRelEntity> functionGroupList = systemService
					.findByProperty(TSFunctionGroupRelEntity.class, "tsFunctionGroup.id",functionGroup.getId());
			Map<String, TSFunctionGroupRelEntity> map = new HashMap<String, TSFunctionGroupRelEntity>();
			for (TSFunctionGroupRelEntity functionofGroup : functionGroupList) {
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
	private void updateCompare(Set<String> set, TSFunctionGroupEntity functionGroup,
			Map<String, TSFunctionGroupRelEntity> map) {
		List<TSFunctionGroupRelEntity> entitys = new ArrayList<TSFunctionGroupRelEntity>();
		List<TSFunctionGroupRelEntity> deleteEntitys = new ArrayList<TSFunctionGroupRelEntity>();
		for (String s : set) {
			if (map.containsKey(s)) {
				map.remove(s);
			} else {
				TSFunctionGroupRelEntity functionGroupRel = new TSFunctionGroupRelEntity();
				TSFunction f = this.systemService.get(TSFunction.class, s);
				functionGroupRel.setTsFunction(f);
				functionGroupRel.setTsFunctionGroup(functionGroup);
				entitys.add(functionGroupRel);
			}
		}
		Collection<TSFunctionGroupRelEntity> collection = map.values();
		Iterator<TSFunctionGroupRelEntity> it = collection.iterator();
		for (; it.hasNext();) {
			deleteEntitys.add(it.next());
		}
		systemService.batchSave(entitys);
		systemService.deleteAllEntitie(deleteEntitys);
	}
	
	/**
	 * 查询用户显示在DataGrid中
	 * @param user
	 * @param request
	 * @param response
	 * @param dataGrid
	 */
	@RequestMapping(params = "userDataGrid", method = RequestMethod.POST)
	@ResponseBody
	public void getUserDataGrid(TSUser user,HttpServletRequest request,HttpServletResponse response,DataGrid dataGrid){
		  CriteriaQuery cq = new CriteriaQuery(TSUser.class, dataGrid);
		  String userName = ResourceUtil.getSessionUser().getUserName();
	        //查询条件组装器
	        org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, user);
	        Short[] userstate = new Short[]{Globals.User_Normal, Globals.User_ADMIN, Globals.User_Forbidden};
	        cq.in("status", userstate);
	        cq.eq("deleteFlag", Globals.Delete_Normal);
	        //判断用户名登陆显示信息
	        if(!userName.equals("admin")) {
	        	StringBuffer hql = new StringBuffer(" from TSDepart t where 1=1 ");
				hql.append(" and id in (select deptId from TSFunctionGroupEntity where id in (select groupId from TSFunctionGroupUserEntity where userId = ?))");
	        	List<TSDepart> deptList = this.systemService.findHql(hql.toString(), userName);
	        	List<String> userLists = new ArrayList<String>();
	        	//根据获取的部门id查询userid
	        	for (TSDepart dept : deptList) {
	        		String orgCodeHql = " from TSDepart where orgCode like '"+dept.getOrgCode()+"%'";
	        		List<TSDepart> orgCode = this.systemService.findHql(orgCodeHql);
	        		for (TSDepart code : orgCode) {
	        			TSDepart tsDept = this.systemService.getEntity(TSDepart.class, code.getId());
						String deptHql = new String(" from TSUserOrg where tsDepart = ?");
						List<TSUserOrg> userList = this.systemService.findHql(deptHql, tsDept);
						if(userList != null && userList.size()>0) {
							for (TSUserOrg u : userList) {
								if(u.getTsUser() != null) {
									if(StringUtils.isNotEmpty(u.getTsUser().getId())) {
										userLists.add(u.getTsUser().getId());
									}
								}
							}
						}
					}
				}
	        	String[] userArrays = new String[userLists.size()];
	        	userLists.toArray(userArrays);
	        	if(userArrays != null && userArrays.length>0) {
	        		cq.in("id", userArrays);
	        	} else {
	        		cq = null;
	        	}
	        }
	        String orgIds = request.getParameter("orgIds");
	        List<String> orgIdList = extractIdListByComma(orgIds);
	        // 获取 当前组织机构的用户信息
	        if (!CollectionUtils.isEmpty(orgIdList)) {
	            CriteriaQuery subCq = new CriteriaQuery(TSUserOrg.class);
	            subCq.setProjection(Property.forName("tsUser.id"));
	            subCq.in("tsDepart.id", orgIdList.toArray());
	            subCq.add();
	            cq.add(Property.forName("id").in(subCq.getDetachedCriteria()));	
	        }
	        if(cq != null) {
		        cq.add();	        	
	        }
	        this.systemService.getDataGridReturn(cq, true);
	        List<TSUser> cfeList = new ArrayList<TSUser>();
	        for (Object o : dataGrid.getResults()) {
	            if (o instanceof TSUser) {
	                TSUser cfe = (TSUser) o;
	                if (cfe.getId() != null && !"".equals(cfe.getId())) {
	                    List<TSRoleUser> roleUser = systemService.findByProperty(TSRoleUser.class, "TSUser.id", cfe.getId());
	                    if (roleUser.size() > 0) {
	                        String roleName = "";
	                        for (TSRoleUser ru : roleUser) {
	                            roleName += ru.getTSRole().getRoleName() + ",";
	                        }
	                        roleName = roleName.substring(0, roleName.length() - 1);
	                        cfe.setUserKey(roleName);
	                    }
	                }
	                cfeList.add(cfe);
	            }
	        }
	        TagUtil.datagrid(response, dataGrid);
	}
	
	/**
	 * 根据选中的权限组返回用户数据
	 * @param user
	 * @param request
	 * @param response
	 * @param dataGrid
	 */
	@RequestMapping(params = "groupUser", method = RequestMethod.POST)
	@ResponseBody
	public void getGroupUser(TSUser user,HttpServletRequest request,HttpServletResponse response,DataGrid dataGrid){
		CriteriaQuery cq = new CriteriaQuery(TSUser.class, dataGrid);
		String groupId = request.getParameter("groupId");
		//根据GroupId查询关系表中所有UserId
		String hql = "select userId from TSFunctionGroupUserEntity where groupId = ?";
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
		
		if(dataGrid.getResults() == null) {
			dataGrid.setResults(new ArrayList<TSUser>());
		}
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
	public AjaxJson saveByUser(TSFunctionGroupUserEntity functionGroupUser, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String groupId = request.getParameter("groupId");
		String userName = request.getParameter("userName");
		try {
			if(StringUtils.isNotEmpty(userName) && StringUtils.isNotEmpty(groupId)) {
				String hql = "from TSFunctionGroupUserEntity where groupId = ? and type = 0";
				List<TSFunctionGroupUserEntity> groupList = systemService.findHql(hql, groupId);
				String arrayName[] = userName.split(",");
				for (int i = 0; i < arrayName.length; i++) {
					functionGroupUser = new TSFunctionGroupUserEntity();
					String uName = arrayName[i];
					if(groupList!=null && groupList.size()>0) {
						for (TSFunctionGroupUserEntity group : groupList) {
							if(group.getUserId().equals(uName)) {
								//判断如果存在数据先删除后添加
								systemService.delete(group);
							}
							functionGroupUser.setUserId(uName);
							functionGroupUser.setGroupId(groupId);
							functionGroupUser.setType(0);
							systemService.save(functionGroupUser);
						}
					} else{
						functionGroupUser.setUserId(uName);
						functionGroupUser.setGroupId(groupId);
						functionGroupUser.setType(0);
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
	public AjaxJson deleteByUser(TSFunctionGroupUserEntity functionGroupUser,HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			String groupId = request.getParameter("groupId");
			String sql = "delete from t_s_function_group_user where user_id = ? and group_id = ?";
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
				String sql = "select dept_id from t_s_function_group where id='"+curId+"'";
				List<Map<String,Object>> deptIdMaps = systemService.findForJdbc(sql);
				if(deptIdMaps.get(0).get("dept_id").equals(deptId)) {
					j.setSuccess(true);
				}
			}else {
				String sql = "select count(0) as count,group_name from t_s_function_group where dept_id='"+deptId+"' group by group_name";
				List<Map<String,Object>> deptMaps = systemService.findForJdbc(sql);
				if(deptMaps.size() > 0) {
					j.setMsg("已绑定"+deptMaps.get(0).get("group_name")+"权限组，请重新选择");
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
	 * 二级权限组授权显示部门树
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(params = "getDepartInfo")
	@ResponseBody
	public AjaxJson getDepartInfo(HttpServletRequest request, HttpServletResponse response){
		AjaxJson j = new AjaxJson();
		//根据登陆用户判断，二级管理员根据一级权限组查询
		String userName = ResourceUtil.getSessionUser().getUserName();
		String orgIds = request.getParameter("orgIds");
		String[] ids = new String[]{}; 
		if(StringUtils.isNotBlank(orgIds)){
			orgIds = orgIds.substring(0, orgIds.length()-1);
			ids = orgIds.split("\\,");
		}
		TSDepart dePart = null;
		List<TSDepart> tSDeparts = new ArrayList<TSDepart>();
		String parentid = request.getParameter("parentid");
		if(userName.equals("admin")) {
			StringBuffer hql = new StringBuffer(" from TSDepart t where 1=1 ");
			if(StringUtils.isNotBlank(parentid)){
				dePart = this.systemService.getEntity(TSDepart.class, parentid);
				hql.append(" and TSPDepart = ?");
				tSDeparts = this.systemService.findHql(hql.toString(), dePart);
			} else {
				hql.append(" and t.orgType = ?");
				tSDeparts = this.systemService.findHql(hql.toString(), "1");
			}
		} else {
			StringBuffer hql = new StringBuffer(" from TSDepart t where 1=1 ");
			hql.append(" and id in (select deptId from TSFunctionGroupEntity where id in (select groupId from TSFunctionGroupUserEntity where userId = '"+userName+"'))");
			if(StringUtils.isNotBlank(parentid)) {
				dePart = this.systemService.getEntity(TSDepart.class, parentid);
				hql = new StringBuffer(" from TSDepart where TSPDepart = ?");
				tSDeparts = this.systemService.findHql(hql.toString(),dePart);
			} else {
				tSDeparts = this.systemService.findHql(hql.toString());
			}
		}
		List<Map<String,Object>> dateList = new ArrayList<Map<String,Object>>();
		if(tSDeparts.size()>0){
			Map<String,Object> map = null;
			String sql = null;
			 Object[] params = null;
			for(TSDepart depart:tSDeparts){
				map = new HashMap<String,Object>();
				map.put("id", depart.getId());
				map.put("name", depart.getDepartname());
				map.put("code",depart.getOrgCode());
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
				dateList.add(map);
			}
		}
		net.sf.json.JSONArray jsonArray = net.sf.json.JSONArray.fromObject(dateList);
		j.setMsg(jsonArray.toString());
		return j;
	}
	
	/**
	 * 授权获取ID,GroupId保存数据
	 * @param functionGroupUser
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "saveUserGroup",method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveUserGroup(TSFunctionGroupUserEntity functionGroupUser, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String groupId = request.getParameter("groupId");
		String userName = request.getParameter("userName");
		try {
			if(StringUtils.isNotEmpty(userName) && StringUtils.isNotEmpty(groupId)) {
				String hql = "from TSFunctionGroupUserEntity where groupId = ? and type = 1";
				//分隔权限组
				String[] groupArrays = groupId.split(",");
				for (String g : groupArrays) {
					//根据前台传的权限组id进行查找
					List<TSFunctionGroupUserEntity> groupList = systemService.findHql(hql, g);
					functionGroupUser = new TSFunctionGroupUserEntity();
					if(groupList!=null && groupList.size()>0) {
						for (TSFunctionGroupUserEntity group : groupList) {
							if(group.getUserId().equals(userName)) {
								//判断如果存在数据先删除后添加
								systemService.delete(group);
							}
							functionGroupUser.setUserId(userName);
							functionGroupUser.setGroupId(g);
							functionGroupUser.setType(1);
							systemService.save(functionGroupUser);
						}
					} else{
						functionGroupUser.setUserId(userName);
						functionGroupUser.setGroupId(g);
						functionGroupUser.setType(1);
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
}
