<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript" charset="utf-8">
	/*
	 *	excel导出
	 */
	function courseListExportXls() {
		JeecgExcelExport("courseController.do?exportXls","courseList");
	}
	function courseListExportXlsByT() {
		JeecgExcelExport("courseController.do?exportXlsByT","courseList");
	}
	function courseListWordXlsByT() {
		JeecgExcelExport("courseController.do?exportDocByT","courseList");
	}
	function courseListExportXlsByTe() {
		JeecgExcelExport("courseController.do?exportXlsByTest","courseList");
	}
	function courseListImportXls() {
		openuploadwin('Excel导入', 'courseController.do?upload', "courseList");
	}
	
</script>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px"><t:datagrid name="courseList" title="课程" actionUrl="courseController.do?datagrid" idField="id" fit="true" queryMode="group">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="课程名称" field="name" query="true" autocomplete="true"></t:dgCol>
	<t:dgCol title="老师姓名" field="teacher_name" query="true" autocomplete="true"></t:dgCol>
	<t:dgCol title="老师照片" image="true" imageSize="400,200" field="teacher_pic"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
	<t:dgDelOpt title="删除" url="courseController.do?del&id={id}" />
	<t:dgToolBar title="录入" icon="icon-add" url="courseController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar title="编辑" icon="icon-edit" url="courseController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar title="查看" icon="icon-search" url="courseController.do?addorupdate" funname="detail"></t:dgToolBar>
	<t:dgToolBar title="导出Excel" icon="icon-search" onclick="courseListExportXls();"></t:dgToolBar>
	<t:dgToolBar title="导入Excel" icon="icon-search" onclick="courseListImportXls()"></t:dgToolBar>
	<t:dgToolBar title="Excel模板导出" icon="icon-search" onclick="courseListExportXlsByT()"></t:dgToolBar>
	<t:dgToolBar title="Excel模板导出统计" icon="icon-search" onclick="courseListExportXlsByTe()"></t:dgToolBar>
	<t:dgToolBar title="Word模板导出" icon="icon-search" onclick="courseListWordXlsByT()"></t:dgToolBar>
</t:datagrid></div>
</div>