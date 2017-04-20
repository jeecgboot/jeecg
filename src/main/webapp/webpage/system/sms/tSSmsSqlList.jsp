<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tSSmsSqlList" checkbox="true" fitColumns="false" title="common.businessSqlTable" actionUrl="tSSmsSqlController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="common.esId"  field="id"  hidden="true"  queryMode="single"  ></t:dgCol>
   <t:dgCol title="common.sqlName"   width="300" query="true" field="sqlName"  queryMode="single"  ></t:dgCol>
   <t:dgCol title="common.sqlContent" width="600" query="true" field="sqlContent"  queryMode="single"  ></t:dgCol>
   <t:dgCol title="common.operate" width="200" field="opt"></t:dgCol>
   <t:dgDelOpt title="common.delete_2" url="tSSmsSqlController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o" />
   <t:dgToolBar title="common.add_2" icon="icon-add" url="tSSmsSqlController.do?goAdd" funname="add"></t:dgToolBar>
   <t:dgToolBar title="common.edit_2" icon="icon-edit" url="tSSmsSqlController.do?goUpdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="common.batchDelete"  icon="icon-remove" url="tSSmsSqlController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="common.view" icon="icon-search" url="tSSmsSqlController.do?goUpdate" funname="detail"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>