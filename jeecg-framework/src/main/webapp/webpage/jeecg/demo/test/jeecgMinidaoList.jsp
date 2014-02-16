<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<div class="easyui-layout" fit="true">
<div region="center" style="padding: 1px;"><t:datagrid name="jeecgMinidaoList" title="Minidao例子" actionUrl="jeecgMinidaoController.do?datagrid" idField="id" fit="true" queryMode="group">
	<t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
	<t:dgCol title="用户名" field="userName" query="true"></t:dgCol>
	<t:dgCol title="手机" field="mobilePhone" query="true"></t:dgCol>
	<t:dgCol title="办公电话" field="officePhone" query="true"></t:dgCol>
	<t:dgCol title="年龄" field="age"></t:dgCol>
	<t:dgCol title="电子邮箱" field="email"></t:dgCol>
	<t:dgCol title="工资" field="salary"></t:dgCol>
	<t:dgCol title="性别" field="sex" dictionary="sex" query="true"></t:dgCol>
	<t:dgCol title="状态" field="status" replace="未处理_0,已处理_1"></t:dgCol>
	<t:dgCol title="生日" field="birthday" formatter="yyyy-MM-dd hh:mm:ss"></t:dgCol>
	<t:dgCol title="创建时间" field="createTime" formatter="yyyy-MM-dd hh:mm:ss"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
	<t:dgDelOpt title="删除" url="jeecgMinidaoController.do?del&id={id}" />
	<t:dgToolBar title="录入" icon="icon-add" url="jeecgMinidaoController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar title="编辑" icon="icon-edit" url="jeecgMinidaoController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar title="查看" icon="icon-search" url="jeecgMinidaoController.do?addorupdate" funname="detail"></t:dgToolBar>
</t:datagrid></div>
</div>