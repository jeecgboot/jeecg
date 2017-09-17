package org.jeecgframework.web.cgreport.controller.core;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.velocity.VelocityContext;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.IpUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.p3.core.util.plugin.ViewVelocity;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.cgreport.entity.core.CgreportConfigHeadEntity;
import org.jeecgframework.web.cgreport.entity.core.CgreportConfigItemEntity;
import org.jeecgframework.web.cgreport.entity.core.CgreportConfigParamEntity;
import org.jeecgframework.web.cgreport.page.core.CgreportConfigHeadPage;
import org.jeecgframework.web.cgreport.service.core.CgreportConfigHeadServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
/**   
 * @Title: Controller
 * @Description: 动态报表配置抬头
 * @author 张代浩
 * @date 2013-12-07 16:00:21
 * @version V1.0   
 *
 */
//@Scope("prototype")
@Controller
@RequestMapping("/cgreportConfigHeadController")
public class CgreportConfigHeadController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(CgreportConfigHeadController.class);

	@Autowired
	private CgreportConfigHeadServiceI cgreportConfigHeadService;
	@Autowired
	private SystemService systemService;

	/**
	 * Velicity页面方式: 跳转列表页面
	 * 
	 * @return
	 */
	@RequestMapping(params = "list", method = { RequestMethod.GET, RequestMethod.POST })
	public void list(HttpServletRequest request, HttpServletResponse response) throws Exception {
		try {
			VelocityContext velocityContext = new VelocityContext();
			String viewName = "cgreport/cgreport-list.vm";
			ViewVelocity.view(request, response, viewName, velocityContext);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * Velicity页面方式: 跳转表单页面
	 * 
	 * @return
	 */
	@RequestMapping(params = "form", method = RequestMethod.GET)
	public void qywxAccountDetail(HttpServletResponse response, HttpServletRequest request) throws Exception {
		VelocityContext velocityContext = new VelocityContext();
		String viewName = "cgreport/cgreport-form.vm";
		ViewVelocity.view(request, response, viewName, velocityContext);
	}

	/**
	 * 动态报表配置抬头列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "cgreportConfigHead")
	public ModelAndView cgreportConfigHead(HttpServletRequest request) {
		return new ModelAndView("jeecg/cgreport/core/cgreportConfigHeadList");
	}
	
	@RequestMapping(params = "cgreportConfigHeadVM", method = RequestMethod.GET)
	public void cgreportConfigHeadVM(HttpServletResponse response, HttpServletRequest request) throws Exception{
		VelocityContext velocityContext = new VelocityContext();
		String viewName = "cgreport/cgreportConfigHeadList.vm";
		ViewVelocity.view(request, response, viewName, velocityContext);
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
	public void datagrid(CgreportConfigHeadEntity cgreportConfigHead,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(CgreportConfigHeadEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, cgreportConfigHead);
		try{
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.cgreportConfigHeadService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除动态报表配置抬头
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(CgreportConfigHeadEntity cgreportConfigHead, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		cgreportConfigHead = systemService.getEntity(CgreportConfigHeadEntity.class, cgreportConfigHead.getId());
		message = "动态报表配置抬头删除成功";
		try{
			cgreportConfigHeadService.delMain(cgreportConfigHead);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			logger.info("["+IpUtil.getIpAddr(request)+"][online报表删除]["+cgreportConfigHead.getCode()+"]"+message);
		}catch(Exception e){
			e.printStackTrace();
			message = "动态报表配置抬头删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 批量删除动态报表配置抬头
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "动态报表配置抬头删除成功";
		try{
			for(String id:ids.split(",")){
				CgreportConfigHeadEntity cgreportConfigHead = systemService.getEntity(CgreportConfigHeadEntity.class, id);
				cgreportConfigHeadService.delMain(cgreportConfigHead);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
				logger.info("["+IpUtil.getIpAddr(request)+"][online报表批量删除]["+cgreportConfigHead.getCode()+"]"+message);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "动态报表配置抬头删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 添加动态报表配置抬头
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(CgreportConfigHeadEntity cgreportConfigHead,CgreportConfigHeadPage cgreportConfigHeadPage, HttpServletRequest request) {
		String message = null;
		List<CgreportConfigItemEntity> cgreportConfigItemList =  cgreportConfigHeadPage.getCgreportConfigItemList();
		List<CgreportConfigParamEntity> cgreportConfigParamList = cgreportConfigHeadPage.getCgreportConfigParamList();
		AjaxJson j = new AjaxJson();
		message = "添加成功";
		try{
			cgreportConfigHeadService.addMain(cgreportConfigHead, cgreportConfigItemList,cgreportConfigParamList);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
			logger.info("["+IpUtil.getIpAddr(request)+"][online报表录入]["+cgreportConfigHead.getCode()+"]"+message);
		}catch(Exception e){
			e.printStackTrace();
			message = "动态报表配置抬头添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	/**
	 * 更新动态报表配置抬头
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(CgreportConfigHeadEntity cgreportConfigHead,CgreportConfigHeadPage cgreportConfigHeadPage, HttpServletRequest request) {
		String message = null;
		List<CgreportConfigItemEntity> cgreportConfigItemList =  cgreportConfigHeadPage.getCgreportConfigItemList();
		List<CgreportConfigParamEntity> cgreportConfigParamList = cgreportConfigHeadPage.getCgreportConfigParamList();
		AjaxJson j = new AjaxJson();
		message = "更新成功";
		try{
			cgreportConfigHeadService.updateMain(cgreportConfigHead, cgreportConfigItemList, cgreportConfigParamList);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			logger.info("["+IpUtil.getIpAddr(request)+"][online报表更新]["+cgreportConfigHead.getCode()+"]"+message);
		}catch(Exception e){
			e.printStackTrace();
			message = "更新动态报表配置抬头失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 动态报表配置抬头新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(CgreportConfigHeadEntity cgreportConfigHead, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(cgreportConfigHead.getId())) {
			cgreportConfigHead = cgreportConfigHeadService.getEntity(CgreportConfigHeadEntity.class, cgreportConfigHead.getId());
			req.setAttribute("cgreportConfigHeadPage", cgreportConfigHead);
		}
		return new ModelAndView("jeecg/cgreport/core/cgreportConfigHead-add");
	}

	@RequestMapping(params = "goAdd_vm")
	public void goAddVM(HttpServletResponse response, HttpServletRequest request) throws Exception {
		VelocityContext velocityContext = new VelocityContext();
		String viewName = "cgreport/cgreportConfigHead-add.vm";
		
		ViewVelocity.view(request,response,viewName,velocityContext);
	}
	
	
	/**
	 * 动态报表配置抬头编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(CgreportConfigHeadEntity cgreportConfigHead, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(cgreportConfigHead.getId())) {
			cgreportConfigHead = cgreportConfigHeadService.getEntity(CgreportConfigHeadEntity.class, cgreportConfigHead.getId());
			req.setAttribute("cgreportConfigHeadPage", cgreportConfigHead);
		}
		return new ModelAndView("jeecg/cgreport/core/cgreportConfigHead-update");
	}
	
	@RequestMapping(params = "goUpdate_vm")
	public void goUpdateVM(@RequestParam(required = true, value = "id" ) String id, HttpServletResponse response, HttpServletRequest request) throws Exception {
		VelocityContext velocityContext = new VelocityContext();
		String viewName = "cgreport/cgreportConfigHead-update.vm";
		
		CgreportConfigHeadEntity cgreportConfigHead = cgreportConfigHeadService.getEntity(CgreportConfigHeadEntity.class, id);
			
		velocityContext.put("cgreportConfigHead",cgreportConfigHead);
		
		ViewVelocity.view(request,response,viewName,velocityContext);
	}
	
	
	/**
	 * 加载明细列表[动态报表配置明细]
	 * 
	 * @return
	 */
	@RequestMapping(params = "cgreportConfigItemList")
	public ModelAndView cgreportConfigItemList(CgreportConfigHeadEntity cgreportConfigHead, HttpServletRequest req) {
	
		//===================================================================================
		//获取参数
		Object id0 = cgreportConfigHead.getId();
		//===================================================================================
		//查询-动态报表配置明细
	    String hql0 = "from CgreportConfigItemEntity where 1 = 1 AND cgrheadId = ? ";
	    try{
	    	List<CgreportConfigItemEntity> cgreportConfigItemEntityList = systemService.findHql(hql0,id0);
			req.setAttribute("cgreportConfigItemList", cgreportConfigItemEntityList);
		}catch(Exception e){
			logger.info(e.getMessage());
		}
		return new ModelAndView("jeecg/cgreport/core/cgreportConfigItemList");
	}
	
	@RequestMapping(params = "cgreportConfigItemList_vm")
	public void cgreportConfigItemListVM(@RequestParam(required = true, value = "id" ) String id, HttpServletResponse response, HttpServletRequest request) throws Exception {
		VelocityContext velocityContext = new VelocityContext();
		String viewName = "cgreport/cgreportConfigItemList.vm";
		
		//===================================================================================
		//获取参数
		Object id0 = id;
		//===================================================================================
		//查询-动态报表配置明细
	    String hql0 = "from CgreportConfigItemEntity where 1 = 1 AND cgrheadId = ? ";
	    try{
	    	List<CgreportConfigItemEntity> cgreportConfigItemEntityList = systemService.findHql(hql0,id0);
			velocityContext.put("cgreportConfigItemList",cgreportConfigItemEntityList);
		}catch(Exception e){
			logger.info(e.getMessage());
		}
		ViewVelocity.view(request,response,viewName,velocityContext);
	}
	
	/**
	 * 加载参数列表[动态报表参数]
	 * 
	 * @return
	 */
	@RequestMapping(params = "cgreportConfigParamList")
	public ModelAndView cgreportConfigParamList(CgreportConfigHeadEntity cgreportConfigHead, HttpServletRequest req) {
	
		//===================================================================================
		//获取参数
		Object id0 = cgreportConfigHead.getId();
		//===================================================================================
		//查询-动态报表配置明细
	    String hql0 = "from CgreportConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
	    try{
	    	List<CgreportConfigParamEntity> cgreportConfigParamEntityList = systemService.findHql(hql0,id0);
			req.setAttribute("cgreportConfigParamList", cgreportConfigParamEntityList);
		}catch(Exception e){
			logger.info(e.getMessage());
		}
		return new ModelAndView("jeecg/cgreport/core/cgreportConfigParamList");
	}
	
	@RequestMapping(params = "cgreportConfigParamList_vm")
	public void cgreportConfigParamListVM(@RequestParam(required = true, value = "id" ) String id, HttpServletResponse response, HttpServletRequest request) throws Exception {
		VelocityContext velocityContext = new VelocityContext();
		String viewName = "cgreport/cgreportConfigParamList.vm";
		
		//===================================================================================
		//获取参数
		Object id0 = id;
		//===================================================================================
		//查询-动态报表配置明细
	    String hql0 = "from CgreportConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
	    try{
	    	List<CgreportConfigParamEntity> cgreportConfigParamEntityList = systemService.findHql(hql0,id0);
	    	velocityContext.put("cgreportConfigParamList",cgreportConfigParamEntityList);
		}catch(Exception e){
			logger.info(e.getMessage());
		}
		ViewVelocity.view(request,response,viewName,velocityContext);
	}
	
	@RequestMapping(params = "popmenulink")
	public ModelAndView popmenulink(ModelMap modelMap,
                                    @RequestParam String url,
                                    @RequestParam String title, HttpServletRequest request) {
        modelMap.put("title",title);
        modelMap.put("url",url);
        StringBuilder sb = new StringBuilder("");
	    try{
	    	CgreportConfigHeadEntity cgreportConfigHead = systemService.findUniqueByProperty(CgreportConfigHeadEntity.class, "code", title);
	    	String hql0 = "from CgreportConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
	    	List<CgreportConfigParamEntity> cgreportConfigParamList = systemService.findHql(hql0,cgreportConfigHead.getId());
	    	if(cgreportConfigParamList!=null&cgreportConfigParamList.size()>0){
	    		for(CgreportConfigParamEntity cgreportConfigParam :cgreportConfigParamList){
	    			sb.append("&").append(cgreportConfigParam.getParamName()).append("=");
	    			if(StringUtil.isNotEmpty(cgreportConfigParam.getParamValue())){
	    				sb.append(cgreportConfigParam.getParamValue());
	    			}else{
	    				sb.append("${"+cgreportConfigParam.getParamName()+"}");
	    			}
	    		}
	    	}
		}catch(Exception e){
			logger.info(e.getMessage());
		}
		modelMap.put("params",sb.toString());
		return new ModelAndView("jeecg/cgreport/core/popmenulink");
	}
	
	@RequestMapping(params = "popmenulink_vm")
	public void popmenulinkVM(@RequestParam String url, @RequestParam String title, HttpServletResponse response, HttpServletRequest request) throws Exception {
		VelocityContext velocityContext = new VelocityContext();
		String viewName = "cgreport/popmenulink.vm";
        StringBuilder sb = new StringBuilder("");
	    try{
	    	CgreportConfigHeadEntity cgreportConfigHead = systemService.findUniqueByProperty(CgreportConfigHeadEntity.class, "code", title);
	    	String hql0 = "from CgreportConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
	    	List<CgreportConfigParamEntity> cgreportConfigParamList = systemService.findHql(hql0,cgreportConfigHead.getId());
	    	if(cgreportConfigParamList!=null&cgreportConfigParamList.size()>0){
	    		for(CgreportConfigParamEntity cgreportConfigParam :cgreportConfigParamList){
	    			sb.append("&").append(cgreportConfigParam.getParamName()).append("=");
	    			if(StringUtil.isNotEmpty(cgreportConfigParam.getParamValue())){
	    				sb.append(cgreportConfigParam.getParamValue());
	    			}else{
	    				sb.append("${"+cgreportConfigParam.getParamName()+"}");
	    			}
	    		}
	    	}
		}catch(Exception e){
			logger.info(e.getMessage());
		}
		velocityContext.put("title",title);
		velocityContext.put("url",url);
		velocityContext.put("params",sb.toString());

		ViewVelocity.view(request,response,viewName,velocityContext);
	}
}
