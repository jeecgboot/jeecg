<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>用户信息</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" layout="table" beforeSubmit="upload">
	<input id="id" type="hidden" value="${id }">
	<table style="width: 500px" cellpadding="0" cellspacing="1" class="formtable">
		<tbody>
			<tr>
				<td class="value" id="test" colspan="2"></td>
			</tr>
			<tr>
				<td align="right"><span class="filedzt">签名文件:</span></td>
				<td class="value"><t:upload name="jfcl" buttonText="选择签名" queueID="test" multi="false" uploader="userController.do?savesign" extend="pic" id="file_upload" formData="formobj"></t:upload></td>
			</tr>
		</tbody>
	</table>
</t:formvalid>
</body>