<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker,ztree"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px">
 <t:datagrid name="roleList" title="接口角色列表" actionUrl="interroleController.do?roleGrid" fitColumns="true"  idField="id" sortName="id" sortOrder="desc" queryMode="group"   >
	<t:dgCol title="common.code" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="接口角色编码" field="roleCode" width="200"></t:dgCol>
	<t:dgCol title="接口角色名称" field="roleName" query="true" width="200"></t:dgCol>
	<t:dgCol title="common.createby" field="createBy" hidden="true"></t:dgCol>
	<t:dgCol title="common.createtime" field="createDate" formatter="yyyy-MM-dd" hidden="true"></t:dgCol>
	<t:dgCol title="common.updateby" field="updateBy" hidden="true"></t:dgCol>
	<t:dgCol title="common.updatetime" field="updateDate" formatter="yyyy-MM-dd" hidden="true"></t:dgCol>
	<t:dgCol title="common.operation" field="opt" width="300"></t:dgCol>
	<t:dgFunOpt funname="delRole(id)"  title="common.delete" urlclass="ace_button"  urlStyle="background-color:#ec4758;" urlfont="fa-trash-o"></t:dgFunOpt>
    <t:dgFunOpt funname="userListbyrole(id,roleName)" title="common.user" urlclass="ace_button"  urlfont="fa-user"></t:dgFunOpt>
	<t:dgFunOpt funname="setfunbyrole(id,roleName)" title="permission.set" urlclass="ace_button" urlStyle="background-color:#18a689;"  urlfont="fa-cog"></t:dgFunOpt>
	<t:dgToolBar    title="接口角色录入" langArg="common.role"   icon="icon-add" url="interroleController.do?addorupdate" funname="add"  ></t:dgToolBar>
	<t:dgToolBar   title="接口角色编辑" langArg="common.role"    icon="icon-edit" url="interroleController.do?addorupdate" funname="update"></t:dgToolBar>
	<%-- <t:dgToolBar title="excelImport" icon="fa fa-arrow-circle-left" funname="ImportXls"></t:dgToolBar>
	<t:dgToolBar title="excelOutput" icon="fa fa-arrow-circle-right" funname="ExportXls"></t:dgToolBar>
	<t:dgToolBar title="templateDownload" icon="fa fa-arrow-circle-o-down" funname="ExportXlsByT"></t:dgToolBar>
 --%>
 </t:datagrid></div>
</div>
<div region="east" style="width: 600px;" split="true">
<div tools="#tt" class="easyui-panel" title='<t:mutiLang langKey="接口权限设置"/>' style="padding: 10px;" fit="true" border="false" id="function-panel"></div>
</div>
<div id="tt"></div>
</div>
 

<script type="text/javascript">
function setfunbyrole(id,roleName) {
	$("#function-panel").panel(
		{
			title :roleName+ ':' + '<t:mutiLang langKey="current.permission"/>',
			href:"interroleController.do?fun&roleId=" + id
		}
	);
	//$('#function-panel').panel("refresh" );
	
}

function userListbyrole(id,roleName) {
	$("#function-panel").panel(
		{
			title :roleName+ ':' + '<t:mutiLang langKey="common.user"/>',
			href:"interroleController.do?userList&roleId=" + id
		}
	);
	//$('#function-panel').panel("refresh" );
	
}
//删除角色
function delRole(id){
	var tabName= 'roleList';
	var url= 'interroleController.do?delRole&id='+id;
	$.dialog.confirm('<t:mutiLang langKey="confirm.delete.this.record"/>', function(){
		doSubmit(url,tabName);
		rowid = '';
		$("#function-panel").html("");//删除角色后，清空对应的权限
	}, function(){
	});
}
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'roleController.do?upload', "roleList");
}

//导出
function ExportXls() {
	JeecgExcelExport("roleController.do?exportXls", "roleList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("roleController.do?exportXlsByT", "roleList");
}
</script>
