package jeecg.system.controller.core;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jeecg.system.pojo.base.TSDepart;
import jeecg.system.pojo.base.TSUser;
import jeecg.system.service.SystemService;
import jeecg.system.service.UserService;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.ComboTree;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.model.json.TreeGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.tag.vo.easyui.TreeGridModel;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


/**
 * 部门信息处理类
 * 
 * @author Administrator
 * 
 */
@Controller
@RequestMapping("/departController")
public class DepartController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(DepartController.class);
	private UserService userService;
	private SystemService systemService;
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
		return new ModelAndView("system/depart/departList");
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
	public void datagrid(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSDepart.class, dataGrid);
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除部门
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(TSDepart depart, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		depart = systemService.getEntity(TSDepart.class, depart.getId());
		message = "部门: " + depart.getDepartname() + "被删除 成功";
		// 删除部门之前更新与之相关的实体
		upEntity(depart);
		systemService.delete(depart);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		
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
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(TSDepart depart, HttpServletRequest request) {
		// 设置上级部门
		String pid = request.getParameter("TSPDepart.id");
		if (pid.equals("")) {
			depart.setTSPDepart(null);
		}
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(depart.getId())) {
			message = "部门: " + depart.getDepartname() + "被更新成功";
			userService.saveOrUpdate(depart);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} else {
			message = "部门: " + depart.getDepartname() + "被添加成功";
			userService.save(depart);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		
		return j;
	}
	//add-begin--Author:liutao  Date:20130405 for：部门管理的添加处理逻辑
	@RequestMapping(params = "add")
	public ModelAndView add(TSDepart depart, HttpServletRequest req) {
		List<TSDepart> departList = systemService.getList(TSDepart.class);
		req.setAttribute("departList", departList);
		if (StringUtil.isNotEmpty(depart.getId())) {
			TSDepart tspDepart = new TSDepart();
			TSDepart tsDepart = new TSDepart();
			depart = systemService.getEntity(TSDepart.class, depart.getId());
			tspDepart.setId(depart.getId());
			tspDepart.setDepartname(depart.getDepartname());
			tsDepart.setTSPDepart(tspDepart);
			req.setAttribute("depart", tsDepart);
		}
		return new ModelAndView("system/depart/depart");
	}
	//add-end--Author:liutao  Date:20130405 for：部门管理的添加处理逻辑
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
		return new ModelAndView("system/depart/depart");
	}
	
	/**
	 * 父级权限列表
	 * 
	 * @param role
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 * @return
	 */
	@RequestMapping(params = "setPFunction")
	@ResponseBody
	public List<ComboTree> setPFunction(HttpServletRequest request, ComboTree comboTree) {
		CriteriaQuery cq = new CriteriaQuery(TSDepart.class);
		if (comboTree.getId() != null) {
			cq.eq("TSPDepart.id", comboTree.getId());
		}
		if (comboTree.getId() == null) {
			cq.isNull("TDepart");
		}
		cq.add();
		List<TSDepart> departsList = systemService.getListByCriteriaQuery(cq, false);
		List<ComboTree> comboTrees = new ArrayList<ComboTree>();
		comboTrees = systemService.comTree(departsList, comboTree);
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
	public  List<TreeGrid>  departgrid(TSDepart tSDepart,HttpServletRequest request, HttpServletResponse response, TreeGrid treegrid) {
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
		treeGrids = systemService.treegrid(departList, treeGridModel);
		return treeGrids;
	}

}
