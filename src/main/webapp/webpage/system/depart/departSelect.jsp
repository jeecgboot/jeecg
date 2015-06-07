<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>组织机构集合</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:datagrid name="departList" title="common.department.list" actionUrl="departController.do?departSelectDataGrid" idField="id" checkbox="true" showRefresh="false">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.department.name" field="departname" width="50"></t:dgCol>
</t:datagrid>
</body>
</html>
