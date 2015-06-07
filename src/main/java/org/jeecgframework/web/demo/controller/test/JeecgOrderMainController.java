package org.jeecgframework.web.demo.controller.test;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.web.demo.entity.test.JeecgOrderCustomEntity;
import org.jeecgframework.web.demo.entity.test.JeecgOrderMainEntity;
import org.jeecgframework.web.demo.entity.test.JeecgOrderProductEntity;
import org.jeecgframework.web.demo.page.JeecgOrderMainPage;
import org.jeecgframework.web.demo.service.test.JeecgOrderMainServiceI;
import org.jeecgframework.web.system.service.SystemService;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
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
 * @Description: 订单信息
 * @author 张代浩
 * @date 2013-03-19 22:01:34
 * @version V1.0   
 *
 */
@Scope("prototype")
@Controller
@RequestMapping("/jeecgOrderMainController")
public class JeecgOrderMainController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(JeecgOrderMainController.class);

	@Autowired
	private JeecgOrderMainServiceI jeecgOrderMainService;
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
	 * 订单信息列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "jeecgOrderMain")
	public ModelAndView jeecgOrderMain(HttpServletRequest request) {
		return new ModelAndView("jeecg/demo/test/jeecgOrderMainList");
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
	public void datagrid(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(JeecgOrderMainEntity.class, dataGrid);
		this.jeecgOrderMainService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除订单信息
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(JeecgOrderMainEntity jeecgOrderMain, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		jeecgOrderMain = systemService.getEntity(JeecgOrderMainEntity.class, jeecgOrderMain.getId());
		message = "删除成功";
		jeecgOrderMainService.delMain(jeecgOrderMain);
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加订单及明细信息
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(JeecgOrderMainEntity jeecgOrderMain ,JeecgOrderMainPage jeecgOrderMainPage,	
			HttpServletRequest request) {
		List<JeecgOrderProductEntity> jeecgOrderProducList =  jeecgOrderMainPage.getJeecgOrderProductList();
		List<JeecgOrderCustomEntity>  jeecgOrderCustomList = jeecgOrderMainPage.getJeecgOrderCustomList();
		Boolean jeecgOrderCustomShow = "true".equals(request.getParameter("jeecgOrderCustomShow"));
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(jeecgOrderMain.getId())) {
			message = "更新成功";
			jeecgOrderMainService.updateMain(jeecgOrderMain, jeecgOrderProducList, jeecgOrderCustomList,jeecgOrderCustomShow);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} else {
			message = "添加成功";
			jeecgOrderMainService.addMain(jeecgOrderMain, jeecgOrderProducList, jeecgOrderCustomList);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		j.setMsg(message);
		return j;
	}
	/**
	 * 订单信息列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(JeecgOrderMainEntity jeecgOrderMain, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jeecgOrderMain.getId())) {
			jeecgOrderMain = jeecgOrderMainService.getEntity(JeecgOrderMainEntity.class, jeecgOrderMain.getId());
			req.setAttribute("jeecgOrderMainPage", jeecgOrderMain);
		}
		return new ModelAndView("jeecg/demo/test/jeecgOrderMain");
	}
	/**
	 * 加载产品列表页面
	 * 
	 * @return
	 */
	@RequestMapping(params = "jeecgOrderProductList")
	public ModelAndView jeecgOrderProductList(JeecgOrderMainEntity jeecgOrderMain, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jeecgOrderMain.getGoOrderCode())) {
			List<JeecgOrderProductEntity> jeecgOrderProductEntityList =  jeecgOrderMainService.findByProperty(JeecgOrderProductEntity.class, "goOrderCode", jeecgOrderMain.getGoOrderCode());
			req.setAttribute("jeecgOrderProductList", jeecgOrderProductEntityList);
		}
		return new ModelAndView("jeecg/demo/test/jeecgOrderProductList");
	}
	
	/**
	 * 加载客户列表页面
	 * 
	 * @return
	 */
	@RequestMapping(params = "jeecgOrderCustomList")
	public ModelAndView jeecgOrderCustomList(JeecgOrderMainEntity jeecgOrderMain, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jeecgOrderMain.getGoOrderCode())) {
			List<JeecgOrderCustomEntity> jeecgJeecgOrderCustomEntityList =  jeecgOrderMainService.findByProperty(JeecgOrderCustomEntity.class, "goOrderCode", jeecgOrderMain.getGoOrderCode());
			req.setAttribute("jeecgOrderCustomList", jeecgJeecgOrderCustomEntityList);
		}
		return new ModelAndView("jeecg/demo/test/jeecgOrderCustomList");
	}
}
