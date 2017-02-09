package org.jeecgframework.web.graphreport.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.velocity.VelocityContext;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.p3.core.util.plugin.ViewVelocity;
import org.jeecgframework.web.graphreport.entity.core.JformGraphreportHeadEntity;
import org.jeecgframework.web.graphreport.entity.core.JformGraphreportItemEntity;
import org.jeecgframework.web.graphreport.service.core.JformGraphreportHeadServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

/**
 * online在线图表配置
 * 
 *  Velocity页面控制器 
 * @author 张加强
 *
 */
@Controller
@RequestMapping("/jformGraphreportHeadVMController")
public class JformGraphreportHeadVMController extends BaseController {

	
	private static final Logger logger = Logger.getLogger(JformGraphreportHeadVMController.class);

	@Autowired
	private JformGraphreportHeadServiceI jformGraphreportHeadService;
	@Autowired
	private SystemService systemService;
	
	/**
	 * 跳转到VelocityList页面
	 * @param request
	 * @param response
	 */
	@RequestMapping(params="jformGraphreportHeadVM")
	public void jformGraphreportHeadVM(HttpServletRequest request,HttpServletResponse response){
		try {
			VelocityContext velocityContext = new VelocityContext();
			String viewName = "graphreport/jformGraphreportHeadList.vm";
			ViewVelocity.view(request, response, viewName, velocityContext);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	/**
	 * 图表配置新增页面  velocity
	 * @param request
	 * @param response
	 */
	@RequestMapping(params="goAdd_VM")
	public void goAddVM(HttpServletRequest request,HttpServletResponse response){
		try {
			VelocityContext velocityContext = new VelocityContext();
			String viewName = "graphreport/jformGraphreportHead-add.vm";
			ViewVelocity.view(request, response, viewName, velocityContext);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 跳转到编辑界面 Velocity
	 * @param jformGraphreportHead
	 * @param request
	 * @param response
	 */
	@RequestMapping(params="goUpdate_VM")
	public void goUpdateVM(JformGraphreportHeadEntity jformGraphreportHead, HttpServletRequest request,HttpServletResponse response){
		try {
			VelocityContext velocityContext = new VelocityContext();
			String viewName = "graphreport/jformGraphreportHead-update.vm";
			if (StringUtil.isNotEmpty(jformGraphreportHead.getId())) {
				jformGraphreportHead = jformGraphreportHeadService.getEntity(JformGraphreportHeadEntity.class, jformGraphreportHead.getId());
				velocityContext.put("jformGraphreportHeadPage", jformGraphreportHead);
			}
			ViewVelocity.view(request, response, viewName, velocityContext);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	/**
	 * 加载明细列表 Velocity
	 * @param entity
	 * @param request
	 * @param response
	 */
	@RequestMapping(params="jformGraphreportItemListVM")
	public void jformGraphreportItemListVM(JformGraphreportHeadEntity entity,HttpServletRequest request,
			HttpServletResponse response){
		VelocityContext velocityContext = new VelocityContext();
		String viewName = "graphreport/jformGraphreportItemList.vm";
		try {
			String hql  = "from JformGraphreportItemEntity where 1 = 1 AND cGREPORT_HEAD_ID = ? ";
			List<JformGraphreportItemEntity> jformGraphreportItemEntityList = systemService.findHql(hql,entity.getId());
			velocityContext.put("jformGraphreportItemList", jformGraphreportItemEntityList);
			ViewVelocity.view(request, response, viewName, velocityContext);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	
	
	/**
	 * 跳转到Velocity上传页面
	 * @param request
	 * @param response
	 */
	@RequestMapping(params="goImportExcelVM")
	public void goImportExcelVM(HttpServletRequest request,HttpServletResponse response){
		try {
			VelocityContext velocityContext = new VelocityContext();
			String viewName = "graphreport/jformGraphreportUpload.vm";
			ViewVelocity.view(request, response, viewName, velocityContext);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * 跳转到配置地址界面
	 * @param request
	 * @param response
	 */
	@RequestMapping(params="popMenuLink")
	public void popMenuLinkVM(@RequestParam String url, @RequestParam String title,HttpServletRequest request,HttpServletResponse response){
		try {
			VelocityContext velocityContext = new VelocityContext();
			String viewName = "graphreport/jfromGraphreportHeadPopMenuLink.vm";
			velocityContext.put("url", url);
			velocityContext.put("title",title);
			ViewVelocity.view(request, response, viewName, velocityContext);
		} catch (Exception e) {
			
		}
	}
	
	
	
	
}
