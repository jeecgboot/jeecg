<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,autocomplete"></t:base>
<div class="easyui-layout" fit="true">
	<div region="center"  style="padding:0px;border:0px">
		<t:datagrid sortName="createDate" sortOrder="desc"
			name="tableSelectPropertyList" title="smart.form.config"
			fitColumns="false" actionUrl="cgFormHeadController.do?datagrid"
			idField="id" fit="true">
			<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
			<t:dgCol title="table.type" field="jformType"
				replace="single.table_1,master.table_2,slave.table_3" query="true"></t:dgCol>
			<t:dgCol title="table.name" field="tableName" query="true"
				autocomplete="true" />
			<t:dgCol title="table.description" field="content"></t:dgCol>
		</t:datagrid>
	</div>
</div>

