<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>分类管理</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
	$(function() {
		$('#categoryTree').combotree({
			url : 'categoryController.do?combotree',
			panelHeight : 200,
			width : 157,
			onClick : function(node) {
				$("#parentId").val(node.id);
			}
		});

		if ($('#id').val()) {
			$('#categoryTree').combotree('disable');
		}

	});
</script>
</head>
<body style="overflow-y: hidden" scroll="no">
	<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="categoryController.do?save">
		<input id="id" name="id" type="hidden" value="${categoryPage.id }">
		<table style="width: 500px;" cellpadding="0" cellspacing="1"
			class="formtable">
			<tr>
				<td align="right"><label class="Validform_label"> 类型名称:</label></td>
				<td class="value"><input class="inputxt" id="name" name="name" ignore="ignore" value="${categoryPage.name}"> <span class="Validform_checktip"></span></td>
			</tr>
			<%-- <tr>
				<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.icon" />:</label></td>
				<td class="value">
					<select name="icon.id">
						<c:forEach items="${iconlist}" var="icon">
							<option value="${icon.id}" <c:if test="${icon.id==categoryPage.icon.id}">selected="selected"</c:if> >
								<t:mutiLang langKey="${icon.iconName}" />
							</option>
						</c:forEach>
					</select>
				</td>
			</tr> --%>
			<tr>
				<td align="right"><label class="Validform_label"> 所属上级:</label></td>
				<td class="value">
					<input id="pId" name="parent.id"type="hidden" value="${categoryPage.parent.id}">
					<input id="categoryTree" value="${categoryPage.parent.name}"> <input id="parentId" name="parent.code" style="display: none;" value="${categoryPage.parent.code}"> 
					<span class="Validform_checktip"></span></td>
			</tr>
		</table>
	</t:formvalid>
</body>