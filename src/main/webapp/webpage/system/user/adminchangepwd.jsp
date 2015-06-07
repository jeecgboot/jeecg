<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>用户信息</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" refresh="false" dialog="true" action="userController.do?savenewpwdforuser" usePlugin="password" layout="table">
	<input id="id" type="hidden" name="id" value="${user.id }">
	<table style="width: 550px" cellpadding="0" cellspacing="1" class="formtable">
		<tbody>
			
			<tr>
				<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.password"/>: </label></td>
				<td class="value"><input type="password" class="inputxt" value="" name="password" plugin="passwordStrength" datatype="*6-18" errormsg="" /> <span class="passwordStrength"
					style="display: none;"><span><t:mutiLang langKey="common.weak"/></span><span><t:mutiLang langKey="common.middle"/></span><span class="last"><t:mutiLang langKey="common.strong"/></span> </span> <span class="Validform_checktip"><t:mutiLang langKey="password.rang6to18"/></span></td>
			</tr>
			<tr>
				<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.repeat.password"/>: </label></td>
				<td class="value"><input id="repassword" class="inputxt" type="password"  recheck="password" datatype="*6-18" errormsg="两次输入的密码不一致！"> <span
					class="Validform_checktip"><t:mutiLang langKey="common.repeat.password"/></span></td>
			</tr>
	
		</tbody>
	</table>
</t:formvalid>
</body>