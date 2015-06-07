package org.jeecgframework.web.cgform.controller.cgformcategory;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.cgform.entity.category.CgformCategoryEntity;
import org.jeecgframework.web.cgform.service.cgformcategory.CgformCategoryServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.core.util.MyBeanUtils;

/**
 * 表单分类管理
 * 
 * @author JueYue
 * @date 2014年10月14日 下午10:32:17
 */
@Controller
@RequestMapping("/cgformCategoryController")
public class CgformCategoryController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(CgformCategoryController.class);

	private static final String CGFORM_CATEGORY_LIST = "jeecg/cgform/cgformcategory/cgformCategoryList";
	private static final String CGFORM_CATEGORY = "jeecg/cgform/cgformcategory/cgformCategory";

	@Autowired
	private CgformCategoryServiceI cgformCategoryService;

	@Autowired
	private SystemService systemService;

	/**
	 * 表单分类管理列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "cgformCategory")
	public String cgformCategory(HttpServletRequest request) {
		return CGFORM_CATEGORY_LIST;
	}

	@RequestMapping(params = "datagrid")
	public void datagrid(CgformCategoryEntity cgformCategory,
			HttpServletRequest request, HttpServletResponse response,
			DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(CgformCategoryEntity.class,
				dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq,
				cgformCategory);
		this.cgformCategoryService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除表单分类管理
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(CgformCategoryEntity cgformCategory,
			HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			cgformCategory = cgformCategoryService.getEntity(
					CgformCategoryEntity.class, cgformCategory.getId());
			j.setMsg("表单分类管理删除成功");
			cgformCategoryService.delete(cgformCategory);
			systemService.addLog(j.getMsg(), Globals.Log_Type_DEL,
					Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			logger.error(e.getMessage(), e.fillInStackTrace());
			j.setMsg("表单分类管理删除失败");
		}
		return j;
	}

	/**
	 * 添加表单分类管理
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(CgformCategoryEntity cgformCategory,
			HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		try {
			if (StringUtil.isNotEmpty(cgformCategory.getId())) {
				j.setMsg("表单分类管理更新成功");
				CgformCategoryEntity t = cgformCategoryService.get(
						CgformCategoryEntity.class, cgformCategory.getId());
				MyBeanUtils.copyBeanNotNull2Bean(cgformCategory, t);
				cgformCategoryService.saveOrUpdate(t);
				systemService.addLog(j.getMsg(), Globals.Log_Type_UPDATE,
						Globals.Log_Leavel_INFO);
			} else {
				j.setMsg("表单分类管理添加成功");
				cgformCategoryService.save(cgformCategory);
				systemService.addLog(j.getMsg(), Globals.Log_Type_INSERT,
						Globals.Log_Leavel_INFO);
			}
		} catch (Exception e) {
			logger.error(e.getMessage(), e.fillInStackTrace());
			j.setMsg("表单分类管理更新失败");
		}
		return j;
	}

	/**
	 * 表单分类管理列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public String addorupdate(CgformCategoryEntity cgformCategory,
			HttpServletRequest req) {
		if (StringUtil.isNotEmpty(cgformCategory.getId())) {
			cgformCategory = cgformCategoryService.getEntity(
					CgformCategoryEntity.class, cgformCategory.getId());
			req.setAttribute("cgformCategoryPage", cgformCategory);
		}
		return CGFORM_CATEGORY;
	}
}
