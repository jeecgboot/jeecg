<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>表单分离</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
	$(function() {
		$('#categoryTree').combotree({
			url : 'categoryController.do?combotree&selfCode=02',
			panelHeight : 200,
			width : 157,
			onClick : function(node) {
				$("#categoryId").val(node.id);
			}
		});
	});
</script>
</head>
<body style="overflow-y: hidden" scroll="no">
	<t:formvalid formid="formobj" dialog="true" usePlugin="password"
		layout="table" action="cgformCategoryController.do?save">
		<input id="id" name="id" type="hidden"
			value="${cgformCategoryPage.id }">
		<table style="width: 600px;" cellpadding="0" cellspacing="1"
			class="formtable">
			<tr>
				<td align="right"><label class="Validform_label"> 表单: </label></td>
				<td class="value"><input id="formId" name="form.id"
					value="${cgformCategoryPage.form.id}" type="hidden" >
					<input name="form.content" class="inputxt"
					value="${cgformCategoryPage.form.content }" id="content"
					readonly="readonly" datatype="*" /> <t:choose
						hiddenName="formId" hiddenid="id"
						url="cgFormHeadController.do?cgForms"
						name="tableSelectPropertyList" icon="icon-search"
						title="smart.form.config" textname="content" isclear="true"></t:choose></td>
			</tr>
			<tr>
				<td align="right"><label class="Validform_label"> 所属分类:
				</label></td>
				<td class="value"><input id="categoryTree"
					value="${cgformCategoryPage.category.name}"> <input
					id="categoryId" name="category.code"
					style="display: none;" value="${cgformCategoryPage.category.code}">
					<span class="Validform_checktip"></span></td>
			</tr>
		</table>
	</t:formvalid>
</body>