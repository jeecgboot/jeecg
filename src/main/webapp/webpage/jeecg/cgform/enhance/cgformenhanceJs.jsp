<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title><t:mutiLang langKey="enhance.js"/></title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="cgformEnhanceJsController.do?save" >
	<input id="id" name="id" type="hidden" value="${cgformenhanceJsPage.id }">
	<input id="formId" name="formId" type="hidden" value="${cgformenhanceJsPage.formId }">
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="enhance.type"/>: </label></td>
			<td class="value"><select name="cgJsType" id="cgJsType">
				<option value="form" <c:if test="${cgformenhanceJsPage.cgJsType=='form'}">selected="selected"</c:if>>form</option>
				<option value="list" <c:if test="${cgformenhanceJsPage.cgJsType=='list'}">selected="selected"</c:if>>list</option>
			</select> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="enhance.js"/>: </label></td>
			<td class="value"><textarea id="cgJsStr" name="cgJsStr" cols="130" rows="30">${cgformenhanceJsPage.cgJsStr}</textarea> <span class="Validform_checktip"></span></td>
		</tr>
	</table>
</t:formvalid>
</body>
<script type="text/javascript">
 $('#cgJsType').change(function() {
	 var cgJsType =$('#cgJsType').val();
	 var formId =$('#formId').val();
	 $.ajax({
			async : false,
			cache : false,
			type : 'POST',
			contentType : 'application/json', 
			dataType:"json",
			url : "cgformEnhanceJsController.do?doCgformEnhanceJs&cgJsType="+cgJsType+"&formId="+formId,// 请求的action路径
			error : function() {// 请求失败处理函数
				alert('<t:mutiLang langKey="get.error"/>');
				frameElement.api.close();
			},
			success : function(data) {
				var d = data;
				if (d.success) {
					var cgformenhanceJsPage = d.obj;
					$('#id').val(cgformenhanceJsPage.id);
					$('#cgJsStr').val(cgformenhanceJsPage.cgJsStr);
				}else{
					$('#id').val("");
					$('#cgJsStr').val("");
				}
			}
		});
	 
 });
</script>
</html>