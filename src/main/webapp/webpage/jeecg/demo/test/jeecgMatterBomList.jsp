<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px"><t:datagrid name="jeecgMatterBomList" title="物料Bom列表" actionUrl="jeecgMatterBomController.do?doTreeGrid" treegrid="true" idField="id"
	pagination="false">
	<t:dgCol title="编号" field="id" treefield="id" hidden="true" />
	<t:dgCol title="名称" field="name" treefield="text" />
	<t:dgCol title="编码" field="code" treefield="src" />
	<t:dgCol title="操作" field="opt" width="100" />
	<t:dgDelOpt title="删除" url="jeecgMatterBomController.do?doDelete&id={id}" />
	<t:dgToolBar title="录入" icon="icon-add" url="jeecgMatterBomController.do?goEdit" funname="add" operationCode="add" />
	<t:dgToolBar title="编辑" icon="icon-edit" url="jeecgMatterBomController.do?goEdit" funname="update" operationCode="update" />
</t:datagrid></div>
</div>