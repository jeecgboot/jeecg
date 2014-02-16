<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<div class="easyui-layout" fit="true">
<div region="center" style="padding: 1px;">
<t:datagrid name="jeecgDemoList" title="DEMO示例列表" autoLoadData="true" actionUrl="jeecgDemoController.do?datagrid" sortName="userName" fitColumns="true"
	idField="id" fit="true" queryMode="group" checkbox="true">
	<%--   update-end--Author:tanghan  Date:20130713 for添加checkbox--%>
	<t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
	<t:dgCol title="用户名" field="userName" query="true" frozenColumn="true"></t:dgCol>
	<t:dgCol title="电话号码" sortable="false" field="mobilePhone" query="true"></t:dgCol>
	<t:dgCol title="办公电话" field="officePhone" query="true"></t:dgCol>
	<t:dgCol title="创建日期" field="createDate" formatter="yyyy-MM-dd hh:mm:ss" query="true" queryMode="group"></t:dgCol>
	<t:dgCol title="邮箱" field="email" query="true"></t:dgCol>
	<t:dgCol title="年龄" sortable="true" field="age" query="true"></t:dgCol>
	<t:dgCol title="工资" field="salary" query="true"></t:dgCol>
	<t:dgCol title="生日" field="birthday" formatter="yyyy/MM/dd" query="true"></t:dgCol>
	<t:dgCol title="性别" sortable="true" field="sex" dictionary="sex" query="true"></t:dgCol>
	<t:dgCol title="状态" field="status" query="true" replace="未处理_0,已处理_1"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="80"></t:dgCol>
	<t:dgFunOpt exp="status#eq#0" operationCode="szqm" funname="szqm(id)" title="审核" />
	<t:dgDelOpt operationCode="del" title="删除" url="jeecgDemoController.do?del&id={id}" />
	<t:dgToolBar operationCode="add" title="录入" icon="icon-add" url="jeecgDemoController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar operationCode="edit" title="编辑" icon="icon-edit" url="jeecgDemoController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar operationCode="detail" title="查看" icon="icon-search" url="jeecgDemoController.do?addorupdate" funname="detail"></t:dgToolBar>
	<t:dgToolBar operationCode="print" title="打印" icon="icon-print" url="jeecgDemoController.do?print" funname="detail"></t:dgToolBar>
	<t:dgToolBar title="批量删除" icon="icon-remove" url="jeecgDemoController.do?doDeleteALLSelect" funname="deleteALLSelect"></t:dgToolBar>
	<t:dgToolBar title="Xml导入测试" icon="icon-put" url="transdata.do?doMigrateIn" funname="doMigrateIn"></t:dgToolBar>
	<t:dgToolBar title="xml导出测试" icon="icon-putout" url="transdata.do?doMigrateOut" funname="doMigrateOut"></t:dgToolBar>
</t:datagrid></div>
</div>
<script type="text/javascript">
	function szqm(id) {
		createwindow('审核', 'jeecgDemoController.do?doCheck&id=' + id);
	}
	function getListSelections(){
		var ids = '';
		var rows = $("#jeecgDemoList").datagrid("getSelections");
		for(var i=0;i<rows.length;i++){
			ids+=rows[i].id;
			ids+=',';
		}
		ids = ids.substring(0,ids.length-1);
		return ids;
	}	
	//表单 sql导出
	function doMigrateOut(title,url,id){
		url += '&ids='+ getListSelections();
		window.location.href= url;
	}
	function doMigrateIn(){
		openuploadwin('Xml导入', 'transdata.do?toMigrate', "jeecgDemoList");
	}
	$(document).ready(function(){
		$("input[name='createDate_begin']").attr("class","easyui-datebox");
		$("input[name='createDate_end']").attr("class","easyui-datebox");
		$("input[name='birthday']").attr("class","easyui-datebox");
	});
</script>