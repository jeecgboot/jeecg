<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>单表模型</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="transactionTestController.do?insertData">
	<fieldset >
		<legend>订单客户信息表</legend>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
			<tr>
				<td align="right"><label class="Validform_label"> 姓名: </label></td>
				<td class="value"><input class="inputxt" id="gocCusName" name="gocCusName" value="" > <span class="Validform_checktip"></span></td>
			</tr>

			<tr>
				<td align="right"><label class="Validform_label"> 订单号: </label></td>
				<td class="value"><input class="inputxt" id="goOrderCode" name="goOrderCode"   > <span class="Validform_checktip"></span></td>
			</tr>
		</table>
	</fieldset>
	<fieldset >
		<legend>JeecgDemo测试表</legend>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
			<tr>
				<td align="right"><label class="Validform_label"> 手机号码: </label></td>
				<td class="value"><input class="inputxt" id="mobilePhone" name="mobilePhone" value="" datatype="n"> <span class="Validform_checktip"></span></td>
			</tr>

			<tr>
				<td align="right"><label class="Validform_label"> 办公电话: </label></td>
				<td class="value"><input class="inputxt" id="officePhone" name="officePhone"  > <span class="Validform_checktip"></span></td>
			</tr>
		</table>
	</fieldset>
	<fieldset >
		<legend>Minidao例子</legend>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
			<tr>
				<td align="right"><label class="Validform_label"> 电子邮件: </label></td>
				<td class="value"><input class="inputxt" id="email" name="email" value="" > <span class="Validform_checktip"></span></td>
			</tr>

		</table>
	</fieldset>
	<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> 模拟回滚: </label></td>
			<td class="value"><select name="rollback">
				<option value="true">回滚</option>
				<option value="false">不回滚</option>
			</select> <span class="Validform_checktip"></span></td>
		</tr>


	</table>
</t:formvalid>
</body>