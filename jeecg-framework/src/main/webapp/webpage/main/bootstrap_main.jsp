<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>JEECG 微云快速开发平台</title>
<t:base type="jquery,easyui,tools,DatePicker,autocomplete"></t:base>
<link rel="stylesheet" href="plug-in/bootstrap/css/bootstrap.css" type="text/css"></link>
<style type="text/css">
.bootstrap-menu i {
	display: inline-block;
	width: 14px;
	height: 14px;
	margin-top: 1px;
	*margin-right: .3em;
	line-height: 14px;
	vertical-align: text-top;
	background-image: url("plug-in/bootstrap/img/glyphicons-halflings.png");
	background-repeat: no-repeat;
}

.bootstrap-center {
	height: 530px;
	overflow-y: auto;
	margin-top: -20px;
	margin-left: 2px;
	margin-right: 2px;
}

.bootstrap-icon {
	display: inline-block;
	width: 16px;
	height: 16px;
	line-height: 16px;
	vertical-align: text-top;
	background-repeat: no-repeat;
	background-image: url("plug-in/accordion/images/pictures.png");
}

.footer {
	margin-top: 10px;
}
</style>
</head>
<body>
<!-- 头部菜单导航-->
<div id="header">
<div class="navbar">
<div class="navbar-inner">
<div class="container-fluid"><a class="brand" href="http://www.jeecg.org" target="_blank">JEECG 演示系统 &nbsp;&nbsp;<span class="slogan"></span></a>
<div class="nav-no-collapse bootstrap-menu">

<ul class="nav pull-right usernav">
	<li style="line-height: 43px;"><span style="color: #CC33FF">当前用户:</span><span style="color: #666633">(${userName })</span> <span style="color: #CC33FF">职务</span>:<span style="color: #666633">${roleName
	}</span></li>
	<li class="dropdown"><a href="#" class="dropdown-toggle avatar" data-toggle="dropdown"> <i class="icon-wrench"></i> <span class="txt">控制面板</span> <b class="caret"></b> </a>
	<ul class="dropdown-menu">
		<li onclick="openwindow('用户信息','userController.do?userinfo')"><a href="javascript:;"><i class="icon-user"></i> 个人信息</a></li>
		<li onclick="add('修改密码','userController.do?changepassword')"><a href="javascript:;"><i class="icon-pencil"></i> 修改密码</a></li>
		<li onclick="add('修改首页风格','userController.do?changestyle')"><a href="javascript:;"><i class="icon-retweet"></i> 首页风格</a></li>
	</ul>
	</li>
	<li class="dropdown"><a href="#" class="dropdown-toggle avatar" data-toggle="dropdown"> <i class="icon-arrow-left"></i> <span class="txt">注销</span> <b class="caret"></b> </a>
	<ul class="dropdown-menu">
		<li onclick="exit('loginController.do?logout','确定退出该系统吗 ?',1);"><a href="javascript:;"><i class="icon-off"></i>退出系统</a></li>
	</ul>
	</li>
</ul>
</div>
<!-- /.nav-collapse --></div>
</div>
<!-- /navbar-inner --></div>
<!-- /navbar --></div>
<!-- End #header -->

<!-- 中间 -->
<div id="wrapper" class="bootstrap-center"></div>

<!-- 底部 -->
<footer class="footer">
<div class="container">
<ul class="footer-links">
	<li style="display: inline;">&copy; 版权所有<a href="http://www.jeecg.org" title="JEECG Framework 3.4.3 GA">JEECG Framework 3.4.3 GA</a></li>
	<li style="display: inline;">&nbsp;(推荐谷歌浏览器，获得更快响应速度) 技术支持:<a title="JEECG Framework 3.4.3 GA版本" href="http://www.jeecg.org">JEECG Framework 3.4.3 GA</a></li>
</ul>
</div>
</footer>
<script type="text/javascript" src="plug-in/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plug-in/accordion/js/bootstrap_main.js"></script>
</body>
</html>