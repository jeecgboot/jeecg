package org.jeecgframework.web.cgform.controller.button;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.web.cgform.entity.button.CgformButtonEntity;
import org.jeecgframework.web.cgform.entity.button.CgformButtonSqlEntity;
import org.jeecgframework.web.cgform.service.button.CgformButtonServiceI;
import org.jeecgframework.web.cgform.service.button.CgformButtonSqlServiceI;
import org.jeecgframework.web.system.service.SystemService;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.IpUtil;
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
 * @Description: 按钮sql增强
 * @author 张代浩
 * @date 2013-08-07 23:09:23
 * @version V1.0   
 *
 */
//@Scope("prototype")
@Controller
@RequestMapping("/cgformButtonSqlController")
public class CgformButtonSqlController extends BaseController {
	/**
	 * Logger for this class
	 */
	@SuppressWarnings("unused")
	private static final Logger logger = Logger.getLogger(CgformButtonSqlController.class);

	@Autowired
	private CgformButtonSqlServiceI cgformButtonSqlService;
	@Autowired
	private CgformButtonServiceI cgformButtonService;
	@Autowired
	private SystemService systemService;


	/**
	 * 按钮sql增强列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "cgformButtonSql")
	public ModelAndView cgformButtonSql(HttpServletRequest request) {
		String formId = request.getParameter("formId");
		String tableName = request.getParameter("tableName");
		request.setAttribute("formId", formId);
		request.setAttribute("tableName", tableName);
		return new ModelAndView("jeecg/cgform/button/cgformButtonSqlList");
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
	public void datagrid(CgformButtonSqlEntity cgformButtonSql,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(CgformButtonSqlEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, cgformButtonSql, request.getParameterMap());
		this.cgformButtonSqlService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除按钮sql增强
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(CgformButtonSqlEntity cgformButtonSql, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		cgformButtonSql = systemService.getEntity(CgformButtonSqlEntity.class, cgformButtonSql.getId());
		message = "删除成功";
		cgformButtonSqlService.delete(cgformButtonSql);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		logger.info("["+IpUtil.getIpAddr(request)+"][online表单sql增强删除]"+message);
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 查找数据
	 * 
	 * @return
	 */
	@RequestMapping(params = "doCgformButtonSql")
	@ResponseBody  
	public AjaxJson doCgformButtonSql(CgformButtonSqlEntity cgformButtonSql, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		CgformButtonSqlEntity cgformSql = cgformButtonSqlService.getCgformButtonSqlByCodeFormId(cgformButtonSql.getButtonCode(), cgformButtonSql.getFormId());
		if(cgformSql!=null){
			j.setObj(cgformSql);
			j.setSuccess(true);
		}else{
			j.setSuccess(false);
		}
		return j;
	}


	/**
	 * 添加按钮sql增强
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(CgformButtonSqlEntity cgformButtonSql, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		List<CgformButtonSqlEntity> list =  cgformButtonSqlService.checkCgformButtonSql(cgformButtonSql);
		if(list!=null&&list.size()>0){
			message = "按钮编码已经存在";
			j.setMsg(message);
			return j;
		}
		if (StringUtil.isNotEmpty(cgformButtonSql.getId())) {
			message = "更新成功";
			CgformButtonSqlEntity t = cgformButtonSqlService.get(CgformButtonSqlEntity.class, cgformButtonSql.getId());
			try {
				MyBeanUtils.copyBeanNotNull2Bean(cgformButtonSql, t);
				cgformButtonSqlService.saveOrUpdate(t);
				systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else {
			message = "添加成功";
			cgformButtonSqlService.save(cgformButtonSql);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		logger.info("["+IpUtil.getIpAddr(request)+"][online表单sql增强添加更新]"+message);
		j.setMsg(message);
		return j;
	}

	/**
	 * 按钮sql增强列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(CgformButtonSqlEntity cgformButtonSql, HttpServletRequest req) {
		//根据buttonCode和formId初始化数据
		cgformButtonSql.setButtonCode("add");
		if (StringUtil.isNotEmpty(cgformButtonSql.getButtonCode())&&StringUtil.isNotEmpty(cgformButtonSql.getFormId())) {
			CgformButtonSqlEntity cgformButtonSqlVo = cgformButtonSqlService.getCgformButtonSqlByCodeFormId(cgformButtonSql.getButtonCode(), cgformButtonSql.getFormId());
		    if(cgformButtonSqlVo!=null){
		    	cgformButtonSql = cgformButtonSqlVo;
		    }
		}
		List<CgformButtonEntity> list = cgformButtonService.getCgformButtonListByFormId(cgformButtonSql.getFormId());
		if(list==null){
			list = new ArrayList<CgformButtonEntity>();
		}
		req.setAttribute("buttonList", list);
		req.setAttribute("cgformButtonSqlPage", cgformButtonSql);
		return new ModelAndView("jeecg/cgform/button/cgformButtonSql");
	}
}
