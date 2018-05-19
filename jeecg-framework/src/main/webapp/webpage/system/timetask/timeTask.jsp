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
	<input id="isStart" name="isStart" type="hidden" value="${(empty timeTaskPage.isStart)?0:timeTaskPage.isStart }">
	<fieldset class="step">
	<div class="form">
		<label class="Validform_label"><t:mutiLang langKey="common.taskid"/>:</label> 
		<input class="inputxt" id="taskId" name="taskId" value="${timeTaskPage.taskId}" datatype="*" style="width:50%"/> 
		<span class="Validform_checktip"></span>
	</div>
	<div class="form">
		<label class="Validform_label"><t:mutiLang langKey="common.task.desc"/>:</label> 
		<input class="inputxt" id="taskDescribe" name="taskDescribe" value="${timeTaskPage.taskDescribe}" datatype="*" style="width:50%"/> 
		<span class="Validform_checktip"></span>
	</div>
	<div class="form">
		<label class="Validform_label"><t:mutiLang langKey="cron.expression"/>:</label> 
		<input class="inputxt" id="cronExpression" name="cronExpression" value="${timeTaskPage.cronExpression}" datatype="*" style="width:50%"/> 
		<span class="Validform_checktip"></span>
	</div>
	<div class="form">
		<label class="Validform_label"><t:mutiLang langKey="common.task.className"/>:</label> 
		<input class="inputxt" id="className" name="className" value="${timeTaskPage.className}" datatype="*" style="width:50%"/> 
		<span class="Validform_checktip"></span>
	</div>
	<div class="form">
		<label class="Validform_label"><t:mutiLang langKey="common.task.runServerIp"/>:</label> 
		<input class="inputxt" id="runServerIp" name="runServerIp" value="${empty timeTaskPage.runServerIp ? '本地' : timeTaskPage.runServerIp}" datatype="*" style="width:50%"/> 
		<span class="Validform_checktip"></span>
	</div>
	<div class="form">
		<label class="Validform_label"><t:mutiLang langKey="common.task.runServer"/>:</label> 
		<input class="inputxt" id="runServer" name="runServer" value="${empty timeTaskPage.runServer ? '本地' : timeTaskPage.runServer}" datatype="*" style="width:50%"/> 
		<span class="Validform_checktip"></span>
	</div>
	</fieldset>
</t:formvalid>
</body>