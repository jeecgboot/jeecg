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
  function browseImages(inputId, Img) {// 图片管理器，可多个上传共用
		var finder = new CKFinder();
		finder.selectActionFunction = function(fileUrl, data) {//设置文件被选中时的函数 
			$("#" + Img).attr("src", fileUrl);
			$("#" + inputId).attr("value", fileUrl);
		};
		finder.resourceType = 'Images';// 指定ckfinder只为图片进行管理
		finder.selectActionData = inputId; //接收地址的input ID
		finder.removePlugins = 'help';// 移除帮助(只有英文)
		finder.defaultLanguage = 'zh-cn';
		finder.popup();
	}
	function browseFiles(inputId, file) {// 文件管理器，可多个上传共用
		var finder = new CKFinder();
		finder.selectActionFunction = function(fileUrl, data) {//设置文件被选中时的函数 
			$("#" + file).attr("href", fileUrl);
			$("#" + inputId).attr("value", fileUrl);
			decode(fileUrl, file);
		};
		finder.resourceType = 'Files';// 指定ckfinder只为文件进行管理
		finder.selectActionData = inputId; //接收地址的input ID
		finder.removePlugins = 'help';// 移除帮助(只有英文)
		finder.defaultLanguage = 'zh-cn';
		finder.popup();
	}
	function decode(value, id) {//value传入值,id接受值
		var last = value.lastIndexOf("/");
		var filename = value.substring(last + 1, value.length);
		$("#" + id).text(decodeURIComponent(filename));
	}
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="${entityName?uncap_first}Controller.do?doAdd" tiptype="1">
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
									               </#if>>
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
									               </#if>>
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
									               </#if>>    
						      	<#elseif po.showType=='datetime'>
									  <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" 
						      						 class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
						      						<#if po.fieldValidType?if_exists?html != ''>
									               datatype="${po.fieldValidType?if_exists?html}"
									               <#else>
									               <#if po.isNull != 'Y'>datatype="*"</#if> 
									               </#if>>
								<#elseif po.showType=='file'>
										<input type="hidden" id="${po.fieldName}" name="${po.fieldName}" />
										<a  target="_blank" id="${po.fieldName}_href">暂时未上传文件</a>
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
									               </#if>>
								</#if>
							<span class="Validform_checktip"></span>
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