package org.jeecgframework.web.demo.controller.test;

import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.ComboTree;
import org.jeecgframework.core.common.model.json.TreeGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.vo.easyui.ComboTreeModel;
import org.jeecgframework.tag.vo.easyui.TreeGridModel;
import org.jeecgframework.web.demo.entity.test.JeecgMatterBom;
import org.jeecgframework.web.demo.service.test.JeecgMatterBomServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

/**
 * <li>类型名称：
 * <li>说明：物料Bom显示控制类
 * <li>创建人： 温俊
 * <li>创建日期：2013-8-12
 * <li>修改人：
 * <li>修改日期：
 */
@Scope("prototype")
@Controller
@RequestMapping("/jeecgMatterBomController")
public class JeecgMatterBomController extends BaseController {

	@Autowired
	private JeecgMatterBomServiceI jeecgMatterBomService;

	@Autowired
	private SystemService systemService;

	private String message;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	/**
	 * <li>方法名：goList
	 * <li>@param request HttpServletRequest
	 * <li>@return 列表页面
	 * <li>返回类型：ModelAndView
	 * <li>说明：跳转到物料Bom列表页面
	 * <li>创建人：温俊
	 * <li>创建日期：2013-8-13
	 * <li>修改人： 
	 * <li>修改日期：
	 */
	@RequestMapping(params = "goList")
	public ModelAndView goList(HttpServletRequest request) {
		return new ModelAndView("jeecg/demo/test/jeecgMatterBomList");
	}

	/**
	 * <li>方法名：doTreeGrid
	 * <li>@param entity JeecgMatterBom
	 * <li>@param request HttpServletRequest
	 * <li>@param response HttpServletResponse
	 * <li>@param treegrid TreeGrid
	 * <li>@return 物料Bom treegrid集合
	 * <li>返回类型：List<TreeGrid>
	 * <li>说明：获取物料Bom treegrid集合
	 * <li>创建人：温俊
	 * <li>创建日期：2013-8-13
	 * <li>修改人： 
	 * <li>修改日期：
	 */
	@RequestMapping(params = "doTreeGrid")
	@ResponseBody
	public List<TreeGrid> doTreeGrid(JeecgMatterBom entity, HttpServletRequest request, HttpServletResponse response, TreeGrid treegrid) {
		CriteriaQuery cq = new CriteriaQuery(JeecgMatterBom.class);
		if("yes".equals(request.getParameter("isSearch"))) {
			treegrid.setId(null);
			entity.setId(null);
		} 
		if(null != entity.getCode()) {
			HqlGenerateUtil.installHql(cq, entity);
		}
		if (treegrid.getId() != null) {
			cq.eq("parent.id", treegrid.getId());
		} else {
			cq.isNull("parent");
		}
		cq.add();
		List<TreeGrid> list = jeecgMatterBomService.getListByCriteriaQuery(cq, false);
		if(list.size() == 0 && entity.getCode() != null) { 
			cq = new CriteriaQuery(JeecgMatterBom.class);
			JeecgMatterBom parent = new JeecgMatterBom();
			entity.setParent(parent);
			HqlGenerateUtil.installHql(cq, entity);
			list = jeecgMatterBomService.getListByCriteriaQuery(cq, false);
		}
		List<TreeGrid> treeGrids = new ArrayList<TreeGrid>();
		TreeGridModel treeGridModel = new TreeGridModel();
		treeGridModel.setTextField("name");
		treeGridModel.setParentText("parent_name");
		treeGridModel.setParentId("parent_id");
		treeGridModel.setSrc("code");
		treeGridModel.setIdField("id");
		treeGridModel.setChildList("children");
		treeGrids = jeecgMatterBomService.treegrid(list, treeGridModel);
		return treeGrids;
	}

