<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>WebOffice例子</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="webOfficeController.do?save">
	<input id="id" name="id" type="hidden" value="${webOfficePage.id }">
	<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> docid: </label></td>
			<td class="value"><input class="inputxt" id="docid" name="docid" ignore="ignore" value="${webOfficePage.docid}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> doctitle: </label></td>
			<td class="value"><input class="inputxt" id="doctitle" name="doctitle" ignore="ignore" value="${webOfficePage.doctitle}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> doctype: </label></td>
			<td class="value"><input class="inputxt" id="doctype" name="doctype" ignore="ignore" value="${webOfficePage.doctype}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> docdate: </label></td>
			<td class="value"><input class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width: 150px" id="docdate" name="docdate" ignore="ignore"
				value="<fmt:formatDate value='${webOfficePage.docdate}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> doccontent: </label></td>
			<td class="value"><input class="inputxt" id="doccontent" name="doccontent" ignore="ignore" value="${webOfficePage.doccontent}"> <span class="Validform_checktip"></span></td>
		</tr>
	</table>
</t:formvalid>
</body>