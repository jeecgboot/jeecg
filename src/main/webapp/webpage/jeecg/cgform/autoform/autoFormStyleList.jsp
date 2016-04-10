<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="autoFormStyleList" checkbox="true" fitColumns="false" title="formstyle.title" actionUrl="autoFormStyleController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title=""  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="auto.form.formTempldateName"  field="styleDesc"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.createName"  field="createName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.createby"  field="createBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.createDate"  field="createDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.updateName"  field="updateName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.updateBy"  field="updateBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.updateDate"  field="updateDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.depart.code"  field="sysOrgCode"  hidden="true"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.company.code"  field="sysCompanyCode" hidden="true"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="common.delete" url="autoFormStyleController.do?doDel&id={id}" />
   <t:dgToolBar title="common.add" icon="icon-add" url="autoFormStyleController.do?goAdd" funname="add" width="100%" height="100%"></t:dgToolBar>
   <t:dgToolBar title="common.edit" icon="icon-edit" url="autoFormStyleController.do?goUpdate" funname="update" width="100%" height="100%"></t:dgToolBar>
   <t:dgToolBar title="common.batch.delete"  icon="icon-remove" url="autoFormStyleController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="common.query" icon="icon-search" url="autoFormStyleController.do?goUpdate" funname="detail" width="100%" height="100%"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 			$("#autoFormStyleListtb").find("input[name='createDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#autoFormStyleListtb").find("input[name='updateDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 });
 
 </script>