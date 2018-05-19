<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>FCK模板</title>
<t:base type="jquery,easyui,tools,ckeditor"></t:base>
<SCRIPT type="text/javascript">
  function test(data) {
	  $.messager.alert('提示信息', data.msg);
		//closetab('TAB方式添加');
	}
  </SCRIPT>
</head>
<body>
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="cgformFtlController.do?saveEditor" >
	<input id="id" name="id" type="hidden" value="${cgformFtlPage.id}">
	<input id="cgformId" name="cgformId" type="hidden" value="${cgformFtlPage.cgformId}">
	<input id="ftlVersion" name="ftlVersion" type="hidden" value="${cgformFtlPage.ftlVersion}">
	<input id="ftlWordUrl" name="ftlWordUrl" type="hidden" value="${cgformFtlPage.ftlWordUrl}">
	<input id="createBy" name="createBy" type="hidden" value="${cgformFtlPage.createBy}">
	<input id="createName" name="createName" type="hidden" value="${cgformFtlPage.createName}">
	<input id="createDate" name="createDate" type="hidden" value="${cgformFtlPage.createDate}">
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label">模板名称:</label></td>
			<td class="value"><input class="inputxt" id="cgformName" name="cgformName" value="${cgformFtlPage.cgformName}" datatype="*"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label">模板:</label></td>
			<td class="value"><t:ckeditor name="ftlContent" type="height:500,width:1400"
				value="${cgformFtlPage.ftlContent == NULL || cgformFtlPage.ftlContent == '' ? cgformStr : cgformFtlPage.ftlContent}"></t:ckeditor></td>
		</tr>
	</table>
</t:formvalid>
</body>