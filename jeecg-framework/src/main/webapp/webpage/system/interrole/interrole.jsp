<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title><t:mutiLang langKey="common.role.info"/></title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" action="interroleController.do?saveRole">
	<input name="id" type="hidden" value="${role.id}">
	<fieldset class="step">
	<div class="form"><label class="Validform_label"><t:mutiLang langKey="common.role.name"/>:</label> 
	<input name="roleName" class="inputxt" value="${role.roleName }" datatype="s2-8"> 
	<span class="Validform_checktip">
	<t:mutiLang langKey="rolescope.rang2to8.notnull"/>
	</span>
	</div>
	<div class="form">
	<label class="Validform_label"> 
		<t:mutiLang langKey="common.role.code"/>: 
	</label> 
	<input name="roleCode" id="roleCode" ajaxurl="interroleController.do?checkRole&code=${role.roleCode }" class="inputxt"
		value="${role.roleCode }" datatype="s2-15"> 
	<span class="Validform_checktip">
	<t:mutiLang langKey="rolecode.rang2to15.notnull"/>
	</span>
	</div>
	</fieldset>
</t:formvalid>
</body>
</html>
