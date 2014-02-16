<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>上传Word布局模板</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="div" beforeSubmit="upload">
	<input id="id" name="id" type="hidden" value="${cgformFtlPage.id }">
	<input id="cgformId" name="cgformId" type="hidden" value="${cgformFtlPage.cgformId }">
	<fieldset class="step">
	<div class="form">
	     <label class="Validform_label">表单模板名称:</label> 
	     <input class="inputxt" id="cgformName" name="cgformName" value="${cgformFtlPage.cgformName}" datatype="*"> 
	     <span class="Validform_checktip"></span></div>
	<div class="form">
	     <t:upload name="fiels" buttonText="选择Word模板文件" uploader="cgformFtlController.do?saveWordFiles" extend="*.doc" id="file_upload" formData="id,cgformId,cgformName,ftlVersion,ftlStatus"></t:upload>
	</div>
	<div class="form" id="filediv" style="height: 50px"></div>

	</fieldset>
</t:formvalid>
</body>