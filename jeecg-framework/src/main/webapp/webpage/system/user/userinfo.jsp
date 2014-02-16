<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true">
	<fieldset class="step"><legend> 用户信息 </legend>
	<div class="form"><label class="form"> 用户名: </label> ${user.userName }</div>
	<div class="form"><label class="form"> 姓名: </label> ${user.realName}</div>
	<div class="form"><label class="form"> 手机号码: </label> ${user.mobilePhone}</div>
	<div class="form"><label class="form"> 办公室电话: </label> ${user.officePhone}</div>
	<div class="form"><label class="form"> 邮箱: </label> ${user.email}</div>
	</fieldset>
	</form>
</t:formvalid>
</body>
</html>

