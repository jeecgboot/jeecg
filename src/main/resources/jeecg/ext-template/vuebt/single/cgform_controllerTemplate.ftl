<#if packageStyle == "service">
package ${bussiPackage}.${entityPackage}.controller;
import ${bussiPackage}.${entityPackage}.entity.${entityName}Entity;
import ${bussiPackage}.${entityPackage}.service.${entityName}ServiceI;
<#else>
package ${bussiPackage}.controller.${entityPackage};
import ${bussiPackage}.entity.${entityPackage}.${entityName}Entity;
import ${bussiPackage}.service.${entityPackage}.${entityName}ServiceI;
</#if>
import java.util.ArrayList;
import java.util.List;
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.common.TreeChildCount;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.core.util.MyBeanUtils;

import java.io.OutputStream;
import org.jeecgframework.core.util.BrowserUtils;
import org.jeecgframework.poi.excel.ExcelExportUtil;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.TemplateExportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.jeecgframework.poi.excel.entity.vo.TemplateExcelConstants;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.jeecgframework.core.util.ResourceUtil;
import java.io.IOException;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import java.util.Map;
import java.util.HashMap;
import org.jeecgframework.core.util.ExceptionUtil;
<#if cgformConfig.supportRestful?? && cgformConfig.supportRestful == "1">
<#-- restful 通用方法生成 -->
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
import org.apache.commons.lang3.StringUtils;
import org.jeecgframework.jwt.util.GsonUtil;
import org.jeecgframework.jwt.util.ResponseMessage;
import org.jeecgframework.jwt.util.Result;
import com.alibaba.fastjson.JSONArray;
<#-- restful 通用方法生成 -->

<#-- swagger api  start -->
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiParam;
<#-- swagger api end -->
</#if>
<#-- 列为文件类型的文件代码生成 -->
<#assign fileFlag = false />
<#list columns as filePo>
<#-- update--begin--author:gj_shaojc date:20180302 for：TASK #2551 【bug】网友问题验证确认 -->
	<#if filePo.showType=='file'  || filePo.showType == 'image'>
<#-- update--end--author:gj_shaojc date:20180302 for：TASK #2551 【bug】网友问题验证确认 -->
		<#assign fileFlag = true />
	</#if>
</#list>

<#if fileFlag==true>
import org.jeecgframework.web.cgform.entity.upload.CgUploadEntity;
import org.jeecgframework.web.cgform.service.config.CgFormFieldServiceI;
import java.util.HashMap;
</#if>
<#-- 列为文件类型的文件代码生成 -->
/**   
 * @Title: Controller  
 * @Description: ${ftl_description}
 * @author onlineGenerator
 * @date ${ftl_create_time}
 * @version V1.0   
 *
 */
@Controller
@RequestMapping("/${entityName?uncap_first}Controller")
<#if cgformConfig.supportRestful?? && cgformConfig.supportRestful == "1">
<#-- update--begin--author:zhangjiaqiang date:20171031 for:API 注解 start -->
@Api(value="${entityName}",description="${ftl_description}",tags="${entityName?uncap_first}Controller")
<#-- update--end--author:zhangjiaqiang date:20171031 for:API 注解 start -->
</#if>
public class ${entityName}Controller extends BaseController {
	private static final Logger logger = LoggerFactory.getLogger(${entityName}Controller.class);

	@Autowired
	private ${entityName}ServiceI ${entityName?uncap_first}Service;
	@Autowired
	private SystemService systemService;
	<#-- restful 通用方法生成 -->
	<#if cgformConfig.supportRestful?? && cgformConfig.supportRestful == "1">
	@Autowired
	private Validator validator;
	</#if>
	<#-- restful 通用方法生成 -->
	
	<#-- 列为文件类型的文件代码生成 -->
	<#if fileFlag==true>
	@Autowired
	private CgFormFieldServiceI cgFormFieldService;
	</#if>
	<#-- 列为文件类型的文件代码生成 -->
	


