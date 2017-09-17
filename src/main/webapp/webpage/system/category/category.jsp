<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>分类管理</title>
<!-- update-begin--author:LiShaoQing Date:20170809 for:[TASK 2268]点击添加，修改确定按钮无效 -->
<t:base type="jquery,easyui,tools"></t:base>
<!-- update-end--author:LiShaoQing Date:20170809 for:[TASK 2268]点击添加，修改确定按钮无效 -->
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
		<!-- //update-begin--Author:LiShaoQing  Date:20170816 for：[TASK #2284]界面大小调整 -->
		<table style="width: 500px;" cellpadding="0" cellspacing="1"
			class="formtable">
		<!-- //update-end--Author:LiShaoQing  Date:20170816 for：[TASK #2284]界面大小调整 -->
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
					<!-- update-start--Author:luobaoli  Date:20150606 for：将父ID传到后台，避免更新为空 -->
					<input id="pId" name="parent.id"type="hidden" value="${categoryPage.parent.id}">
					<!-- update-end--Author:luobaoli  Date:20150606 for：将父ID传到后台，避免更新为空 -->
					<input id="categoryTree" value="${categoryPage.parent.name}"> <input id="parentId" name="parent.code" style="display: none;" value="${categoryPage.parent.code}"> 
					<span class="Validform_checktip"></span></td>
			</tr>
		</table>
	</t:formvalid>
</body>