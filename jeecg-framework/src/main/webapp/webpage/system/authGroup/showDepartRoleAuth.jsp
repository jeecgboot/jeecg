<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>部门角色信息展示</title>
<t:base type="jquery,easyui,tools"></t:base>

<style>
.table-form {
    width: 99.6%;
    font-size: 12px;
    margin: 2px auto;
}
table {
    border-spacing: 0;
    border-collapse: collapse;
}
.table-form tr th {
    width: 20%;
    height: 32px;
    background: #FBFBFF;
    color: #282831;
    padding: 0px 5px;
    text-align: right;
    border: 1px solid #EBECEF;
    font-weight: normal;
}
td, th {
    display: table-cell;
    vertical-align: inherit;
}
.table-form td {
    font-weight: normal;
    padding: 5px 5px;
    border: 1px solid #EBECEF;
}
td input {
	width : 156px !important;
}
</style>
</head>
<body style="overflow: hidden;" scroll="no">
<t:formvalid formid="formobj" layout="table" dialog="true" >
	<table class="table-form" cellspacing="0">
		<tbody>
			<tr>
				<th><span>管理员组名称:</span></th>
				<td class="ng-binding">
					<lable name="deptName">${departAuthGroup.deptName}</lable>
				</td>
			</tr>
			<tr>
				<th><span>部门名称:</span></th>
				<td class="ng-binding">
					<lable name="deptName">${departAuthGroup.groupName}</lable>
				</td>
			</tr>
			<tr>
				<th><span>部门编码:</span></th>
				<td class="ng-binding">
					<lable name="deptCode">${departAuthGroup.deptCode}</lable>
				</td>
			</tr>
		</tbody>
	</table>
</t:formvalid>
</body>
</html>
