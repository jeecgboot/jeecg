<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>表单自定义按钮</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="cgformButtonController.do?save">
	<input id="id" name="id" type="hidden" value="${cgformButtonPage.id }">
	<input id="formId" name="formId" type="hidden" value="${cgformButtonPage.formId }">
	<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> 按钮编码: </label></td>
			<td class="value"><input class="inputxt" id="buttonCode" name="buttonCode" ignore="ignore" value="${cgformButtonPage.buttonCode}"> <span class="Validform_checktip">编码不能是add/update/delete</span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 按钮名称: </label></td>
			<td class="value"><input class="inputxt" id="buttonName" name="buttonName" ignore="ignore" value="${cgformButtonPage.buttonName}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 按钮样式 </label></td>
			<td class="value"><select name="buttonStyle" id="buttonStyle">
				<option value="link" <c:if test="${cgformButtonPage.buttonStyle=='link'}">selected="selected"</c:if>>link</option>
				<option value="button" <c:if test="${cgformButtonPage.buttonStyle=='button'}">selected="selected"</c:if>>button</option>
			</select> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 动作类型 </label></td>
			<td class="value"><select name="optType" id="optType">
				<option value="js" <c:if test="${cgformButtonPage.optType=='js'}">selected="selected"</c:if>>js</option>
				<option value="action" <c:if test="${cgformButtonPage.optType=='action'}">selected="selected"</c:if>>action</option>
			</select> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 显示顺序 </label></td>
			<td class="value"><input class="inputxt" id="orderNum" name="orderNum" datatype="n" value="${cgformButtonPage.orderNum}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 显示图标样式 </label></td>
			<td class="value"><input class="inputxt" id="buttonIcon" name="buttonIcon" datatype="*"
				value="<c:if test="${cgformButtonPage.buttonIcon!=null&&cgformButtonPage.buttonIcon!=''}">${cgformButtonPage.buttonIcon}</c:if><c:if test="${cgformButtonPage.buttonIcon==null||cgformButtonPage.buttonIcon==''}">pictures</c:if>">
			<span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 显示表达式 </label></td>
			<td class="value"><input class="inputxt" id="exp" name="exp" ignore="ignore" value="${cgformButtonPage.exp}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 使用状态 </label></td>
			<td class="value"><select name="buttonStatus" id="buttonStatus">
				<option value="0" <c:if test="${cgformButtonPage.buttonStatus=='0'}">selected="selected"</c:if>>禁用</option>
				<option value="1" <c:if test="${cgformButtonPage.buttonStatus=='1'}">selected="selected"</c:if>>使用</option>
			</select> <span class="Validform_checktip"></span></td>
		</tr>
	</table>
</t:formvalid>
</body>
</html>