package org.jeecgframework.web.system.controller.core;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.ComboTree;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.model.json.TreeGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.LogUtil;
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.datatable.SortDirection;
import org.jeecgframework.tag.vo.easyui.ComboTreeModel;
import org.jeecgframework.tag.vo.easyui.TreeGridModel;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.pojo.base.TSUserOrg;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.web.system.service.UserService;
import org.jeecgframework.web.system.util.OrgConstants;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;


/**
 * 组织机构管理
 * 
 * @author LiShaoQing
 * 
 */
@Controller
@RequestMapping("/organzationController")
public class OrganzationController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(OrganzationController.class);
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

	/**
	 * 部门列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "depart")
	public ModelAndView depart() {
		return new ModelAndView("system/organzation/departList");
	}
	
	/**
	 * 部门管理树
	 * 
	 * @return
	 */
	@RequestMapping(params = "myDepart")
	public ModelAndView myDepart() {
		return new ModelAndView("system/organzation/myDepartList");
	}
	
	/**
	 * 部门管理树
	 * 
	 * @return
	 */
	@RequestMapping(params = "comDepart")
	public ModelAndView comDepart() {
		return new ModelAndView("system/organzation/comDepartList");
	}
	
	
	/**
	 * 添加一级公司 
	 * 
	 * @return
	 */
	@RequestMapping(params = "toAddCompany")
	public ModelAndView toAddCompany() {
		return new ModelAndView("system/organzation/company-add");
	}
	
	
	/**
	 * 添加子公司
	 * 
	 * @return
	 */
	@RequestMapping(params = "toAddSubCompany")
	public ModelAndView toAddSubCompany(HttpServletRequest request, HttpServletResponse response) {
		String pid = request.getParameter("pid");
		ModelAndView mv = new ModelAndView("system/organzation/subcompany-add");
		mv.addObject("pid", pid);
		return mv;
	}
	
	/**
	 * 添加下级公司
	 * 
	 * @return
	 */
	@RequestMapping(params = "toAddSubOrg")
	public ModelAndView toAddSubOrg(HttpServletRequest request, HttpServletResponse response) {
		String pid = request.getParameter("pid");
		ModelAndView mv = new ModelAndView("system/organzation/suborg-add");
		mv.addObject("pid", pid);
		return mv;
	}
	
	/**
	 * 添加下级岗位
	 * 
	 * @return
	 */
	@RequestMapping(params = "toAddSubJob")
	public ModelAndView toAddSubJob(HttpServletRequest request, HttpServletResponse response) {
		String pid = request.getParameter("pid");
		ModelAndView mv = new ModelAndView("system/organzation/subjob-add");
		mv.addObject("pid", pid);
		return mv;
	}
	
	
	/**
	 * 组织机构编辑
	 * 
	 * @return
	 */
	@RequestMapping(params = "comUpdate")
	public ModelAndView comUpdate(TSDepart depart, HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		String viewName = "";
		if (StringUtil.isNotEmpty(depart.getId())) {
			depart = systemService.getEntity(TSDepart.class, depart.getId());
			req.setAttribute("depart", depart);
			if("1".equals(depart.getOrgType())){
				viewName = "system/organzation/subcompany-edit";
			}else if("2".equals(depart.getOrgType())){
				viewName = "system/organzation/suborg-edit";
			}else if("3".equals(depart.getOrgType())){
				viewName = "system/organzation/subjob-edit";
			}
		}
		
		mv.setViewName(viewName);
		return mv;
	}
	
	
	/**
	 * 组织机构编辑
	 * 
	 * @return
	 */
	@RequestMapping(params = "comDetail")
	public ModelAndView comDetail(TSDepart depart, HttpServletRequest req) {
		ModelAndView mv = new ModelAndView();
		String viewName = "";
		if (StringUtil.isNotEmpty(depart.getId())) {
			depart = systemService.getEntity(TSDepart.class, depart.getId());
			req.setAttribute("depart", depart);
			if("1".equals(depart.getOrgType())){
				viewName = "system/organzation/subcompany-detail";
			}else if("2".equals(depart.getOrgType())){
				viewName = "system/organzation/suborg-detail";
			}else if("3".equals(depart.getOrgType())){
				viewName = "system/organzation/subjob-detail";
			}
		}
		mv.setViewName(viewName);
		return mv;
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
		CriteriaQuery cq = new CriteriaQuery(TSDepart.class, dataGrid);
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

		@RequestMapping(params = "delUserOrg")
		@ResponseBody
		public AjaxJson delUserOrg(@RequestParam(required=true)String userid,@RequestParam(required=true)String departid) {
			AjaxJson ajaxJson = new AjaxJson();
			try {
				//判断授权部门角色是否赋值,有值则不可删除

				String sql1 = "SELECT COUNT(0) FROM t_s_role_user ru WHERE ru.roleid in (SELECT tsr.id FROM t_s_role tsr WHERE depart_ag_id = (SELECT dag.id FROM t_s_depart_auth_group dag WHERE dag.dept_id = ?)) and ru.userid = ?";
				long roleUserCount = this.systemService.getCountForJdbcParam(sql1,departid,userid);

				List<TSUserOrg> userOrgList = this.systemService.findByProperty(TSUserOrg.class, "tsUser.id", userid);
				//判断分配职务是否赋值,有值则不可删除
				//查找直接上级公司
				String companyId = getCompanyId(departid);
				if(StringUtils.isEmpty(companyId)){
					companyId = "";
				}

				String sql2 = "select count(0) from t_s_user_position_rel where user_id = ? and company_id = ?";
				long duties = this.systemService.getCountForJdbcParam(sql2,userid,companyId);
				if(roleUserCount >= 1 || duties >= 1) {
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("当前用户拥有职务或部门角色，不可删除。");
				}else if(userOrgList.size() == 1){
					ajaxJson.setSuccess(false);
					ajaxJson.setMsg("当前用户只包含有当前组织机构关系，不可删除，请切换用户的组织机构关系");
				}else{
					String sql = "delete from t_s_user_org where user_id = ? and org_id = ?";
					this.systemService.executeSql(sql,userid,departid);

					ajaxJson.setMsg("成功删除用户对应的组织机构关系");
				}
			} catch (Exception e) {
				e.printStackTrace();
				LogUtil.log("删除用户对应的组织机构关系失败", ajaxJson.getMsg());
				ajaxJson.setSuccess(false);
				ajaxJson.setMsg(e.getMessage());
			}
			return ajaxJson;
		}

	/**
	 * 删除部门：
	 * <ul>
     *     组织机构下存在子机构时
     *     <li>不允许删除 组织机构</li>
	 * </ul>
	 * <ul>
     *     组织机构下存在用户时
     *     <li>不允许删除 组织机构</li>
	 * </ul>
	 * <ul>
     *     组织机构下 不存在子机构 且 不存在用户时
     *     <li>删除 组织机构-角色 信息</li>
     *     <li>删除 组织机构 信息</li>
	 * </ul>
	 * @return 删除的结果信息
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(TSDepart depart, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		depart = systemService.getEntity(TSDepart.class, depart.getId());
        message = MutiLangUtil.paramDelSuccess("common.department");
        if (depart.getTSDeparts().size() == 0) {

            Long userCount = systemService.getCountForJdbcParam("select count(1) from t_s_user_org where org_id = ?",depart.getId());

            if(userCount == 0) { // 组织机构下没有用户时，该组织机构才允许删除。
                systemService.executeSql("delete from t_s_role_org where org_id=?", depart.getId());
                systemService.delete(depart);
                systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
            }else{

            	message = MutiLangUtil.getLang("common.department.hasuser");

            }
        } else {
            message = MutiLangUtil.paramDelFail("common.department");
        }

        j.setMsg(message);
		return j;
	}


	public void upEntity(TSDepart depart) {
		List<TSUser> users = systemService.findByProperty(TSUser.class, "TSDepart.id", depart.getId());
		if (users.size() > 0) {
			for (TSUser tsUser : users) {
				//tsUser.setTSDepart(null);
				//systemService.saveOrUpdate(tsUser);
				systemService.delete(tsUser);
			}
		}
	}

	/**
	 * 添加部门
	 * 
	 * @param depart
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(TSDepart depart, HttpServletRequest request) {
		String message = null;
		// 设置上级部门
		String pid = request.getParameter("TSPDepart.id");
		if (pid.equals("")) {
			depart.setTSPDepart(null);
		}
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(depart.getId())) {
            message = MutiLangUtil.paramUpdSuccess("common.department");
			userService.saveOrUpdate(depart);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} else {
            message = MutiLangUtil.paramAddSuccess("common.department");
			userService.save(depart);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}

        j.setMsg(message);
		return j;
	}
	@RequestMapping(params = "add")
	public ModelAndView add(TSDepart depart, HttpServletRequest req) {
		List<TSDepart> departList = systemService.getList(TSDepart.class);
		req.setAttribute("departList", departList);
//        这个if代码段没有用吧，注释之
//		if (StringUtil.isNotEmpty(depart.getId())) {
//			TSDepart tspDepart = new TSDepart();
//			TSDepart tsDepart = new TSDepart();
//			depart = systemService.getEntity(TSDepart.class, depart.getId());
//			tspDepart.setId(depart.getId());
//			tspDepart.setDepartname(depart.getDepartname());
//			tsDepart.setTSPDepart(tspDepart);
//			req.setAttribute("depart", tsDepart);
//		}
        req.setAttribute("pid", depart.getId());
		return new ModelAndView("system/organzation/depart");
	}
	/**
	 * 部门列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "update")
	public ModelAndView update(TSDepart depart, HttpServletRequest req) {
		List<TSDepart> departList = systemService.getList(TSDepart.class);
		req.setAttribute("departList", departList);
		if (StringUtil.isNotEmpty(depart.getId())) {
			depart = systemService.getEntity(TSDepart.class, depart.getId());
			req.setAttribute("depart", depart);
		}
		return new ModelAndView("system/organzation/depart");
	}
	
	/**
	 * 父级权限列表
	 * 
	 * @param request
	 * @param comboTree
	 * @return
	 */
	@RequestMapping(params = "setPFunction")
	@ResponseBody
	public List<ComboTree> setPFunction(HttpServletRequest request, ComboTree comboTree) {
		CriteriaQuery cq = new CriteriaQuery(TSDepart.class);
		if(null != request.getParameter("selfId")){
			cq.notEq("id", request.getParameter("selfId"));
		}
		if (comboTree.getId() != null) {
			cq.eq("TSPDepart.id", comboTree.getId());
		}
		if (comboTree.getId() == null) {
			cq.isNull("TSPDepart");
		}

		cq.addOrder("orgCode", SortDirection.asc);

		cq.add();
		List<TSDepart> departsList = systemService.getListByCriteriaQuery(cq, false);
		List<ComboTree> comboTrees = new ArrayList<ComboTree>();
		ComboTreeModel comboTreeModel = new ComboTreeModel("id", "departname", "TSDeparts");

		TSDepart defaultDepart = new TSDepart();
		defaultDepart.setId("");
		defaultDepart.setDepartname("请选择组织机构");
		departsList.add(0, defaultDepart);

		comboTrees = systemService.ComboTree(departsList, comboTreeModel, null, true);
		return comboTrees;

	}
	/**
	 * 部门列表，树形展示
	 * @param request
	 * @param response
	 * @param treegrid
	 * @return
	 */
	@RequestMapping(params = "departgrid")
	@ResponseBody
	public Object departgrid(TSDepart tSDepart,HttpServletRequest request, HttpServletResponse response, TreeGrid treegrid) {
		CriteriaQuery cq = new CriteriaQuery(TSDepart.class);
		if("yes".equals(request.getParameter("isSearch"))){
			treegrid.setId(null);
			tSDepart.setId(null);
		} 
		if(null != tSDepart.getDepartname()){
			org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, tSDepart);
		}
		if (treegrid.getId() != null) {
			cq.eq("TSPDepart.id", treegrid.getId());
		}
		if (treegrid.getId() == null) {
			cq.isNull("TSPDepart");
		}

		cq.addOrder("orgCode", SortDirection.asc);

		cq.add();
		List<TreeGrid> departList =null;
		departList=systemService.getListByCriteriaQuery(cq, false);
		if(departList.size()==0&&tSDepart.getDepartname()!=null){ 
			cq = new CriteriaQuery(TSDepart.class);
			TSDepart parDepart = new TSDepart();
			tSDepart.setTSPDepart(parDepart);
			org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, tSDepart);
		    departList =systemService.getListByCriteriaQuery(cq, false);
		}
		List<TreeGrid> treeGrids = new ArrayList<TreeGrid>();
		TreeGridModel treeGridModel = new TreeGridModel();
		treeGridModel.setTextField("departname");
		treeGridModel.setParentText("TSPDepart_departname");
		treeGridModel.setParentId("TSPDepart_id");
		treeGridModel.setSrc("description");
		treeGridModel.setIdField("id");
		treeGridModel.setChildList("TSDeparts");
        Map<String,Object> fieldMap = new HashMap<String, Object>();
        fieldMap.put("orgCode", "orgCode");
        fieldMap.put("orgType", "orgType");
		fieldMap.put("mobile", "mobile");
		fieldMap.put("fax", "fax");
		fieldMap.put("address", "address");
		fieldMap.put("order", "departOrder");
        treeGridModel.setFieldMap(fieldMap);
        treeGrids = systemService.treegrid(departList, treeGridModel);

        JSONArray jsonArray = new JSONArray();
        for (TreeGrid treeGrid : treeGrids) {
            jsonArray.add(JSON.parse(treeGrid.toJson()));
        }
        return jsonArray;
	}
	//----
	/**
	 * 方法描述:  查看成员列表
	 * 作    者： yiming.zhang
	 * 日    期： Dec 4, 2013-8:53:39 PM
	 * @param request
	 * @param departid
	 * @return 
	 * 返回类型： ModelAndView
	 */
	@RequestMapping(params = "userList")
	public ModelAndView userList(HttpServletRequest request, String departid) {
		request.setAttribute("departid", departid);
		return new ModelAndView("system/organzation/departUserList");
	}
	
	//----
	/**
	 * 方法描述:  查看成员列表
	 * 作    者： yiming.zhang
	 * 日    期： Dec 4, 2013-8:53:39 PM
	 * @param request
	 * @param departid
	 * @return 
	 * 返回类型： ModelAndView
	 */
	@RequestMapping(params = "userOrgList")
	public ModelAndView userOrgList(HttpServletRequest request, String departid) {
		request.setAttribute("departid", departid);
		return new ModelAndView("system/organzation/comDepartUserList");
	}
	
	/**
	 * 方法描述:  我的组织机构查看成员列表
	 * 作    者： yiming.zhang
	 * 日    期： Dec 4, 2013-8:53:39 PM
	 * @param request
	 * @param departid
	 * @return 
	 * 返回类型： ModelAndView
	 */
	@RequestMapping(params = "myUserOrgList")
	public ModelAndView myUserOrgList(HttpServletRequest request, String departid) {
		request.setAttribute("departid", departid);
		return new ModelAndView("system/organzation/myDepartUserList");
	}
	
	/**
	 * 方法描述:  成员列表dataGrid
	 * 作    者： yiming.zhang
	 * 日    期： Dec 4, 2013-10:40:17 PM
	 * @param user
	 * @param request
	 * @param response
	 * @param dataGrid 
	 * 返回类型： void
	 */
	@RequestMapping(params = "userDatagrid")
	public void userDatagrid(TSUser user,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {

		if(user!=null&&user.getDepartid()!=null){
			user.setDepartid(null);//设置用户的所属部门的查询条件为空；
		}

		CriteriaQuery cq = new CriteriaQuery(TSUser.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, user);
		String departid = oConvertUtils.getString(request.getParameter("departid"));
		if (!StringUtil.isEmpty(departid)) {

			DetachedCriteria dc = cq.getDetachedCriteria();
			DetachedCriteria dcDepart = dc.createCriteria("userOrgList");
			dcDepart.add(Restrictions.eq("tsDepart.id", departid));
            // 这种方式也是可以的
//            DetachedCriteria dcDepart = dc.createAlias("userOrgList", "userOrg");
//            dcDepart.add(Restrictions.eq("userOrg.tsDepart.id", departid));

		}
		Short[] userstate = new Short[] { Globals.User_Normal, Globals.User_ADMIN };
		cq.in("status", userstate);
		cq.add();
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}
	//----

    /**
     * 获取机构树-combotree
     * @param request
     * @return
     */
    @RequestMapping(params = "getOrgTree")
    @ResponseBody
    public List<ComboTree> getOrgTree(HttpServletRequest request) {
//        findHql不能处理is null条件
//        List<TSDepart> departsList = systemService.findHql("from TSPDepart where TSPDepart.id is null");
        List<TSDepart> departsList = systemService.findByQueryString("from TSDepart where TSPDepart.id is null");
        List<ComboTree> comboTrees = new ArrayList<ComboTree>();
        ComboTreeModel comboTreeModel = new ComboTreeModel("id", "departname", "TSDeparts");
        comboTrees = systemService.ComboTree(departsList, comboTreeModel, null, true);
        return comboTrees;
    }

    /**
     * 添加 用户到组织机构 的页面  跳转
     * @param req request
     * @return 处理结果信息
     */
    @RequestMapping(params = "goAddUserToOrg")
    public ModelAndView goAddUserToOrg(HttpServletRequest req) {
        req.setAttribute("orgId", req.getParameter("orgId"));
        return new ModelAndView("system/organzation/noCurDepartUserList");
    }
    
    /**
     * 添加 用户到组织机构 的页面  跳转
     * @param req request
     * @return 处理结果信息
     */
    @RequestMapping(params = "goAddMyOrgUserToOrg")
    public ModelAndView goAddMyOrgUserToOrg(HttpServletRequest req) {
        req.setAttribute("orgId", req.getParameter("orgId"));
        return new ModelAndView("system/organzation/noCurDepartMyOrgUserList");
    }
    /**
     * 获取 除当前 组织之外的用户信息列表
     * @param request request
     * @return 处理结果信息
     */
    @RequestMapping(params = "addUserToOrgList")
    public void addUserToOrgList(TSUser user, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        String orgId = request.getParameter("orgId");

        CriteriaQuery cq = new CriteriaQuery(TSUser.class, dataGrid);
        org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, user);

        // 获取 当前组织机构的用户信息
        CriteriaQuery subCq = new CriteriaQuery(TSUserOrg.class);
        subCq.setProjection(Property.forName("tsUser.id"));
        subCq.eq("tsDepart.id", orgId);
        subCq.add();

        cq.add(Property.forName("id").notIn(subCq.getDetachedCriteria()));
        cq.add();

        this.systemService.getDataGridReturn(cq, true);
        TagUtil.datagrid(response, dataGrid);
    }
    
    /**
     * 获取 除当前 组织之外的用户信息列表
     * @param request request
     * @return 处理结果信息
     */
    @RequestMapping(params = "addMyOrgUserToOrgList")
    public void addMyOrgUserToOrgList(TSUser user, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        String orgId = request.getParameter("orgId");

        CriteriaQuery cq = new CriteriaQuery(TSUser.class, dataGrid);
        org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, user);

        // 获取 当前组织机构的用户信息
