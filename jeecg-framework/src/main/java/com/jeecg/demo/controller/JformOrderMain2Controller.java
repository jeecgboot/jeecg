package com.jeecg.demo.controller;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.criterion.Restrictions;
import org.jeecgframework.core.beanvalidator.BeanValidators;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.jwt.util.ResponseMessage;
import org.jeecgframework.jwt.util.Result;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.service.SystemService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.util.UriComponentsBuilder;

import com.alibaba.fastjson.JSONArray;
import com.jeecg.demo.entity.JformOrderCustomer2Entity;
import com.jeecg.demo.entity.JformOrderMain2Entity;
import com.jeecg.demo.entity.JformOrderTicket2Entity;
import com.jeecg.demo.page.JformOrderMain2Page;
import com.jeecg.demo.service.JformOrderMain2ServiceI;
import org.jeecgframework.web.superquery.util.SuperQueryUtil;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;

/**   
 * @Title: Controller
 * @Description: 订单主信息
 * @author onlineGenerator
 * @date 2018-03-27 16:21:58
 * @version V1.0   
 *
 */
@Api(value="JformOrderMain2",description="订单主信息",tags="jformOrderMain2Controller")
@Controller
@RequestMapping("/jformOrderMain2Controller")
public class JformOrderMain2Controller extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(JformOrderMain2Controller.class);

	@Autowired
	private JformOrderMain2ServiceI jformOrderMain2Service;
	@Autowired
	private SystemService systemService;
	@Autowired
	private Validator validator;

	/**
	 *  订单信息列表 首页跳转
	 * @return
	 */
	@RequestMapping(params = "index")
	public ModelAndView index(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/jformOrderMain2/jformOrderMain2Index");
	}
	/**
	 * 订单主信息列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("com/jeecg/demo/jformOrderMain2/main/list");
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
	public void datagrid(JformOrderMain2Entity jformOrderMain2,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(JformOrderMain2Entity.class, dataGrid);
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, jformOrderMain2);
		try{
			//自定义追加查询条件
			String sql = SuperQueryUtil.getComplxSuperQuerySQL(request);
			if(oConvertUtils.isNotEmpty(sql)) {
				cq.add(Restrictions.sqlRestriction(" id in ("+sql+")"));
			}
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.jformOrderMain2Service.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除订单主信息
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(JformOrderMain2Entity jformOrderMain2, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		jformOrderMain2 = systemService.getEntity(JformOrderMain2Entity.class, jformOrderMain2.getId());
		String message = "订单主信息删除成功";
		try{
			if(jformOrderMain2!=null){
				jformOrderMain2Service.delMain(jformOrderMain2);
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "订单主信息删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 批量删除订单主信息
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		String message = "订单主信息删除成功";
		try{
			for(String id:ids.split(",")){
				JformOrderMain2Entity jformOrderMain2 = systemService.getEntity(JformOrderMain2Entity.class,
				id
				);
				if(jformOrderMain2!=null){
					jformOrderMain2Service.delMain(jformOrderMain2);
					systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "订单主信息删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * 添加订单主信息
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(JformOrderMain2Entity jformOrderMain2,JformOrderMain2Page jformOrderMain2Page, HttpServletRequest request) {
		List<JformOrderTicket2Entity> jformOrderTicket2List =  jformOrderMain2Page.getJformOrderTicket2List();
		List<JformOrderCustomer2Entity> jformOrderCustomer2List =  jformOrderMain2Page.getJformOrderCustomer2List();
		AjaxJson j = new AjaxJson();
		String message = "添加成功";
		try{
			jformOrderMain2Service.addMain(jformOrderMain2, jformOrderTicket2List,jformOrderCustomer2List);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "订单主信息添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	/**
	 * 更新订单主信息
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(JformOrderMain2Entity jformOrderMain2,JformOrderMain2Page jformOrderMain2Page, HttpServletRequest request) {
		List<JformOrderTicket2Entity> jformOrderTicket2List =  jformOrderMain2Page.getJformOrderTicket2List();
		List<JformOrderCustomer2Entity> jformOrderCustomer2List =  jformOrderMain2Page.getJformOrderCustomer2List();
		AjaxJson j = new AjaxJson();
		String message = "更新成功";
		try{
			jformOrderMain2Service.updateMain(jformOrderMain2, jformOrderTicket2List,jformOrderCustomer2List);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "更新订单主信息失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}

	
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(HttpServletRequest req) {
		//跳转主页面
		return new ModelAndView("com/jeecg/demo/jformOrderMain2/main/addOrUpdate");
	}
	
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(HttpServletRequest req) {
		//跳转主页面
		String id = req.getParameter("id");
		req.setAttribute("mainId",id);
		req.setAttribute("load", req.getParameter("load"));
		return new ModelAndView("com/jeecg/demo/jformOrderMain2/main/addOrUpdate");
	}
	
	/**
	 * 订单主信息新增编辑字段页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "mainPage")
	public ModelAndView mainPage(JformOrderMain2Entity jformOrderMain2, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(jformOrderMain2.getId())) {
			jformOrderMain2 = jformOrderMain2Service.getEntity(JformOrderMain2Entity.class, jformOrderMain2.getId());
			req.setAttribute("jformOrderMain2Page", jformOrderMain2);
		}
		return new ModelAndView("com/jeecg/demo/jformOrderMain2/main/jformOrderMain2");
	}
	
	
	/**
	 * 加载明细列表[订单机票信息]
	 * 
	 * @return
	 */
	@RequestMapping(params = "jformOrderTicket2List")
	public ModelAndView jformOrderTicket2List(JformOrderMain2Entity jformOrderMain2, HttpServletRequest req) {
	
		//===================================================================================
		//获取参数
		Object id0 = jformOrderMain2.getId();
		//===================================================================================
		//查询-订单机票信息
	    String hql0 = "from JformOrderTicket2Entity where 1 = 1 AND fCK_ID = ? ";
	    try{
	    	List<JformOrderTicket2Entity> jformOrderTicket2EntityList = systemService.findHql(hql0,id0);
			req.setAttribute("jformOrderTicket2List", jformOrderTicket2EntityList);
		}catch(Exception e){
			logger.info(e.getMessage());
		}
		return new ModelAndView("com/jeecg/demo/jformOrderMain2/main/jformOrderTicket2");
	}
	/**
	 * 加载明细列表[订单客户信息]
	 * 
	 * @return
	 */
	@RequestMapping(params = "jformOrderCustomer2List")
	public ModelAndView jformOrderCustomer2List(JformOrderMain2Entity jformOrderMain2, HttpServletRequest req) {
	
		//===================================================================================
		//获取参数
		Object id1 = jformOrderMain2.getId();
		//===================================================================================
		//查询-订单客户信息
	    String hql1 = "from JformOrderCustomer2Entity where 1 = 1 AND fK_ID = ? ";
	    try{
	    	List<JformOrderCustomer2Entity> jformOrderCustomer2EntityList = systemService.findHql(hql1,id1);
			req.setAttribute("jformOrderCustomer2List", jformOrderCustomer2EntityList);
		}catch(Exception e){
			logger.info(e.getMessage());
		}
		return new ModelAndView("com/jeecg/demo/jformOrderMain2/main/jformOrderCustomer2");
	}

    /**
    * 导出excel
    *
    * @param request
    * @param response
    */
    @RequestMapping(params = "exportXls")
    public String exportXls(JformOrderMain2Entity jformOrderMain2,HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid,ModelMap map) {
    	CriteriaQuery cq = new CriteriaQuery(JformOrderMain2Entity.class, dataGrid);
    	//查询条件组装器
    	org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, jformOrderMain2);
    	try{
    	//自定义追加查询条件
    	}catch (Exception e) {
    		throw new BusinessException(e.getMessage());
    	}
    	cq.add();
    	List<JformOrderMain2Entity> list=this.jformOrderMain2Service.getListByCriteriaQuery(cq, false);
    	List<JformOrderMain2Page> pageList=new ArrayList<JformOrderMain2Page>();
        if(list!=null&&list.size()>0){
        	for(JformOrderMain2Entity entity:list){
        		try{
        		JformOrderMain2Page page=new JformOrderMain2Page();
        		   MyBeanUtils.copyBeanNotNull2Bean(entity,page);
            	    Object id0 = entity.getId();
				    String hql0 = "from JformOrderTicket2Entity where 1 = 1 AND fCK_ID = ? ";
        	        List<JformOrderTicket2Entity> jformOrderTicket2EntityList = systemService.findHql(hql0,id0);
            		page.setJformOrderTicket2List(jformOrderTicket2EntityList);
            	    Object id1 = entity.getId();
				    String hql1 = "from JformOrderCustomer2Entity where 1 = 1 AND fK_ID = ? ";
        	        List<JformOrderCustomer2Entity> jformOrderCustomer2EntityList = systemService.findHql(hql1,id1);
            		page.setJformOrderCustomer2List(jformOrderCustomer2EntityList);
            		pageList.add(page);
            	}catch(Exception e){
            		logger.info(e.getMessage());
            	}
            }
        }
        map.put(NormalExcelConstants.FILE_NAME,"订单主信息");
        map.put(NormalExcelConstants.CLASS,JformOrderMain2Page.class);
        map.put(NormalExcelConstants.PARAMS,new ExportParams("订单主信息列表", "导出人:Jeecg",
            "导出信息"));
        map.put(NormalExcelConstants.DATA_LIST,pageList);
        return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}

    /**
	 * 通过excel导入数据
	 * @param request
	 * @param
	 * @return
	 */
	@RequestMapping(params = "importExcel", method = RequestMethod.POST)
	@ResponseBody
	public AjaxJson importExcel(HttpServletRequest request, HttpServletResponse response) {
		AjaxJson j = new AjaxJson();
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();// 获取上传文件对象
			ImportParams params = new ImportParams();
			params.setTitleRows(2);
			params.setHeadRows(2);
			params.setNeedSave(true);
			try {
				List<JformOrderMain2Page> list =  ExcelImportUtil.importExcel(file.getInputStream(), JformOrderMain2Page.class, params);
				JformOrderMain2Entity entity1=null;
				for (JformOrderMain2Page page : list) {
					entity1=new JformOrderMain2Entity();
					MyBeanUtils.copyBeanNotNull2Bean(page,entity1);
		            jformOrderMain2Service.addMain(entity1, page.getJformOrderTicket2List(),page.getJformOrderCustomer2List());
				}
				j.setMsg("文件导入成功！");
			} catch (Exception e) {
				j.setMsg("文件导入失败！");
				logger.error(ExceptionUtil.getExceptionMessage(e));
			}finally{
				try {
					file.getInputStream().close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
			}
			return j;
	}
	/**
	* 导出excel 使模板
	*/
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(ModelMap map) {
		map.put(NormalExcelConstants.FILE_NAME,"订单主信息");
		map.put(NormalExcelConstants.CLASS,JformOrderMain2Page.class);
		map.put(NormalExcelConstants.PARAMS,new ExportParams("订单主信息列表", "导出人:"+ ResourceUtil.getSessionUser().getRealName(),
		"导出信息"));
		map.put(NormalExcelConstants.DATA_LIST,new ArrayList());
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	/**
	* 导入功能跳转
	*
	* @return
	*/
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		req.setAttribute("controller_name", "jformOrderMain2Controller");
		return new ModelAndView("common/upload/pub_excel_upload");
	}

 	
 	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody
	@ApiOperation(value="订单主信息列表信息",produces="application/json",httpMethod="GET")
	public ResponseMessage<List<JformOrderMain2Page>> list() {
		List<JformOrderMain2Entity> list= jformOrderMain2Service.getList(JformOrderMain2Entity.class);
    	List<JformOrderMain2Page> pageList=new ArrayList<JformOrderMain2Page>();
        if(list!=null&&list.size()>0){
        	for(JformOrderMain2Entity entity:list){
        		try{
        			JformOrderMain2Page page=new JformOrderMain2Page();
        		   MyBeanUtils.copyBeanNotNull2Bean(entity,page);
					Object id0 = entity.getId();
					Object id1 = entity.getId();
				     String hql0 = "from JformOrderTicket2Entity where 1 = 1 AND fCK_ID = ? ";
	    			List<JformOrderTicket2Entity> jformOrderTicket2OldList = this.jformOrderMain2Service.findHql(hql0,id0);
            		page.setJformOrderTicket2List(jformOrderTicket2OldList);
				     String hql1 = "from JformOrderCustomer2Entity where 1 = 1 AND fK_ID = ? ";
	    			List<JformOrderCustomer2Entity> jformOrderCustomer2OldList = this.jformOrderMain2Service.findHql(hql1,id1);
            		page.setJformOrderCustomer2List(jformOrderCustomer2OldList);
            		pageList.add(page);
            	}catch(Exception e){
            		logger.info(e.getMessage());
            	}
            }
        }
		return Result.success(pageList);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	@ApiOperation(value="根据ID获取订单主信息信息",notes="根据ID获取订单主信息信息",httpMethod="GET",produces="application/json")
	public ResponseMessage<?> get(@ApiParam(required=true,name="id",value="ID")@PathVariable("id") String id) {
		JformOrderMain2Entity task = jformOrderMain2Service.get(JformOrderMain2Entity.class, id);
		if (task == null) {
			return Result.error("根据ID获取订单主信息信息为空");
		}
		JformOrderMain2Page page = new JformOrderMain2Page();
		try {
			MyBeanUtils.copyBeanNotNull2Bean(task, page);
				Object id0 = task.getId();
				Object id1 = task.getId();
		    String hql0 = "from JformOrderTicket2Entity where 1 = 1 AND fCK_ID = ? ";
			List<JformOrderTicket2Entity> jformOrderTicket2OldList = this.jformOrderMain2Service.findHql(hql0,id0);
    		page.setJformOrderTicket2List(jformOrderTicket2OldList);
		    String hql1 = "from JformOrderCustomer2Entity where 1 = 1 AND fK_ID = ? ";
			List<JformOrderCustomer2Entity> jformOrderCustomer2OldList = this.jformOrderMain2Service.findHql(hql1,id1);
    		page.setJformOrderCustomer2List(jformOrderCustomer2OldList);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return Result.success(page);
	}
 	
 	@RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@ApiOperation(value="创建订单主信息")
	public ResponseMessage<?> create(@ApiParam(name="订单主信息对象")@RequestBody JformOrderMain2Page jformOrderMain2Page, UriComponentsBuilder uriBuilder) {
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<JformOrderMain2Page>> failures = validator.validate(jformOrderMain2Page);
		if (!failures.isEmpty()) {
			return Result.error(JSONArray.toJSONString(BeanValidators.extractPropertyAndMessage(failures)));
		}

		//保存
		List<JformOrderTicket2Entity> jformOrderTicket2List =  jformOrderMain2Page.getJformOrderTicket2List();
		List<JformOrderCustomer2Entity> jformOrderCustomer2List =  jformOrderMain2Page.getJformOrderCustomer2List();
		
		JformOrderMain2Entity jformOrderMain2 = new JformOrderMain2Entity();
		try{
			MyBeanUtils.copyBeanNotNull2Bean(jformOrderMain2Page,jformOrderMain2);
		}catch(Exception e){
            logger.info(e.getMessage());
            return Result.error("保存订单主信息失败");
        }
		jformOrderMain2Service.addMain(jformOrderMain2, jformOrderTicket2List,jformOrderCustomer2List);

		return Result.success(jformOrderMain2);
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	@ApiOperation(value="更新订单主信息",notes="更新订单主信息")
	public ResponseMessage<?> update(@RequestBody JformOrderMain2Page jformOrderMain2Page) {
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<JformOrderMain2Page>> failures = validator.validate(jformOrderMain2Page);
		if (!failures.isEmpty()) {
			return Result.error(JSONArray.toJSONString(BeanValidators.extractPropertyAndMessage(failures)));
		}

		//保存
		List<JformOrderTicket2Entity> jformOrderTicket2List =  jformOrderMain2Page.getJformOrderTicket2List();
		List<JformOrderCustomer2Entity> jformOrderCustomer2List =  jformOrderMain2Page.getJformOrderCustomer2List();
		
		JformOrderMain2Entity jformOrderMain2 = new JformOrderMain2Entity();
		try{
			MyBeanUtils.copyBeanNotNull2Bean(jformOrderMain2Page,jformOrderMain2);
		}catch(Exception e){
            logger.info(e.getMessage());
            return Result.error("订单主信息更新失败");
        }
		jformOrderMain2Service.updateMain(jformOrderMain2, jformOrderTicket2List,jformOrderCustomer2List);

		//按Restful约定，返回204状态码, 无内容. 也可以返回200状态码.
		return Result.success();
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.NO_CONTENT)
	@ApiOperation(value="删除订单主信息")
	public ResponseMessage<?> delete(@ApiParam(name="id",value="ID",required=true)@PathVariable("id") String id) {
		logger.info("delete[{}]" + id);
		// 验证
		if (StringUtils.isEmpty(id)) {
			return Result.error("ID不能为空");
		}
		try {
			JformOrderMain2Entity jformOrderMain2 = jformOrderMain2Service.get(JformOrderMain2Entity.class, id);
			jformOrderMain2Service.delMain(jformOrderMain2);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error("订单主信息删除失败");
		}

		return Result.success();
	}
}
