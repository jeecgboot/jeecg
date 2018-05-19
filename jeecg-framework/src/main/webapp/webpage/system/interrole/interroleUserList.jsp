<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<%--<t:datagrid name="userList" title="user.manage" actionUrl="roleController.do?roleUserDatagrid&roleId=${roleId}" fit="true" fitColumns="true" idField="id">--%>
<%--	<t:dgCol title="common.id" field="id" hidden="true" ></t:dgCol>--%>
<%--	<t:dgCol title="common.username" sortable="false" field="userName" width="5"></t:dgCol>--%>
<%--	<t:dgCol title="common.real.name" field="realName" width="5"></t:dgCol>--%>
<%--</t:datagrid>--%>

<t:datagrid name="interroleUserList" title="common.operation"
            actionUrl="interroleController.do?roleUserDatagrid&roleId=${roleId}" fit="true" fitColumns="true" idField="id" queryMode="group">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.username" sortable="false" field="userName" query="true"></t:dgCol>
	<t:dgCol title="common.real.name" field="realName" query="true"></t:dgCol>
	<t:dgCol title="common.status" sortable="true" field="status" replace="common.active_1,common.inactive_0,super.admin_-1"></t:dgCol>
	<t:dgCol title="common.operation" field="opt"></t:dgCol>
	<t:dgDelOpt title="common.delete" url="interroleController.do?delUserRole&userid={id}&roleid=${roleId }" urlclass="ace_button"  urlfont="fa-trash-o"/>
	<t:dgToolBar title="common.add.param" langArg="common.user" icon="icon-add" url="userController.do?addorupdateInterfaceUser&roleId=${roleId}" funname="add"></t:dgToolBar>
	<t:dgToolBar title="common.edit.param" langArg="common.user" icon="icon-edit" url="userController.do?addorupdateInterfaceUser&roleId=${roleId}" funname="update"></t:dgToolBar>
	<t:dgToolBar title="添加已有接口用户" icon="icon-add" url="interroleController.do?goAddUserToRole&roleId=${roleId}" funname="add" width="580"></t:dgToolBar>
</t:datagrid>

