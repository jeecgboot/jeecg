<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>DEMO示例</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="jeecgDemoController.do?save">
	<input id="id" name="id" type="hidden" value="${jgDemo.id }">
	<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable" id = "formtableId">
		<tr>
			<td align="right" width="15%" nowrap><label class="Validform_label"> 用户名: </label></td>
			<td class="value" width="85%"><c:if test="${jgDemo.id!=null }">
					     ${jgDemo.userName }
					     </c:if> <c:if test="${jgDemo.id==null }">
				<input id="userName" class="inputxt" name="userName" value="${jgDemo.userName }" datatype="*">
				<span class="Validform_checktip">用户名范围在2~10位字符</span>
			</c:if></td>
		</tr>
		<tr id= "add_phnoe">
			<td align="right" nowrap><label class="Validform_label"> 手机号码: </label></td>
			<td class="value"><input  class="inputxt" name="mobilePhone" value="${jgDemo.mobilePhone}" datatype="m" errormsg="手机号码不正确!" ignore="ignore"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 办公电话: </label></td>
			<td class="value"><input class="inputxt" name="officePhone" value="${jgDemo.officePhone}" datatype="n" errormsg="办公室电话不正确!" ignore="ignore"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 常用邮箱: </label></td>
			<td class="value"><input class="inputxt" name="email" value="${jgDemo.email}" datatype="e" errormsg="邮箱格式不正确!" ignore="ignore"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 年龄: </label></td>
			<td class="value"><input class="inputxt" name="age" value="${jgDemo.age}" datatype="n" errormsg="年龄格式不正确!" ignore="ignore"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 工资: </label></td>
			<td class="value"><input class="inputxt" name="salary" value="${jgDemo.salary}" datatype="d" errormsg="工资格式不正确!" ignore="ignore"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 生日: </label></td>
			<td class="value"><input name="birthday" class="Wdate" onClick="WdatePicker()" style="width: 150px" value="<fmt:formatDate value='${jgDemo.birthday }' type="date" pattern="yyyy-MM-dd"/>"
				errormsg="生日格式不正确!" ignore="ignore"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 创建日期: </label></td>
			<td class="value"><input name="createDate" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width: 150px"
				value="<fmt:formatDate value='${jgDemo.createDate }' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>" errormsg="日期格式不正确!" ignore="ignore"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 性别: </label></td>
			<td class="value"><t:dictSelect field="sex" typeGroupCode="sex" hasLabel="false" defaultVal="${jgDemo.sex}" readonly="readonly"></t:dictSelect> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 部门: </label></td>
			<td class="value"><select id="depId" name="depId" datatype="*">
				<c:forEach items="${departList}" var="depart">
					<option value="${depart.id }" <c:if test="${depart.id==jgDemo.depId}">selected="selected"</c:if>>${depart.departname}</option>
				</c:forEach>
			</select> <span class="Validform_checktip">请选择部门</span></td>
		</tr>
	</table>
</t:formvalid>
<t:authFilter name="formtableId"></t:authFilter>
</body>