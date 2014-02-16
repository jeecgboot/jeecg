<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>${ftl_description}</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="plug-in/ckeditor_new/ckeditor.js"></script>
  <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="${entityName?uncap_first}Controller.do?doUpdate" tiptype="1">
			<#list columns as po>
				<#if po.isShow == 'N'>
					<input id="${po.fieldName}" name="${po.fieldName}" type="hidden" value="${'$'}{${entityName?uncap_first}Page.${po.fieldName} }">
				</#if>
			</#list>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
			<#list pageColumns as po>
				<#if (pageColumns?size>10)>
					<#if po_index%2==0>
					<tr>
					</#if>
					<#else>
					<tr>
				</#if>
						<td align="right">
							<label class="Validform_label">
								${po.content}:
							</label>
						</td>
						<td class="value">
							<#if po.showType=='text'>
						     	 <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" class="inputxt"  
						      						<#if po.fieldValidType?if_exists?html != ''>
									               datatype="${po.fieldValidType?if_exists?html}"
									               <#else>
									               <#if po.type == 'int'>
									               datatype="n" 
									               <#elseif po.type=='double'>
									               datatype="/^(-?\d+)(\.\d+)?$/" 
									               <#else>
									               <#if po.isNull != 'Y'>datatype="*"</#if>
									               </#if>
									               </#if>  value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'>
						    <#elseif po.showType=='textarea'>
						  	 	<textarea id="${po.fieldName}" name="${po.fieldName}">${'$'}{${entityName?uncap_first}Page.${po.fieldName}}</textarea>
						     <#elseif po.showType=='password'>
						      	<input id="${po.fieldName}" name="${po.fieldName}" type="password" style="width: 150px" class="inputxt"  
						      						<#if po.fieldValidType?if_exists?html != ''>
									               datatype="${po.fieldValidType?if_exists?html}"
									               <#else>
									               <#if po.type == 'int'>
									               datatype="n" 
									               <#elseif po.type=='double'>
									               datatype="/^(-?\d+)(\.\d+)?$/" 
									               <#else>
									               <#if po.isNull != 'Y'>datatype="*"</#if>
									               </#if>
									               </#if>  value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'>
								<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>	 
									<t:dictSelect field="${po.fieldName}" type="${po.showType?if_exists?html}"
										<#if po.dictTable?if_exists?html != ''>dictTable="${po.dictTable?if_exists?html}" dictField="${po.dictField?if_exists?html}" dictText="${po.dictText?if_exists?html}"<#else>typeGroupCode="${po.dictField}"</#if> defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
								<#elseif po.showType=='date'>
									  <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" 
						      						class="Wdate" onClick="WdatePicker()"
						      						<#if po.fieldValidType?if_exists?html != ''>
									               datatype="${po.fieldValidType?if_exists?html}"
									               <#else>
									               <#if po.isNull != 'Y'>datatype="*"</#if> 
									               </#if>
						      						 value='<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type="date" pattern="yyyy-MM-dd"/>'>    
						      	<#elseif po.showType=='datetime'>
									  <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" 
						      						 class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						      						<#if po.fieldValidType?if_exists?html != ''>
									               datatype="${po.fieldValidType?if_exists?html}"
									               <#else>
									               <#if po.isNull != 'Y'>datatype="*"</#if> 
									               </#if>
						      						 value='<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>'>
						      	<#elseif po.showType=='file'>
									  <input type="hidden" id="${po.fieldName}" name="${po.fieldName}" value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/>
										<c:if test="${'$'}{${entityName?uncap_first}Page.${po.fieldName}==''}">
											<a   target="_blank" id="${po.fieldName}_href">暂时未上传文件</a>
										</c:if>
										<c:if test="${'$'}{${entityName?uncap_first}Page.${po.fieldName}!=''}">
											<a href="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}"  target="_blank" id="${po.fieldName}_href">下载</a>
										</c:if>
									   <input class="ui-button" type="button" value="上传附件"
													onclick="browseFiles('${po.fieldName}','${po.fieldName}_href')"/>
						      	<#else>
						      		<input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" class="inputxt"  
						      						<#if po.fieldValidType?if_exists?html != ''>
									               datatype="${po.fieldValidType?if_exists?html}"
									               <#else>
									               <#if po.type == 'int'>
									               datatype="n" 
									               <#elseif po.type=='double'>
									               datatype="/^(-?\d+)(\.\d+)?$/" 
									               <#else>
									               <#if po.isNull != 'Y'>datatype="*"</#if>
									               </#if>
									               </#if>  value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'>
								</#if>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
						</td>
			<#if (columns?size>10)>
				<#if (po_index%2==0)&&(!po_has_next)>
				<td align="right">
					<label class="Validform_label">
					</label>
				</td>
				<td class="value">
				</td>
				</#if>
				<#if (po_index%2!=0)||(!po_has_next)>
					</tr>
				</#if>
				<#else>
					</tr>
			</#if>
				</#list>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/${bussiPackage?replace('.','/')}/${entityPackage}/${entityName?uncap_first}.js"></script>		