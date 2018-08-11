<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<%--非当前组织机构的用户列表--%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div id="main_depart_list" class="easyui-layout" fit="true">
    <div region="center"  style="padding:0px;border:0px">
        <t:datagrid name="noCurDepartUserList" title="common.operation"
                    actionUrl="departController.do?addUserToOrgList&orgId=${orgId}" fit="true" fitColumns="true"
                    idField="id" checkbox="true" queryMode="group">
            <t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
            <t:dgCol title="common.username" sortable="false" width="100" field="userName" query="true"></t:dgCol>
            <t:dgCol title="common.real.name" field="realName" width="100" query="true"></t:dgCol>
            <t:dgCol title="common.user.type" field="userType" dictionary="user_type" width="80"></t:dgCol>
            <t:dgCol title="common.status" sortable="true" width="100" field="status" replace="common.active_1,common.inactive_0,super.admin_-1"></t:dgCol>
        </t:datagrid>
    </div>
</div>

<div style="display: none">
    <t:formvalid formid="formobj" layout="div" dialog="true" action="departController.do?doAddUserToOrg&orgId=${orgId}" beforeSubmit="setUserIds">
        <input id="userIds" name="userIds">
    </t:formvalid>
</div>
<script>
    function setUserIds() {
        $("#userIds").val(getUserListSelections('id'));
        return true;
    }

    function getUserListSelections(field) {
        var ids = [];
        var rows = $('#noCurDepartUserList').datagrid('getSelections');
        for (var i = 0; i < rows.length; i++) {
            ids.push(rows[i][field]);
        }
        ids.join(',');
        return ids
    }
</script>
