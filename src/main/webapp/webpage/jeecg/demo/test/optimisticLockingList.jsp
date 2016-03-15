<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px"><t:datagrid name="optimisticLockingList" title="乐观锁测试" actionUrl="optimisticLockingController.do?datagrid" idField="id" fit="true">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="name" field="name"></t:dgCol>
	<t:dgCol title="age" field="age"></t:dgCol>
	<t:dgCol title="account" field="account"></t:dgCol>
	<t:dgCol title="ver" field="ver"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
	<t:dgDelOpt title="删除" url="optimisticLockingController.do?del&id={id}" />
	<t:dgToolBar title="录入" icon="icon-add" url="optimisticLockingController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar title="编辑" icon="icon-edit" url="optimisticLockingController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar title="查看" icon="icon-search" url="optimisticLockingController.do?addorupdate" funname="detail"></t:dgToolBar>
</t:datagrid></div>
</div>