	/**
	 * ${ftl_description}列表 页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "list")
	public ModelAndView list(HttpServletRequest request) {
		return new ModelAndView("${bussiPackage?replace(".","/")}/${entityPackage}/${entityName?uncap_first}List");
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
	public void datagrid(${entityName}Entity ${entityName?uncap_first},HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
		CriteriaQuery cq = new CriteriaQuery(${entityName}Entity.class, dataGrid);
		<#if cgformConfig.cgFormHead.isTree == 'Y'>
		if(StringUtil.isEmpty(${entityName?uncap_first}.getId())){
			cq.isNull("${cgformConfig.cgFormHead.treeParentIdFieldNamePage}");
		}else{
			cq.eq("${cgformConfig.cgFormHead.treeParentIdFieldNamePage}", ${entityName?uncap_first}.getId());
			${entityName?uncap_first}.setId(null);
		}
		</#if>
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, ${entityName?uncap_first}, request.getParameterMap());
		try{
		//自定义追加查询条件
		}catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
		cq.add();
		this.${entityName?uncap_first}Service.getDataGridReturn(cq, true);
		<#if cgformConfig.cgFormHead.isTree == 'Y'>
		TagUtil.treegrid(response, dataGrid);
		<#else>
		TagUtil.datagrid(response, dataGrid);
		</#if>
	}
	
	/**
	 * 删除${ftl_description}
	 * 
	 * @return
	 */
	@RequestMapping(params = "doDel")
	@ResponseBody
	public AjaxJson doDel(${entityName}Entity ${entityName?uncap_first}, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		${entityName?uncap_first} = systemService.getEntity(${entityName}Entity.class, ${entityName?uncap_first}.getId());
		message = "${ftl_description}删除成功";
		try{
			${entityName?uncap_first}Service.delete(${entityName?uncap_first});
			systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "${ftl_description}删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 批量删除${ftl_description}
	 * 
	 * @return
	 */
	 @RequestMapping(params = "doBatchDel")
	@ResponseBody
	public AjaxJson doBatchDel(String ids,HttpServletRequest request){
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "${ftl_description}删除成功";
		try{
			for(String id:ids.split(",")){
				${entityName}Entity ${entityName?uncap_first} = systemService.getEntity(${entityName}Entity.class, 
				<#if cgformConfig.cgFormHead.jformPkType?if_exists?html == "UUID">
				id
				<#elseif cgformConfig.cgFormHead.jformPkType?if_exists?html == "NATIVE">
				Integer.parseInt(id)
				<#elseif cgformConfig.cgFormHead.jformPkType?if_exists?html == "SEQUENCE">
				Integer.parseInt(id)
				<#else>
				id
				</#if>
				);
				${entityName?uncap_first}Service.delete(${entityName?uncap_first});
				systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
			}
		}catch(Exception e){
			e.printStackTrace();
			message = "${ftl_description}删除失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加${ftl_description}
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doAdd")
	@ResponseBody
	public AjaxJson doAdd(${entityName}Entity ${entityName?uncap_first}, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "${ftl_description}添加成功";
		try{
			<#if cgformConfig.cgFormHead.isTree == 'Y'>
			if(StringUtil.isEmpty(${entityName?uncap_first}.get${cgformConfig.cgFormHead.treeParentIdFieldNamePage?cap_first}())){
				${entityName?uncap_first}.set${cgformConfig.cgFormHead.treeParentIdFieldNamePage?cap_first}(null);
			}
			</#if>
			${entityName?uncap_first}Service.save(${entityName?uncap_first});
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "${ftl_description}添加失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		<#-- 列为文件类型的文件代码生成 -->
		<#if fileFlag==true>
		j.setObj(${entityName?uncap_first});
		</#if>
		<#-- 列为文件类型的文件代码生成 -->
		return j;
	}
	
	/**
	 * 更新${ftl_description}
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "doUpdate")
	@ResponseBody
	public AjaxJson doUpdate(${entityName}Entity ${entityName?uncap_first}, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "${ftl_description}更新成功";
		${entityName}Entity t = ${entityName?uncap_first}Service.get(${entityName}Entity.class, ${entityName?uncap_first}.getId());
		try {
			MyBeanUtils.copyBeanNotNull2Bean(${entityName?uncap_first}, t);
			<#if cgformConfig.cgFormHead.isTree == 'Y'>
			if(StringUtil.isEmpty(t.get${cgformConfig.cgFormHead.treeParentIdFieldNamePage?cap_first}())){
				t.set${cgformConfig.cgFormHead.treeParentIdFieldNamePage?cap_first}(null);
			}
			</#if>
			${entityName?uncap_first}Service.saveOrUpdate(t);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} catch (Exception e) {
			e.printStackTrace();
			message = "${ftl_description}更新失败";
			throw new BusinessException(e.getMessage());
		}
		j.setMsg(message);
		return j;
	}
	
	<#list buttons as btn>
 	<#if btn.optType=='action'>
 	/**
	 * 自定义按钮-[${btn.buttonName}]业务
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "do${btn.buttonCode?cap_first}")
	@ResponseBody
	public AjaxJson do${btn.buttonCode?cap_first}(${entityName}Entity ${entityName?uncap_first}, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "${btn.buttonName}成功";
		${entityName}Entity t = ${entityName?uncap_first}Service.get(${entityName}Entity.class, ${entityName?uncap_first}.getId());
		try{
			${entityName?uncap_first}Service.do${btn.buttonCode?cap_first}Bus(t);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		}catch(Exception e){
			e.printStackTrace();
			message = "${btn.buttonName}失败";
		}
		j.setMsg(message);
		return j;
	}
 	</#if>
 	</#list> 

	/**
	 * ${ftl_description}新增页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goAdd")
	public ModelAndView goAdd(${entityName}Entity ${entityName?uncap_first}, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(${entityName?uncap_first}.getId())) {
			${entityName?uncap_first} = ${entityName?uncap_first}Service.getEntity(${entityName}Entity.class, ${entityName?uncap_first}.getId());
			req.setAttribute("${entityName?uncap_first}Page", ${entityName?uncap_first});
		}
		return new ModelAndView("${bussiPackage?replace(".","/")}/${entityPackage}/${entityName?uncap_first}-add");
	}
	/**
	 * ${ftl_description}编辑页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "goUpdate")
	public ModelAndView goUpdate(${entityName}Entity ${entityName?uncap_first}, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(${entityName?uncap_first}.getId())) {
			${entityName?uncap_first} = ${entityName?uncap_first}Service.getEntity(${entityName}Entity.class, ${entityName?uncap_first}.getId());
			req.setAttribute("${entityName?uncap_first}Page", ${entityName?uncap_first});
		}
		return new ModelAndView("${bussiPackage?replace(".","/")}/${entityPackage}/${entityName?uncap_first}-update");
	}
	
	/**
	 * ${ftl_description} 根据ID查询数据
	 * 
	 * @return
	 */
	@RequestMapping(params = "getById")
	@ResponseBody
	public AjaxJson getById(${entityName}Entity ${entityName?uncap_first}, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		message = "${ftl_description}查询成功";
		if (StringUtil.isNotEmpty(${entityName?uncap_first}.getId())) {
			${entityName?uncap_first} = ${entityName?uncap_first}Service.getEntity(${entityName}Entity.class, ${entityName?uncap_first}.getId());
			j.setObj(${entityName?uncap_first});
		}else{
			message = "该条数据不存在！";
		}
		j.setMsg(message);
		return j;
	}
	
	/**
	 * 导入功能跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "upload")
	public ModelAndView upload(HttpServletRequest req) {
		req.setAttribute("controller_name","${entityName?uncap_first}Controller");
		return new ModelAndView("common/upload/pub_excel_upload");
	}
	
	/**
	 * 导出excel
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXls")
	public String exportXls(${entityName}Entity ${entityName?uncap_first},HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
		CriteriaQuery cq = new CriteriaQuery(${entityName}Entity.class, dataGrid);
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, ${entityName?uncap_first}, request.getParameterMap());
		List<${entityName}Entity> ${entityName?uncap_first}s = this.${entityName?uncap_first}Service.getListByCriteriaQuery(cq,false);
		modelMap.put(NormalExcelConstants.FILE_NAME,"${ftl_description}");
		modelMap.put(NormalExcelConstants.CLASS,${entityName}Entity.class);
		modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("${ftl_description}列表", "导出人:"+ResourceUtil.getSessionUser().getRealName(),
			"导出信息"));
		modelMap.put(NormalExcelConstants.DATA_LIST,${entityName?uncap_first}s);
		return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	/**
	 * 导出excel 使模板
	 * 
	 * @param request
	 * @param response
	 */
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(${entityName}Entity ${entityName?uncap_first},HttpServletRequest request,HttpServletResponse response
			, DataGrid dataGrid,ModelMap modelMap) {
    	modelMap.put(NormalExcelConstants.FILE_NAME,"${ftl_description}");
    	modelMap.put(NormalExcelConstants.CLASS,${entityName}Entity.class);
    	modelMap.put(NormalExcelConstants.PARAMS,new ExportParams("${ftl_description}列表", "导出人:"+ResourceUtil.getSessionUser().getRealName(),
    	"导出信息"));
    	modelMap.put(NormalExcelConstants.DATA_LIST,new ArrayList());
    	return NormalExcelConstants.JEECG_EXCEL_VIEW;
	}
	
	@SuppressWarnings("unchecked")
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
			params.setHeadRows(1);
			params.setNeedSave(true);
			try {
				List<${entityName}Entity> list${entityName}Entitys = ExcelImportUtil.importExcel(file.getInputStream(),${entityName}Entity.class,params);
				for (${entityName}Entity ${entityName?uncap_first} : list${entityName}Entitys) {
					${entityName?uncap_first}Service.save(${entityName?uncap_first});
				}
				j.setMsg("文件导入成功！");
			} catch (Exception e) {
				j.setMsg("文件导入失败！");
				logger.error(e.getMessage());
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
	
	<#-- 列为文件类型的文件代码生成 -->
	<#if fileFlag==true>
	/**
	 * 获取文件附件信息
	 * 
	 * @param id ${entityName?uncap_first}主键id
	 */
	@RequestMapping(params = "getFiles")
	@ResponseBody
	public AjaxJson getFiles(String id){
		List<CgUploadEntity> uploadBeans = cgFormFieldService.findByProperty(CgUploadEntity.class, "cgformId", id);
		List<Map<String,Object>> files = new ArrayList<Map<String,Object>>(0);
		for(CgUploadEntity b:uploadBeans){
			String title = b.getAttachmenttitle();//附件名
			String fileKey = b.getId();//附件主键
			String path = b.getRealpath();//附件路径
			String field = b.getCgformField();//表单中作为附件控件的字段
			Map<String, Object> file = new HashMap<String, Object>();
			file.put("title", title);
			file.put("fileKey", fileKey);
			file.put("path", path);
			file.put("field", field==null?"":field);
			files.add(file);
		}
		AjaxJson j = new AjaxJson();
		j.setObj(files);
		return j;
	}
	</#if>
	<#-- 列为文件类型的文件代码生成 -->
	
	<#if cgformConfig.supportRestful?? && cgformConfig.supportRestful == "1">
	<#-- update--begin--author:zhangjiaqiang date:20171113 for:TASK #2415 【restful接口模板】模板再次改造，封装了通用了返回结果，加了必要校验 -->
	<#-- restful 通用方法生成 -->
	<#-- update-begin-Author:LiShaoQing Date:20180828 for: TASK #3105 【代码生成器】代码生成rest接口 list获取改造 -->
	@RequestMapping(value="/list/{pageNo}/{pageSize}", method = RequestMethod.GET)
	@ResponseBody
	<#-- update--begin--author:zhangjiaqiang date:20171031 for:TASK #2397 【新功能】代码生成器模板修改，追加swagger-ui注解 -->
	@ApiOperation(value="${ftl_description}列表信息",produces="application/json",httpMethod="GET")
	<#-- update--end--author:zhangjiaqiang date:20171031 for:TASK #2397 【新功能】代码生成器模板修改，追加swagger-ui注解 -->
	public ResponseMessage<List<${entityName}Entity>> list(@PathVariable("pageNo") int pageNo, @PathVariable("pageSize") int pageSize, HttpServletRequest request) {
		if(pageSize > Globals.MAX_PAGESIZE){
			return Result.error("每页请求不能超过" + Globals.MAX_PAGESIZE + "条");
		}
		CriteriaQuery query = new CriteriaQuery(${entityName}Entity.class);
		query.setCurPage(pageNo<=0?1:pageNo);
		query.setPageSize(pageSize<1?1:pageSize);
		List<${entityName}Entity> list${entityName}s = this.${entityName?uncap_first}Service.getListByCriteriaQuery(query,true);
		return Result.success(list${entityName}s);
	}
	<#-- update-end-Author:LiShaoQing Date:20180828 for: TASK #3105 【代码生成器】代码生成rest接口 list获取改造 -->
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	<#-- update--begin--author:zhangjiaqiang date:20171031 for:TASK #2397 【新功能】代码生成器模板修改，追加swagger-ui注解 -->
	@ApiOperation(value="根据ID获取${ftl_description}信息",notes="根据ID获取${ftl_description}信息",httpMethod="GET",produces="application/json")
	<#-- update--end--author:zhangjiaqiang date:20171031 for:TASK #2397 【新功能】代码生成器模板修改，追加swagger-ui注解 -->
	public ResponseMessage<?> get(@ApiParam(required=true,name="id",value="ID")@PathVariable("id") String id) {
		${entityName}Entity task = ${entityName?uncap_first}Service.get(${entityName}Entity.class, id);
		if (task == null) {
			return Result.error("根据ID获取${ftl_description}信息为空");
		}
		return Result.success(task);
	}

	@RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	<#-- update--begin--author:zhangjiaqiang date:20171031 for:TASK #2397 【新功能】代码生成器模板修改，追加swagger-ui注解 -->
	@ApiOperation(value="创建${ftl_description}")
	public ResponseMessage<?> create(@ApiParam(name="${ftl_description}对象")@RequestBody ${entityName}Entity ${entityName?uncap_first}, UriComponentsBuilder uriBuilder) {
		<#-- update--end--author:zhangjiaqiang date:20171031 for:TASK #2397 【新功能】代码生成器模板修改，追加swagger-ui注解 -->
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<${entityName}Entity>> failures = validator.validate(${entityName?uncap_first});
		if (!failures.isEmpty()) {
			return Result.error(JSONArray.toJSONString(BeanValidators.extractPropertyAndMessage(failures)));
		}

		//保存
		try{
			${entityName?uncap_first}Service.save(${entityName?uncap_first});
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error("${ftl_description}信息保存失败");
		}
		return Result.success(${entityName?uncap_first});
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	<#-- update--begin--author:zhangjiaqiang date:20171031 for:TASK #2397 【新功能】代码生成器模板修改，追加swagger-ui注解 -->
	@ApiOperation(value="更新${ftl_description}",notes="更新${ftl_description}")
	<#-- update--end--author:zhangjiaqiang date:20171031 for:TASK #2397 【新功能】代码生成器模板修改，追加swagger-ui注解 -->
	public ResponseMessage<?> update(@ApiParam(name="${ftl_description}对象")@RequestBody ${entityName}Entity ${entityName?uncap_first}) {
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<${entityName}Entity>> failures = validator.validate(${entityName?uncap_first});
		if (!failures.isEmpty()) {
			return Result.error(JSONArray.toJSONString(BeanValidators.extractPropertyAndMessage(failures)));
		}

		//保存
		try{
			${entityName?uncap_first}Service.saveOrUpdate(${entityName?uncap_first});
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error("更新${ftl_description}信息失败");
		}

		//按Restful约定，返回204状态码, 无内容. 也可以返回200状态码.
		return Result.success("更新${ftl_description}信息成功");
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.NO_CONTENT)
	<#-- update--begin--author:zhangjiaqiang date:20171031 for:TASK #2397 【新功能】代码生成器模板修改，追加swagger-ui注解 -->
	@ApiOperation(value="删除${ftl_description}")
	<#-- update--begin--author:zhangjiaqiang date:20171031 for:TASK #2397 【新功能】代码生成器模板修改，追加swagger-ui注解 -->
	public ResponseMessage<?> delete(@ApiParam(name="id",value="ID",required=true)@PathVariable("id") String id) {
		logger.info("delete[{}]" , id);
		// 验证
		if (StringUtils.isEmpty(id)) {
			return Result.error("ID不能为空");
		}
		try {
			${entityName?uncap_first}Service.deleteEntityById(${entityName}Entity.class, id);
		} catch (Exception e) {
			e.printStackTrace();
			return Result.error("${ftl_description}删除失败");
		}

		return Result.success();
	}
	<#-- restful 通用方法生成 -->
	<#-- update--end--author:zhangjiaqiang date:20171113 for:TASK #2415 【restful接口模板】模板再次改造，封装了通用了返回结果，加了必要校验 -->
	</#if>
}
