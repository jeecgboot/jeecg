package org.jeecgframework.web.cgreport.controller.core;
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
	 * 动态报表配置抬头列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "cgreportConfigHead")
	public ModelAndView cgreportConfigHead(HttpServletRequest request) {
		return new ModelAndView("jeecg/cgreport/core/cgreportConfigHeadList");
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
			//判断参数和查询列是否有冲突的
			for(CgreportConfigParamEntity parm:cgreportConfigParamList){
				for(CgreportConfigItemEntity item:cgreportConfigItemList){
					if(CgReportConstant.BOOL_TRUE.equalsIgnoreCase(item.getSFlag())
							&&parm.getParamName().equals(item.getFieldName())){
						message = "配置的参数名【"+parm.getParamName()+"】和配置明细中是查询的列冲突，请更改参数名称";
						j.setMsg(message);
						j.setSuccess(false);
						return j;
					}
				}
			}
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
			//判断参数和查询列是否有冲突的
			for(CgreportConfigParamEntity parm:cgreportConfigParamList){
				for(CgreportConfigItemEntity item:cgreportConfigItemList){
					if(CgReportConstant.BOOL_TRUE.equalsIgnoreCase(item.getSFlag())
							&&parm.getParamName().equals(item.getFieldName())){
						message = "配置的参数名【"+parm.getParamName()+"】和配置明细中是查询的列冲突，请更改参数名称";
						j.setMsg(message);
						j.setSuccess(false);
						return j;
					}
				}
			}
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
	
}
