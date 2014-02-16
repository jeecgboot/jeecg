<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>角色集合</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:datagrid name="roleList" title="按角色选择" actionUrl="userController.do?datagridRole" idField="id" checkbox="true" showRefresh="false">
	<t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
	<t:dgCol title="角色名称" field="roleName" width="50"></t:dgCol>
</t:datagrid>
</body>
</html>
