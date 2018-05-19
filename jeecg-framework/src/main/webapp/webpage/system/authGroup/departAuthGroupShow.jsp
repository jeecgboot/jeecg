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
	var groupId = $("#id").val();
	var groupName = $("#groupName").val();
	$("#function-panel").panel(
			{
			title :groupName+ ':' + '<t:mutiLang langKey="current.permission"/>',
			href:"departAuthGroupController.do?fun&id="+groupId
		}
	);
})

</script>
</head>
<body style="overflow: hidden;margin: -8px -1px;" scroll="no">
	<input id="id" name="id" type="hidden" value="${departAuthGroup.id}">
	<input id="groupName" name="groupName" type="hidden" value="${departAuthGroup.groupName}">
	<div id="dd" class="easyui-tabs" data-options="tools:'#tab-tools'" style="width:auto;">
		<div title="管理员组授权">
			<!-- 管理员组授权 -->
			<div tools="#tt" class="easyui-panel" title='<t:mutiLang langKey="permission.set"/>' style="padding: 10px;" fit="true" border="false" id="function-panel"></div>
			<div id="tt"></div>
		</div>
		<div title="设置管理员" data-options="tools:'#tab-tools'" style="padding:10px;overflow:auto;">
			<iframe scrolling="yes" frameborder="0"  src="departAuthGroupController.do?departGroupUserList&id=${departAuthGroup.id}" style="width:100%;height:100%;"></iframe>
		</div>
	</div>
</body>
<script>
var divHeight = $(window).height();
$("#dd").css("height",divHeight+"px"); 
</script>
</html>