//        CriteriaQuery subCq = new CriteriaQuery(TSUserOrg.class);
//        subCq.setProjection(Property.forName("tsUser.id"));
//        subCq.notEq("tsDepart.id", orgId);
        TSDepart tsDepart = ResourceUtil.getSessionUser().getCurrentDepart();
//        subCq.like("tsDepart.orgCode", tsDepart.getOrgCode()+"%");
//        subCq.add();

        String sql = "select uo.user_id from t_s_user_org  uo left join t_s_depart d on uo.org_id = d.id where d.org_code like concat(?,'%') " +
        		     "and uo.user_id not in (select suo.user_id from t_s_user_org  suo  where suo.org_id = ? )";
        List<Map<String, Object>> userIdMaps = this.systemService.findForJdbc(sql, tsDepart.getOrgCode(),orgId);

        List<Object> userIds = new ArrayList<Object>();
        for(Map<String, Object> map :userIdMaps){
        	userIds.add(map.get("user_id"));
        }
        Object[] userIdArr = userIds.toArray();
//        cq.add(Property.forName("id").in(subCq.getDetachedCriteria()));
        cq.add(Property.forName("id").in(userIdArr));
        cq.add();

        this.systemService.getDataGridReturn(cq, true);
        TagUtil.datagrid(response, dataGrid);
    }
    /**
     * 添加 用户到组织机构
     * @param req request
     * @return 处理结果信息
     */
    @RequestMapping(params = "doAddUserToOrg")
    @ResponseBody
    public AjaxJson doAddUserToOrg(HttpServletRequest req) {
    	String message = null;
        AjaxJson j = new AjaxJson();
        TSDepart depart = systemService.getEntity(TSDepart.class, req.getParameter("orgId"));
        saveOrgUserList(req, depart);
        message =  MutiLangUtil.paramAddSuccess("common.user");
//      systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
        j.setMsg(message);

        return j;
    }
    /**
     * 保存 组织机构-用户 关系信息
     * @param request request
     * @param depart depart
     */
    private void saveOrgUserList(HttpServletRequest request, TSDepart depart) {
        String orgIds = oConvertUtils.getString(request.getParameter("userIds"));

        List<TSUserOrg> userOrgList = new ArrayList<TSUserOrg>();
        List<String> userIdList = extractIdListByComma(orgIds);
        for (String userId : userIdList) {
            TSUser user = new TSUser();
            user.setId(userId);

            TSUserOrg userOrg = new TSUserOrg();
            userOrg.setTsUser(user);
            userOrg.setTsDepart(depart);

            userOrgList.add(userOrg);
        }
        if (!userOrgList.isEmpty()) {
            systemService.batchSave(userOrgList);
        }
    }

    /**
     * 用户选择机构列表跳转页面
     *
     * @return
     */
    @RequestMapping(params = "departSelect")
    public String departSelect(HttpServletRequest req) {
    	
    	req.setAttribute("orgIds", req.getParameter("orgIds"));
    	
        return "system/organzation/departSelect";
    }
    
    /**
     * 用户选择机构列表跳转页面
     *
     * @return
     */
    @RequestMapping(params = "myDepartSelect")
    public String myDepartSelect(HttpServletRequest req) {
    	
    	req.setAttribute("orgIds", req.getParameter("orgIds"));
    	
        return "system/organzation/myDepartSelect";
    }
    /**
     * 角色显示列表
     *
     * @param response response
     * @param dataGrid dataGrid
     */
    @RequestMapping(params = "departSelectDataGrid")
    public void datagridRole(HttpServletResponse response, DataGrid dataGrid) {
        CriteriaQuery cq = new CriteriaQuery(TSDepart.class, dataGrid);
        this.systemService.getDataGridReturn(cq, true);
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * 用户选择机构列表跳转页面(树列表)
     *
     * @return
     */
    @RequestMapping(params = "orgSelect")
    public String orgSelect(HttpServletRequest req) {
    	
    	req.setAttribute("orgIds", req.getParameter("orgIds"));

        return "system/organzation/orgSelect";
    }

    
	/**
	 * 导入功能跳转
	 *
	 * @return
	 */
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		req.setAttribute("controller_name","departController");
		return new ModelAndView("common/upload/pub_excel_upload");
	}

	/**
	 * 导出excel
	 *
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXls")
	public String exportXls(TSDepart tsDepart, HttpServletRequest request, HttpServletResponse response
			, DataGrid dataGrid, ModelMap modelMap) {
		CriteriaQuery cq = new CriteriaQuery(TSDepart.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, tsDepart, request.getParameterMap());
		cq.addOrder("orgCode", SortDirection.asc);
		List<TSDepart> tsDeparts = this.systemService.getListByCriteriaQuery(cq,false);
		/*List<TSDepart> finalTsDeparts = new ArrayList<TSDepart>();
		List<TSDepart> tsDeparts = systemService.getSession().createSQLQuery("select * from t_s_depart where length(org_code) = 3 order by org_code asc").addEntity(TSDepart.class).list();
		for(TSDepart tsDepart1:tsDeparts){
			finalTsDeparts.add(tsDepart1);
			String orgcode1 = tsDepart1.getOrgCode();
			List<TSDepart> tsDeparts1 = systemService.getSession().createSQLQuery("select * from t_s_depart where org_code like :orgcode and length(org_code)=6 order by org_code asc").addEntity(TSDepart.class).setString("orgcode",orgcode1+"%").list();
			for(TSDepart tsDepart2:tsDeparts1){
				finalTsDeparts.add(tsDepart2);
				String orgcode2 = tsDepart2.getOrgCode();
				List<TSDepart> tsDeparts2 = systemService.getSession().createSQLQuery("select * from t_s_depart where org_code like :orgcode and length(org_code)=9 order by org_code asc").addEntity(TSDepart.class).setString("orgcode",orgcode2+"%").list();
				for(TSDepart tsDepart3:tsDeparts2){
					finalTsDeparts.add(tsDepart3);
				}
			}
		}*/
		modelMap.put(NormalExcelConstants.FILE_NAME,"组织机构表");
		modelMap.put(NormalExcelConstants.CLASS,TSDepart.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("组织机构表列表", "导出人:"+ ResourceUtil.getSessionUser().getRealName(),
				"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST,tsDeparts);
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	/**
	 * 导出excel 使模板
	 *
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(TSDepart tsDepart,HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		modelMap.put(NormalExcelConstants.FILE_NAME,"组织机构表");
		modelMap.put(NormalExcelConstants.CLASS,TSDepart.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("组织机构表列表", "导出人:"+ResourceUtil.getSessionUser().getRealName(),
				"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST,new ArrayList());
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(params = "importExcel", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson importExcel(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();

		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();// 获取上传文件对象
			ImportParams params = new ImportParams();
			params.setTitleRows(2);
			params.setHeadRows(1);
			params.setNeedSave(true);
			try {
				List<TSDepart> tsDeparts = ExcelImportUtil.importExcel(file.getInputStream(),TSDepart.class,params);
				for (TSDepart tsDepart : tsDeparts) {
					String orgCode = tsDepart.getOrgCode();
					List<TSDepart> departs = systemService.findByProperty(TSDepart.class,"orgCode",orgCode);
					if(departs.size()!=0){
						TSDepart depart = departs.get(0);
						MyBeanUtils.copyBeanNotNull2Bean(tsDepart,depart);
						systemService.saveOrUpdate(depart);
					}else {

						if(oConvertUtils.isNotEmpty(tsDepart.getOrgType())){
							String orgType = tsDepart.getOrgType().substring(0,1);
							if("1".equals(orgType) || "2".equals(orgType) || "3".equals(orgType)){
								tsDepart.setOrgType(orgType);
							}else{
								j.setMsg("机构类型编码错误");
								return j;
							}
						}else{
							j.setMsg("机构类型编码不能为空");
							return j;
						}

						//TSTypegroup ts = systemService.findByProperty(TSTypegroup.class,"typegroupcode","orgtype").get(0);
						//List<TSType> types = systemService.findByProperty(TSType.class,"id",ts.getId());
						//int len = 3;//每级组织机构得长度
						/*for(int i=0;i<types.size();i++){
							String typecode = types.get(i).getTypecode();

						}*/
						String orgcode = tsDepart.getOrgCode();
						String parentOrgCode = orgcode.substring(0,orgcode.length()-3);

						List<TSDepart> parentList = systemService.getSession().createSQLQuery("select * from t_s_depart where ORG_CODE = :parentOrgCode")
								.addEntity(TSDepart.class)
								.setString("parentOrgCode",parentOrgCode)
								.list();
						if(parentList.size() > 0){
							TSDepart parentDept =  parentList.get(0);
							tsDepart.setTSPDepart(parentDept);
						}
						tsDepart.setDepartOrder("0");

						systemService.save(tsDepart);
					}
				}
				j.setMsg("文件导入成功！");
			} catch (Exception e) {
				j.setMsg("文件导入失败！");
				logger.error(ExceptionUtil.getExceptionMessage(e));
			}finally{
				try {
					file.getInputStream().close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
		return j;
	}

	@RequestMapping(params = "getDepartInfo")
	@ResponseBody
	public AjaxJson getDepartInfo(HttpServletRequest request, HttpServletResponse response){
		
		AjaxJson j = new AjaxJson();
		
		String orgIds = request.getParameter("orgIds");
		
		String[] ids = new String[]{}; 
		if(StringUtils.isNotBlank(orgIds)){
			orgIds = orgIds.substring(0, orgIds.length()-1);
			ids = orgIds.split("\\,");
		}
		
		String parentid = request.getParameter("parentid");
		
		List<TSDepart> tSDeparts = new ArrayList<TSDepart>();
		
		StringBuffer hql = new StringBuffer(" from TSDepart t where 1=1 ");
		if(StringUtils.isNotBlank(parentid)){
			
			TSDepart dePart = this.systemService.getEntity(TSDepart.class, parentid);
			
			hql.append(" and TSPDepart = ?");
			tSDeparts = this.systemService.findHql(hql.toString(), dePart);
		} else {
			hql.append(" and t.orgType = ?");
			tSDeparts = this.systemService.findHql(hql.toString(), "1");
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

	
	
	@RequestMapping(params = "getMyDepartInfo")
	@ResponseBody
	public AjaxJson getMyDepartInfo(HttpServletRequest request, HttpServletResponse response){
		
		AjaxJson j = new AjaxJson();
		
		String orgIds = request.getParameter("orgIds");
		
		String[] ids = new String[]{}; 
		if(StringUtils.isNotBlank(orgIds)){
			orgIds = orgIds.substring(0, orgIds.length()-1);
			ids = orgIds.split("\\,");
		}
		
		String parentid = request.getParameter("parentid");
		
		List<TSDepart> tSDeparts = new ArrayList<TSDepart>();
		
		StringBuffer hql = new StringBuffer(" from TSDepart t where 1=1 ");
		if(StringUtils.isNotBlank(parentid)){
			
			TSDepart dePart = this.systemService.getEntity(TSDepart.class, parentid);
			
			hql.append(" and TSPDepart = ?");
			tSDeparts = this.systemService.findHql(hql.toString(), dePart);
		} else {
//			hql.append(" and t.orgType = ?");
//			tSDeparts = this.systemService.findHql(hql.toString(), "1");
			TSDepart dePart = ResourceUtil.getSessionUser().getCurrentDepart();
			tSDeparts.add(dePart);
//			hql.append(" and TSPDepart = ?");
//			tSDeparts = this.systemService.findHql(hql.toString(), dePart);
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
	 * 组织机构管理zTree
	 * @param functionGroup
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(params="getTreeData",method ={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<Map<String,Object>> getTreeData(HttpServletResponse response,HttpServletRequest request ){
		List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
		try{
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String level = request.getParameter("level");
			logger.info("------id----"+id+"----name----"+name+"----level-----"+level);
		    //如果id为空，则查询一级节点
			if(StringUtils.isEmpty(id)){
				String hql = "from TSDepart t where t.TSPDepart is null order by t.departOrder";
				List<TSDepart> departList =  this.systemService.findHql(hql);
				populateTree(departList,dataList);
			}else{
				String hql = "from TSDepart t where t.TSPDepart.id = ? order by t.departOrder";
				List<TSDepart> departList =  this.systemService.findHql(hql,id);
				populateTree(departList,dataList);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return dataList;
	}
	
	/**
	 * 我的机构管理zTree
	 * @param functionGroup
	 * @param response
	 * @param request
	 * @return
	 */
	@RequestMapping(params="getMyTreeData",method ={RequestMethod.GET, RequestMethod.POST})
	@ResponseBody
	public List<Map<String,Object>> getMyTreeData(HttpServletResponse response,HttpServletRequest request ){
		List<Map<String,Object>> dataList = new ArrayList<Map<String,Object>>();
		try{
			String id = request.getParameter("id");
			String name = request.getParameter("name");
			String level = request.getParameter("level");
			logger.info("------id----"+id+"----name----"+name+"----level-----"+level);
		    //如果id不为空，则查询当前节点子节点
			if(StringUtils.isNotEmpty(id)){
				String hql = "from TSDepart t where t.TSPDepart.id = ? order by t.departOrder";
				List<TSDepart> departList =  this.systemService.findHql(hql,id);
				populateTree(departList,dataList);
			}else{

				String userName = ResourceUtil.getSessionUser().getUserName();
				StringBuffer hql = new StringBuffer(" from TSDepart t where 1=1 ");
				//当其他用户登陆的时候查询用户关联的管理员组的组织机构

				List<TSDepart> departList;
				if(!"admin".equals(userName)) {
					hql.append(" and id in (select deptId from TSDepartAuthGroupEntity where id in (select groupId from TSDepartAuthgManagerEntity where userId = ?))");
					departList = this.systemService.findHql(hql.toString(),userName);
				}else{
					departList = this.systemService.findHql(hql.toString());
				}

				populateTree(departList,dataList);
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
		return dataList;
	}
	
	private void populateTree(List<TSDepart> departList,List<Map<String,Object>> dataList){
		Map<String,Object> map = null;
		if(departList!=null&&departList.size()>0){
			for(TSDepart depart :departList){
				map = new HashMap<String,Object>();
//				map.put("chkDisabled",false);
//				map.put("click", true);
				map.put("open", false);
				map.put("id", depart.getId());
				map.put("name", depart.getDepartname());
				map.put("orgType", depart.getOrgType());
//				map.put("nocheck", false);
//				map.put("struct","TREE");
//				map.put("title","01title");
//				map.put("level", "1");

				if(!depart.getOrgCode().equals(OrgConstants.SUPPLIER_ORG_CODE)) {

					//判断是否有子节点
					String sql = "select count(*) from t_s_depart where parentdepartid = ?";
					Long count = this.systemService.getCountForJdbcParam(sql, depart.getId());

					 if(count>0){
						 map.put("isParent", true);
					 }else{
						 map.put("isParent", false);
					 }
					 if("1".equals(depart.getOrgType())){
						 map.put("icon","plug-in/ztree/css/img/diy/company.png");
					 }else if("2".equals(depart.getOrgType())){
						 map.put("icon","plug-in/ztree/css/img/diy/depart.png");
					 }else if("3".equals(depart.getOrgType())){
						 map.put("icon","plug-in/ztree/css/img/diy/position.png");
					 }else if("4".equals(depart.getOrgType())){
						 map.put("icon","plug-in/ztree/css/img/diy/gys.png");
					 }else if("9".equals(depart.getOrgType())){
						 map.put("icon","plug-in/ztree/css/img/diy/gysroot.png");
					 }
					TSDepart parentdepart = depart.getTSPDepart();
					if(parentdepart == null){
						map.put("parentId","0");
					}else{
						map.put("parentId",parentdepart.getId());
					}
				} else {
					map.put("icon","plug-in/ztree/css/img/diy/gysroot.png");
				}

				dataList.add(map);
			}
		}
	}
	
	private String getCompanyId(String departid){
		TSDepart depart= this.systemService.findUniqueByProperty(TSDepart.class, "id", departid);
		if(depart!=null&&("1".equals(depart.getOrgType())||"4".equals(depart.getOrgType()))){
			return depart.getId();
		}else{
			if(depart.getTSPDepart()!=null){
				return getCompanyId(depart.getTSPDepart().getId());
			}
		}
		return null;
	}
	
}
