<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<%--   update-start--Author:duanql  Date:20130619 for：操作按钮窗口显示控制--%>
<div id="system_function_functionList" class="easyui-layout" fit="true"><%--   update-end--Author:duanql  Date:20130619 for：操作按钮窗口显示控制--%>
<div region="center" style="padding: 1px;"><t:datagrid name="functionList" title="菜单管理" actionUrl="functionController.do?functionGrid" idField="id" treegrid="true" pagination="false">
	<t:dgCol title="编号" field="id" treefield="id" hidden="false"></t:dgCol>
	<t:dgCol title="菜单名称" field="functionName" treefield="text"></t:dgCol>
	<t:dgCol title="图标" field="TSIcon_iconPath" treefield="code" image="true"></t:dgCol>
	<t:dgCol title="菜单地址" field="functionUrl" treefield="src"></t:dgCol>
	<t:dgCol title="菜单顺序" field="functionOrder" treefield="order"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
	<t:dgDelOpt url="functionController.do?del&id={id}" title="删除"></t:dgDelOpt>
	<%--   update-start--Author:anchao  Date:20130415 for：按钮权限控制--%>
	<t:dgFunOpt funname="operationDetail(id)" title="按钮设置"></t:dgFunOpt>
	<%--   update-end--Author:anchao  Date:20130415 for：按钮权限控制--%>
	<t:dgToolBar title="菜单录入" icon="icon-add" url="functionController.do?addorupdate" funname="addFun"></t:dgToolBar>
	<t:dgToolBar title="菜单编辑" icon="icon-edit" url="functionController.do?addorupdate" funname="update"></t:dgToolBar>
</t:datagrid></div>
</div>
<%--   update-start--Author:duanql  Date:20130619 for：操作按钮窗口显示控制--%>
<div data-options="region:'east',
	title:'操作按钮',
	collapsed:true,
	split:true,
	border:false,
	onExpand : function(){
		li_east = 1;
	},
	onCollapse : function() {
	    li_east = 0;
	}"
	style="width: 400px; overflow: hidden;">
<div class="easyui-panel" style="padding: 1px;" fit="true" border="false" id="operationDetailpanel"></div>
</div>
</div>

<script type="text/javascript">
<%--   update-start--Author:anchao  Date:20130415 for：按钮权限控制--%>
$(function() {
	var li_east = 0;
});
function operationDetail(functionId)
{
	if(li_east == 0){
	   $('#system_function_functionList').layout('expand','east'); 
	}
	$('#operationDetailpanel').panel("refresh", "functionController.do?operation&functionId=" +functionId);
}
<%--   update-end--Author:anchao  Date:20130415 for：按钮权限控制--%>
<%--   update-start--Author:jueyue  Date:20130622 for：菜单录入代入父菜单--%>
function addFun(title,url, id) {
	var rowData = $('#'+id).datagrid('getSelected');
	if (rowData) {
		url += '&TSFunction.id='+rowData.id;
	}
	add(title,url,'functionList');
}
<%--   update-end--Author:jueyue  Date:20130622 for：菜单录入代入父菜单--%>
</script>

