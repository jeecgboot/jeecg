package org.jeecgframework.web.cgform.controller.button;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.web.cgform.entity.button.CgformButtonEntity;
import org.jeecgframework.web.cgform.service.button.CgformButtonServiceI;
import org.jeecgframework.web.system.service.SystemService;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**   
 * @Title: Controller
 * @Description: 表单自定义按钮
 * @author 张代浩
 * @date 2013-08-07 20:16:26
 * @version V1.0   
 *
 */
//@Scope("prototype")
@Controller
@RequestMapping("/cgformButtonController")
public class CgformButtonController extends BaseController {
	/**
	 * Logger for this class
	 */
	@SuppressWarnings("unused")
	private static final Logger logger = Logger.getLogger(CgformButtonController.class);

	@Autowired
	private CgformButtonServiceI cgformButtonService;
	@Autowired
	private SystemService systemService;


	/**
	 * 表单自定义按钮列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "cgformButton")
	public ModelAndView cgformButton(HttpServletRequest request) {
		String formId = request.getParameter("formId");
		String tableName = request.getParameter("tableName");
		request.setAttribute("formId", formId);
		request.setAttribute("tableName", tableName);
		return new ModelAndView("jeecg/cgform/button/cgformButtonList");
	}

	/**
	 * easyui AJAX请求数据
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */

	@SuppressWarnings("unchecked")
	@RequestMapping(params = "datagrid")
	public void datagrid(CgformButtonEntity cgformButton,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(CgformButtonEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, cgformButton, request.getParameterMap());
		this.cgformButtonService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除表单自定义按钮
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(CgformButtonEntity cgformButton, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		cgformButton = systemService.getEntity(CgformButtonEntity.class, cgformButton.getId());
		message = "删除成功";
		cgformButtonService.delete(cgformButton);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加表单自定义按钮
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(CgformButtonEntity cgformButton, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		if("add".equalsIgnoreCase(cgformButton.getButtonCode())
				||"update".equalsIgnoreCase(cgformButton.getButtonCode())
				||"delete".equalsIgnoreCase(cgformButton.getButtonCode())){
			message = "按钮编码不能是add/update/delete";
			j.setMsg(message);
			return j;
		}
		List<CgformButtonEntity> list =  cgformButtonService.checkCgformButton(cgformButton);
		if(list!=null&&list.size()>0){
			message = "按钮编码已经存在";
			j.setMsg(message);
			return j;
		}
		if (StringUtil.isNotEmpty(cgformButton.getId())) {
			message = "更新成功";
			CgformButtonEntity t = cgformButtonService.get(CgformButtonEntity.class, cgformButton.getId());
			try {
				MyBeanUtils.copyBeanNotNull2Bean(cgformButton, t);
				cgformButtonService.saveOrUpdate(t);
				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			message = "添加成功";
			cgformButtonService.save(cgformButton);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 表单自定义按钮列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(CgformButtonEntity cgformButton, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(cgformButton.getId())) {
			cgformButton = cgformButtonService.getEntity(CgformButtonEntity.class, cgformButton.getId());
		}
		req.setAttribute("cgformButtonPage", cgformButton);
		return new ModelAndView("jeecg/cgform/button/cgformButton");
	}
}
