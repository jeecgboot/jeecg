package org.jeecgframework.web.system.controller.core;

import org.apache.log4j.Logger;
import org.hibernate.mapping.Array;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.common.UploadFile;
import org.jeecgframework.core.common.model.json.*;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.extend.hqlsearch.parse.ObjectParseUtil;
import org.jeecgframework.core.extend.hqlsearch.parse.PageValueConvertRuleEnum;
import org.jeecgframework.core.extend.hqlsearch.parse.vo.HqlRuleEnum;
import org.jeecgframework.core.util.*;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.easyui.ComboTreeModel;
import org.jeecgframework.tag.vo.easyui.TreeGridModel;
import org.jeecgframework.web.system.manager.ClientManager;
import org.jeecgframework.web.system.manager.ClientSort;
import org.jeecgframework.web.system.pojo.base.*;
import org.jeecgframework.web.system.service.MutiLangServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.util.*;

/**
 * 类型字段处理类
 *
 * @author 张代浩
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("/systemController")
public class SystemController extends BaseController {
	private static final Logger logger = Logger.getLogger(SystemController.class);
	private UserService userService;
	private SystemService systemService;
	private MutiLangServiceI mutiLangService;

	private String message;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Autowired
	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}

	@Autowired
	public void setMutiLangService(MutiLangServiceI mutiLangService) {
		this.mutiLangService = mutiLangService;
	}

	public UserService getUserService() {
		return userService;
	}

	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}
	@RequestMapping(params = "druid")
	public ModelAndView druid() {
		return new ModelAndView(new RedirectView("druid/index.html"));
	}
	/**
	 * 类型字典列表页面跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "typeGroupTabs")
	public ModelAndView typeGroupTabs(HttpServletRequest request) {
		List<TSTypegroup> typegroupList = systemService.loadAll(TSTypegroup.class);
		request.setAttribute("typegroupList", typegroupList);
		return new ModelAndView("system/type/typeGroupTabs");
	}

	/**
	 * 类型分组列表页面跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "typeGroupList")
	public ModelAndView typeGroupList(HttpServletRequest request) {
		return new ModelAndView("system/type/typeGroupList");
	}

	/**
	 * 类型列表页面跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "typeList")
	public ModelAndView typeList(HttpServletRequest request) {
		String typegroupid = request.getParameter("typegroupid");
		TSTypegroup typegroup = systemService.getEntity(TSTypegroup.class, typegroupid);
		request.setAttribute("typegroup", typegroup);
		return new ModelAndView("system/type/typeList");
	}

	/**
	 * easyuiAJAX请求数据
	 */

	@RequestMapping(params = "typeGroupGrid")
	public void typeGroupGrid(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid, TSTypegroup typegroup) {
		CriteriaQuery cq = new CriteriaQuery(TSTypegroup.class, dataGrid);
        String typegroupname = request.getParameter("typegroupname");
        if(typegroupname != null && typegroupname.trim().length() > 0) {
            typegroupname = typegroupname.trim();
            List<String> typegroupnameKeyList = systemService.findByQueryString("select typegroupname from TSTypegroup");
            MutiLangSqlCriteriaUtil.assembleCondition(typegroupnameKeyList, cq, "typegroupname", typegroupname);
        }
		this.systemService.getDataGridReturn(cq, true);
        MutiLangUtil.setMutiLangValueForList(dataGrid.getResults(), "typegroupname");

		TagUtil.datagrid(response, dataGrid);
	}
	/**
	 *
	 * @param request
	 * @param comboTree
	 * @param code
	 * @return
	 */
	@RequestMapping(params = "formTree")
	@ResponseBody
	public List<ComboTree> formTree(HttpServletRequest request,final ComboTree rootCombotree) {
		String typegroupCode = request.getParameter("typegroupCode");
		TSTypegroup group = TSTypegroup.allTypeGroups.get(typegroupCode.toLowerCase());
		List<ComboTree> comboTrees = new ArrayList<ComboTree>();

		for(TSType tsType : TSTypegroup.allTypes.get(typegroupCode.toLowerCase())){
			ComboTree combotree = new ComboTree();
			combotree.setId(tsType.getTypecode());
			combotree.setText(tsType.getTypename());
			comboTrees.add(combotree);
		}
		rootCombotree.setId(group.getTypegroupcode());
		rootCombotree.setText(group.getTypegroupname());
		rootCombotree.setChecked(false);
		rootCombotree.setChildren(comboTrees);

		return new ArrayList<ComboTree>(){{add(rootCombotree);}};
	}

	/**
	 * easyuiAJAX请求数据
	 *
	 * @param request
	 * @param response
	 * @param dataGrid
	 */

	@RequestMapping(params = "typeGrid")
	public void typeGrid(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		String typegroupid = request.getParameter("typegroupid");
		String typename = request.getParameter("typename");
		CriteriaQuery cq = new CriteriaQuery(TSType.class, dataGrid);
		cq.eq("TSTypegroup.id", typegroupid);
		cq.like("typename", typename);
		cq.add();
		this.systemService.getDataGridReturn(cq, true);
        MutiLangUtil.setMutiLangValueForList(dataGrid.getResults(), "typename");

		TagUtil.datagrid(response, dataGrid);
	}
    /**
     * 跳转到类型页面
     * @param request request
     * @return
     */
	@RequestMapping(params = "goTypeGrid")
	public ModelAndView goTypeGrid(HttpServletRequest request) {
		String typegroupid = request.getParameter("typegroupid");
        request.setAttribute("typegroupid", typegroupid);
		return new ModelAndView("system/type/typeListForTypegroup");
	}
