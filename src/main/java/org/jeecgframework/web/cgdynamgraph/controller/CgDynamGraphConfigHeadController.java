package org.jeecgframework.web.cgdynamgraph.controller;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.online.def.CgReportConstant;
import org.jeecgframework.core.util.IpUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigHeadEntity;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigItemEntity;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigParamEntity;
import org.jeecgframework.web.cgdynamgraph.page.core.CgDynamGraphConfigHeadPage;
import org.jeecgframework.web.cgdynamgraph.service.core.CgDynamGraphConfigHeadServiceI;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

/**   
 * @Title: Controller
 * @Description: Online移动图表配置
 * @author scott
 * @date 2016-01-10 16:00:21
 * @version V1.0   
 *
 */
//@Scope("prototype")
@Controller
@RequestMapping("/cgDynamGraphConfigHeadController.do")
public class CgDynamGraphConfigHeadController extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(CgDynamGraphConfigHeadController.class);

	@Autowired
	private CgDynamGraphConfigHeadServiceI cgDynamGraphConfigHeadService;
	@Autowired
	private SystemService systemService;


	/**
	 * 移动图表配置抬头列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "cgDynamGraphConfigHead")
	public ModelAndView CgDynamGraphConfigHead(HttpServletRequest request) {
		return new ModelAndView("jeecg/cgdynamgraph/core/cgDynamGraphConfigHeadList");
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
	public void datagrid(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(CgDynamGraphConfigHeadEntity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, cgDynamGraphConfigHead);
		try{
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.cgDynamGraphConfigHeadService.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除移动图表配置抬头
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		cgDynamGraphConfigHead = systemService.getEntity(CgDynamGraphConfigHeadEntity.class, cgDynamGraphConfigHead.getId());
		message = "移动图表配置抬头删除成功";
		try{
			cgDynamGraphConfigHeadService.delMain(cgDynamGraphConfigHead);
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			logger.info("["+IpUtil.getIpAddr(request)+"][online移动图表删除]["+cgDynamGraphConfigHead.getCode()+"]"+message);
		}catch(Exception e){
			e.printStackTrace();
			message = "移动图表配置抬头删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 批量删除移动图表配置抬头
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "移动图表配置抬头删除成功";
		try{
			for(String id:ids.split(",")){
				CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead = systemService.getEntity(CgDynamGraphConfigHeadEntity.class, id);
				cgDynamGraphConfigHeadService.delMain(cgDynamGraphConfigHead);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
				logger.info("["+IpUtil.getIpAddr(request)+"][online移动图表批量删除]["+cgDynamGraphConfigHead.getCode()+"]"+message);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "移动图表配置抬头删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 添加移动图表配置抬头
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead,CgDynamGraphConfigHeadPage cgDynamGraphConfigHeadPage, HttpServletRequest request) {
		String message = null;
		List<CgDynamGraphConfigItemEntity> cgDynamGraphConfigItemList =  cgDynamGraphConfigHeadPage.getCgDynamGraphConfigItemList();
		List<CgDynamGraphConfigParamEntity> cgDynamGraphConfigParamList = cgDynamGraphConfigHeadPage.getCgDynamGraphConfigParamList();
		AjaxJson j = new AjaxJson();
		message = "添加成功";
		try{
			//判断参数和查询列是否有冲突的
			for(CgDynamGraphConfigParamEntity parm:cgDynamGraphConfigParamList){
				for(CgDynamGraphConfigItemEntity item:cgDynamGraphConfigItemList){
					if(CgReportConstant.BOOL_TRUE.equalsIgnoreCase(item.getSFlag())
							&&parm.getParamName().equals(item.getFieldName())){
						message = "配置的参数名【"+parm.getParamName()+"】和配置明细中是查询的列冲突，请更改参数名称";
						j.setMsg(message);
						j.setSuccess(false);
						return j;
					}
				}
			}
			cgDynamGraphConfigHeadService.addMain(cgDynamGraphConfigHead, cgDynamGraphConfigItemList,cgDynamGraphConfigParamList);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
			logger.info("["+IpUtil.getIpAddr(request)+"][online移动图表录入]["+cgDynamGraphConfigHead.getCode()+"]"+message);
		}catch(Exception e){
			e.printStackTrace();
			message = "移动图表配置抬头添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	/**
	 * 更新移动图表配置抬头
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead,CgDynamGraphConfigHeadPage cgDynamGraphConfigHeadPage, HttpServletRequest request) {
		String message = null;
		List<CgDynamGraphConfigItemEntity> cgDynamGraphConfigItemList =  cgDynamGraphConfigHeadPage.getCgDynamGraphConfigItemList();
		List<CgDynamGraphConfigParamEntity> cgDynamGraphConfigParamList = cgDynamGraphConfigHeadPage.getCgDynamGraphConfigParamList();
		AjaxJson j = new AjaxJson();
		message = "更新成功";
		try{
			//判断参数和查询列是否有冲突的
			for(CgDynamGraphConfigParamEntity parm:cgDynamGraphConfigParamList){
				for(CgDynamGraphConfigItemEntity item:cgDynamGraphConfigItemList){
					if(CgReportConstant.BOOL_TRUE.equalsIgnoreCase(item.getSFlag())
							&&parm.getParamName().equals(item.getFieldName())){
						message = "配置的参数名【"+parm.getParamName()+"】和配置明细中是查询的列冲突，请更改参数名称";
						j.setMsg(message);
						j.setSuccess(false);
						return j;
					}
				}
			}
			cgDynamGraphConfigHeadService.updateMain(cgDynamGraphConfigHead, cgDynamGraphConfigItemList, cgDynamGraphConfigParamList);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
			logger.info("["+IpUtil.getIpAddr(request)+"][online移动图表更新]["+cgDynamGraphConfigHead.getCode()+"]"+message);
		}catch(Exception e){
			e.printStackTrace();
			message = "更新移动图表配置抬头失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 移动图表配置抬头新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(cgDynamGraphConfigHead.getId())) {
			cgDynamGraphConfigHead = cgDynamGraphConfigHeadService.getEntity(CgDynamGraphConfigHeadEntity.class, cgDynamGraphConfigHead.getId());
			req.setAttribute("cgDynamGraphConfigHeadPage", cgDynamGraphConfigHead);
		}
		return new ModelAndView("jeecg/cgdynamgraph/core/cgDynamGraphConfigHead-add");
	}
		
	/**
	 * 移动图表配置抬头编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(cgDynamGraphConfigHead.getId())) {
			cgDynamGraphConfigHead = cgDynamGraphConfigHeadService.getEntity(CgDynamGraphConfigHeadEntity.class, cgDynamGraphConfigHead.getId());
			req.setAttribute("cgDynamGraphConfigHeadPage", cgDynamGraphConfigHead);
		}
		return new ModelAndView("jeecg/cgdynamgraph/core/cgDynamGraphConfigHead-update");
	}
		
	/**
	 * 加载明细列表[移动图表配置明细]
	 * 
	 * @return
	 */
	@RequestMapping(params = "cgDynamGraphConfigItemList")
	public ModelAndView cgDynamGraphConfigItemList(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead, HttpServletRequest req) {
	
		//===================================================================================
		//获取参数
		Object id0 = cgDynamGraphConfigHead.getId();
		//===================================================================================
		//查询-移动图表配置明细
	    String hql0 = "from CgDynamGraphConfigItemEntity where 1 = 1 AND cgrheadId = ? ";
	    try{
	    	List<CgDynamGraphConfigItemEntity> cgDynamGraphConfigItemEntityList = systemService.findHql(hql0,id0);
			req.setAttribute("cgDynamGraphConfigItemList", cgDynamGraphConfigItemEntityList);
		}catch(Exception e){
			logger.info(e.getMessage());
		}
		return new ModelAndView("jeecg/cgdynamgraph/core/cgDynamGraphConfigItemList");
	}
		
	/**
	 * 加载参数列表[移动图表参数]
	 * 
	 * @return
	 */
	@RequestMapping(params = "cgDynamGraphConfigParamList")
	public ModelAndView cgDynamGraphConfigParamList(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead, HttpServletRequest req) {
	
		//===================================================================================
		//获取参数
		Object id0 = cgDynamGraphConfigHead.getId();
		//===================================================================================
		//查询-移动图表配置明细
	    String hql0 = "from CgDynamGraphConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
	    try{
	    	List<CgDynamGraphConfigParamEntity> cgDynamGraphConfigParamEntityList = systemService.findHql(hql0,id0);
			req.setAttribute("cgDynamGraphConfigParamList",cgDynamGraphConfigParamEntityList);
		}catch(Exception e){
			logger.info(e.getMessage());
		}
		return new ModelAndView("jeecg/cgdynamgraph/core/cgDynamGraphConfigParamList");
	}
	
	@RequestMapping(params = "popmenulink")
	public ModelAndView popmenulink(ModelMap modelMap,
                                    @RequestParam String url,
                                    @RequestParam String title, HttpServletRequest request) {
        modelMap.put("title",title);
        modelMap.put("url",url);
        StringBuilder sb = new StringBuilder("");
	    try{
	    	CgDynamGraphConfigHeadEntity cgDynamGraphConfigHeadEntity = systemService.findUniqueByProperty(CgDynamGraphConfigHeadEntity.class,  "code", title);
	    	String hql0 = "from CgDynamGraphConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
	    	List<CgDynamGraphConfigParamEntity> cgreportConfigParamList = systemService.findHql(hql0,cgDynamGraphConfigHeadEntity.getId());
	    	if(cgreportConfigParamList!=null&cgreportConfigParamList.size()>0){
	    		for(CgDynamGraphConfigParamEntity cgreportConfigParam :cgreportConfigParamList){
	    			sb.append("&").append(cgreportConfigParam.getParamName()).append("=");
	    			if(StringUtil.isNotEmpty(cgreportConfigParam.getParamValue())){
	    				sb.append(cgreportConfigParam.getParamValue());
	    			}else{
	    				sb.append("${"+cgreportConfigParam.getParamName()+"}");
	    			}
	    		}
	    	}
		}catch(Exception e){
		}
		modelMap.put("params",sb.toString());
		return new ModelAndView("jeecg/cgreport/core/popmenulink");
	}
	
}
