<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>部门角色管理</title>
<t:base type="jquery,easyui,tools"></t:base>

<style>
.table-form {
    width: 99.6%;
    font-size: 12px;
    margin: 2px auto;
}
table {
    border-spacing: 0;
    border-collapse: collapse;
}
.table-form tr th {
    width: 20%;
    height: 32px;
    background: #FBFBFF;
    color: #282831;
    padding: 0px 5px;
    text-align: right;
    border: 1px solid #EBECEF;
    font-weight: normal;
}
td, th {
    display: table-cell;
    vertical-align: inherit;
}
.table-form td {
    font-weight: normal;
    padding: 5px 5px;
    border: 1px solid #EBECEF;
}
td input {
	width : 156px !important;
}
</style>
<script>
function saveObj() {
	debugger;
	var groupId = $("#id").val();
	var roleName = $("#roleName").val();
	var roleCode = $("#roleCode").val();
	$.ajax({
		url : "departAuthGroupController.do?saveDepartRoleAuth",
		data : {
			"groupId":groupId,
			"roleName":roleName,
			"roleCode":roleCode
		},
		type : "POST",
		success:function(data){
			var d = $.parseJSON(data);
			tip(d.msg);
			$("#formobj", parent.loadTree());
			$("#formobj").find(":input").val("");
			location.reload("departAuthGroupController.do?addDepartRoleAuth&id="+groupId);
		},
		error:function(data) {
			var d = $.parseJSON(data);
			tip(d.msg);
		}
	});
}
</script>
</head>
<body style="overflow: hidden;" scroll="no">
<t:formvalid formid="formobj" layout="table" dialog="true" >
<div class="datagrid-toolbar">
	<a class="easyui-linkbutton l-btn l-btn-plain" onclick="saveObj()">
		<i class="fa fa-plus"></i><span class="bigger-110 no-text-shadow"> 保  存</span>
	</a>
</div>
<input type="hidden" id="id" name="id" value="${departAuthGroup.id}"/>
<input type="hidden" id="level" name="level" value="${departAuthGroup.level}"/>
	<table class="table-form" cellspacing="0">
		<tbody>
			<c:set var="curId" value="${departAuthGroup.id}"></c:set>
			<tr>
				<th><span>管理员组名称:</span></th>
				<td class="ng-binding">
					<input type="text" id="groupName" readonly="readonly" name="groupName" value="${departAuthGroup.groupName}"/>
				</td>
			</tr>
			<tr>								
				<th style="width:350px;"><span>角色名称:</span></th>
				<td class="ng-binding">
					<input type="text" name="roleName" id="roleName" />
				</td>
			</tr>
			<tr>								
				<th style="width:350px;"><span>角色编码:</span></th>
				<td class="ng-binding">
					<input type="text" name="roleCode" id="roleCode" />
				</td>
			</tr>
			<input id="deptId" name="deptId" type="hidden" value="${departAuthGroup.deptId}">
			<input id="deptName" name="deptName" type="hidden" value="${departAuthGroup.deptName}">
			<input type="hidden" name="deptCode" id="deptCode" value="${departAuthGroup.deptCode }"/>
		</tbody>
	</table>
</t:formvalid>
</body>
</html>