//	@RequestMapping(params = "typeGroupTree")
//	@ResponseBody
//	public List<ComboTree> typeGroupTree(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
//		CriteriaQuery cq = new CriteriaQuery(TSTypegroup.class);
//		List<TSTypegroup> typeGroupList = systemService.getListByCriteriaQuery(cq, false);
//		List<ComboTree> trees = new ArrayList<ComboTree>();
//		for (TSTypegroup obj : typeGroupList) {
//			ComboTree tree = new ComboTree();
//			tree.setId(obj.getId());
//			tree.setText(obj.getTypegroupname());
//			List<TSType> types = obj.getTSTypes();
//			if (types != null) {
//				if (types.size() > 0) {
//					//tree.setState("closed");
//					List<ComboTree> children = new ArrayList<ComboTree>();
//					for (TSType type : types) {
//						ComboTree tree2 = new ComboTree();
//						tree2.setId(type.getId());
//						tree2.setText(type.getTypename());
//						children.add(tree2);
//					}
//					tree.setChildren(children);
//				}
//			}
//			//tree.setChecked(false);
//			trees.add(tree);
//		}
//		return trees;
//	}

	@RequestMapping(params = "typeGridTree")
	@ResponseBody
    @Deprecated // add-begin-end--Author:zhangguoming  Date:20140928 for：数据字典修改，该方法启用，数据字典不在已树结构展示了
	public List<TreeGrid> typeGridTree(HttpServletRequest request, TreeGrid treegrid) {
		CriteriaQuery cq;
		List<TreeGrid> treeGrids = new ArrayList<TreeGrid>();
		if (treegrid.getId() != null) {
			cq = new CriteriaQuery(TSType.class);
			cq.eq("TSTypegroup.id", treegrid.getId().substring(1));
			cq.add();
			List<TSType> typeList = systemService.getListByCriteriaQuery(cq, false);
			for (TSType obj : typeList) {
				TreeGrid treeNode = new TreeGrid();
				treeNode.setId("T"+obj.getId());
				treeNode.setText(obj.getTypename());
				treeNode.setCode(obj.getTypecode());
				treeGrids.add(treeNode);
			}
		} else {
			cq = new CriteriaQuery(TSTypegroup.class);
            String typegroupcode = request.getParameter("typegroupcode");
            if(typegroupcode != null ) {
                HqlRuleEnum rule = PageValueConvertRuleEnum
						.convert(typegroupcode);
                Object value = PageValueConvertRuleEnum.replaceValue(rule,
                		typegroupcode);
				ObjectParseUtil.addCriteria(cq, "typegroupcode", rule, value);
                cq.add();
            }
            String typegroupname = request.getParameter("typegroupname");
            if(typegroupname != null && typegroupname.trim().length() > 0) {
                typegroupname = typegroupname.trim();
                List<String> typegroupnameKeyList = systemService.findByQueryString("select typegroupname from TSTypegroup");
                MutiLangSqlCriteriaUtil.assembleCondition(typegroupnameKeyList, cq, "typegroupname", typegroupname);
            }
            List<TSTypegroup> typeGroupList = systemService.getListByCriteriaQuery(cq, false);
			for (TSTypegroup obj : typeGroupList) {
				TreeGrid treeNode = new TreeGrid();
				treeNode.setId("G"+obj.getId());
				treeNode.setText(obj.getTypegroupname());
				treeNode.setCode(obj.getTypegroupcode());
				treeNode.setState("closed");
				treeGrids.add(treeNode);
			}
		}
		MutiLangUtil.setMutiTree(treeGrids);
		return treeGrids;
	}

