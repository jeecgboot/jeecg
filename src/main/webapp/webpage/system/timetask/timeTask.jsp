<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>定时任务管理</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="div" action="timeTaskController.do?save">
	<input id="id" name="id" type="hidden" value="${timeTaskPage.id }">
	<input id="isEffect" name="isEffect" type="hidden" value="${(empty timeTaskPage.isEffect)?0:timeTaskPage.isEffect}">
	<input id="isStart" name="isStart" type="hidden" value="${(empty timeTaskPage.isStart)?1:timeTaskPage.isStart }">
	<fieldset class="step">
	<div class="form"><label class="Validform_label"><t:mutiLang langKey="common.taskid"/>:</label> <input class="inputxt" id="taskId" name="taskId" value="${timeTaskPage.taskId}" datatype="*"> <span
		class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label"><t:mutiLang langKey="common.task.desc"/>:</label> <input class="inputxt" id="taskDescribe" name="taskDescribe" value="${timeTaskPage.taskDescribe}" datatype="*"> <span
		class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label"><t:mutiLang langKey="cron.expression"/>:</label> <input class="inputxt" id="cronExpression" name="cronExpression" value="${timeTaskPage.cronExpression}" datatype="*"> <span
		class="Validform_checktip"></span></div>
	</fieldset>
</t:formvalid>
</body>