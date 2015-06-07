package org.jeecgframework.web.system.controller.core;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.web.system.pojo.base.TSConfig;
import org.jeecgframework.web.system.service.SystemService;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;


/**
 * 配置信息处理类
 * 
 * @author 张代浩
 * 
 */
@Scope("prototype")
@Controller
@RequestMapping("/configController")
public class ConfigController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger
			.getLogger(ConfigController.class);
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

	/**
	 * 配置列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "config")
	public ModelAndView config() {
		return new ModelAndView("system/config/configList");
	}

	/**
	 * easyuiAjax表单请求
	 * 
	 * @param request
	 * @param response
	 * @param dataGrid
	 */
	@RequestMapping(params = "datagrid")
	public void datagrid(HttpServletRequest request,
			HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(TSConfig.class, dataGrid);
		this.systemService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除配置信息
	 * 
	 * @param config
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(TSConfig config, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		config = systemService.getEntity(TSConfig.class, config.getId());
		message = "配置信息: " + config.getName() + "被删除 成功";
		systemService.delete(config);
		systemService.addLog(message, Globals.Log_Type_DEL,
				Globals.Log_Leavel_INFO);
		
		return j;
	}

	/**
	 * 添加和更新配置信息
	 * 
	 * @param config
	 * @param request
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(TSConfig tsConfig,HttpServletRequest request) {
		if (StringUtil.isEmpty(tsConfig.getId())) {
			TSConfig tsConfig2=systemService.findUniqueByProperty(TSConfig.class, "code", tsConfig.getCode());
			if(tsConfig2!=null){
				message = "编码为: " + tsConfig.getCode() + "的配置信息已存在";
			}else{
				tsConfig.setTSUser(ResourceUtil.getSessionUserName());
				systemService.save(tsConfig);
				message = "配置信息: " + tsConfig.getName() + "被添加成功";
				systemService.addLog(message, Globals.Log_Type_INSERT,
						Globals.Log_Leavel_INFO);
			}
			
		}else{
			message = "配置信息: " + tsConfig.getName() + "被修改成功";
			systemService.updateEntitie(tsConfig);
			systemService.addLog(message, Globals.Log_Type_INSERT,
					Globals.Log_Leavel_INFO);
		}
		AjaxJson j = new AjaxJson();
		j.setMsg(message);
		
		return j;
	}

	/**
	 * 添加和更新配置信息页面
	 * 
	 * @param config
	 * @param req
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(TSConfig config, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(config.getId())) {
			config = systemService.getEntity(TSConfig.class,
					config.getId());
			req.setAttribute("config", config);
		}
		return new ModelAndView("system/config/config");
	}

}
