<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true">
	<fieldset class="step">
		<div class="form"><label class="form"> <t:mutiLang langKey="common.username"/>: </label> ${user.userName }</div>
		<div class="form"><label class="form"> <t:mutiLang langKey="common.surname"/>: </label> ${user.realName}</div>
		<div class="form"><label class="form"> <t:mutiLang langKey="common.phone"/>: </label> ${user.mobilePhone}</div>
		<div class="form"><label class="form"> <t:mutiLang langKey="common.office.tel"/>: </label> ${user.officePhone}</div>
		<div class="form"><label class="form"> <t:mutiLang langKey="common.mail"/>: </label> ${user.email}</div>
	</fieldset>
	</form>
</t:formvalid>
</body>
</html>

