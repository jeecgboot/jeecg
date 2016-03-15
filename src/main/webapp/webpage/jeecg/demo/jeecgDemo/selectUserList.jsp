<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<html>
<head>
<title>Popup示例</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<div class="easyui-layout" fit="true">
<div region="north" style="padding: 1px; height: 30px;"><span style="display: -moz-inline-box; display: inline-block;"> <span
	style="display: -moz-inline-box; display: inline-block; width: 80px; text-align: right;">用户名：</span> <input type="text" style="width: 100px" id="userName"> </span> <span
	style="display: -moz-inline-box; display: inline-block;"> <span style="display: -moz-inline-box; display: inline-block; width: 80px; text-align: right;">部门：</span> <select style="width: 104px"
	width="100" id="TSDepart_departname">
	<option value="">---请选择---</option>
	<option value="150">信息部</option>
	<option value="152">设计部</option>
	<option value="297e5a493d9f2cbc013d9f4450530001">研发室</option>
</select> </span> <span style="display: -moz-inline-box; display: inline-block;"> <span style="display: -moz-inline-box; display: inline-block; width: 80px; text-align: right;">真实姓名：</span> <input type="text"
	style="width: 100px" id="realName"> </span> <span style="display: -moz-inline-box; display: inline-block;"> <input type="button" value="查询" onclick="searchUserList();"> </span></div>
<div region="center" style="padding:0px;border:0px"><t:datagrid name="userList" title="用户管理" actionUrl="userController.do?datagrid" checkbox="true" fit="true" fitColumns="true" idField="id">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="用户名" sortable="false" field="userName" query="true"></t:dgCol>
	<t:dgCol title="部门" field="TSDepart_departname" query="true" queryMode="single" replace="${departsReplace}"></t:dgCol>
	<t:dgCol title="真实姓名" field="realName" query="true"></t:dgCol>
	<t:dgCol title="状态" sortable="true" field="status" replace="正常_1,禁用_0,超级管理员_-1"></t:dgCol>
</t:datagrid></div>
</div>
</body>
</html>
<script type="text/javascript">
	function searchUserList(){
		$('#userList').datagrid('reload',{
			userName: $("#userName").val(),
			TSDepart_departname: $("#TSDepart_departname").val(),
			realName:  $("#realName").val()
		});
	}
	function getSelectRows(){
		return $('#userList').datagrid('getChecked');
	}
</script>