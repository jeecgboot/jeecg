<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>${ftl_description}</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
 </head>
 <body style="overflow-y: hidden" scroll="no">
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="div" action="${entityName?uncap_first}Controller.do?save">
		<input id="id" name="id" type="hidden" value="${'$'}{${entityName?uncap_first}Page.id }">
		<fieldset class="step">
		<#list columns as po>
			<div class="form">
		      <label class="Validform_label">${po.filedComment}:</label>
		      <input <#if po.classType=='easyui-datetimebox'>class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="width: 150px"<#elseif po.classType=='easyui-datebox'>class="Wdate" onClick="WdatePicker()"  style="width: 150px"<#else>class="${po.classType}"</#if> id="${po.fieldName}" name="${po.fieldName}" <#if po.nullable == 'Y'>ignore="ignore"</#if>   <#if po.fieldType?index_of("time")!=-1>  value="<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"<#else><#if po.fieldType?index_of("date")!=-1>value="<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type="date" pattern="yyyy-MM-dd"/>"<#else>value="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}"</#if></#if><#if po.optionType?trim?length !=0> datatype="${po.optionType}"</#if> />
		      <span class="Validform_checktip"></span>
		    </div>
			</#list>
	    </fieldset>
  </t:formvalid>
 </body>