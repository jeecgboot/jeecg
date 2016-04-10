<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Excel导入Online字段</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" beforeSubmit="upload">
	<input id="headId" name="headId" type="hidden" value="${headId }">
	<fieldset class="step">
	<div class="form"><t:upload name="fiels" buttonText="选择要导入的文件" uploader="cgFormHeadController.do?importExcel" extend="*.xls;*.xlsx" id="file_upload" formData="headId"></t:upload></div>
	<div class="form" id="filediv" style="height: 50px"></div>
	<div class="form" style="height: 50px;"><a href="export/template/online_import_template.xls"><span style="color:blue">模板下载</span></a></div>
	</fieldset>
</t:formvalid>
</body>
</html>
