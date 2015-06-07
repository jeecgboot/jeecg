<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>课程</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="courseController.do?save">
	<input id="id" name="id" type="hidden" value="${coursePage.id }">
	<table style="width: 660px;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> 课程名称: </label></td>
			<td class="value"><input class="inputxt" id="name" name="name" ignore="ignore" value="${coursePage.name}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 老师姓名: </label></td>
			<td class="value"><input class="inputxt" id="teacher" name="teacher.name" ignore="ignore" value="${coursePage.teacher.name}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr style="display: none">
			<td align="right"><label class="Validform_label"> 老师Id: </label></td>
			<td class="value"><input class="inputxt" id="teacher" name="teacher.id" ignore="ignore" value="${coursePage.teacher.id}"> <span class="Validform_checktip"></span></td>
		</tr>
	</table>
	<div style="width: auto; height: 200px;"><%-- 增加一个div，用于调节页面大小，否则默认太小 --%>
	<div style="width: 690px; height: 1px;"></div>
	<t:tabs id="tt" iframe="false" tabPosition="top" fit="false">
		<t:tab href="courseController.do?studentsList&id=${coursePage.id}" icon="icon-search" title="产品明细" id="Product"></t:tab>
	</t:tabs></div>
</t:formvalid>
<table style="display: none">
	<tbody id="add_jeecgStudent_table_template">
		<tr>
			<td align="center"><input style="width: 20px;" type="checkbox" name="ck" /></td>
			<td align="left"><input name="students[#index#].name" maxlength="50" type="text" style="width:220px;"></td>
			<td align="left"><t:dictSelect field="students[#index#].sex" typeGroupCode="sex" hasLabel="false"></t:dictSelect></td>
        </tr>
	</tbody>
</table>
</body>