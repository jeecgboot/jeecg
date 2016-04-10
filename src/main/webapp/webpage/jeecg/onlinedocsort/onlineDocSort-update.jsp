<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
	<title>目录管理</title>
	<t:base type="jquery,easyui,tools"></t:base>
	<script type="text/javascript">
		$(function() {
			$('#onlineDocSortTree').combotree({
				url : 'onlineDocSortController.do?tree',
				panelHeight : 200,
				width : 157,
				onClick : function(node) {
					$("#parentId").val(node.id);
				}
			});
		});
	</script>
</head>
<body style="overflow-y: hidden" scroll="no">
	<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="onlineDocSortController.do?doUpdate">
		<input type="hidden" id="id" name="id" value="${onlineDocSortPage.id }"/>
		<table cellpadding="0" cellspacing="1" class="formtable">
			<tr>
				<td align="right">
					<label class="Validform_label">上级目录:</label>
				</td>
				<td class="value">
					<input id="onlineDocSortTree" value="${onlineDocSortPage.parent.name}">
					<input id="parentId" name="parent.id" style="display: none;" value="${onlineDocSortPage.parent.id}">
					<span class="Validform_checktip"></span>
				</td>
			</tr>
			<tr>
				<td align="right">
					<label class="Validform_label">目录名称:</label>
				</td>
				<td class="value">
					<input class="inputxt" id="name" name="name" ignore="ignore" value="${onlineDocSortPage.name}" style="vertical-align: middle;"/>
					<span class="Validform_checktip"></span>
				</td>
			</tr>
		</table>
	</t:formvalid>
</body>