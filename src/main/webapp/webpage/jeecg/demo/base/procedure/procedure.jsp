<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px">
<t:datagrid name="jeecgDemoList" title="DEMO示例列表" autoLoadData="true" actionUrl="jeecgProcedureController.do?datagrid" sortName="userName" fitColumns="true" idField="id" fit="true" queryMode="group" checkbox="true">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="用户名" field="userName" query="true" frozenColumn="true"  width="120"></t:dgCol>
	<t:dgCol title="电话号码" sortable="false" field="mobilePhone" query="true"  width="120"></t:dgCol>
	<t:dgCol title="办公电话" field="officePhone" width="120"></t:dgCol>
	<t:dgCol title="创建日期" field="createDate" editor="datebox" formatter="yyyy-MM-dd hh:mm:ss" query="true" queryMode="group" width="200"></t:dgCol>
	<t:dgCol title="邮箱" field="email" width="200"></t:dgCol>
	<t:dgCol title="年龄" sortable="true" editor="numberbox" field="age" width="80"></t:dgCol>
	<t:dgCol title="工资" field="salary" width="120"></t:dgCol>
	<t:dgCol title="生日" field="birthday" formatter="yyyy-MM-dd" hidden="true" width="120"></t:dgCol>
	<t:dgCol title="性别" sortable="true" field="sex" dictionary="sex" query="true" width="60"></t:dgCol>
	<t:dgCol title="状态" field="status" replace="未处理_0,已处理_1" width="60" query="true"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="150"></t:dgCol>
	<t:dgDelOpt operationCode="del" title="删除" url="jeecgDemoController.do?del&id={id}" />
	<t:dgToolBar operationCode="add" title="录入" icon="icon-add" url="jeecgDemoController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar operationCode="edit" title="编辑" icon="icon-edit" url="jeecgDemoController.do?addorupdate" funname="update"></t:dgToolBar>
</t:datagrid></div>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$("input[name='createDate_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("input[name='createDate_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("input[name='birthday']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
	});

</script>