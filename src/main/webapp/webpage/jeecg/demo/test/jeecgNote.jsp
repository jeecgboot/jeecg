<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>单表模型</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="jeecgNoteController.do?save">
	<input id="id" name="id" type="hidden" value="${jeecgNotePage.id }">
	<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> 年龄: </label></td>
			<td class="value"><input class="inputxt" id="age" name="age" value="${jeecgNotePage.age}" datatype="n"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 生日: </label></td>
			<td class="value"><input class="Wdate" onClick="WdatePicker()" style="width: 150px" id="birthday" name="birthday" ignore="ignore"
				value="<fmt:formatDate value='${jeecgNotePage.birthday}' type="date" pattern="yyyy-MM-dd"/>"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 出生日期: </label></td>
			<td class="value"><input class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width: 150px" id="createdt" name="createdt"
				value="<fmt:formatDate value='${jeecgNotePage.createdt}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>" datatype="*"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 用户名: </label></td>
			<td class="value"><input class="inputxt" id="name" name="name" value="${jeecgNotePage.name}" datatype="*6-16"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 工资: </label></td>
			<td class="value"><input class="inputxt" id="salary" name="salary" value="${jeecgNotePage.salary}" datatype="d"> <span class="Validform_checktip"></span></td>
		</tr>
	</table>
</t:formvalid>
</body>