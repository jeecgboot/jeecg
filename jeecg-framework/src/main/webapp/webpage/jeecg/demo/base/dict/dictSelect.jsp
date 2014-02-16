<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery,easyui,tools"></t:base>
<title>数据字典演示</title>
</head>
<body style="overflow-y: hidden" scroll="no" onload="chageValue1();">
<t:formvalid formid="formobj" layout="div" dialog="true" action="##">
	<fieldset class="step"><t:dictSelect field="sex" typeGroupCode="sex" defaultVal="default" title="性别 Label"></t:dictSelect> <t:dictSelect field="sex" typeGroupCode="sex"
		defaultVal="default" hasLabel="false" title="性别(没有label)"></t:dictSelect></fieldset>
</t:formvalid>
</body>
</html>
