<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<#include "../../ui/datatype.ftl"/>
<#include "../../ui/dictInfo.ftl"/>
<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<#-- update--begin--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
<#include "../../ui/tag.ftl"/>
<#-- update--end--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
<!DOCTYPE html>
<#assign callbackFlag = false />
<#assign fileName = "" />
<#list pageColumns as callBackTestPo>
	<#if callBackTestPo.showType=='file' || callBackTestPo.showType == 'image'>
		<#assign callbackFlag = true />
		<#break>
	</#if>
</#list>
<html>
 <head>
  <title>${ftl_description}</title>
    <style>
  .ui-button {
  	  display: inline-block;
	  padding: 2px 2px;
	  margin-bottom: 0;
	  font-size: 8px;
	  font-weight: normal;
	  line-height: 1.42857143;
	  text-align: center;
	  white-space: nowrap;
	  vertical-align: middle;
	  -ms-touch-action: manipulation;
      touch-action: manipulation;
	  cursor: pointer;
	  -webkit-user-select: none;
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
	  background-image: none;
	  border: 1px solid transparent;
	  border-radius: 4px;
  }
  </style>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <#if callbackFlag == true>
		<link rel="stylesheet" href="plug-in/uploadify/css/uploadify.css" type="text/css" />
		<script type="text/javascript" src="plug-in/uploadify/jquery.uploadify-3.1.js"></script>
  </#if>
  <script type="text/javascript">
  $(document).ready(function(){
	$('#tt').tabs({
	   onSelect:function(title){
	       $('#tt .panel-body').css('width','auto');
		}
	});
	$(".tabs-wrap").css('width','100%');
  });
 </script>
 </head>
 <body style="overflow-x: hidden;">
  <#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
 <#assign ue_widget_count = 0>
 <#-- update--end--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" tiptype="1" action="${entityName?uncap_first}Controller.do?doAdd" ${callbackFlag?string("callback=\"jeecgFormFileCallBack@Override\"", "")}>
			<#list columns as po>
				<#if po.isShow == 'N'>
					<#-- update--begin--author:zhoujf date:20170622 for:TASK #1967 【代码生成器优化】online生成代码，无用太多，简化代码(1. 系统标准字段，表单页面，添加和修改页面，不生成隐藏字段) -->
					<#if po.fieldName == 'id'>
					<input id="${po.fieldName}" name="${po.fieldName}" type="hidden" value="${'$'}{${entityName?uncap_first}Page.${po.fieldName} }"/>
					</#if>
					<#-- update--end--author:zhoujf date:20170622 for:TASK #1967 【代码生成器优化】online生成代码，无用太多，简化代码(1. 系统标准字段，表单页面，添加和修改页面，不生成隐藏字段) -->
				</#if>
			</#list>
	<table cellpadding="0" cellspacing="1" class="formtable">
		<#list pageColumns as po>
		<#if po_index%2==0>
		<tr>
		</#if>
			<td align="right">
				<label class="Validform_label">${po.content}:</label>
			</td>
			<td class="value">
			<#if po.showType=='text'>
					<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					<#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
		     	 <input id="${po.fieldName}" name="${po.fieldName}" type="text" maxlength="${po.length?c}" style="width: 150px" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}" />/>
		     	 <#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
					<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
			<#elseif po.showType=='popup'>
			<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
				<#-- update--begin--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
				<input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" class="searchbox-inputtext" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/>			 
				<#-- update--end--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
			  	<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
			  <#elseif po.showType=='textarea'>
				<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
				  <#-- update--begin--author:gj_shaojc Date:20180315 for:TASK #2548 【代码生成器】样式问题-->
				  <textarea id="${po.fieldName}" style="width:600px;height:60px;" class="inputxt" rows="6" name="${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />></textarea>
		      	  <#-- update--end--author:gj_shaojc Date:20180315 for:TASK #2548 【代码生成器】样式问题-->
		      	<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
		      <#elseif po.showType=='password'>
		      	<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
		      	<#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
		      	 <input id="${po.fieldName}" name="${po.fieldName}" type="password" maxlength="${po.length?c}" style="width: 150px" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
		      	 <#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
					<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
				<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>	 
					 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					  <t:dictSelect field="${po.fieldName}" type="${po.showType?if_exists?html}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}" ></t:dictSelect>     
						<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
				<#elseif po.showType=='date'>
						<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					  <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px"  class="Wdate" onClick="WdatePicker()" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
		      			<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
		      	<#elseif po.showType=='datetime'>
		      		<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					  <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
					<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
				<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
				<#--update-start--Author: jg_huangxg  Date:20160421 for：TASK #1027 【online】代码生成器模板不支持UE编辑器 -->
				<#elseif po.showType='umeditor'>
					<#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
					<#assign ue_widget_count = ue_widget_count + 1>
					<#if ue_widget_count == 1>
					<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
					<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
					</#if>
					<#-- update--end--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
			    	<textarea name="${po.fieldName}" id="${po.fieldName}" style="width: 650px;height:300px"></textarea>
				    <script type="text/javascript">
				        <#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
				        var ${po.fieldName}_editor = UE.getEditor('${po.fieldName}');
				        <#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
				    </script>
				<#--update-end--Author: jg_huangxg  Date:20160421 for：TASK #1027 【online】代码生成器模板不支持UE编辑器 -->
				<#-- update--begin--author:taoyan date:20180514 for:【代码生成器】上传空间、树控件 宏封装 -->
				<#elseif po.showType=='file' || po.showType == 'image'>
					<@uploadtag po = po />
				<#elseif po.showType=='tree'>
					<@treetag po = po />
				<#-- update--end--author:taoyan date:20180514 for:【代码生成器】上传空间、树控件 宏封装 -->
		      	<#else>
		      		<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
		      		<#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
		      		<input id="${po.fieldName}" name="${po.fieldName}" type="text" maxlength="${po.length?c}" style="width: 150px" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
					<#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
					<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
				</#if>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
			</td>
		<#if (po_index+1)%2==0>
		</tr>
		<#else>
		<#if !po_has_next>
		</tr>
		</#if>
		</#if>
	</#list>
	
	<#-- update--begin--author:zhoujf Date:20170523 for:TASK #1961 【代码生成器】一对多富文本编辑器，生成代码格式问题 -->
	<#list pageAreatextColumns as po>
		<tr>
			<td align="right">
				<label class="Validform_label">${po.content}:</label>
			</td>
			<td class="value" colspan="3">
			  <#if po.showType=='textarea'>
				<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
				  <#-- update--begin--author:gj_shaojc Date:20180315 for:TASK #2548 【代码生成器】样式问题-->
				  <textarea id="${po.fieldName}" style="width:600px;height:60px;" class="inputxt" rows="6" name="${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />></textarea>
		      	  <#-- update--end--author:gj_shaojc Date:20180315 for:TASK #2548 【代码生成器】样式问题-->
		      	<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
				<#elseif po.showType='umeditor'>
					<#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
					<#assign ue_widget_count = ue_widget_count + 1>
					<#if ue_widget_count == 1>
					<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
					<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
					</#if>
					<#-- update--end--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
			    	<textarea name="${po.fieldName}" id="${po.fieldName}" style="width: 650px;height:300px"></textarea>
				    <script type="text/javascript">
				        <#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
				        var ${po.fieldName}_editor = UE.getEditor('${po.fieldName}');
				        <#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
				    </script>
				</#if>
				<span class="Validform_checktip"></span>
				<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
			</td>
		</tr>
	</#list>
	<#-- update--end--author:zhoujf Date:20170523 for:TASK #1961 【代码生成器】一对多富文本编辑器，生成代码格式问题 -->
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
			 <td align="center"><div style="width: 25px;" name="xh"></div></td>
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
					  	<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					  	<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" type="text" class="inputxt"  style="width:120px;" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}" idFieldName="${sub.entityName?uncap_first}List[#index#].id" />/>
						<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						<#elseif po.showType=='password'>
							<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
							<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" type="password" class="inputxt"  style="width:120px;"<@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
							<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
							<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
							<t:dictSelect field="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" type="${po.showType?if_exists?html}"  <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="" hasLabel="false"  title="${po.content}"></t:dictSelect>     
							<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						<#elseif po.showType=='date'>
							<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
							<#-- update--begin--author:gj_shaojc Date:20180409 for:TASK #2622 【代码生成体验问题】代码生成 [多tab风格]、[table风格] 列表时间控件长度短了 -->
							<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" type="text" class="Wdate" onClick="WdatePicker()"  style="width:150px;"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
					    	<#-- update--end--author:gj_shaojc Date:20180409 for:TASK #2622 【代码生成体验问题】代码生成 [多tab风格]、[table风格] 列表时间控件长度短了 -->
					    	<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					    <#elseif po.showType=='datetime'>
					      	<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					      	<#-- update--begin--author:gj_shaojc Date:20180409 for:TASK #2622 【代码生成体验问题】代码生成 [多tab风格]、[table风格] 列表时间控件长度短了 -->
					      	<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" type="text"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="width:150px;"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
					    	<#-- update--end--author:gj_shaojc Date:20180409 for:TASK #2622 【代码生成体验问题】代码生成 [多tab风格]、[table风格] 列表时间控件长度短了 -->
					    	<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					    	<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
					    <#elseif po.showType=='file' || po.showType == 'image'>
					    <#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
										<input type="hidden" id="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" />
									   <#-- update--begin--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
									   <input class="ui-button" type="button" value="上传附件"
													onclick="commonUpload(commonUploadDefaultCallBack,'${sub.entityName?uncap_first}List\\[#index#\\]\\.${po.fieldName}')"/>
										<a  target="_blank" id="${sub.entityName?uncap_first}List[#index#].${po.fieldName}_href"></a>
									<#-- update--end--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
						<#elseif po.showType=='popup'>
							<#-- update--begin--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
					  		<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" type="text" style="width: 150px" class="searchbox-inputtext" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/>
					  		<#-- update--end--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
					       <#else>
					       <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					       	<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" type="text" class="inputxt"  style="width:120px;"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
					  		<#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					  </#if>
					  <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
				  </td>
				  </#if>
              </#list>
			</tr>
		 </tbody>
		 </#list>
		</table>
 </body>
 <script src = "webpage/${bussiPackage?replace('.','/')}/${entityPackage}/${entityName?uncap_first}.js"></script>
