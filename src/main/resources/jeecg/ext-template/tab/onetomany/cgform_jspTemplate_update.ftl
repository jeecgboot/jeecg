<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#include "../../ui/datatype.ftl"/>
<#include "../../ui/dictInfo.ftl"/>
<#-- update--begin--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
<#include "../../ui/tag.ftl"/>
<#-- update--end--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
<link rel="stylesheet" href="plug-in/themes/fineui/css/mainform.css" type="text/css"/>
<style>
.conc-wrapper input:not([type='radio']){
width:95%;
}
<#-- update--begin--author:Yandong-- date:20180309--for:TASK #2549 【代码生成器】多tab生成的样式有问题 --->
.conc-wrapper input[type='checkbox'],input[type='radio']{
width:auto;
}
<#-- update--end--author:Yandong-- date:20180309--for:TASK #2549 【代码生成器】多tab生成的样式有问题 --->
.conc-wrapper select{
width:95% !important;
}
<#-- update-begin-author:taoyan date:2018704 for:TASK #2765 【online表单】多tab风格 存在文件字段时样式乱了 -->
.con-wrapper .show-grid > div,.con-wrapper .row.show-grid{border-left:none}
<#-- update-end-author:taoyan date:2018704 for:TASK #2765 【online表单】多tab风格 存在文件字段时样式乱了 -->
</style>
<#-- update--begin--author:zhoujf date:20180410 for:TASK #2630 【代码生成】一对多 多TAB模式生成存在富文本控件时生成代码报错问题 -->
<#assign ue_widget_count = 0>
<#-- update--end--author:zhoujf date:20180410 for:TASK #2630 【代码生成】一对多 多TAB模式生成存在富文本控件时生成代码报错问题-->
<#-- update--begin--author:taoyan-- date:20180326--for:多tab生成树控件bug --->
<div style="margin: 0 15px;padding-bottom:10px;">
<!-- 若页面内容太多需要滚动条 ,可自己根据页面添加overflow: auto;样式 -->
<#-- update--end--author:taoyan-- date:20180326--for:多tab生成树控件bug --->
<div class="conc-wrapper" style="margin-top:10px">
	<#list pageColumns as po>
	<#-- 4个字段为一行，2行一个模块 -->
		<#-- 模块头部开始 -->
			<#if po_index%8==0>
			<#assign index_m = po_index>
			<div class="main-tab">
				<ul class="tab-info">
				  <li role="presentation" class="active">
					<a href="javascript:void(0);"> &nbsp;&nbsp;信息模块${(po_index/8)+1}</a>
				  </li>
				</ul>
				<!-- tab内容 -->
				<div class="con-wrapper1">
				  <div class="row form-wrapper">
			</#if>
		<#-- 模块头部结束 -->
		<#-- 行头部开始 -->
			<#if po_index%4==0>
			<#assign index_h = po_index>
			<div class="row show-grid">
			</#if>
		<#-- 行头部结束 -->
		
		<#-- 字段内容开始 -->
		<div class="col-xs-1 text-center">
			<b>${po.content}：</b>
		</div>
		<#-- update-begin-author:taoyan date:2018704  若按col-xs-5走 页面会乱 -->
		<div class="col-xs-2">
		<#-- update-end-author:taoyan date:2018704  若按col-xs-5走 页面会乱 -->
			<#if po.showType=='text'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
				<input id="${po.fieldName}" name="${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}" /> value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' />
				<#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
				<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
		   <#elseif po.showType=='popup'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<#-- update--begin--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
				<#-- update--begin--author:gj_shaojc Date:20180308 for:TASK #2548 【代码生成器】样式问题 -->
				<#-- update--begin--author:Yandong-- date:20180309--for:TASK #2550 【代码生成器】多tab风格生成的代码，popup有问题 --->
				<input id="${po.fieldName}" name="${po.fieldName}" type="text"  class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> <#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>  value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/> 
				<#-- update--end--author:Yandong-- date:20180309--for:TASK #2550 【代码生成器】多tab风格生成的代码，popup有问题 --->
				<#-- update--end--author:gj_shaojc Date:20180308 for:TASK #2548 【代码生成器】样式问题 -->
				<#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
			<#elseif po.showType=='textarea'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<textarea id="${po.fieldName}" class="form-control" rows="6" name="${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />>${'$'}{${entityName?uncap_first}Page.${po.fieldName}}</textarea>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
			<#elseif po.showType=='password'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
				<input id="${po.fieldName}" name="${po.fieldName}" type="password" maxlength="${po.length?c}" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' />
				<#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
				<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
			<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>	 
				<#-- update-begin-author:taoyan Date:20180519 for:dictselect改用标签便于以后统一修改 -->
				<@dictSelecttag po = po namePre="" valuePre = "${entityName?uncap_first}Page." formStyle="aces" opt="update" />
				<#-- update-end-author:taoyan Date:20180519 for:dicselect改用标签便于以后统一修改 -->
			<#elseif po.showType=='date'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<input id="${po.fieldName}" name="${po.fieldName}" type="text"  <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;"  class="form-control" onClick="WdatePicker()" value="<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type='date' pattern='yyyy-MM-dd'/>" />
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
			<#elseif po.showType=='datetime'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<input id="${po.fieldName}" name="${po.fieldName}" type="text" style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;" class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>  value="<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type='date' pattern='yyyy-MM-dd hh:mm:ss'/>" />
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
			<#--update-start--Author: jg_huangxg  Date:20160421 for：TASK #1027 【online】代码生成器模板不支持UE编辑器 -->
			<#elseif po.showType='umeditor'>
				<#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
				<#assign ue_widget_count = ue_widget_count + 1>
				<#if ue_widget_count == 1>
				<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
				<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
				</#if>
				<textarea name="${po.fieldName}" id="${po.fieldName}" style="width: 650px;height:300px">${'$'}{${entityName?uncap_first}Page.${po.fieldName} }</textarea>
				<script type="text/javascript">
					<#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
					var ${po.fieldName}_editor = UE.getEditor('${po.fieldName}');
					<#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
				</script>
			<#-- update--begin--author:taoyan date:20180514 for:【代码生成器】上传空间、树控件 宏封装 -->
			<#elseif po.showType=='file' || po.showType == 'image'>
				<@uploadtag po = po opt="update"/>
			<#elseif po.showType=='tree'>
				<@treetag po = po  opt="update" formStyle="ace"/>
			<#-- update--end--author:taoyan date:20180514 for:【代码生成器】上传空间、树控件 宏封装 -->
			<#else>
				<#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
				<input id="${po.fieldName}" name="${po.fieldName}" type="text" maxlength="${po.length?c}" style="width: 150px" class="form-control"  <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>   value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/>
				<#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
			</#if>
			<span class="Validform_checktip" style="float:left;height:0px;"></span>
			<label class="Validform_label" style="display: none">${po.content?if_exists?html}</label>
		</div>
		<#-- 字段内容结束 -->
		
		<#-- 行尾部开始 -->
			<#if ((po_index+1)%4==0 && (index_h+4)==(po_index+1)) || !po_has_next>
			</div>
			</#if>
		<#-- 行尾部结束 -->
		
		<#-- 模块尾部开始 -->
			<#if ((po_index+1)%8==0 && (index_m+8)==(po_index+1)) || !po_has_next>
					</div>
				</div>
			</div>
			</#if>
		<#-- 模块尾部结束 -->
	</#list>
	<#list pageAreatextColumns as po>
			<#if po_index%2==0>
			<#assign index_a = po_index>
			<div class="main-tab">
				<ul class="tab-info">
				  <li role="presentation" class="active">
					<a href="javascript:void(0);"> &nbsp;&nbsp;其他信息${po_index+1}</a>
				  </li>
				</ul>
				<!-- tab内容 -->
				<div class="con-wrapper1">
				  <div class="row form-wrapper">
				  <div class="row show-grid">
			</#if>
		
		<div class="col-xs-1 text-center">
			<b>${po.content}：</b>
		</div>
		<div class="col-xs-5">
			<#if po.showType=='textarea'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<#-- update--begin--author:gj_shaojc Date:20180315 for:TASK #2548 【代码生成器】样式问题-->
				<textarea id="${po.fieldName}" class="form-control" rows="6" name="${po.fieldName}" cols="28" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />>${'$'}{${entityName?uncap_first}Page.${po.fieldName}}</textarea>
				<#-- update--end--author:gj_shaojc Date:20180315 for:TASK #2548 【代码生成器】样式问题-->
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
			<#elseif po.showType='umeditor'>
				<#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
				<#assign ue_widget_count = ue_widget_count + 1>
				<#if ue_widget_count == 1>
				<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
				<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
				</#if>
				<textarea name="${po.fieldName}" id="${po.fieldName}" style="width: 650px;height:300px">${'$'}{${entityName?uncap_first}Page.${po.fieldName} }</textarea>
				<script type="text/javascript">
					var ${po.fieldName}_editor = UE.getEditor('${po.fieldName}');
				</script>
			</#if>
			<span class="Validform_checktip" style="float:left;height:0px;"></span>
			<label class="Validform_label" style="display: none">${po.content?if_exists?html}</label>
		</div>
			<#if (po_index%2==0 && po_index==(index_a+2)) || !po_has_next>
			</div></div></div></div>
			</#if>
	</#list>
	
</div>
</div>
<script type="text/javascript">
   $(function(){
	    //查看模式情况下,删除和上传附件功能禁止使用
		if(location.href.indexOf("load=detail")!=-1){
			$(".jeecgDetail").hide();
			$("input,select,textarea").attr("disabled","disabled");
		}
   });
</script>