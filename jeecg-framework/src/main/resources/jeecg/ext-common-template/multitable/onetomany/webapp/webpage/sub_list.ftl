<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#include "/ui/tdgColcb.ftl"/>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<link rel="stylesheet" href="${'$'}{webRoot}/plug-in/mutitables/datagrid.menu.css" type="text/css"></link>
<style>.datagrid-toolbar{padding:0 !important;border:0}</style>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="${subsG['${key}'].entityName?uncap_first}List" filterBtn="true" checkbox="true" fitColumns="false" title="" actionUrl="${subsG['${key}'].entityName?uncap_first}Controller.do?datagrid" idField="id" fit="true" queryMode="group" onDblClick="datagridDbclick" onLoadSuccess="optsMenuToggle">
   <t:dgCol title="操作" field="opt" width="77" optsMenu="true"></t:dgCol>
   <t:dgFunOpt funname="curd.addRow" urlfont="fa-plus" title="新增一行" />
   <t:dgFunOpt funname="curd.deleteOne(id)" urlfont="fa-minus" title="删除该行" />
   <t:dgFunOpt inGroup="true" funname="curd.detail(id)" urlfont="fa-eye" title="查看详情"/>
   <t:dgFunOpt inGroup="true" exp="bpmStatus#eq#1"  funname="startProcess(id)" urlfont="fa-level-up" title="提交流程"/>
   <@dgcol columns=subColumnsMap['${key}'] noquery = "1"/>
  </t:datagrid>
  </div>
  	<input type="hidden" id = "${subsG['${key}'].entityName?uncap_first}ListMainId"/>
</div>
  <script type="text/javascript" src="${'$'}{webRoot}/plug-in/mutitables/mutitables.urd.js"></script>
  <script type="text/javascript" src="${'$'}{webRoot}/plug-in/mutitables/mutitables.curdInIframe.js"></script>
  <script type="text/javascript">
   $(document).ready(function(){
	  curd = $.curdInIframe({
		  name:"${subsG['${key}'].entityName?uncap_first}",
		  describe:"${subsG['${key}'].ftlDescription}",
		  urls:{
			  excelImport:'${entityName?uncap_first}Controller.do?commonUpload'
		  }
	  });
 	});
 	
  //双击行编辑
  function datagridDbclick(index,row,dgname){
	  $("#${subsG['${key}'].entityName?uncap_first}List").datagrid('beginEdit', index);
	  afterRowEdit(index);
  }
  
   /**
	* dataGrid 操作菜单 切换显示onloadSuccess 调用*/
   function optsMenuToggle(data){
  	  optsMenuToggleBydg($("#${subsG['${key}'].entityName?uncap_first}List").datagrid('getPanel'));
   }
   
  /**
   * 行编辑开启后需要处理相关列的选择事件
   * @editIndex 行编辑对应的行索引
   */
  function afterRowEdit(editIndex){
	  //TODO 
  }
 	
 //导出模板
 function exportExcelTemplate(){
	JeecgExcelExport("${subsG['${key}'].entityName?uncap_first}Controller.do?exportXlsByT","${subsG['${key}'].entityName?uncap_first}List");
 }
 //导出
 function ExportXls() {
	JeecgExcelExport("${subsG['${key}'].entityName?uncap_first}Controller.do?exportXls","${subsG['${key}'].entityName?uncap_first}List");
 }
  </script>