<#if callbackFlag == true>
  	<script type="text/javascript">
  		function jeecgFormFileCallBack(data){
  			if (data.success == true) {
				uploadFile(data);
			} else {
				if (data.responseText == '' || data.responseText == undefined) {
					$.messager.alert('错误', data.msg);
					$.Hidemsg();
				} else {
					try {
						var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
						$.messager.alert('错误', emsg);
						$.Hidemsg();
					} catch(ex) {
						$.messager.alert('错误', data.responseText + '');
					}
				}
				return false;
			}
			if (!neibuClickFlag) {
				var win = frameElement.api.opener;
				win.reloadTable();
			}
  		}
  		function upload() {
			<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
			<#assign subFileName = fileName?substring(0,fileName?length - 1) />
  			<#list subFileName?split(",") as name>
				$('#${name}').uploadify('upload', '*');
			</#list>
			<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->		
		}
		
		var neibuClickFlag = false;
		function neibuClick() {
			neibuClickFlag = true; 
			$('#btn_sub').trigger('click');
		}
		function cancel() {
			<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
			<#assign subFileName = fileName?substring(0,fileName?length - 1) />
  			<#list subFileName?split(",") as name>
				$('#${name}').uploadify('cancel', '*');
			</#list>
			<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
		}
		function uploadFile(data){
			if(!$("input[name='id']").val()){
				if(data.obj!=null && data.obj!='undefined'){
					$("input[name='id']").val(data.obj.id);
				}
			}
			if($(".uploadify-queue-item").length>0){
				upload();
			}else{
				if (neibuClickFlag){
					alert(data.msg);
					neibuClickFlag = false;
				}else {
					var win = frameElement.api.opener;
					win.reloadTable();
					win.tip(data.msg);
					frameElement.api.close();
				}
			}
		}
  	</script>
</#if>	