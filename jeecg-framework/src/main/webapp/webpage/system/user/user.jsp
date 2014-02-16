<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>用户信息</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="userController.do?saveUser">
	<input id="id" name="id" type="hidden" value="${user.id }">
	<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="15%" nowrap><label class="Validform_label"> 用户名: </label></td>
			<td class="value" width="85%"><c:if test="${user.id!=null }">
     ${user.userName }
     </c:if> <c:if test="${user.id==null }">
				<input id="userName" class="inputxt" name="userName" validType="t_s_base_user,userName,id" value="${user.userName }" datatype="s2-10" />
				<span class="Validform_checktip">用户名范围在2~10位字符</span>
			</c:if></td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap><label class="Validform_label"> 真实姓名: </label></td>
			<td class="value" width="10%"><input id="realName" class="inputxt" name="realName" value="${user.realName }" datatype="s2-10"> <span class="Validform_checktip">填写个人真实姓名</span></td>
		</tr>
		<c:if test="${user.id==null }">
			<tr>
				<td align="right"><label class="Validform_label"> 密码: </label></td>
				<td class="value"><input type="password" class="inputxt" value="" name="password" plugin="passwordStrength" datatype="*6-18" errormsg="" /> <span class="passwordStrength"
					style="display: none;"><span>弱</span><span>中</span><span class="last">强</span> </span> <span class="Validform_checktip">密码至少6个字符,最多18个字符</span></td>
			</tr>
			<tr>
				<td align="right"><label class="Validform_label"> 重复密码: </label></td>
				<td class="value"><input id="repassword" class="inputxt" type="password" value="${user.password}" recheck="password" datatype="*6-18" errormsg="两次输入的密码不一致！"> <span
					class="Validform_checktip">重复个人密码</span></td>
			</tr>
		</c:if>
		<tr>
			<td align="right"><label class="Validform_label"> 部门: </label></td>
			<td class="value"><select id="TSDepart.id" name="TSDepart.id" datatype="*">
				<c:forEach items="${departList}" var="depart">
					<option value="${depart.id }" <c:if test="${depart.id==user.TSDepart.id}">selected="selected"</c:if>>${depart.departname}</option>
				</c:forEach>
			</select> <span class="Validform_checktip">请选择部门</span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 角色: </label></td>
			<td class="value" nowrap><input name="roleid" name="roleid" type="hidden" value="${id}" id="roleid"> <input name="roleName" class="inputxt" value="${roleName }" id="roleName"
				readonly="readonly" datatype="*" /> <t:choose hiddenName="roleid" hiddenid="id" url="userController.do?roles" name="roleList" icon="icon-search" title="角色列表" textname="roleName" isclear="true"></t:choose>
			<span class="Validform_checktip">角色可多选</span></td>
		</tr>
		<tr>
			<td align="right" nowrap><label class="Validform_label"> 手机号码: </label></td>
			<td class="value"><input class="inputxt" name="mobilePhone" value="${user.mobilePhone}" datatype="m" errormsg="手机号码不正确!" ignore="ignore"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 办公电话: </label></td>
			<td class="value"><input class="inputxt" name="officePhone" value="${user.officePhone}" datatype="n" errormsg="办公室电话不正确!" ignore="ignore"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 常用邮箱: </label></td>
			<td class="value"><input class="inputxt" name="email" value="${user.email}" datatype="e" errormsg="邮箱格式不正确!" ignore="ignore"> <span class="Validform_checktip"></span></td>
		</tr>
	</table>
</t:formvalid>
</body>