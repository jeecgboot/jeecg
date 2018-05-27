<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>

<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="dbSourceList" title="common.datasource.manage" actionUrl="dynamicDataSourceController.do?datagrid" idField="id" fit="true" sortName="id" sortOrder="desc">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.dbname" field="dbName" hidden="false" width="50"></t:dgCol>
	<t:dgCol title="common.datasrouce.key" field="dbKey" width="50"></t:dgCol>
	<t:dgCol title="common.description" field="description" width="60"></t:dgCol>
	<t:dgCol title="common.driverclass" field="driverClass" width="100"></t:dgCol>
	<t:dgCol title="common.datasrouce.url" field="url" width="120"></t:dgCol>
	<t:dgCol title="common.dbuser" field="dbUser" width="50"></t:dgCol>
	<t:dgCol title="common.dbpassword" field="dbPassword" width="100" hidden="true"></t:dgCol>
	<t:dgCol title="common.dbtype" field="dbType" width="50"></t:dgCol>
	<t:dgCol title="common.operation" field="opt" width="50"></t:dgCol>
<!-- update-begin--Author:zhangjq  Date:20160904 for：[1342]【系统图标统一调整】讲{消息中间件}{系统监控}的链接按钮，改成ace风格的-->
	<t:dgDelOpt title="common.delete" url="dynamicDataSourceController.do?del&id={id}"  urlclass="ace_button"  urlfont="fa-trash-o"/>
<!-- update-end--Author:zhangjq  Date:20160904 for：[1342]【系统图标统一调整】讲{消息中间件}{系统监控}的链接按钮，改成ace风格的-->
	<t:dgToolBar title="common.add" icon="icon-add" url="dynamicDataSourceController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar title="common.edit" icon="icon-edit" url="dynamicDataSourceController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar title="common.view" icon="icon-search" url="dynamicDataSourceController.do?addorupdate" funname="detail"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>