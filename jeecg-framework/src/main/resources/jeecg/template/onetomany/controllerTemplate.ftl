package ${bussiPackage}.controller.${entityPackage};
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.pojo.base.TSDepart;
import org.jeecgframework.web.system.service.SystemService;
import org.jeecgframework.core.util.MyBeanUtils;

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
<#-- restful 通用方法生成 -->

import ${bussiPackage}.entity.${entityPackage}.${entityName}Entity;
import ${bussiPackage}.page.${entityPackage}.${entityName}Page;
import ${bussiPackage}.service.${entityPackage}.${entityName}ServiceI;
<#list subTab as sub>
import ${bussiPackage}.entity.${sub.entityPackage}.${sub.entityName}Entity;
</#list>
/**   
 * @Title: Controller
 * @Description: ${ftl_description}
 * @author zhangdaihao
 * @date ${ftl_create_time}
 * @version V1.0   
 *
 */
@Controller
@RequestMapping("/${entityName?uncap_first}Controller")
public class ${entityName}Controller extends BaseController {
	/**
	 * Logger for this class
	 */
	private static final Logger logger = Logger.getLogger(${entityName}Controller.class);

	@Autowired
	private ${entityName}ServiceI ${entityName?uncap_first}Service;
	@Autowired
	private SystemService systemService;
	<#-- restful 通用方法生成 -->
	@Autowired
	private Validator validator;
	<#-- restful 通用方法生成 -->
	
	
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
		//查询条件组装器
		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, ${entityName?uncap_first});
		this.${entityName?uncap_first}Service.getDataGridReturn(cq, true);
		TagUtil.datagrid(response, dataGrid);
	}

	/**
	 * 删除${ftl_description}
	 * 
	 * @return
	 */
	@RequestMapping(params = "del")
	@ResponseBody
	public AjaxJson del(${entityName}Entity ${entityName?uncap_first}, HttpServletRequest request) {
		String message = null;
		AjaxJson j = new AjaxJson();
		${entityName?uncap_first} = systemService.getEntity(${entityName}Entity.class, ${entityName?uncap_first}.getId());
		message = "删除成功";
		${entityName?uncap_first}Service.delete(${entityName?uncap_first});
		systemService.addLog(message, Globals.Log_Type_DEL, Globals.Log_Leavel_INFO);
		
		j.setMsg(message);
		return j;
	}


	/**
	 * 添加${ftl_description}
	 * 
	 * @param ids
	 * @return
	 */
	@RequestMapping(params = "save")
	@ResponseBody
	public AjaxJson save(${entityName}Entity ${entityName?uncap_first},${entityName}Page ${entityName?uncap_first}Page, HttpServletRequest request) {
		String message = null;
		<#list subTab as sub>
		List<${sub.entityName}Entity> ${sub.entityName?uncap_first}List =  ${entityName?uncap_first}Page.get${sub.entityName}List();
		</#list>
		AjaxJson j = new AjaxJson();
		if (StringUtil.isNotEmpty(${entityName?uncap_first}.getId())) {
			message = "更新成功";
			${entityName?uncap_first}Service.updateMain(${entityName?uncap_first}, <#list subTab as sub>${sub.entityName?uncap_first}List<#if sub_has_next>,</#if></#list>);
			systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
		} else {
			message = "添加成功";
			${entityName?uncap_first}Service.addMain(${entityName?uncap_first}, <#list subTab as sub>${sub.entityName?uncap_first}List<#if sub_has_next>,</#if></#list>);
			systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
		}
		j.setMsg(message);
		return j;
	}

	/**
	 * ${ftl_description}列表页面跳转
	 * 
	 * @return
	 */
	@RequestMapping(params = "addorupdate")
	public ModelAndView addorupdate(${entityName}Entity ${entityName?uncap_first}, HttpServletRequest req) {
		if (StringUtil.isNotEmpty(${entityName?uncap_first}.getId())) {
			${entityName?uncap_first} = ${entityName?uncap_first}Service.getEntity(${entityName}Entity.class, ${entityName?uncap_first}.getId());
			req.setAttribute("${entityName?uncap_first}Page", ${entityName?uncap_first});
		}
		return new ModelAndView("${bussiPackage?replace(".","/")}/${entityPackage}/${entityName?uncap_first}");
	}
	
	
	<#list subTab as sub>
	/**
	 * 加载明细列表[${sub.ftlDescription}]
	 * 
	 * @return
	 */
	@RequestMapping(params = "${sub.entityName?uncap_first}List")
	public ModelAndView ${sub.entityName?uncap_first}List(${entityName}Entity ${entityName?uncap_first}, HttpServletRequest req) {
	
		//===================================================================================
		//获取参数
		<#list sub.foreignKeys as key>
		    <#if key?lower_case?index_of("${jeecg_table_id}")!=-1>
		Object ${jeecg_table_id}${sub_index} = ${entityName?uncap_first}.get${jeecg_table_id?cap_first}();
		    <#else>
		Object ${key?uncap_first}${sub_index} = ${entityName?uncap_first}.get${key}();
		    </#if>
	    </#list>
		//===================================================================================
		//查询-${sub.ftlDescription}
	    String hql${sub_index} = "from ${sub.entityName}Entity where 1 = 1<#list sub.foreignKeys as key> AND ${key?uncap_first} = ? </#list>";
		try{
		    List<${sub.entityName}Entity> ${sub.entityName?uncap_first}EntityList = systemService.findHql(hql${sub_index},<#list sub.foreignKeys as key><#if key?lower_case?index_of("${jeecg_table_id}")!=-1>${jeecg_table_id}${sub_index}<#else>${key?uncap_first}${sub_index}</#if><#if key_has_next>,</#if></#list>);
			req.setAttribute("${sub.entityName?uncap_first}List", ${sub.entityName?uncap_first}EntityList);
		}catch(Exception e){
			logger.info(e.getMessage());
		}
		return new ModelAndView("${bussiPackage?replace(".","/")}/${entityPackage}/${sub.entityName?uncap_first}List");
	}
	</#list>
	
	<#-- restful 通用方法生成 -->
	@RequestMapping(method = RequestMethod.GET)
	@ResponseBody
	public List<${entityName}Entity> list() {
		List<${entityName}Entity> list${entityName}s=${entityName?uncap_first}Service.getList(${entityName}Entity.class);
		return list${entityName}s;
	}
	
	@RequestMapping(value = "/{id}", method = RequestMethod.GET)
	@ResponseBody
	public ResponseEntity<?> get(@PathVariable("id") String id) {
		${entityName}Entity task = ${entityName?uncap_first}Service.get(${entityName}Entity.class, id);
		if (task == null) {
			return new ResponseEntity(HttpStatus.NOT_FOUND);
		}
		return new ResponseEntity(task, HttpStatus.OK);
	}

	@RequestMapping(method = RequestMethod.POST, consumes = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public ResponseEntity<?> create(@RequestBody ${entityName}Entity ${entityName?uncap_first}, UriComponentsBuilder uriBuilder) {
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<${entityName}Entity>> failures = validator.validate(${entityName?uncap_first});
		if (!failures.isEmpty()) {
			return new ResponseEntity(BeanValidators.extractPropertyAndMessage(failures), HttpStatus.BAD_REQUEST);
		}

		//保存
		${entityName?uncap_first}Service.save(${entityName?uncap_first});

		//按照Restful风格约定，创建指向新任务的url, 也可以直接返回id或对象.
		String id = ${entityName?uncap_first}.getId();
		URI uri = uriBuilder.path("/rest/${entityName?uncap_first}Controller/" + id).build().toUri();
		HttpHeaders headers = new HttpHeaders();
		headers.setLocation(uri);

		return new ResponseEntity(headers, HttpStatus.CREATED);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.PUT, consumes = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<?> update(@RequestBody ${entityName}Entity ${entityName?uncap_first}) {
		//调用JSR303 Bean Validator进行校验，如果出错返回含400错误码及json格式的错误信息.
		Set<ConstraintViolation<${entityName}Entity>> failures = validator.validate(${entityName?uncap_first});
		if (!failures.isEmpty()) {
			return new ResponseEntity(BeanValidators.extractPropertyAndMessage(failures), HttpStatus.BAD_REQUEST);
		}

		//保存
		${entityName?uncap_first}Service.saveOrUpdate(${entityName?uncap_first});

		//按Restful约定，返回204状态码, 无内容. 也可以返回200状态码.
		return new ResponseEntity(HttpStatus.NO_CONTENT);
	}

	@RequestMapping(value = "/{id}", method = RequestMethod.DELETE)
	@ResponseStatus(HttpStatus.NO_CONTENT)
	public void delete(@PathVariable("id") String id) {
		${entityName?uncap_first}Service.deleteEntityById(${entityName}Entity.class, id);
	}
	<#-- restful 通用方法生成 -->
}
