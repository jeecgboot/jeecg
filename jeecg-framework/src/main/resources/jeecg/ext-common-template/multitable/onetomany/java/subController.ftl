<#list subtables as key>
#segment#${subsG['${key}'].entityName}Controller.java
package ${bussiPackage}.${subsG['${key}'].entityPackage}.controller;

import ${bussiPackage}.${subsG['${key}'].entityPackage}.entity.${subsG['${key}'].entityName}Entity;
import ${bussiPackage}.${entityPackage}.service.${entityName}ServiceI;

import java.util.ArrayList;
import java.util.List; 
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.ExceptionUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import java.io.IOException;
import java.util.Map;

<#-- restful 通用方法生成 -->
import org.apache.commons.lang3.StringUtils;
import org.jeecgframework.jwt.util.GsonUtil;
import org.jeecgframework.jwt.util.ResponseMessage;
import org.jeecgframework.jwt.util.Result;
import com.alibaba.fastjson.JSONArray;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.jeecgframework.core.beanvalidator.BeanValidators;
import java.util.Set;
import javax.validation.ConstraintViolation;
import javax.validation.Validator;
import java.net.URI;
import org.springframework.http.MediaType;
import org.springframework.web.util.UriComponentsBuilder;
<#-- restful 通用方法生成 -->

<#-- swagger api  start -->
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
<#-- swagger api end -->

/**   
 * @Title: controller
 * @Description: ${subsG['${key}'].ftlDescription}
 * @author onlineGenerator
 * @date ${ftl_create_time}
 * @version V1.0   
 *
 */

@Api(value="${subsG['${key}'].entityName}",description="${subsG['${key}'].ftlDescription}",tags="${subsG['${key}'].entityName?uncap_first}Controller")
@Controller
@RequestMapping("/${subsG['${key}'].entityName?uncap_first}Controller")
public class ${subsG['${key}'].entityName}Controller extends BaseController {
	
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(${subsG['${key}'].entityName}Controller.class);

	@Autowired
	private ${entityName}ServiceI ${entityName?uncap_first}Service;
	@Autowired
	private SystemService systemService;
	@Autowired
	private Validator validator;

