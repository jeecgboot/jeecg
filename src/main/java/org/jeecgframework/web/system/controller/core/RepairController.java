package org.jeecgframework.web.system.controller.core;

import org.jeecgframework.web.system.service.RepairService;
import org.jeecgframework.web.system.service.SystemService;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

/**
 * @Description   修复数据库
 * @ClassName: RepairController
 * @author tanghan
 * @date 2013-7-19 下午01:23:08
 */
@Scope("prototype")
@Controller
@RequestMapping("/repairController")
public class RepairController extends BaseController {

	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(RepairController.class);
			
	private SystemService systemService;
    
	private RepairService repairService;
	
	private String message;

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	@Autowired
	public void setRepairService(RepairService repairService) {
		this.repairService = repairService;
	}

	@Autowired
	public void setSystemService(SystemService systemService) {
		this.systemService = systemService;
	}

	/** 
	 * @Description repair
	 */
	@RequestMapping(params = "repair")
	public ModelAndView repair() {
		repairService.deleteAndRepair();
		systemService.initAllTypeGroups();   //初始化缓存
		return new ModelAndView("login/login");
	}
	
}
