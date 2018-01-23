<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>文件列表</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" beforeSubmit="upload">
	<input type="hidden" id="docId" <c:if test="${not empty doc }">value="${doc.id }"</c:if> >
	<fieldset class="step">
	<div class="form">
		<label class="Validform_label"> 文件标题: </label> 
		<input name="documentTitle" id="documentTitle" datatype="s3-50" value="${doc.documentTitle}" type="text"> 
		<span class="Validform_checktip">标题名称在3~50位字符,且不为空</span>
	</div>
	<div class="form">
		<t:upload name="fiels" buttonText="上传文件" uploader="jeecgFormDemoController.do?saveFiles&documentId=${doc.id}" extend="" id="file_upload" formData="documentTitle"></t:upload>
	</div>
	<div class="form" id="filediv" style="height: 50px">
		<c:if test="${not empty attachment }">
			<div class="row" style="margin-left:20px;">
				${attachment.attachmenttitle }.${attachment.extend }
			</div>
		</c:if>
	</div>
	</fieldset>
</t:formvalid>
</body>
</html>
