<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>部门管理员组管理添加更新</title>
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
//提交form重置zTree,校验部门,部门一对一授权组
function saveObj() {
	var deptId = $("#deptId").val();
	var curId = $("#id").val();
	if(deptId == null && deptId == "") {
		tip("请选择部门");
		return false;	
	}
	$.ajax({
		url : "departAuthGroupController.do?checkDept",
		data : {
			"deptId":deptId,
			"curId":curId
		},
		type : "POST",
		success:function(data){
			var d = $.parseJSON(data);
			if(d.success) {
				$('#formobj').form('submit', {
					url : "departAuthGroupController.do?save",
					success : function(r) {
						$("#formobj", parent.loadTree());
						$("#formobj").find(":input").val("");
						tip("更新数据成功");
						location.replace("departAuthGroupController.do?addOrUpdate&id="+curId);
					}
				});
			}else {
				tip(d.msg);
			}
		},
		error:function(data) {
			var d = $.parseJSON(data);
			tip(d.msg);
		}
	});
}
//弹出部门选择框
	function openDepartmentSelect() {
		$.dialog.setting.zIndex = getzIndex(); 
		var deptId = $("#deptId").val();
		$.dialog({content: 'url:departAuthGroupController.do?departSelect&deptId='+deptId, zIndex: getzIndex(), title: '组织机构列表', lock: true, width: '400px', height: '350px', opacity: 0.4, button: [
		   {name: '<t:mutiLang langKey="common.confirm"/>', callback: callbackDepartmentSelect, focus: true},
		   {name: '<t:mutiLang langKey="common.cancel"/>', callback: function (){}}
	   ]}).zindex();
	}
//回调函数,把值赋值到对应的属性上
	function callbackDepartmentSelect() {
		var iframe = this.iframe.contentWindow;
		var treeObj = iframe.$.fn.zTree.getZTreeObj("departSelect");
		var nodes = treeObj.getCheckedNodes(true);
		if(nodes.length>0){
			$('#deptName').val(nodes[0].name);
			$('#deptName').blur();
			$('#deptId').val(nodes[0].id);
			$('#deptCode').val(nodes[0].code);
			$('#departType').val(nodes[0].type);
		}
	}
	$(function(){
		$("#deptName").prev().hide();
	});
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
			<tr>								
				<th style="width:350px;"><span>管理员组名称:</span></th>
				<td class="ng-binding">
					<input type="text" name="groupName" id="groupName" value="${departAuthGroup.groupName }" />
				</td>
			</tr>
			
			<c:set var="curId" value="${departAuthGroup.id}"></c:set>
			<tr>
				<th><span>部门名称:</span></th>
				<td class="ng-binding">
					<input id="deptId" name="deptId" type="hidden" value="${departAuthGroup.deptId}">
					<input id="deptName" name="deptName" type="text" value="${departAuthGroup.deptName}" <c:if test="${not empty curId}">onclick="javascript:void(0)" readonly="readonly"</c:if> onclick="openDepartmentSelect()">
				</td>
			</tr>
			<tr style="display:none">
				<th><span>部门编码:</span></th>
				<td class="ng-binding">
					<input type="hidden" value="${departAuthGroup.departType}" id="departType" name="departType">
					<input type="text" name="deptCode" id="deptCode" value="${departAuthGroup.deptCode }" />
				</td>
			</tr>
		</tbody>
	</table>
</t:formvalid>
</body>
</html>
