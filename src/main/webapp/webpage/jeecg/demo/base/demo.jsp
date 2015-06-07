<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>DEMO编辑</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" action="demoController.do?saveDemo">
	<input type="hidden" name="id" id="id" value="${demo.id}">
	<fieldset class="step">
	<div class="form"><label class="Validform_label"> DEMO名称： </label> <input name="demotitle" class="inputxt" value="${demo.demotitle}" datatype="s2-50"> <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label"> DEMO地址： </label> <input name="demourl" class="inputxt" value="${demo.demourl}"> <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label"> 上级DEMO： </label> <t:comboTree url="demoController.do?pDemoList" name="TSDemo.id" id="pdemo" value="${demo.TSDemo.id }"></t:comboTree></div>
	<div class="form"><label class="Validform_label"> html代码： </label> <textarea cols="80" name="democode" rows="10" datatype="*">${demo.democode}</textarea></div>
	<div class="form"><label class="Validform_label"> 排序： </label> <input name="demoorder" class="inputxt" value="${demo.demoorder }" datatype="n"> <span class="Validform_checktip"></span></div>
	</fieldset>
</t:formvalid>
</body>
</html>
