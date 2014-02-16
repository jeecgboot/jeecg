<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>乐观锁测试</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="optimisticLockingController.do?save">
	<input id="id" name="id" type="hidden" value="${optimisticLockingPage.id }">
	<input id="ver" name="ver" type="hidden" value="${optimisticLockingPage.ver}">
	<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> name: </label></td>
			<td class="value"><input class="inputxt" id="name" name="name" ignore="ignore" value="${optimisticLockingPage.name}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> age: </label></td>
			<td class="value"><input class="inputxt" id="age" name="age" ignore="ignore" value="${optimisticLockingPage.age}" datatype="n"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> account: </label></td>
			<td class="value"><input class="inputxt" id="account" name="account" ignore="ignore" value="${optimisticLockingPage.account}" datatype="n"> <span class="Validform_checktip"></span></td>
		</tr>
	</table>
</t:formvalid>
</body>