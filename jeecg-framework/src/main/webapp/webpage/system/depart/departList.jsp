<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<div id="main_depart_list" class="easyui-layout" fit="true">
<div region="center" style="padding: 1px;"><t:datagrid name="departList" title="部门列表" actionUrl="departController.do?departgrid" treegrid="true" idField="departid" pagination="false"
	onClick="queryUsersByRowData">
	<t:dgCol title="编号" field="id" treefield="id" hidden="false"></t:dgCol>
	<t:dgCol title="部门名称" field="departname" treefield="text"></t:dgCol>
	<t:dgCol title="职能描述" field="description" treefield="src"></t:dgCol>
	<t:dgCol title="操作" field="opt"></t:dgCol>
	<t:dgDelOpt url="departController.do?del&id={id}" title="删除"></t:dgDelOpt>
	<t:dgFunOpt funname="queryUsersByDepart(id)" title="查看成员"></t:dgFunOpt>
</t:datagrid>
<div id="departListtb" style="padding: 3px; height: 25px">
<div style="float: left;"><a href="#" class="easyui-linkbutton" plain="true" icon="icon-add" onclick="add('部门录入','departController.do?add','departList')">部门录入</a> <a href="#"
	class="easyui-linkbutton" plain="true" icon="icon-edit" onclick="update('部门编辑','departController.do?update','departList')">部门编辑</a></div>
</div>
</div>
</div>
<div data-options="region:'east',
	title:'成员列表',
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
<div class="easyui-panel" style="padding: 1px;" fit="true" border="false" id="userListpanel"></div>
</div>

<script type="text/javascript">
<!--
$(function() {
	var li_east = 0;
});

function queryUsersByRowData(rowData){
	if(li_east == 0){
	   $('#main_depart_list').layout('expand','east'); 
	}
	$('#userListpanel').panel("refresh", "departController.do?userList&departid=" + rowData.id);
}

function queryUsersByDepart(departid){
	if(li_east == 0){
	   $('#main_depart_list').layout('expand','east'); 
	}
	$('#userListpanel').panel("refresh", "departController.do?userList&departid=" + departid);
}
//-->
</script>