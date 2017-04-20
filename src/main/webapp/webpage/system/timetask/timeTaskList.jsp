<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px">
	<t:datagrid name="timeTaskList" title="schedule.task.manage" actionUrl="timeTaskController.do?datagrid" 
	    idField="id" fit="true" sortName="createDate" sortOrder="desc">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.taskid" field="taskId"></t:dgCol>
	<t:dgCol title="common.task.desc" field="taskDescribe"></t:dgCol>
	<t:dgCol title="cron.expression" field="cronExpression"></t:dgCol>
	<t:dgCol title="common.iseffect" field="isEffect" replace="未生效_0,已生效_1"></t:dgCol>
	<t:dgCol title="running.state" field="isStart" replace="停止_0,运行_1"></t:dgCol>
	<t:dgCol title="common.createby" field="createBy" hidden="true"></t:dgCol>
	<t:dgCol title="common.createtime" field="createDate" formatter="yyyy-MM-dd" hidden="true"></t:dgCol>
	<t:dgCol title="common.updateby" field="updateBy" hidden="true"></t:dgCol>
	<t:dgCol title="common.updatetime" field="updateDate" formatter="yyyy-MM-dd" hidden="true"></t:dgCol>
	<t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
	<!-- update-begin--Author:zhangjq  Date:20160904 for：[1342]【系统图标统一调整】讲{消息中间件}{系统监控}的链接按钮，改成ace风格的-->
	<t:dgConfOpt title="common.start" url="timeTaskController.do?startOrStopTask&id={id}&isStart=1" urlclass="ace_button"  urlfont="fa-play-circle" message="确认运行任务" exp="isStart#eq#0"/>
	<t:dgConfOpt title="common.stop" url="timeTaskController.do?startOrStopTask&id={id}&isStart=0" urlclass="ace_button"  urlfont="fa-stop" message="确认停止" exp="isStart#eq#1"/>
	<t:dgConfOpt title="effective.immediately" url="timeTaskController.do?updateTime&id={id}" urlclass="ace_button"  urlfont="fa-clock-o" message="确认更新任务时间"  exp="isEffect#eq#0"/>
	<t:dgDelOpt  url="timeTaskController.do?del&id={id}" title="common.delete" urlclass="ace_button"  urlfont="fa-trash-o"></t:dgDelOpt>
	<!-- update-end--Author:zhangjq  Date:20160904 for：[1342]【系统图标统一调整】讲{消息中间件}{系统监控}的链接按钮，改成ace风格的-->
	<t:dgToolBar title="common.add" icon="icon-add" url="timeTaskController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar title="common.edit" icon="icon-edit" url="timeTaskController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar title="common.view" icon="icon-search" url="timeTaskController.do?addorupdate" funname="detail"></t:dgToolBar>
</t:datagrid></div>
</div>
