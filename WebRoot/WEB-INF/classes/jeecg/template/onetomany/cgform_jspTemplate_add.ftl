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
  $(document).ready(function(){
	$('#tt').tabs({
	   onSelect:function(title){
	       $('#tt .panel-body').css('width','auto');
		}
	});
  });
 //初始化下标
	function resetTrNum(tableId) {
		$tbody = $("#"+tableId+"");
		$tbody.find('>tr').each(function(i){
			$(':input, select,button,a', this).each(function(){
				var $this = $(this), name = $this.attr('name'),id=$this.attr('id'),onclick_str=$this.attr('onclick'), val = $this.val();
				if(name!=null){
					if (name.indexOf("#index#") >= 0){
						$this.attr("name",name.replace('#index#',i));
					}else{
						var s = name.indexOf("[");
						var e = name.indexOf("]");
						var new_name = name.substring(s+1,e);
						$this.attr("name",name.replace(new_name,i));
					}
				}
				if(id!=null){
					if (id.indexOf("#index#") >= 0){
						$this.attr("id",id.replace('#index#',i));
					}else{
						var s = id.indexOf("[");
						var e = id.indexOf("]");
						var new_id = id.substring(s+1,e);
						$this.attr("id",id.replace(new_id,i));
					}
				}
				if(onclick_str!=null){
					if (onclick_str.indexOf("#index#") >= 0){
						$this.attr("onclick",onclick_str.replace(/#index#/g,i));
					}else{
					}
				}
			});
		});
	}
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
 <body style="overflow-x: hidden;">
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" tiptype="1" action="${entityName?uncap_first}Controller.do?doAdd">
			<#list columns as po>
				<#if po.isShow == 'N'>
					<input id="${po.fieldName}" name="${po.fieldName}" type="hidden" value="${'$'}{${entityName?uncap_first}Page.${po.fieldName} }">
				</#if>
			</#list>
	<table cellpadding="0" cellspacing="1" class="formtable">
		<#list pageColumns as po>
		<#if po_index%2==0>
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
		<#if (po_index+1)%2==0>
		</tr>
		<#else>
		<#if !po_has_next>
		</tr>
		</#if>
		</#if>
	</#list>
	</table>
			<div style="width: auto;height: 200px;">
				<%-- 增加一个div，用于调节页面大小，否则默认太小 --%>
				<div style="width:800px;height:1px;"></div>
				<t:tabs id="tt" iframe="false" tabPosition="top" fit="false">
				<#list subTab as sub>
				 <t:tab href="${entityName?uncap_first}Controller.do?${sub.entityName?uncap_first}List<#list sub.foreignKeys as key><#if key?lower_case?index_of("${jeecg_table_id}")!=-1>&${jeecg_table_id}=${"$"}{${entityName?uncap_first}Page.${jeecg_table_id}}<#else>&${key?uncap_first}=${"$"}{${entityName?uncap_first}Page.${key?uncap_first}}</#if></#list>" icon="icon-search" title="${sub.ftlDescription}" id="${sub.entityName?uncap_first}"></t:tab>
				</#list>
				</t:tabs>
			</div>
			</t:formvalid>
			<!-- 添加 附表明细 模版 -->
	<table style="display:none">
		<#list subTab as sub>
	<tbody id="add_${sub.entityName?uncap_first}_table_template">
		<tr>
			 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td>
			 <#list subPageColumnsMap[sub.tableName] as po>
				 <#assign check = 0 >
				  <#list sub.foreignKeys as key>
				  <#if subFieldMeta[po.fieldName]==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				  <td align="left">
					  <#if po.showType == "text">
					  	<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="text" class="inputxt"  style="width:120px;"
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
							<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="password" class="inputxt"  style="width:120px;"
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
							<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="text" class="Wdate" onClick="WdatePicker()"  style="width:120px;"
					  		<#if po.fieldValidType?if_exists?html != ''>
					               datatype="${po.fieldValidType?if_exists?html}"
					               <#else>
					               <#if po.isNull != 'Y'>datatype="*"</#if> 
					               </#if>>  
					      <#elseif po.showType=='datetime'>
					      	<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" 
						  		type="text"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="width:120px;"
						  		<#if po.fieldValidType?if_exists?html != ''>
					               datatype="${po.fieldValidType?if_exists?html}"
					               <#else>
					               <#if po.isNull != 'Y'>datatype="*"</#if> 
					               </#if>>  
					       <#elseif po.showType=='file'>
										<input type="hidden" id="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" />
										<a  target="_blank" id="${sub.entityName?uncap_first}List[#index#].${po.fieldName}_href">暂时未上传文件</a>
									   <input class="ui-button" type="button" value="上传附件"
													onclick="browseFiles('${sub.entityName?uncap_first}List\\[#index#\\]\\.${po.fieldName}','${sub.entityName?uncap_first}List\\[#index#\\]\\.${po.fieldName}_href')"/>
					       <#else>
					       	<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" 
						  		type="text" class="inputxt"  style="width:120px;"
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
				  </td>
				  </#if>
              </#list>
			</tr>
		 </tbody>
		 </#list>
		</table>
 </body>
 <script src = "webpage/${bussiPackage?replace('.','/')}/${entityPackage}/${entityName?uncap_first}.js"></script>	