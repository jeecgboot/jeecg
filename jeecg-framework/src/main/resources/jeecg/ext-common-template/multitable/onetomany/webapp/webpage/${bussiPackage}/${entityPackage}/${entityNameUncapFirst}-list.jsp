<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#include "../../ui/tdgCol.ftl"/>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<style>.datagrid-toolbar{padding:0 !important;border:0}</style>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="${entityName?uncap_first}List" checkbox="true" fitColumns="true" title="" actionUrl="${entityName?uncap_first}Controller.do?datagrid" idField="id" fit="true" queryMode="group" extendParams="checkOnSelect:false,onSelect:function(index,row){datagridSelect(index,row);}">
   <@dgcol columns=columns noquery = "1"/>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgFunOpt title="删除" funname="deleteMainRecord(id,{'${entityName?uncap_first}Controller.do?doDel'})"  urlclass="ace_button" urlfont="fa-trash-o"/>
  </t:datagrid>
  </div>
 </div>
  <script type="text/javascript" src="plug-in/mutitables/mutitables.urd.js"></script>
  <script type="text/javascript" src="plug-in/mutitables/mutitables.curdInIframe.js"></script>
  <script type="text/javascript">
 $(function(){
	  curd = $.curdInIframe({
		  name:"${entityName?uncap_first}",
		  isMain:true,
		  describe:"${ftl_description}",
		  form:{width:'100%',height:'100%'},
	  });
 });
 
 /**
  * 选中事件加载子表数据
  */
 function datagridSelect(index,row){
	$('#${entityName?uncap_first}List').datagrid('unselectAll');
 	parent.initSubList(row.id);
 }

 /**
  * 主页面重置调用方法
  */
 function queryResetit(){
	searchReset('${entityName?uncap_first}List');
	${entityName?uncap_first}Listsearch();
 }
 
 /**
  * 刷新子表数据
  */
 function refreshSubTable(){
	 parent.freshSubList();
 }
 </script>