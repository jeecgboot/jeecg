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
<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
	<#if callBackTestPo.showType=='file' || callBackTestPo.showType == 'image'>
		<#assign callbackFlag = true />
		<#break>
	</#if>
	<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
</#list>
<html>
 <head>
  <title>${ftl_description}</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <#if callbackFlag == true>
  <t:base type="uploadify"></t:base>
  </#if>
  <script src="plug-in/layer/layer.js"></script>
 <script>
	function btn_ok(){
		$("#btnsub").click();
	}
	function callback(data){
		
		<#if callbackFlag == true>
	  	jeecgFormFileCallBack(data);
  	</#if>
		
		if(data.success){
			layer.alert(data.msg, function(index){
				window.location.href="${entityName?uncap_first}Controller.do?list"
				layer.close(index);
			});       
		}
		else{
			layer.alert(data.msg);
		}
	}
</script>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
 <#assign ue_widget_count = 0>
 <#-- update--end--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
  <t:formvalid formid="formobj" dialog="false" usePlugin="password" layout="table" action="${entityName?uncap_first}Controller.do?doAdd" tiptype="1" callback="callback">
			<#list columns as po>
				<#if po.isShow == 'N'>
					<#-- update--begin--author:zhoujf date:20170622 for:TASK #1967 【代码生成器优化】online生成代码，无用太多，简化代码(1. 系统标准字段，表单页面，添加和修改页面，不生成隐藏字段) -->
					<#if po.fieldName == 'id'>
					<input id="${po.fieldName}" name="${po.fieldName}" type="hidden" value="${'$'}{${entityName?uncap_first}Page.${po.fieldName} }"/>
					</#if>
					<#-- update--end--author:zhoujf date:20170622 for:TASK #1967 【代码生成器优化】online生成代码，无用太多，简化代码(1. 系统标准字段，表单页面，添加和修改页面，不生成隐藏字段) -->
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
						  <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						  	 <#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
					     	 <input id="${po.fieldName}" name="${po.fieldName}" type="text" maxlength="${po.length?c}" style="width: 150px" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/>/>
						  	 <#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
							 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						<#elseif po.showType=='popup'>
								 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
								 <#-- update--begin--author:zhoujf date:20180319 for:TASK #2557 popup,当字典Text为多个值时 -->
								<input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" class="searchbox-inputtext" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/><#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/>
						  		<#-- update--end--author:zhoujf date:20180319 for:TASK #2557 popup,当字典Text为多个值时 -->
						  			 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						  <#elseif po.showType=='textarea'>
						  	  <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						  	 <textarea style="width:600px;" class="inputxt" rows="6" id="${po.fieldName}"  name="${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>></textarea>
					      		 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					      <#elseif po.showType=='password'>
					      		 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					      		 <#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
					      		<input id="${po.fieldName}" name="${po.fieldName}" maxlength="${po.length?c}" type="password" style="width: 150px" class="inputxt"  <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>/>
								 <#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
								 <#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
							<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>	 
							  	 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
							  	<t:dictSelect field="${po.fieldName}" type="${po.showType?if_exists?html}"<@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" inputCheck="2"/> defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
								 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
							<#elseif po.showType=='date'>
							    <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
							   <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" class="Wdate" onClick="WdatePicker()"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>    
					      		 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
					      	<#elseif po.showType=='datetime'>
							    <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
							   <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
								 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
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
					      		<input id="${po.fieldName}" name="${po.fieldName}" type="text" maxlength="${po.length?c}" style="width: 150px" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
								 <#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
								 <#-- update--end--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
							</#if>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
						</td>
			<#if (pageColumns?size>10)>
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
				
				<#-- update--begin--author:zhoujf Date:20170523 for:TASK #1961 【代码生成器】一对多富文本编辑器，生成代码格式问题 -->
				<#list pageAreatextColumns as po>
				<tr>
					<td align="right">
						<label class="Validform_label">
							${po.content}:
						</label>
					</td>
					<td class="value" <#if (pageColumns?size>10)> colspan="4" <#else> colspan="2" </#if>>
						  <#if po.showType=='textarea'>
						  	  <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						  	 <textarea style="width:600px;" class="inputxt" rows="6" maxlength="${po.length?c}" id="${po.fieldName}"  name="${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>></textarea>
					      		 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
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
				<tr>
					<td height="50px" align="center" colspan="2">
						<a style="margin-left:80px" href="#" class="easyui-linkbutton l-btn"  plain="true" iconcls="icon-le-back" onclick="history.go(-1)">返回</a>
						<div style="display:none"><input type="submit" id ="btnsub" value=""/></div>
						<a  href="#" class="easyui-linkbutton l-btn"  iconcls="icon-le-ok" onclick="btn_ok()">提交</a>
					</td>
				</tr>
			</table>
		</t:formvalid>
 </body>
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
					}
				}
			}
	  	</script>
  	</#if>
  	<#if (cgformConfig.formJs.cgJsStr)?? && cgformConfig.formJs.cgJsStr!="">
		<script type="text/javascript">
		//JS增强
		${cgformConfig.formJs.cgJsStr}
		</script>
	</#if>