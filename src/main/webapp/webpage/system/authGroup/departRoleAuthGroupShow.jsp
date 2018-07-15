<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>管理员组授权</title>
<t:base type="jquery,easyui,tools,ztree"></t:base>
<script type="text/javascript">
//加载ID,Name赋值文本框跳转授权页面
$(function(){
	var roleId = $("#id").val();
	var roleName = $("#roleName").val();
	var departAgId = $("#departAgId").val();
	$("#function-panel").panel(
			{
			title :roleName+ ':' + '<t:mutiLang langKey="current.permission"/>',
			href:"departAuthGroupController.do?funDepartRoleAuth&id="+roleId+"&pid="+departAgId
		}
	);
})

</script>
</head>
<body style="overflow: hidden;margin: -8px -1px;" scroll="no">
	<input id="id" name="id" type="hidden" value="${role.id}">
	<input id="roleName" name="roleName" type="hidden" value="${role.roleName}">
	<input id="departAgId" name="departAgId" type="hidden" value="${role.departAgId}">
	<div id="dd" class="easyui-tabs" data-options="tools:'#tab-tools'" style="width:auto;">
		<div title="角色授权">
			<div tools="#tt" class="easyui-panel" title='<t:mutiLang langKey="permission.set"/>' style="padding: 10px;" fit="true" border="false" id="function-panel"></div>
			<div id="tt"></div>
		</div>
	</div>
</body>
<script>
var divHeight = $(window).height();
$("#dd").css("height",divHeight+"px"); 
</script>
</html>
