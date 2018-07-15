<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title><t:mutiLang langKey="common.add.param"/></title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" action="systemController.do?saveTypeGroup">
	<input name="id" type="hidden" value="${typegroup.id }">
	<fieldset class="step">
	<div class="form">
	<label class="Validform_label"> <t:mutiLang langKey="common.code"/>: </label> 
	<input name="typegroupcode" class="inputxt" validType="t_s_typegroup,typegroupcode,id" value="${typegroup.typegroupcode }" datatype="s2-10"> <span class="Validform_checktip"><t:mutiLang langKey="common.code.range" langArg="common.code,common.range2to8"/></span></div>
	<div class="form">
	<label class="Validform_label"> <t:mutiLang langKey="common.name"/>: </label> 
	<input name="typegroupname" class="inputxt" value="${typegroup.typegroupname }" datatype="s2-10"> <span class="Validform_checktip"><t:mutiLang langKey="common.name.range" langArg="common.name,common.range2to10"/></span></div>
	</fieldset>
</t:formvalid>
</body>
</html>