//    private void assembleConditionForMutilLang(CriteriaQuery cq, String typegroupname, List<String> typegroupnameKeyList) {
//        Map<String,String> typegroupnameMap = new HashMap<String, String>();
//        for (String nameKey : typegroupnameKeyList) {
//            String name = mutiLangService.getLang(nameKey);
//            typegroupnameMap.put(nameKey, name);
//        }
//        List<String> tepegroupnameParamList = new ArrayList<String>();
//        for (Map.Entry<String, String> entry : typegroupnameMap.entrySet()) {
//            String key = entry.getKey();
//            String value = entry.getValue();
//            if (typegroupname.startsWith("*") && typegroupname.endsWith("*")) {
//                if (value.contains(typegroupname)) {
//                    tepegroupnameParamList.add(key);
//                }
//            } else if(typegroupname.startsWith("*")) {
//                if (value.endsWith(typegroupname.substring(1))) {
//                    tepegroupnameParamList.add(key);
//                }
//            } else if(typegroupname.endsWith("*")) {
//                if (value.startsWith(typegroupname.substring(0, typegroupname.length() -1))) {
//                    tepegroupnameParamList.add(key);
//                }
//            } else {
//                if (value.equals(typegroupname)) {
//                    tepegroupnameParamList.add(key);
//                }
//            }
//        }
//
//        if (tepegroupnameParamList.size() > 0) {
//            cq.in("typegroupname", tepegroupnameParamList.toArray());
//            cq.add();
//        }
//    }

    /**
	 * 删除类型分组或者类型（ID以G开头的是分组）
	 *
	 * @return
	 */
	@RequestMapping(params = "delTypeGridTree")
	@ResponseBody
	public AjaxJson delTypeGridTree(String id, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		if (id.startsWith("G")) {//分组
			TSTypegroup typegroup = systemService.getEntity(TSTypegroup.class, id.substring(1));
			message = "数据字典分组: " + mutiLangService.getLang(typegroup.getTypegroupname()) + "被删除 成功";
			systemService.delete(typegroup);
		} else {
			TSType type = systemService.getEntity(TSType.class, id.substring(1));
			message = "数据字典类型: " + mutiLangService.getLang(type.getTypename()) + "被删除 成功";
			systemService.delete(type);
		}
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		//刷新缓存
		systemService.refleshTypeGroupCach();
		j.setMsg(message);
		return j;
	}

	/**
	 * 删除类型分组
	 *
	 * @return
	 */
	@RequestMapping(params = "delTypeGroup")
	@ResponseBody
	public AjaxJson delTypeGroup(TSTypegroup typegroup, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		typegroup = systemService.getEntity(TSTypegroup.class, typegroup.getId());
		message = "类型分组: " + mutiLangService.getLang(typegroup.getTypegroupname()) + " 被删除 成功";
        if (ListUtils.isNullOrEmpty(typegroup.getTSTypes())) {
            systemService.delete(typegroup);
            systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
            //刷新缓存
            systemService.refleshTypeGroupCach();
        } else {
            message = "类型分组: " + mutiLangService.getLang(typegroup.getTypegroupname()) + " 下有类型信息，不能删除！";
        }
		j.setMsg(message);
		return j;
	}

	/**
	 * 删除类型
	 *
	 * @return
	 */
	@RequestMapping(params = "delType")
	@ResponseBody
	public AjaxJson delType(TSType type, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		type = systemService.getEntity(TSType.class, type.getId());
		message = "类型: " + mutiLangService.getLang(type.getTypename()) + "被删除 成功";
		systemService.delete(type);
		//刷新缓存
		systemService.refleshTypesCach(type);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		j.setMsg(message);
		return j;
	}

	/**
	 * 检查分组代码
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "checkTypeGroup")
	@ResponseBody
	public ValidForm checkTypeGroup(HttpServletRequest request) {
		ValidForm v = new ValidForm();
		String typegroupcode=oConvertUtils.getString(request.getParameter("param"));
		String code=oConvertUtils.getString(request.getParameter("code"));
		List<TSTypegroup> typegroups=systemService.findByProperty(TSTypegroup.class,"typegroupcode",typegroupcode);
		if(typegroups.size()>0&&!code.equals(typegroupcode))
		{
			v.setInfo("分组已存在");
			v.setStatus("n");
		}
		return v;
	}
	/**
	 * 添加类型分组
	 *
	 * @param typegroup
	 * @return
	 */
	@RequestMapping(params = "saveTypeGroup")
	@ResponseBody
	public AjaxJson saveTypeGroup(TSTypegroup typegroup, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(typegroup.getId())) {
			message = "类型分组: " + mutiLangService.getLang(typegroup.getTypegroupname()) + "被更新成功";
			userService.saveOrUpdate(typegroup);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} else {
			message = "类型分组: " + mutiLangService.getLang(typegroup.getTypegroupname()) + "被添加成功";
			userService.save(typegroup);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		//刷新缓存
		systemService.refleshTypeGroupCach();
		j.setMsg(message);
		return j;
	}
	/**
	 * 检查类型代码
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "checkType")
	@ResponseBody
	public ValidForm checkType(HttpServletRequest request) {
		ValidForm v = new ValidForm();
		String typecode=oConvertUtils.getString(request.getParameter("param"));
		String code=oConvertUtils.getString(request.getParameter("code"));
		String typeGroupCode=oConvertUtils.getString(request.getParameter("typeGroupCode"));
		StringBuilder hql = new StringBuilder("FROM ").append(TSType.class.getName()).append(" AS entity WHERE 1=1 ");
		hql.append(" AND entity.TSTypegroup.typegroupcode =  '").append(typeGroupCode).append("'");
		hql.append(" AND entity.typecode =  '").append(typecode).append("'");
		List<Object> types = this.systemService.findByQueryString(hql.toString());
		if(types.size()>0&&!code.equals(typecode))
		{
			v.setInfo("类型已存在");
			v.setStatus("n");
		}
		return v;
	}
	/**
	 * 添加类型
	 *
	 * @param type
	 * @return
	 */
	@RequestMapping(params = "saveType")
	@ResponseBody
	public AjaxJson saveType(TSType type, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(type.getId())) {
			message = "类型: " + mutiLangService.getLang(type.getTypename()) + "被更新成功";
			userService.saveOrUpdate(type);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} else {
			message = "类型: " + mutiLangService.getLang(type.getTypename()) + "被添加成功";
			userService.save(type);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		//刷新缓存
		systemService.refleshTypesCach(type);
		j.setMsg(message);
		return j;
	}



	/**
	 * 类型分组列表页面跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "aouTypeGroup")
	public ModelAndView aouTypeGroup(TSTypegroup typegroup, HttpServletRequest req) {
		if (typegroup.getId() != null) {
			typegroup = systemService.getEntity(TSTypegroup.class, typegroup.getId());
			req.setAttribute("typegroup", typegroup);
		}
		return new ModelAndView("system/type/typegroup");
	}

	/**
	 * 类型列表页面跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "addorupdateType")
	public ModelAndView addorupdateType(TSType type, HttpServletRequest req) {
		String typegroupid = req.getParameter("typegroupid");
		req.setAttribute("typegroupid", typegroupid);
        TSTypegroup typegroup = systemService.findUniqueByProperty(TSTypegroup.class, "id", typegroupid);
        String typegroupname = typegroup.getTypegroupname();
        req.setAttribute("typegroupname", mutiLangService.getLang(typegroupname));
		if (StringUtil.isNotEmpty(type.getId())) {
			type = systemService.getEntity(TSType.class, type.getId());
			req.setAttribute("type", type);
		}
		return new ModelAndView("system/type/type");
	}

	/*
	 * *****************部门管理操作****************************
	 */

	/**
	 * 部门列表页面跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "depart")
	public ModelAndView depart() {
		return new ModelAndView("system/depart/departList");
	}

	/**
	 * easyuiAJAX请求数据
	 *
	 * @param request
	 * @param response
	 * @param dataGrid
	 */

	@RequestMapping(params = "datagridDepart")
	public void datagridDepart(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSDepart.class, dataGrid);
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
		;
	}

	/**
	 * 删除部门
	 *
	 * @return
	 */
	@RequestMapping(params = "delDepart")
	@ResponseBody
	public AjaxJson delDepart(TSDepart depart, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		depart = systemService.getEntity(TSDepart.class, depart.getId());
		message = "部门: " + depart.getDepartname() + "被删除 成功";
		systemService.delete(depart);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);

		return j;
	}

	/**
	 * 添加部门
	 *
	 * @param depart
	 * @return
	 */
	@RequestMapping(params = "saveDepart")
	@ResponseBody
	public AjaxJson saveDepart(TSDepart depart, HttpServletRequest request) {
		// 设置上级部门
		String pid = request.getParameter("TSPDepart.id");
		if (pid.equals("")) {
			depart.setTSPDepart(null);
		}
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(depart.getId())) {
			userService.saveOrUpdate(depart);
            message = MutiLangUtil.paramUpdSuccess("common.department");
            systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);

		} else {
//			String orgCode = systemService.generateOrgCode(depart.getId(), pid);
//			depart.setOrgCode(orgCode);
			if(oConvertUtils.isNotEmpty(pid)){
				TSDepart paretDept = systemService.findUniqueByProperty(TSDepart.class, "id", pid);
				String localMaxCode  = getMaxLocalCode(paretDept.getOrgCode());
				depart.setOrgCode(YouBianCodeUtil.getSubYouBianCode(paretDept.getOrgCode(), localMaxCode));
			}else{
				String localMaxCode  = getMaxLocalCode(null);
				depart.setOrgCode(YouBianCodeUtil.getNextYouBianCode(localMaxCode));
			}
			userService.save(depart);
            message = MutiLangUtil.paramAddSuccess("common.department");
            systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);

        }
		j.setMsg(message);
		return j;
	}

	private synchronized String getMaxLocalCode(String parentCode){
		if(oConvertUtils.isEmpty(parentCode)){
			parentCode = "";
		}
		int localCodeLength = parentCode.length() + YouBianCodeUtil.zhanweiLength;
		StringBuilder sb = new StringBuilder();
		sb.append("SELECT org_code FROM t_s_depart");
		sb.append(" where LENGTH(org_code) = ").append(localCodeLength);
		if(oConvertUtils.isNotEmpty(parentCode)){
			sb.append(" and  org_code like '").append(parentCode).append("%'");
		}
		sb.append(" ORDER BY org_code DESC LIMIT 1");
		Map<String, Object> objMap = systemService.findOneForJdbc(sb.toString());
		String returnCode = null;
		if(objMap!=null){
			returnCode = (String)objMap.get("org_code");
		}
		return returnCode;
	}

	/**
	 * 部门列表页面跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "addorupdateDepart")
	public ModelAndView addorupdateDepart(TSDepart depart, HttpServletRequest req) {
		List<TSDepart> departList = systemService.getList(TSDepart.class);
		req.setAttribute("departList", departList);
		if (depart.getId() != null) {
			depart = systemService.getEntity(TSDepart.class, depart.getId());
			req.setAttribute("depart", depart);
		}
		return new ModelAndView("system/depart/depart");
	}

	/**
	 * 父级权限列表
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "setPFunction")
	@ResponseBody
	public List<ComboTree> setPFunction(HttpServletRequest request, ComboTree comboTree) {
		CriteriaQuery cq = new CriteriaQuery(TSDepart.class);
		if (StringUtil.isNotEmpty(comboTree.getId())) {
			cq.eq("TSPDepart.id", comboTree.getId());
		}
		// ----------------------------------------------------------------
		// ----------------------------------------------------------------
		if (StringUtil.isEmpty(comboTree.getId())) {
			cq.isNull("TSPDepart.id");
		}
		// ----------------------------------------------------------------
		// ----------------------------------------------------------------
		cq.add();
		List<TSDepart> departsList = systemService.getListByCriteriaQuery(cq, false);
		List<ComboTree> comboTrees = new ArrayList<ComboTree>();
		comboTrees = systemService.comTree(departsList, comboTree);
		return comboTrees;

	}

	/*
	 * *****************角色管理操作****************************
	 */
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

	@RequestMapping(params = "datagridRole")
	public void datagridRole(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSRole.class, dataGrid);
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除角色
	 *
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "delRole")
	@ResponseBody
	public AjaxJson delRole(TSRole role, String ids, HttpServletRequest request) {
		message = "角色: " + role.getRoleName() + "被删除成功";
		AjaxJson j = new AjaxJson();
		role = systemService.getEntity(TSRole.class, role.getId());
		userService.delete(role);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		j.setMsg(message);
		return j;
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
		if (role.getId() != null) {
			message = "角色: " + role.getRoleName() + "被更新成功";
			userService.saveOrUpdate(role);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} else {
			message = "角色: " + role.getRoleName() + "被添加成功";
			userService.saveOrUpdate(role);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 角色列表页面跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "fun")
	public ModelAndView fun(HttpServletRequest request) {
		Integer roleid = oConvertUtils.getInt(request.getParameter("roleid"), 0);
		request.setAttribute("roleid", roleid);
		return new ModelAndView("system/role/roleList");
	}

	/**
	 * 设置权限
	 *
	 * @param role
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "setAuthority")
	@ResponseBody
	public List<ComboTree> setAuthority(TSRole role, HttpServletRequest request, ComboTree comboTree) {
		CriteriaQuery cq = new CriteriaQuery(TSFunction.class);
		if (comboTree.getId() != null) {
			cq.eq("TFunction.functionid", oConvertUtils.getInt(comboTree.getId(), 0));
		}
		if (comboTree.getId() == null) {
			cq.isNull("TFunction");
		}
		cq.add();
		List<TSFunction> functionList = systemService.getListByCriteriaQuery(cq, false);
		List<ComboTree> comboTrees = new ArrayList<ComboTree>();
		Integer roleid = oConvertUtils.getInt(request.getParameter("roleid"), 0);
		List<TSFunction> loginActionlist = new ArrayList<TSFunction>();// 已有权限菜单
		role = this.systemService.get(TSRole.class, roleid);
		if (role != null) {
			List<TSRoleFunction> roleFunctionList = systemService.findByProperty(TSRoleFunction.class, "TSRole.id", role.getId());
			if (roleFunctionList.size() > 0) {
				for (TSRoleFunction roleFunction : roleFunctionList) {
					TSFunction function = (TSFunction) roleFunction.getTSFunction();
					loginActionlist.add(function);
				}
			}
		}
		ComboTreeModel comboTreeModel = new ComboTreeModel("id", "functionName", "TSFunctions");
		comboTrees = systemService.ComboTree(functionList, comboTreeModel, loginActionlist, false);
		return comboTrees;
	}

	/**
	 * 更新权限
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "updateAuthority")
	public String updateAuthority(HttpServletRequest request) {
		Integer roleid = oConvertUtils.getInt(request.getParameter("roleid"), 0);
		String rolefunction = request.getParameter("rolefunctions");
		TSRole role = this.systemService.get(TSRole.class, roleid);
		List<TSRoleFunction> roleFunctionList = systemService.findByProperty(TSRoleFunction.class, "TSRole.id", role.getId());
		systemService.deleteAllEntitie(roleFunctionList);
		String[] roleFunctions = null;
		if (rolefunction != "") {
			roleFunctions = rolefunction.split(",");
			for (String s : roleFunctions) {
				TSRoleFunction rf = new TSRoleFunction();
				TSFunction f = this.systemService.get(TSFunction.class, Integer.valueOf(s));
				rf.setTSFunction(f);
				rf.setTSRole(role);
				this.systemService.save(rf);
			}
		}
		return "system/role/roleList";
	}

	/**
	 * 角色页面跳转
	 *
	 * @param role
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "addorupdateRole")
	public ModelAndView addorupdateRole(TSRole role, HttpServletRequest req) {
		if (role.getId() != null) {
			role = systemService.getEntity(TSRole.class, role.getId());
			req.setAttribute("role", role);
		}
		return new ModelAndView("system/role/role");
	}

	/**
	 * 操作列表页面跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "operate")
	public ModelAndView operate(HttpServletRequest request) {
		String roleid = request.getParameter("roleid");
		request.setAttribute("roleid", roleid);
		return new ModelAndView("system/role/functionList");
	}

	/**
	 * 权限操作列表
	 *
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "setOperate")
	@ResponseBody
	public List<TreeGrid> setOperate(HttpServletRequest request, TreeGrid treegrid) {
		String roleid = request.getParameter("roleid");
		CriteriaQuery cq = new CriteriaQuery(TSFunction.class);
		if (treegrid.getId() != null) {
			cq.eq("TFunction.functionid", oConvertUtils.getInt(treegrid.getId(), 0));
		}
		if (treegrid.getId() == null) {
			cq.isNull("TFunction");
		}
		cq.add();
		List<TSFunction> functionList = systemService.getListByCriteriaQuery(cq, false);
		List<TreeGrid> treeGrids = new ArrayList<TreeGrid>();
		Collections.sort(functionList, new SetListSort());
		TreeGridModel treeGridModel = new TreeGridModel();
		treeGridModel.setRoleid(roleid);
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
		String roleid = request.getParameter("roleid");
		// 录入操作前清空上一次的操作数据
		clearp(roleid);
		String[] fun_op = fop.split(",");
		String aa = "";
		String bb = "";
		// 只有一个被选中
		if (fun_op.length == 1) {
			bb = fun_op[0].split("_")[1];
			aa = fun_op[0].split("_")[0];
			savep(roleid, bb, aa);
		} else {
			// 至少2个被选中
			for (int i = 0; i < fun_op.length; i++) {
				String cc = fun_op[i].split("_")[0]; // 操作id
				if (i > 0 && bb.equals(fun_op[i].split("_")[1])) {
					aa += "," + cc;
					if (i == (fun_op.length - 1)) {
						savep(roleid, bb, aa);
					}
				} else if (i > 0) {
					savep(roleid, bb, aa);
					aa = fun_op[i].split("_")[0]; // 操作ID
					if (i == (fun_op.length - 1)) {
						bb = fun_op[i].split("_")[1]; // 权限id
						savep(roleid, bb, aa);
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
	 * @param roleid
	 * @param functionid
	 * @param ids
	 */
	public void savep(String roleid, String functionid, String ids) {
		String hql = "from TRoleFunction t where" + " t.TSRole.id=" + roleid + " " + "and t.TFunction.functionid=" + functionid;
		TSRoleFunction rFunction = systemService.singleResult(hql);
		if (rFunction != null) {
			rFunction.setOperation(ids);
			systemService.saveOrUpdate(rFunction);
		}
	}

	/**
	 * 清空操作
	 *
	 * @param roleid
	 */
	public void clearp(String roleid) {
		String hql = "from TRoleFunction t where" + " t.TSRole.id=" + roleid;
		List<TSRoleFunction> rFunctions = systemService.findByQueryString(hql);
		if (rFunctions.size() > 0) {
			for (TSRoleFunction tRoleFunction : rFunctions) {
				tRoleFunction.setOperation(null);
				systemService.saveOrUpdate(tRoleFunction);
			}
		}
	}

	/************************************** 版本维护 ************************************/

	/**
	 * 版本维护列表
	 */
	@RequestMapping(params = "versionList")
	public void versionList(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSVersion.class, dataGrid);
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
		;
	}

	/**
	 * 删除版本
	 */

	@RequestMapping(params = "delVersion")
	@ResponseBody
	public AjaxJson delVersion(TSVersion version, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		version = systemService.getEntity(TSVersion.class, version.getId());
		message = "版本：" + version.getVersionName() + "被删除 成功";
		systemService.delete(version);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);

		return j;
	}

	/**
	 * 版本添加跳转
	 *
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "addversion")
	public ModelAndView addversion(HttpServletRequest req) {
		return new ModelAndView("system/version/version");
	}

	/**
	 * 保存版本
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params = "saveVersion", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveVersion(HttpServletRequest request) throws Exception {
		AjaxJson j = new AjaxJson();
		TSVersion version = new TSVersion();
		String versionName = request.getParameter("versionName");
		String versionCode = request.getParameter("versionCode");
		version.setVersionCode(versionCode);
		version.setVersionName(versionName);
		systemService.save(version);
		j.setMsg("版本保存成功");
		return j;
	}

	/**
	 * 新闻法规文件列表
	 */
	@RequestMapping(params = "documentList")
	public void documentList(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSDocument.class, dataGrid);
		String typecode = oConvertUtils.getString(request.getParameter("typecode"));
		cq.createAlias("TSType", "TSType");
		cq.eq("TSType.typecode", typecode);
		cq.add();
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除文档
	 *
	 * @param document
	 * @return
	 */
	@RequestMapping(params = "delDocument")
	@ResponseBody
	public AjaxJson delDocument(TSDocument document, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		document = systemService.getEntity(TSDocument.class, document.getId());
		message = "" + document.getDocumentTitle() + "被删除成功";
		userService.delete(document);
		systemService.addLog(message, Globals.Log_Type_DEL,
				Globals.Log_Leavel_INFO);
		j.setSuccess(true);
		j.setMsg(message);
		return j;
	}

	/**
	 * 文件添加跳转
	 *
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "addFiles")
	public ModelAndView addFiles(HttpServletRequest req) {
		return new ModelAndView("system/document/files");
	}

	/**
	 * 保存文件
	 *
	 * @param document
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(params = "saveFiles", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson saveFiles(HttpServletRequest request, HttpServletResponse response, TSDocument document) {
		AjaxJson j = new AjaxJson();
		Map<String, Object> attributes = new HashMap<String, Object>();
		TSTypegroup tsTypegroup=systemService.getTypeGroup("fieltype","文档分类");
		TSType tsType = systemService.getType("files","附件", tsTypegroup);
		String fileKey = oConvertUtils.getString(request.getParameter("fileKey"));// 文件ID
		String documentTitle = oConvertUtils.getString(request.getParameter("documentTitle"));// 文件标题
		if (StringUtil.isNotEmpty(fileKey)) {
			document.setId(fileKey);
			document = systemService.getEntity(TSDocument.class, fileKey);
			document.setDocumentTitle(documentTitle);

		}
		document.setSubclassname(MyClassLoader.getPackPath(document));
		document.setCreatedate(DateUtils.gettimestamp());
		document.setTSType(tsType);
		UploadFile uploadFile = new UploadFile(request, document);
		uploadFile.setCusPath("files");
		uploadFile.setSwfpath("swfpath");
		document = systemService.uploadFile(uploadFile);
		attributes.put("url", document.getRealpath());
		attributes.put("fileKey", document.getId());
		attributes.put("name", document.getAttachmenttitle());
		attributes.put("viewhref", "commonController.do?objfileList&fileKey=" + document.getId());
		attributes.put("delurl", "commonController.do?delObjFile&fileKey=" + document.getId());
		j.setMsg("文件添加成功");
		j.setAttributes(attributes);
		return j;
	}

	/**
	 * 在线用户列表
	 * @param request
	 * @param response
	 * @param dataGrid
	 */

	@RequestMapping(params = "datagridOnline")
	public void datagridOnline(Client tSOnline,HttpServletRequest request,
			HttpServletResponse response, DataGrid dataGrid) {
		List<Client> onlines = new ArrayList<Client>();
		onlines.addAll(ClientManager.getInstance().getAllClient());
		dataGrid.setTotal(onlines.size());
		dataGrid.setResults(getClinetList(onlines,dataGrid));
		TagUtil.datagrid(response, dataGrid);
	}
	/**
	 * 获取当前页面的用户列表
	 * @param onlines
	 * @param dataGrid
	 * @return
	 */
	private List<Client> getClinetList(List<Client> onlines, DataGrid dataGrid) {
		Collections.sort(onlines, new ClientSort());
		List<Client> result = new ArrayList<Client>();
		for(int i = (dataGrid.getPage()-1)*dataGrid.getRows();
				i<onlines.size()&&i<dataGrid.getPage()*dataGrid.getRows();i++){
			result.add(onlines.get(i));
		}
		return result;
	}

	/**
     * 文件上传通用跳转
     *
     * @param req
     * @return
     */
    @RequestMapping(params = "commonUpload")
    public ModelAndView commonUpload(HttpServletRequest req) {
            return new ModelAndView("common/upload/uploadView");
    }
    /************************************** 数据日志 ************************************/
    /**
     * 转跳到 数据日志
     * @param request
     * @return
     */
    @RequestMapping(params = "dataLogList")
    public ModelAndView dataLogList(HttpServletRequest request){
    	return new ModelAndView("system/dataLog/dataLogList");
    }

    @RequestMapping(params = "datagridDataLog")
    public void dataLogDatagrid(TSDatalogEntity datalogEntity,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid){
    	CriteriaQuery cq = new CriteriaQuery(TSDatalogEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, datalogEntity, request.getParameterMap());
		cq.add();
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
    }

    @RequestMapping(params = "popDataContent")
	public ModelAndView popDataContent(ModelMap modelMap, @RequestParam String id, HttpServletRequest request) {
    	TSDatalogEntity datalogEntity = this.systemService.get(TSDatalogEntity.class, id);
        modelMap.put("dataContent",datalogEntity.getDataContent());
		return new ModelAndView("system/dataLog/popDataContent");
	}
    /**
     * 转跳到 数据日志
     * @param request
     * @return
     */
    @RequestMapping(params = "dataDiff")
    public ModelAndView dataDiff(HttpServletRequest request){
    	return new ModelAndView("system/dataLog/dataDiff");
    }

	@RequestMapping(params = "getDataVersion")
	@ResponseBody
    public AjaxJson getDataVersion(@RequestParam String tableName, @RequestParam String dataId){
    	AjaxJson j = new AjaxJson();
    	String hql = "from TSDatalogEntity where tableName = ? and dataId = ? order by versionNumber desc";
    	List<TSDatalogEntity> datalogEntities = this.systemService.findHql(hql, new Object[]{tableName,dataId});

    	if (datalogEntities.size() > 0) {
			j.setObj(datalogEntities);
		}

    	return j;
    }
	@RequestMapping(params = "diffDataVersion")
	public ModelAndView diffDataVersion(HttpServletRequest request, @RequestParam String id1, @RequestParam String id2){
		String hql1 = "from TSDatalogEntity where id = '" + id1 + "'";
		TSDatalogEntity datalogEntity1 = this.systemService.singleResult(hql1);

		String hql2 = "from TSDatalogEntity where id = '" + id2 + "'";
		TSDatalogEntity datalogEntity2 = this.systemService.singleResult(hql2);

		if (datalogEntity1 != null && datalogEntity2 != null) {
			//正则用于去掉头尾的[]字符(如存在)
			Integer version1 = datalogEntity1.getVersionNumber();
			Integer version2 = datalogEntity2.getVersionNumber();
			Map<String, Object> map1 = null;
			Map<String, Object> map2 = null;

			if (version1 < version2) {
				map1 = JSONHelper.toHashMap(datalogEntity1.getDataContent().replaceAll("^\\[|\\]$", ""));
				map2 = JSONHelper.toHashMap(datalogEntity2.getDataContent().replaceAll("^\\[|\\]$", ""));
			}else{
				map1 = JSONHelper.toHashMap(datalogEntity2.getDataContent().replaceAll("^\\[|\\]$", ""));
				map2 = JSONHelper.toHashMap(datalogEntity1.getDataContent().replaceAll("^\\[|\\]$", ""));
			}

			Map<String, Object> mapAll = new HashMap<String, Object>();
			mapAll.putAll(map1);
			mapAll.putAll(map2);
			Set<String> set = mapAll.keySet();

			List<DataLogDiff> dataLogDiffs = new LinkedList<DataLogDiff>();

			String value1 = null;
			String value2 = null;
			for (String string : set) {
				DataLogDiff dataLogDiff = new DataLogDiff();
				dataLogDiff.setName(string);
				if (map1.containsKey(string)) {
					value1 = map1.get(string).toString();
					if (value1 == null) {
						dataLogDiff.setValue1("");
					}else {
						dataLogDiff.setValue1(value1);
					}
				}else{
					dataLogDiff.setValue1("");
				}
				
				if (map2.containsKey(string)) {
					value2 = map2.get(string).toString();
					if (value2 == null) {
						dataLogDiff.setValue2("");
					}else {
						dataLogDiff.setValue2(value2);
					}
				}else {
					dataLogDiff.setValue2("");
				}
				
				if (value1 == null && value2 == null) {
					dataLogDiff.setDiff("N");
				}else {
					if (value1 != null && value2 != null) {
						if (value1.equals(value2)) {//相同
							dataLogDiff.setDiff("N");
						}else {
							dataLogDiff.setDiff("Y");
						}
					}else {
						dataLogDiff.setDiff("Y");
					}
				}
				dataLogDiffs.add(dataLogDiff);
			}

			if (version1 < version2) {
				request.setAttribute("versionNumber1", datalogEntity1.getVersionNumber());
				request.setAttribute("versionNumber2", datalogEntity2.getVersionNumber());
			}else {
				request.setAttribute("versionNumber1", datalogEntity2.getVersionNumber());
				request.setAttribute("versionNumber2", datalogEntity1.getVersionNumber());
			}
			request.setAttribute("dataLogDiffs", dataLogDiffs);
		}
		return new ModelAndView("system/dataLog/diffDataVersion");
	}
}
