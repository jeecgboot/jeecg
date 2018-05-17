<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#include "/ui/tdgCol.ftl"/>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<style>.datagrid-toolbar{padding:0 !important;border:0}</style>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="${subsG['${key}'].entityName?uncap_first}List" checkbox="true" fitColumns="true" title="" actionUrl="${subsG['${key}'].entityName?uncap_first}Controller.do?datagrid" idField="id" fit="true" queryMode="group">
  <@dgcol columns=subColumnsMap['${key}'] noquery = "1"/>
  <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
  <t:dgDelOpt title="删除" url="${subsG['${key}'].entityName?uncap_first}Controller.do?doDel&id={id}"  urlclass="ace_button" urlfont="fa-trash-o"/>
  </t:datagrid>
  </div>
  	<input type="hidden" id = "${subsG['${key}'].entityName?uncap_first}ListMainId"/>
</div>
  <script type="text/javascript" src="plug-in/mutitables/mutitables.urd.js"></script>
  <script type="text/javascript" src="plug-in/mutitables/mutitables.curdInIframe.js"></script>
  <script type="text/javascript">
   $(document).ready(function(){
	  curd = $.curdInIframe({
		  name:"${subsG['${key}'].entityName?uncap_first}",
		  describe:"${subsG['${key}'].ftlDescription}"
	  });
 	});
  </script>