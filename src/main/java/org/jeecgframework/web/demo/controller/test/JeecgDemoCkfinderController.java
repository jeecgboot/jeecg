package org.jeecgframework.web.demo.controller.test;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.core.util.MyBeanUtils;

import org.jeecgframework.web.demo.entity.test.JeecgDemoCkfinderEntity;
import org.jeecgframework.web.demo.service.test.JeecgDemoCkfinderServiceI;

/**
 * @Title: Controller
 * @Description: ckeditor+ckfinder例子
 * @author Alexander
 * @date 2013-09-19 18:29:20
 * @version V1.0
 * 
 */
@Scope("prototype")
@Controller
@RequestMapping("/jeecgDemoCkfinderController")
public class JeecgDemoCkfinderController extends BaseController {

	@Autowired
	private JeecgDemoCkfinderServiceI jeecgDemoCkfinderService;
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
	 * ckeditor+ckfinder例子列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "jeecgDemoCkfinder")
	public ModelAndView jeecgDemoCkfinder(HttpServletRequest request) {
		return new ModelAndView("jeecg/demo/test/jeecgDemoCkfinderList");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@RequestMapping(params = "datagrid")
	public void datagrid(JeecgDemoCkfinderEntity jeecgDemoCkfinder,
			HttpServletRequest request, HttpServletResponse response,
			DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(JeecgDemoCkfinderEntity.class,
				dataGrid);
		// 查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq,
				jeecgDemoCkfinder, request.getParameterMap());
		this.jeecgDemoCkfinderService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除ckeditor+ckfinder例子
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(JeecgDemoCkfinderEntity jeecgDemoCkfinder,
			HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		jeecgDemoCkfinder = systemService.getEntity(
				JeecgDemoCkfinderEntity.class, jeecgDemoCkfinder.getId());
		message = "ckeditor+ckfinder例子删除成功";
		jeecgDemoCkfinderService.delete(jeecgDemoCkfinder);
		systemService.addLog(message, Globals.Log_Type_DEL,
				Globals.Log_Leavel_INFO);

		j.setMsg(message);
		return j;
	}

	/**
	 * 添加ckeditor+ckfinder例子
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(JeecgDemoCkfinderEntity jeecgDemoCkfinder,
			HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(jeecgDemoCkfinder.getId())) {
			message = "ckeditor+ckfinder例子更新成功";
			JeecgDemoCkfinderEntity t = jeecgDemoCkfinderService.get(
					JeecgDemoCkfinderEntity.class, jeecgDemoCkfinder.getId());
			try {
				MyBeanUtils.copyBeanNotNull2Bean(jeecgDemoCkfinder, t);
				jeecgDemoCkfinderService.saveOrUpdate(t);
				systemService.addLog(message, Globals.Log_Type_UPDATE,
						Globals.Log_Leavel_INFO);
			} catch (Exception e) {
				e.printStackTrace();
				message = "ckeditor+ckfinder例子更新失败";
			}
		} else {
			message = "ckeditor+ckfinder例子添加成功";
			jeecgDemoCkfinderService.save(jeecgDemoCkfinder);
			systemService.addLog(message, Globals.Log_Type_INSERT,
					Globals.Log_Leavel_INFO);
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * ckeditor+ckfinder例子列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(JeecgDemoCkfinderEntity jeecgDemoCkfinder,
			HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jeecgDemoCkfinder.getId())) {
			jeecgDemoCkfinder = jeecgDemoCkfinderService.getEntity(
					JeecgDemoCkfinderEntity.class, jeecgDemoCkfinder.getId());
			req.setAttribute("jeecgDemoCkfinderPage", jeecgDemoCkfinder);
		}
		return new ModelAndView("jeecg/demo/test/jeecgDemoCkfinder");
	}
	
	/**
	 * ckeditor+ckfinder例子预览
	 * 
	 * @return
	 */
	@RequestMapping(params = "preview")
	public ModelAndView preview(JeecgDemoCkfinderEntity jeecgDemoCkfinder,
			HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jeecgDemoCkfinder.getId())) {
			jeecgDemoCkfinder = jeecgDemoCkfinderService.getEntity(
					JeecgDemoCkfinderEntity.class, jeecgDemoCkfinder.getId());
			req.setAttribute("ckfinderPreview", jeecgDemoCkfinder);
		}
		return new ModelAndView("jeecg/demo/test/jeecgDemoCkfinderPreview");
	}
}
