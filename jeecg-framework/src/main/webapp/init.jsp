<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>JEECG 初始化数据库</title>
</head>
<body>
数据库初始化中.....
<script type="text/javascript">
		window.setTimeout(function() {
			window.location.replace('repairController.do?repair');
		}, 1000);
	</script>
</body>
</html>
