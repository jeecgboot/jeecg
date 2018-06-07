<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>用户信息</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body >
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="userController.do?saveInterfaceUser">
	<input id="id" name="id" type="hidden" value="${user.id }"/>
	<input id="devFlag" name="devFlag" type="hidden" value="0"/>
	<input id="activitiSync" name="activitiSync" type="hidden" value="0"/>
	<input id="userType" name="userType" type="hidden" value="2"/>
	<input id="roleId" name="roleid" type="hidden" value="${roleId}"/>
	<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label">  <t:mutiLang langKey="common.username"/>:  </label>
            </td>
			<td class="value" width="85%">
                <c:if test="${user.id!=null }"> ${user.userName } </c:if>
                <c:if test="${user.id==null }">
                    <input id="userName" class="inputxt" name="userName" validType="t_s_base_user,userName,id" value="${user.userName }" datatype="*" />
                    <span class="Validform_checktip"></span>
                </c:if>
            </td>
		</tr>
		<c:if test="${!empty roleId }">
		<tr>
			<td align="right" width="25%" nowrap>
                <label class="Validform_label"> 所属接口角色:  </label>
            </td>
			<td class="value" width="85%">
                 ${roleName}
            </td>
		</tr>
		</c:if>
		<tr>
			<td align="right" width="10%" nowrap><label class="Validform_label"> <t:mutiLang langKey="common.real.name"/>: </label></td>
			<td class="value" width="10%">
                <input id="realName" class="inputxt" name="realName" value="${user.realName }" datatype="*"/>
                <span class="Validform_checktip"></span>
            </td>
		</tr>
		<c:if test="${empty user.id}">
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.password"/>: </label></td>
			<td class="value">
                   <input type="password" class="inputxt" value="" name="password" plugin="passwordStrength" datatype="*6-18" errormsg="" />
                   <span class="passwordStrength" style="display: none;">
                       <span><t:mutiLang langKey="common.weak"/></span>
                       <span><t:mutiLang langKey="common.middle"/></span>
                       <span class="last"><t:mutiLang langKey="common.strong"/></span>
                   </span>
                   <span class="Validform_checktip"> <t:mutiLang langKey="password.rang6to18"/></span>
               </td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.repeat.password"/>: </label></td>
			<td class="value">
                   <input id="repassword" class="inputxt" type="password" value="" recheck="password" datatype="*6-18" errormsg="两次输入的密码不一致！"/>
                   <span class="Validform_checktip"><t:mutiLang langKey="common.repeat.password"/></span>
               </td>
		</tr>
		</c:if>
		<tr>
			<td align="right" nowrap><label class="Validform_label">  <t:mutiLang langKey="common.phone"/>: </label></td>
			<td class="value">
                <input class="inputxt" name="mobilePhone" value="${user.mobilePhone}" datatype="m" errormsg="手机号码不正确" ignore="ignore"/>
                <span class="Validform_checktip"></span>
            </td>
		</tr>
		<tr>
			<td align="right" width="10%" nowrap><label class="Validform_label">备注: </label></td>
			<td class="value" width="10%">
                <textarea id="memo" name="memo" rows="5" cols="80">${user.memo}</textarea>
                <span class="Validform_checktip">填写备注</span>
            </td>
		</tr>
	</table>
</t:formvalid>
</body>