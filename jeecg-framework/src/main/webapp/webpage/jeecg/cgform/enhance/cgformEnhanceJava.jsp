<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>按钮JAVA增强</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="cgformEnhanceJavaController.do?save">
	<input id="id" name="id" type="hidden" value="${cgformEnhanceJavaPage.id }">
	<input id="formId" name="formId" type="hidden" value="${cgformEnhanceJavaPage.formId }">
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="center" width="150px"><label class="Validform_label"> <t:mutiLang langKey="operate.code"/>: </label></td>
			<td class="value"><select id="buttonCode" name="buttonCode" datatype="*" style="width: 200px;" >
				<option value="add" <c:if test="${cgformEnhanceJavaPage.buttonCode=='add'}">selected="selected"</c:if>>add</option>
				<option value="update" <c:if test="${cgformEnhanceJavaPage.buttonCode=='update'}">selected="selected"</c:if>>update</option>
				<option value="delete" <c:if test="${cgformEnhanceJavaPage.buttonCode=='delete'}">selected="selected"</c:if>>delete</option>
				<c:forEach items="${buttonList}" var="button">
					<option value="${button.buttonCode }" <c:if test="${button.buttonCode==cgformEnhanceJavaPage.buttonCode}">selected="selected"</c:if>>${button.buttonCode}</option>
				</c:forEach>
			</select> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="center" width="150px"><label class="Validform_label"> <t:mutiLang langKey="common.type"/>: </label></td>
			<td class="value"><t:dictSelect field="cgJavaType" type="radio" typeGroupCode="enhanceType" hasLabel="false" defaultVal="${cgformEnhanceJavaPage.cgJavaType==null?'spring':(cgformEnhanceJavaPage.cgJavaType)}"></t:dictSelect><span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="center" width="150px"><label class="Validform_label"> <t:mutiLang langKey="common.value"/>: </label></td>
			<!--update-end--Author:luobaoli  Date:20150701 for：取消非空校验-->
			<td class="value"><input id="cgJavaValue" name="cgJavaValue" type="text" style="width: 300px;height: 26px" value="${cgformEnhanceJavaPage.cgJavaValue}"/><span class="Validform_checktip"></span></td>
			<!--update-end--Author:luobaoli  Date:20150701 for：取消非空校验-->
		</tr>
		<tr>
			<td align="center" width="150px"><label class="Validform_label"> <t:mutiLang langKey="common.iseffect"/>: </label></td>
			<td class="value">
				<input type="radio" name="activeStatus" value="0" ${cgformEnhanceJavaPage.activeStatus eq 0 ? 'checked' : '' } /><t:mutiLang langKey="common.disable"/>
				<input type="radio" name="activeStatus" value="1" ${empty cgformEnhanceJavaPage.activeStatus or cgformEnhanceJavaPage.activeStatus eq '1' ? 'checked' : '' } /><t:mutiLang langKey="common.enable"/>
				<span class="Validform_checktip"></span>
			</td>
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
			url : "cgformEnhanceJavaController.do?doCgformEnhanceJava&buttonCode="+buttonCode+"&formId="+formId,// 请求的action路径
			error : function() {// 请求失败处理函数
				alert('<t:mutiLang langKey="get.error"/>');
				frameElement.api.close();
			},
			success : function(data) {
				var d = data;
				if (d.success) {
					var cgformEnhanceJavaEntity = d.obj;
					$('#id').val(cgformEnhanceJavaEntity.id);
					$("input[type=radio][value='"+cgformEnhanceJavaEntity.cgJavaType+"']").attr("checked","checked");
					$('#cgJavaValue').val(cgformEnhanceJavaEntity.cgJavaValue);
				}else{
					$('#id').val("");
					$('#cgJavaType').val("");
					$('#cgJavaValue').val("");
				}
			}
		});
 });
</script>
</html>