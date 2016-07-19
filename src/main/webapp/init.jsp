<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<body>
数据库初始化中.....
<script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.min.js"></script>
<script  type="text/javascript" src="plug-in/sliding/js/jquery.cookie.js"></script>
<script type="text/javascript">
    var iconCookieKey = "iconCookieKey";
    var iconCookieKeyForSlider = "iconCookieKeyForSlider";
    $.cookie(iconCookieKey, null);
    $.cookie(iconCookieKeyForSlider, null);
</script>
<script type="text/javascript">
    window.setTimeout(function() {
        window.location.replace('repairController.do?repair');
    }, 1000);
</script>
</body>
<head>
<title>JEECG 初始化数据库</title>
</head>
</html>
