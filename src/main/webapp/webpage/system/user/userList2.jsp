<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px">
	<t:datagrid name="userList2" title="用户管理" actionUrl="userController.do?datagrid" idField="id" fit="true">
		<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
		<t:dgCol title="用户名" sortable="false" field="userName" width="20"></t:dgCol>
		<t:dgCol title="部门" field="TSDepart_departname"></t:dgCol>
		<t:dgCol title="真实姓名" field="realName" sortable="false"></t:dgCol>
		<t:dgCol title="状态" sortable="true" field="status" replace="正常_1,禁用_0,超级管理员_-1"></t:dgCol>
		<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
		<t:dgFunOpt funname="szqm(id)" title="设置签名" />
		<t:dgDelOpt title="删除" url="userController.do?del&id={id}&userName={userName}" />
	</t:datagrid>

   <div id="userListtb" style="padding: 3px; height: 25px">
	<div style="float: left;">
		<a href="#" id="add" class="easyui-linkbutton" plain="true" icon="icon-add" onclick="add('用户录入','userController.do?addorupdate','userList2')">用户录入</a> 
		<a href="#" class="update" plain="true" icon="icon-edit" onclick="update('用户编辑','userController.do?addorupdate','userList2')">用户编辑</a></div>
	<div align="right">
		用户名: <input class="easyui-validatebox" name="userName" style="width: 80px"> 
		真实姓名: <input class="easyui-validatebox" name="realName" style="width: 80px"> 
		<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="userListsearch();">查询</a>
	</div>
   </div>
</div>
</div>

<script type="text/javascript">
	function szqm(id) {
		createwindow('设置签名', 'userController.do?addsign&id=' + id);
	}
</script>
