<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding: 1px;">
<t:datagrid name="roleList" title="common.role.list" actionUrl="roleController.do?roleGrid" 
    idField="id" sortName="createDate" sortOrder="desc">
	<t:dgCol title="common.code" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.role.code" field="roleCode"></t:dgCol>
	<t:dgCol title="common.role.name" field="roleName" query="true"></t:dgCol>
	<t:dgCol title="common.createby" field="createBy" hidden="true"></t:dgCol>
	<t:dgCol title="common.createtime" field="createDate" formatter="yyyy-MM-dd" hidden="true"></t:dgCol>
	<t:dgCol title="common.updateby" field="updateBy" hidden="true"></t:dgCol>
	<t:dgCol title="common.updatetime" field="updateDate" formatter="yyyy-MM-dd" hidden="true"></t:dgCol>
	<t:dgCol title="common.operation" field="opt"></t:dgCol>
	<t:dgFunOpt funname="delRole(id)" title="common.delete"></t:dgFunOpt>
	<t:dgFunOpt funname="userListbyrole(id,roleName)" title="common.user"></t:dgFunOpt>
	<t:dgFunOpt funname="setfunbyrole(id,roleName)" title="permission.set"></t:dgFunOpt>
	<t:dgToolBar title="common.add.param" langArg="common.role" icon="icon-add" url="roleController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar title="common.edit.param" langArg="common.role" icon="icon-edit" url="roleController.do?addorupdate" funname="update"></t:dgToolBar>
</t:datagrid></div>
</div>
<div region="east" style="width: 600px;" split="true">
<div tools="#tt" class="easyui-panel" title='<t:mutiLang langKey="permission.set"/>' style="padding: 10px;" fit="true" border="false" id="function-panel"></div>
</div>
<div id="tt"></div>
</div>
<script type="text/javascript">
function setfunbyrole(id,roleName) {
	$("#function-panel").panel(
		{
			title :roleName+ ':' + '<t:mutiLang langKey="current.permission"/>',
			href:"roleController.do?fun&roleId=" + id
		}
	);
	$('#function-panel').panel("refresh" );
	
}
function userListbyrole(id,roleName) {
	$("#function-panel").panel(
		{
			title :roleName+ ':' + '<t:mutiLang langKey="common.user"/>',
			href:"roleController.do?userList&roleId=" + id
		}
	);
	$('#function-panel').panel("refresh" );
	
}
//删除角色
function delRole(id){
	var tabName= 'roleList';
	var url= 'roleController.do?delRole&id='+id;
	$.dialog.confirm('<t:mutiLang langKey="confirm.delete.this.record"/>', function(){
		doSubmit(url,tabName);
		rowid = '';
		$("#function-panel").html("");//删除角色后，清空对应的权限
	}, function(){
	});
}
</script>
