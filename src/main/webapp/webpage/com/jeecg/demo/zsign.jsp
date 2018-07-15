<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>电子印章例子</title>
<link href="plug-in/zsign/css/jquery.zsign.css" rel="stylesheet" type="text/css" />
<script src="plug-in/zsign/js/jquery-1.7.1.min.js" type="text/javascript"></script>
<script src="plug-in/zsign/js/jquery.zsign.js" type="text/javascript"></script>
</head>
<body style="overflow-y: hidden" scroll="no">
 	<div id="test" style="width:595px;height:418px;border:1px solid red;margin:40px auto; position:relative;"><img src="plug-in/zsign/images/bg.png" /></div>
		<script>
			var a =$("#test").zSign({ img: 'plug-in/zsign/images/sign.gif'});
		</script>
		<div style="text-align:center;margin:50px 0; font:normal 14px/24px 'MicroSoft YaHei';">
	</div>
</body>