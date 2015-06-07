<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Minidao例子</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: auto" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="div" action="jeecgMinidaoController.do?save">
	<input id="id" name="id" type="hidden" value="${jeecgMinidaoPage.id }">
	<fieldset class="step">
	<div class="form"><label class="Validform_label">用户名:</label> <input class="inputxt" id="userName" name="userName" value="${jeecgMinidaoPage.userName}" datatype="*"> <span
		class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label">手机:</label> <input class="inputxt" id="mobilePhone" name="mobilePhone" ignore="ignore" value="${jeecgMinidaoPage.mobilePhone}"> <span
		class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label">办公电话:</label> <input class="inputxt" id="officePhone" name="officePhone" ignore="ignore" value="${jeecgMinidaoPage.officePhone}"> <span
		class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label">电子邮箱:</label> <input class="inputxt" id="email" name="email" ignore="ignore" value="${jeecgMinidaoPage.email}"> <span
		class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label">年龄:</label> <input class="inputxt" id="age" name="age" ignore="ignore" value="${jeecgMinidaoPage.age}" datatype="n"> <span
		class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label">工资:</label> <input class="inputxt" id="salary" name="salary" ignore="ignore" value="${jeecgMinidaoPage.salary}" datatype="d"> <span
		class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label">生日:</label> <input class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width: 150px" id="birthday" name="birthday"
		ignore="ignore" value="<fmt:formatDate value='${jeecgMinidaoPage.birthday}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"> <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label">创建时间:</label> <input class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" style="width: 150px" id="createTime" name="createTime"
		ignore="ignore" value="<fmt:formatDate value='${jeecgMinidaoPage.createTime}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"> <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label">部门:</label> <select id="depId" name="depId" datatype="*">
		<c:forEach items="${departList}" var="depart">
			<option value="${depart.id }" <c:if test="${depart.id==jgDemo.depId}">selected="selected"</c:if>>${depart.departname}</option>
		</c:forEach>
	</select> <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label">性别:</label> <t:dictSelect field="sex" typeGroupCode="sex" hasLabel="false" defaultVal="${jgDemo.sex}"></t:dictSelect> <span
		class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label">状态:</label> <input class="inputxt" id="status" name="status" ignore="ignore" value="${jeecgMinidaoPage.status}"> <span
		class="Validform_checktip"></span></div>
	</fieldset>
</t:formvalid>
</body>