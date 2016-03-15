<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center"  style="padding:0px;border:0px">
<t:datagrid name="jeecgMinidaoList" title="menu.minidao.example" actionUrl="jeecgMinidaoController.do?datagrid" idField="id" fit="true" queryMode="group">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.username" field="userName" query="true" width="120"></t:dgCol>
	<t:dgCol title="common.moblePhone" field="mobilePhone" query="true" width="120"></t:dgCol>
	<t:dgCol title="common.tel" field="officePhone" query="true" width="120"></t:dgCol>
	<t:dgCol title="common.age" field="age" width="120"></t:dgCol>
	<t:dgCol title="common.email" field="email" width="120"></t:dgCol>
	<t:dgCol title="common.wage" field="salary" width="120"></t:dgCol>
	<t:dgCol title="common.sex" field="sex" dictionary="sex" query="true" width="120"></t:dgCol>
	<t:dgCol title="common.status" field="status" replace="未处理_0,已处理_1" width="120"></t:dgCol>
	<t:dgCol title="common.birthday" field="birthday" formatter="yyyy-MM-dd hh:mm:ss" width="120"></t:dgCol>
	<t:dgCol title="common.createtime" field="createTime" formatter="yyyy-MM-dd hh:mm:ss" width="120"></t:dgCol>
	<t:dgCol title="common.opt" field="opt" width="100"></t:dgCol>
	<t:dgDelOpt title="common.delete" url="jeecgMinidaoController.do?del&id={id}" />
	<t:dgToolBar title="common.add" icon="icon-add" url="jeecgMinidaoController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar title="common.edit" icon="icon-edit" url="jeecgMinidaoController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar title="common.search" icon="icon-search" url="jeecgMinidaoController.do?addorupdate" funname="detail"></t:dgToolBar>
</t:datagrid>
</div>
</div>