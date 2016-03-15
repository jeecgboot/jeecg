<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>组织机构集合</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<%--update-start--Author:lijun  Date:20160301 for：组织机构查询显示为树形结构--%>
<t:datagrid name="departList" title="common.department.list" actionUrl="departController.do?departgrid" checkbox="true" showRefresh="false"
 treegrid="true" idField="id" pagination="false">
	<t:dgCol title="common.id" field="id"  treefield="id"  hidden="true"></t:dgCol>
	<t:dgCol title="common.department.name" field="departname" width="50"  treefield="text"></t:dgCol>
</t:datagrid>
<%--update-end--Author:lijun  Date:20160301 for：组织机构查询显示为树形结构--%>
</body>
</html>
