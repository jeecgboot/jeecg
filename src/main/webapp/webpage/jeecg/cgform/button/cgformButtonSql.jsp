<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>按钮sql增强</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="cgformButtonSqlController.do?save">
	<input id="id" name="id" type="hidden" value="${cgformButtonSqlPage.id }">
	<input id="formId" name="formId" type="hidden" value="${cgformButtonSqlPage.formId }">
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="operate.code"/>: </label></td>
			<td class="value"><select id="buttonCode" name="buttonCode" datatype="*">
				<option value="add" <c:if test="${cgformButtonSqlPage.buttonCode=='add'}">selected="selected"</c:if>>add</option>
				<option value="update" <c:if test="${cgformButtonSqlPage.buttonCode=='update'}">selected="selected"</c:if>>update</option>
				<option value="delete" <c:if test="${cgformButtonSqlPage.buttonCode=='delete'}">selected="selected"</c:if>>delete</option>
				<c:forEach items="${buttonList}" var="button">
					<option value="${button.buttonCode }" <c:if test="${button.buttonCode==cgformButtonSqlPage.buttonCode}">selected="selected"</c:if>>${button.buttonCode}</option>
				</c:forEach>
			</select> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.description"/>: </label></td>
			<td class="value"><textarea id="content" name="content" cols="100" rows="3">${cgformButtonSqlPage.content}</textarea> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="enhance.sql"/>: </label></td>
			<td class="value"><textarea id="cgbSqlStr" name="cgbSqlStr" rows="25" cols="150">${cgformButtonSqlPage.cgbSqlStr }</textarea> <span class="Validform_checktip"></span></td>
		</tr>
	</table>
</t:formvalid>
</body>
<script type="text/javascript">
 $('#buttonCode').change(function() {
	 var buttonCode =$('#buttonCode').val();
	 var formId =$('#formId').val();
	 $.ajax({
			async : false,
			cache : false,
			type : 'POST',
			contentType : 'application/json', 
			dataType:"json",
			url : "cgformButtonSqlController.do?doCgformButtonSql&buttonCode="+buttonCode+"&formId="+formId,// 请求的action路径
			error : function() {// 请求失败处理函数
				alert('<t:mutiLang langKey="get.error"/>');
				frameElement.api.close();
			},
			success : function(data) {
				var d = data;
				if (d.success) {
					var cgformButtonSqlPage = d.obj;
					$('#id').val(cgformButtonSqlPage.id);
					$('#content').val(cgformButtonSqlPage.content);
					$('#cgbSqlStr').val(cgformButtonSqlPage.cgbSqlStr);
				}else{
					$('#id').val("");
					$('#content').val("");
					$('#cgbSqlStr').val("");
				}
			}
		});
	 
 });
</script>
</html>