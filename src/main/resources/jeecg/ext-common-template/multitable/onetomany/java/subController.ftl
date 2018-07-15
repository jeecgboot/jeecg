<#list subtables as key>
#segment#${subsG['${key}'].entityName}Controller.java
package ${bussiPackage}.${subsG['${key}'].entityPackage}.controller;

import ${bussiPackage}.${subsG['${key}'].entityPackage}.entity.${subsG['${key}'].entityName}Entity;
import ${bussiPackage}.${entityPackage}.service.${entityName}ServiceI;
import ${bussiPackage}.${entityPackage}.page.${entityName}Page;

import java.util.ArrayList;
import java.util.List; 
import java.text.SimpleDateFormat;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.poi.ss.usermodel.Workbook;
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
import org.jeecgframework.poi.excel.ExcelExportUtil;
import org.jeecgframework.poi.excel.entity.ExportParams;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.jeecgframework.poi.excel.entity.vo.NormalExcelConstants;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Map;

<#-- restful 通用方法生成 -->
import org.apache.commons.collections.CollectionUtils;
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
			org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, ${subsG['${key}'].entityName?uncap_first},request.getParameterMap());
			try{
				//自定义追加查询条件
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
	
	/**
	 * 行编辑保存操作
	 * @param page
	 * @return
	 */
	@RequestMapping(params = "saveRows")
	@ResponseBody
	public AjaxJson saveRows(${entityName}Page page,HttpServletRequest req){
		String message = "操作成功！";
		List<${subsG['${key}'].entityName}Entity> lists=page.get${subsG['${key}'].entityName}List();
		AjaxJson j = new AjaxJson();
		String mainId = req.getParameter("mainId");
		if(CollectionUtils.isNotEmpty(lists)){
			for(${subsG['${key}'].entityName}Entity temp:lists){
				if (StringUtil.isNotEmpty(temp.getId())) {
					${subsG['${key}'].entityName}Entity t =this.systemService.get(${subsG['${key}'].entityName}Entity.class, temp.getId());
					try {
						MyBeanUtils.copyBeanNotNull2Bean(temp, t);
						systemService.saveOrUpdate(t);
						systemService.addLog(message, Globals.Log_Type_UPDATE, Globals.Log_Leavel_INFO);
					} catch (Exception e) {
						e.printStackTrace();
					}
				} else {
					try {
						//temp.setDelFlag(0);若有则需要加
						<#list subsG['${key}'].foreignKeys as fk>
						temp.set${fk?cap_first}(mainId);
					    <#break>
					    </#list>
						systemService.save(temp);
						systemService.addLog(message, Globals.Log_Type_INSERT, Globals.Log_Leavel_INFO);
					} catch (Exception e) {
						e.printStackTrace();
					}
					
				}
			}
		}
		return j;
	}
	
	/**
	 * 导出excel
	 * @param request
	 * @param response
	 */
    @RequestMapping(params = "exportXls")
    public void exportXls(${subsG['${key}'].entityName}Entity ${subsG['${key}'].entityName?uncap_first},HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid,ModelMap map) throws Exception {
    	CriteriaQuery cq = new CriteriaQuery(${subsG['${key}'].entityName}Entity.class, dataGrid);
    	//必须要有合同id
		String mainId = request.getParameter("mainId");
		List<${subsG['${key}'].entityName}Entity> list =new ArrayList<${subsG['${key}'].entityName}Entity>();
		if(oConvertUtils.isNotEmpty(mainId)){
			//查询条件组装器
			<#list subsG['${key}'].foreignKeys as fk>
			${subsG['${key}'].entityName?uncap_first}.set${fk?cap_first}(mainId);
		    <#break>
		    </#list>
			org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, ${subsG['${key}'].entityName?uncap_first}, request.getParameterMap());
			try{
				//自定义追加查询条件
				//cq.eq("delFlag", 0);
			}catch (Exception e) {
				e.printStackTrace();
				throw new BusinessException(e.getMessage());
			}
			cq.add();
			list= this.systemService.getListByCriteriaQuery(cq, false);
			Workbook excel=ExcelExportUtil.exportExcel(new ExportParams(), ${subsG['${key}'].entityName}Entity.class, list);
			response.setContentType("application/x-msdownload;charset=utf-8");
			response.setHeader("Content-disposition", "attachment; filename="+new String("${subsG['${key}'].ftlDescription}列表.xls".getBytes("UTF-8"), "iso-8859-1"));
			OutputStream outputStream = null;
			try {
				outputStream = response.getOutputStream();
				excel.write(outputStream);
			} catch (IOException e) {
				e.printStackTrace();
			}finally{
				try {
					if(outputStream!=null)outputStream.close();
				} catch (IOException e) {
					e.printStackTrace();
				}
			}
		}
	}
	
   /**
	* 导出excel 使模板
	*/
	@RequestMapping(params = "exportXlsByT")
	public String exportXlsByT(ModelMap map) {
		map.put(NormalExcelConstants.FILE_NAME,"${subsG['${key}'].ftlDescription}");
		map.put(NormalExcelConstants.CLASS,${subsG['${key}'].entityName}Entity.class);
		map.put(NormalExcelConstants.PARAMS,new ExportParams("${subsG['${key}'].ftlDescription}列表", "导出人:"+ ResourceUtil.getSessionUser().getRealName(),"导出信息"));
		map.put(NormalExcelConstants.DATA_LIST,new ArrayList());
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
		String mainId = request.getParameter("mainId");
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
			MultipartFile file = entity.getValue();// 获取上传文件对象
			ImportParams params = new ImportParams();
			params.setTitleRows(2);
			params.setHeadRows(2);
			params.setNeedSave(true);
			try {
				List<${subsG['${key}'].entityName}Entity> list =  ExcelImportUtil.importExcel(file.getInputStream(), ${subsG['${key}'].entityName}Entity.class, params);
				for (${subsG['${key}'].entityName}Entity page : list) {
					<#list subsG['${key}'].foreignKeys as fk>
					page.set${fk?cap_first}(mainId);
				    <#break>
				    </#list>
		       		${entityName?uncap_first}Service.save(page);
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
	
}
</#list>