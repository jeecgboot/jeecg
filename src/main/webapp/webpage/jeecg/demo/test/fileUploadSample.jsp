<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE HTML>
<html>
<head>
<meta charset="utf-8">
<title>jQuery File Upload Example</title>
<script src="plug-in/jquery-plugs/fileupload/js/jquery.1.9.1.min.js"></script>

<script src="plug-in/jquery-plugs/fileupload/js/vendor/jquery.ui.widget.js"></script>
<script src="plug-in/jquery-plugs/fileupload/js/jquery.iframe-transport.js"></script>
<script src="plug-in/jquery-plugs/fileupload/js/jquery.fileupload.js"></script>

<!-- bootstrap just to have good looking page -->
<script src="plug-in/jquery-plugs/fileupload/bootstrap/js/bootstrap.min.js"></script>
<link href="plug-in/jquery-plugs/fileupload/bootstrap/css/bootstrap.css" type="text/css" rel="stylesheet" />

<!-- we code these -->
<link href="plug-in/jquery-plugs/fileupload/css/dropzone.css" type="text/css" rel="stylesheet" />
<script src="plug-in/jquery-plugs/fileupload/js/myuploadfunction.js"></script>
</head>

<body>
<div class="datagrid-toolbar" style="width:700px;padding:20px">

	<input id="fileupload" type="file" name="files[]" data-url="fileUploadController.do?upload" multiple>
	
	<div id="progress" class="progress">
    	<div class="bar" style="width: 0%;"></div>
	</div>

	<table id="uploaded-files" class="table">
		<tr  bgcolor="#EEEEEE">
			<th align="center" bgcolor="#EEEEEE">文件名</th>
			<th align="center" bgcolor="#EEEEEE">文件大小</th>
			<th align="center" bgcolor="#EEEEEE">文件类型</th>
			<th align="center" bgcolor="#EEEEEE">链接</th>
		</tr>
	</table>
	
</div>
</body> 
</html>
