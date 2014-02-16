<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>ckeditor+ckfinder例子预览</title>
<style type="text/css">
a {
	color: Black;
	text-decoration: none;
}

a:hover {
	color: black;
	text-decoration: none;
}
</style>
</head>
<body>
<div style="width: 750px; margin-left: auto; margin-right: auto;">${ckfinderPreview.remark}</div>
<!-- 底部 -->
<div region="south" border="false" style="height: 25px; overflow: hidden;">
<div align="center" style="color: #CC99FF; padding-top: 2px">&copy; 版权所有 <span class="tip"><a href="http://www.jeecg.org" title="JEECG_v3.1 Simple版本">JEECG_v3.1</a> (推荐谷歌浏览器，获得更快响应速度)
技术支持:<a href="#" title="JEECG_v3.1 Simple版本">JEECG_v3.1</a> </span></div>
</div>
</body>