	/**
	 * ${subsG['${key}'].ftlDescription}列表 页面跳转
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("${bussiPackage?replace(".","/")}/${subsG['${key}'].entityPackage}/${subsG['${key}'].entityName?uncap_first}-list");
	}


	/**
	 * easyui AJAX请求数据
	 * @param request
	 * @param response
	 * @param dataGrid
	 * @param user
	 */
	@RequestMapping(params = "datagrid")
	public void datagrid(${subsG['${key}'].entityName}Entity ${subsG['${key}'].entityName?uncap_first},HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(${subsG['${key}'].entityName}Entity.class, dataGrid);
		String mainId = request.getParameter("mainId");
		if(oConvertUtils.isNotEmpty(mainId)){
			//查询条件组装器
			org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, ${subsG['${key}'].entityName?uncap_first});
			try{
			//自定义追加查询条件
			<#list subColumnsMap['${key}'] as po>
			<#if po.isQuery =='Y' && po.queryMode =='group'>
			String query_${po.fieldName}_begin = request.getParameter("${po.fieldName}_begin");
			String query_${po.fieldName}_end = request.getParameter("${po.fieldName}_end");
			<#-- update--begin--author:zhoujf date:20180316 for:TASK #2557 范围查询double字段错误 -->
			if(StringUtil.isNotEmpty(query_${po.fieldName}_begin)){
				<#if po.type == "java.util.Date">
				cq.ge("${po.fieldName}", new SimpleDateFormat("yyyy-MM-dd").parse(query_${po.fieldName}_begin));
				<#elseif po.type == "java.lang.Double">
				cq.ge("${po.fieldName}", Double.parseDouble(query_${po.fieldName}_begin));
				<#else>
				cq.ge("${po.fieldName}", Integer.parseInt(query_${po.fieldName}_begin));
				</#if>
			}
			if(StringUtil.isNotEmpty(query_${po.fieldName}_end)){
				<#if po.type == "java.util.Date">
				cq.le("${po.fieldName}", new SimpleDateFormat("yyyy-MM-dd").parse(query_${po.fieldName}_end));
				<#elseif po.type == "java.lang.Double">
				cq.le("${po.fieldName}", Double.parseDouble(query_${po.fieldName}_end));
				<#else>
				cq.le("${po.fieldName}", Integer.parseInt(query_${po.fieldName}_end));
				</#if>
			}
			<#-- update--end--author:zhoujf date:20180316 for:TASK #2557 范围查询double字段错误 -->
			</#if>
			</#list> 
			
		    <#list subsG['${key}'].foreignKeys as fk>
			 	cq.eq("${fk?uncap_first}", mainId);
		    <#break>
		    </#list>
				
			}catch (Exception e) {
				throw new BusinessException(e.getMessage());
			}
			cq.add();
			this.${entityName?uncap_first}Service.getDataGridReturn(cq, true);
		}
		TagUtil.datagrid(response, dataGrid);
	}
	
	/**
	 * 删除${subsG['${key}'].ftlDescription}
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(${subsG['${key}'].entityName}Entity ${subsG['${key}'].entityName?uncap_first}, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		${subsG['${key}'].entityName?uncap_first} = systemService.getEntity(${subsG['${key}'].entityName}Entity.class, ${subsG['${key}'].entityName?uncap_first}.getId());
		String message = "${subsG['${key}'].ftlDescription}删除成功";
		try{
			if(${subsG['${key}'].entityName?uncap_first}!=null){
				${entityName?uncap_first}Service.delete(${subsG['${key}'].entityName?uncap_first});
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "${subsG['${key}'].ftlDescription}删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除${subsG['${key}'].ftlDescription}
	 * @return
	 */
	@RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		AjaxJson j = new AjaxJson();
		String message = "${subsG['${key}'].ftlDescription}删除成功";
		try{
			for(String id:ids.split(",")){
				${subsG['${key}'].entityName}Entity ${subsG['${key}'].entityName?uncap_first} = systemService.getEntity(${subsG['${key}'].entityName}Entity.class,
				<#if subsG['${key}'].cgFormHead.jformPkType?if_exists?html == "UUID">
				id
				<#elseif subsG['${key}'].cgFormHead.jformPkType?if_exists?html == "NATIVE">
				Integer.parseInt(id)
				<#elseif subsG['${key}'].cgFormHead.jformPkType?if_exists?html == "SEQUENCE">
				Integer.parseInt(id)
				<#else>
				id
				</#if>
				);
				if(${subsG['${key}'].entityName?uncap_first}!=null){
					${entityName?uncap_first}Service.delete(${subsG['${key}'].entityName?uncap_first});
					systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
				}
				
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "${subsG['${key}'].ftlDescription}删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 添加${subsG['${key}'].ftlDescription}
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(${subsG['${key}'].entityName}Entity ${subsG['${key}'].entityName?uncap_first}, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String message = "添加成功";
		try{
			${entityName?uncap_first}Service.save(${subsG['${key}'].entityName?uncap_first});
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "${subsG['${key}'].ftlDescription}添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 更新${subsG['${key}'].ftlDescription}
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(${subsG['${key}'].entityName}Entity ${subsG['${key}'].entityName?uncap_first}, HttpServletRequest request) {
		AjaxJson j = new AjaxJson();
		String message = "更新成功";
		${subsG['${key}'].entityName}Entity t = ${entityName?uncap_first}Service.get(${subsG['${key}'].entityName}Entity.class,${subsG['${key}'].entityName?uncap_first}.getId());
		try{
			MyBeanUtils.copyBeanNotNull2Bean(${subsG['${key}'].entityName?uncap_first}, t);
			${entityName?uncap_first}Service.saveOrUpdate(t);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "${subsG['${key}'].ftlDescription}更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	
	/**
	 * ${subsG['${key}'].ftlDescription}新增页面跳转
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(${subsG['${key}'].entityName}Entity ${subsG['${key}'].entityName?uncap_first}, HttpServletRequest request){
		if (StringUtil.isNotEmpty(${subsG['${key}'].entityName?uncap_first}.getId())) {
			${subsG['${key}'].entityName?uncap_first} = ${entityName?uncap_first}Service.getEntity(${subsG['${key}'].entityName}Entity.class, ${subsG['${key}'].entityName?uncap_first}.getId());
			request.setAttribute("${subsG['${key}'].entityName?uncap_first}Page", ${subsG['${key}'].entityName?uncap_first});
		}
		request.setAttribute("mainId", request.getParameter("mainId"));
		return new ModelAndView("${bussiPackage?replace(".","/")}/${subsG['${key}'].entityPackage}/${subsG['${key}'].entityName?uncap_first}-add");
	}
	/**
	 * ${subsG['${key}'].ftlDescription}编辑页面跳转
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(${subsG['${key}'].entityName}Entity ${subsG['${key}'].entityName?uncap_first}, HttpServletRequest request){
		if (StringUtil.isNotEmpty(${subsG['${key}'].entityName?uncap_first}.getId())) {
			${subsG['${key}'].entityName?uncap_first} = ${entityName?uncap_first}Service.getEntity(${subsG['${key}'].entityName}Entity.class, ${subsG['${key}'].entityName?uncap_first}.getId());
			request.setAttribute("${subsG['${key}'].entityName?uncap_first}Page", ${subsG['${key}'].entityName?uncap_first});
		}
		return new ModelAndView("${bussiPackage?replace(".","/")}/${subsG['${key}'].entityPackage}/${subsG['${key}'].entityName?uncap_first}-update");
	}
}
</#list>