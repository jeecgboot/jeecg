<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
<div class="easyui-layout" fit="true">
<div region="center"  style="padding:0px;border:0px">
<t:datagrid name="${typegroup.typegroupcode}List" title="类型列表" actionUrl="systemController.do?typeGrid&typegroupid=${typegroup.id}" idField="id" queryMode="group" sortOrder="desc" sortName="id">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="类型名称" field="typename"></t:dgCol>
	<t:dgCol title="类型编码" field="typecode"></t:dgCol>
	<t:dgCol title="操作" field="opt"></t:dgCol>
	<t:dgDelOpt url="systemController.do?delType&id={id}" title="删除" urlclass="ace_button"  urlfont="fa-trash-o"></t:dgDelOpt>
	<t:dgToolBar title="${typegroup.typegroupname}录入" icon="icon-add" url="systemController.do?addorupdateType&typegroupid=${typegroup.id}" funname="add"></t:dgToolBar>
	<t:dgToolBar title="类别编辑" icon="icon-edit" url="systemController.do?addorupdateType&typegroupid=${typegroup.id}" funname="update"></t:dgToolBar>
</t:datagrid></div>
</div>

