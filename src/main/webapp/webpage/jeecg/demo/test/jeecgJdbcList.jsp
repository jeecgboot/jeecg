<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px"><t:datagrid name="jeecgJdbcList" title="通过JDBC访问数据库" actionUrl="jeecgJdbcController.do?datagrid" idField="id" fit="true"
	onDblClick="jeecgJdbcList_edit">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="姓名" field="userName" query="true"></t:dgCol>
	<t:dgCol title="部门" field="depId"></t:dgCol>
	<t:dgCol title="性别" field="sex"></t:dgCol>
	<t:dgCol title="年龄" field="age"></t:dgCol>
	<t:dgCol title="生日" field="birthday" formatter="yyyy-MM-dd hh:mm:ss"></t:dgCol>
	<t:dgCol title="E-Mail" field="email"></t:dgCol>
	<t:dgCol title="手机" field="mobilePhone" query="true"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
	<t:dgDelOpt title="删除" url="jeecgJdbcController.do?del&id={id}" />
	<t:dgToolBar title="录入" icon="icon-add" url="jeecgJdbcController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar title="编辑" icon="icon-edit" url="jeecgJdbcController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar title="查看" icon="icon-search" url="jeecgJdbcController.do?addorupdate" funname="detail"></t:dgToolBar>
</t:datagrid></div>
</div>

<script type="text/javascript">
	function jeecgJdbcList_edit(rowIndex,rowData) {
		createwindow("XXX编辑",'jeecgJdbcController.do?addorupdate&id='+rowData.id);
	}
</script>