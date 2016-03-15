<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script type="text/javascript" charset="utf-8">
	/*
	 *	excel导出
	 */
	function jpPersonListExportXls() {
		 window.location.href="jpPersonController.do?exportXls";
	}
	
	function jpPersonListImportXls() {
		add('Excel导入', 'jpPersonController.do?goImplXls', "jpPersonList");
	}
</script>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px"><t:datagrid name="jpPersonList" title="Excel导出" actionUrl="jpPersonController.do?datagrid" idField="id" fit="true">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="年龄" field="age"></t:dgCol>
	<t:dgCol title="生日" field="birthday" formatter="yyyy-MM-dd"></t:dgCol>
	<t:dgCol title="出生日期" field="createdt" formatter="yyyy-MM-dd hh:mm:ss"></t:dgCol>
	<t:dgCol title="用户名" field="name"></t:dgCol>
	<t:dgCol title="工资" field="salary"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
	<t:dgDelOpt title="删除" url="jpPersonController.do?del&id={id}" />
	<t:dgToolBar title="录入" icon="icon-add" url="jpPersonController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar title="编辑" icon="icon-edit" url="jpPersonController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar title="导出excel" onclick="jpPersonListExportXls();"></t:dgToolBar>
	<t:dgToolBar title="导入excel" onclick="jpPersonListImportXls()"></t:dgToolBar>
</t:datagrid></div>
</div>
