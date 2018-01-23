<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px">
<t:datagrid name="cgformButtonList" title="custom.button" actionUrl="cgformButtonController.do?datagrid&formId=${formId}" idField="id" fit="true">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="button.code" field="buttonCode"></t:dgCol>
	<t:dgCol title="button.name" field="buttonName"></t:dgCol>
	<t:dgCol title="button.style" field="buttonStyle"></t:dgCol>
	<t:dgCol title="action.type" field="optType"></t:dgCol>
	<t:dgCol title="common.show.sequence" field="orderNum"></t:dgCol>
	<t:dgCol title="common.show.icon.style" field="buttonIcon"></t:dgCol>
	<t:dgCol title="common.show.expression" field="exp"></t:dgCol>
	<t:dgCol title="common.status" field="buttonStatus" replace="common.active_1,common.inactive_0"></t:dgCol>
	<t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
	<t:dgDelOpt title="common.delete" url="cgformButtonController.do?del&id={id}&formId=${formId}" urlclass="ace_button"  urlfont="fa-trash-o" />
	<t:dgToolBar title="common.add" icon="icon-add" url="cgformButtonController.do?addorupdate&formId=${formId}" funname="add"></t:dgToolBar>
	<t:dgToolBar title="common.edit" icon="icon-edit" url="cgformButtonController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar title="common.view" icon="icon-search" url="cgformButtonController.do?addorupdate" funname="detail"></t:dgToolBar>
</t:datagrid>
</div>
</div>