	/**
	 * <li>方法名：goEdit
	 * <li>@param entity JeecgMatterBom
	 * <li>@param request HttpServletRequest
	 * <li>@return 录入或编辑页面
	 * <li>返回类型：ModelAndView
	 * <li>说明：跳转到录入或编辑页面
	 * <li>创建人：温俊
	 * <li>创建日期：2013-8-13
	 * <li>修改人： 
	 * <li>修改日期：
	 */
	@RequestMapping(params = "goEdit")
	public ModelAndView goEdit(JeecgMatterBom entity, HttpServletRequest request) {
		if (StringUtil.isNotEmpty(entity.getId())) {
			entity = jeecgMatterBomService.getEntity(JeecgMatterBom.class, entity.getId());
			request.setAttribute("entity", entity);
		}
		return new ModelAndView("jeecg/demo/test/jeecgMatterBom");
	}
	
	/**
	 * <li>方法名：getChildren
	 * <li>@param request HttpServletRequest
	 * <li>@param comboTree ComboTree
	 * <li>@return 物料Bom ComboTree集合
	 * <li>返回类型：List<ComboTree>
	 * <li>说明：获取物料Bom ComboTree集合
	 * <li>创建人：温俊
	 * <li>创建日期：2013-8-13
	 * <li>修改人： 
	 * <li>修改日期：
	 */
	@RequestMapping(params = "getChildren")
	@ResponseBody
	public List<ComboTree> getChildren(HttpServletRequest request, ComboTree comboTree) {
		CriteriaQuery cq = new CriteriaQuery(JeecgMatterBom.class);
		if (comboTree.getId() != null) {
			cq.eq("parent.id", comboTree.getId());
		} else {
			cq.isNull("parent");
		}
		cq.add();
		List<JeecgMatterBom> list = jeecgMatterBomService.getListByCriteriaQuery(cq, false);
		ComboTreeModel comboTreeModel = new ComboTreeModel("id", "name", "children");
		List<ComboTree> comboTrees = systemService.ComboTree(list, comboTreeModel, null, false);
		return comboTrees;

	}

	/**
	 * <li>方法名：doSave
	 * <li>@param entity JeecgMatterBom
	 * <li>@param request HttpServletRequest
	 * <li>@return ajax提示信息
	 * <li>返回类型：AjaxJson
	 * <li>说明：保存或更新物料Bom
	 * <li>创建人：温俊
	 * <li>创建日期：2013-8-13
	 * <li>修改人： 
	 * <li>修改日期：
	 */
	@RequestMapping(params = "doSave")
	@ResponseBody
	public AjaxJson doSave(JeecgMatterBom entity, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		//设置上级物料Bom
		String parentId = request.getParameter("parent.id");
		if (StringUtil.isEmpty(parentId)) {
			entity.setParent(null);
		}
		if (StringUtil.isNotEmpty(entity.getId())) {
			message = "更新成功";
			JeecgMatterBom t = jeecgMatterBomService.get(JeecgMatterBom.class, entity.getId());
			try {
				MyBeanUtils.copyBeanNotNull2Bean(entity, t);
				jeecgMatterBomService.saveOrUpdate(t);
				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			message = "添加成功";
			jeecgMatterBomService.save(entity);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}

		return j;
	}

	/**
	 * <li>方法名：doDelete
	 * <li>@param entity JeecgMatterBom
	 * <li>@param request HttpServletRequest
	 * <li>@return ajax提示信息
	 * <li>返回类型：AjaxJson
	 * <li>说明：删除物料Bom
	 * <li>创建人：温俊
	 * <li>创建日期：2013-8-13
	 * <li>修改人： 
	 * <li>修改日期：
	 */
	@RequestMapping(params = "doDelete")
	@ResponseBody
	public AjaxJson doDelete(JeecgMatterBom entity, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();

		jeecgMatterBomService.deleteEntityById(JeecgMatterBom.class, entity.getId());

		message = "删除成功";
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);

		j.setMsg(message);
		return j;
	}

}
