<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div id="system_function_functionList" class="easyui-layout" fit="true"><%--   update-end--Author:duanql  Date:20130619 for：操作按钮窗口显示控制--%>
<div region="center" style="padding:0px;border:0px">
	<t:datagrid name="interfaceList" title="接口权限管理" actionUrl="interfaceController.do?interfaceGrid" idField="id" treegrid="true" pagination="false" btnCls="bootstrap btn btn-normal btn-xs">
        <t:dgCol title="common.id" field="id" treefield="id" hidden="true"></t:dgCol>
        <t:dgCol title="接口权限名称" field="interfaceName" treefield="text" width="100"></t:dgCol>
        <t:dgCol title="接口权限编码" field="interfaceCode" treefield="interfaceCode" width="100" formatterjs="getInterfaceCode"></t:dgCol>
        <t:dgCol title="接口权限地址" field="interfaceUrl" treefield="src" width="80"></t:dgCol>
        <t:dgCol title="请求方式" field="interfaceMethod" treefield="interfaceMethod" width="100" formatterjs="getInterfaceMethod"></t:dgCol>
        <t:dgCol title="排序" field="interfaceOrder" treefield="order" width="50"></t:dgCol>
        <t:dgCol title="common.operation" field="opt" width="120"></t:dgCol>
        <t:dgDelOpt url="interfaceController.do?del&id={id}" title="common.delete" urlclass="ace_button" urlStyle="background-color:#ec4758;" urlfont="fa-trash-o"></t:dgDelOpt>
        <t:dgFunOpt funname="operationData(id)" title="接口权限规则" urlclass="ace_button" urlStyle="background-color:#1a7bb9;" urlfont="fa-database"></t:dgFunOpt>
        <t:dgToolBar title="接口权限录入" langArg="common.menu" icon="fa fa-plus" url="interfaceController.do?addorupdate" height="400" funname="addFun"></t:dgToolBar>
        <t:dgToolBar title="接口权限编辑" langArg="common.menu" icon="fa fa-edit" url="interfaceController.do?addorupdate" height="490" funname="update"></t:dgToolBar>
    </t:datagrid>
</div>
</div>
<div data-options="region:'east',
	title:'<t:mutiLang langKey="operate.button.list"/>',
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
<div class="easyui-panel" style="padding:0px;border:0px" fit="true" border="false" id="operationDetailpanel"></div>
</div>
</div>

<script type="text/javascript">
$(function() {
	var li_east = 0;
});

function getInterfaceCode(value,rec,index){
	return rec.fieldMap.interfaceCode;
}
function getInterfaceMethod(value,rec,index){
	return rec.fieldMap.interfaceMethod;
}
//权限规则
function  operationData(interfaceId){
	if(li_east == 0){
	   $('#system_function_functionList').layout('expand','east'); 
	}
	$('#operationDetailpanel').panel("refresh", "interfaceController.do?dataRule&interfaceId=" +interfaceId);
}
function operationDetail(interfaceId)
{
	if(li_east == 0){
	   $('#system_function_functionList').layout('expand','east'); 
	}
	$('#operationDetailpanel').panel("refresh", "interfaceController.do?operation&interfaceId=" +interfaceId);
}
function addFun(title,url, id) {
	var rowData = $('#'+id).datagrid('getSelected');
	if (rowData) {
		url += '&TSInterface.id='+rowData.id;
	}
	add(title,url,'interfaceList',700,480);
}
</script>

