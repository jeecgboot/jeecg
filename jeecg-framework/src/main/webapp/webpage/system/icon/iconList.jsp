<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<div class="easyui-layout" fit="true">
<div region="center" style="padding: 1px;"><t:datagrid name="iconList" title="图标列表" actionUrl="iconController.do?datagrid" idField="id">
	<t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
	<t:dgCol title="图标名称" query="true" field="iconName"></t:dgCol>
	<t:dgCol title="图标样式" field="iconClas"></t:dgCol>
	<t:dgCol title="图标类型" field="iconType" replace="系统图标_1,菜单图标_2"></t:dgCol>
	<t:dgCol title="图标" field="iconPath" image="true"></t:dgCol>
	<t:dgCol title="类型" field="extend"></t:dgCol>
	<t:dgCol title="操作" field="opt"></t:dgCol>
	<t:dgDelOpt url="iconController.do?del&id={id}" title="删除"></t:dgDelOpt>
	<t:dgToolBar title="图标录入" icon="icon-add" url="iconController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar title="图标修改" icon="icon-edit" url="iconController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar title="批量生成样式" icon="icon-edit" url="iconController.do?repair" funname="doSubmit"></t:dgToolBar>
</t:datagrid></div>
</div>
