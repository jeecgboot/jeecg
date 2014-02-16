<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>通过JDBC访问数据库</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="jeecgJdbcController.do?save">
	<input id="id" name="id" type="hidden" value="${jeecgJdbcPage.id }">
	<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> age: </label></td>
			<td class="value"><input class="inputxt" id="age" name="age" ignore="ignore" value="${jeecgJdbcPage.age}" datatype="n"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> birthday: </label></td>
			<td class="value"><input class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width: 150px" id="birthday" name="birthday" ignore="ignore"
				value="<fmt:formatDate value='${jeecgJdbcPage.birthday}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> createTime: </label></td>
			<td class="value"><input class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width: 150px" id="createTime" name="createTime" ignore="ignore"
				value="<fmt:formatDate value='${jeecgJdbcPage.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> depId: </label></td>
			<td class="value"><input class="inputxt" id="depId" name="depId" ignore="ignore" value="${jeecgJdbcPage.depId}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> email: </label></td>
			<td class="value"><input class="inputxt" id="email" name="email" ignore="ignore" value="${jeecgJdbcPage.email}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> mobilePhone: </label></td>
			<td class="value"><input class="inputxt" id="mobilePhone" name="mobilePhone" ignore="ignore" value="${jeecgJdbcPage.mobilePhone}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> officePhone: </label></td>
			<td class="value"><input class="inputxt" id="officePhone" name="officePhone" ignore="ignore" value="${jeecgJdbcPage.officePhone}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> salary: </label></td>
			<td class="value"><input class="inputxt" id="salary" name="salary" ignore="ignore" value="${jeecgJdbcPage.salary}" datatype="d"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> sex: </label></td>
			<td class="value"><input class="inputxt" id="sex" name="sex" ignore="ignore" value="${jeecgJdbcPage.sex}"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> userName: </label></td>
			<td class="value"><input class="inputxt" id="userName" name="userName" value="${jeecgJdbcPage.userName}" datatype="*"> <span class="Validform_checktip"></span></td>
		</tr>
	</table>
</t:formvalid>
</body>