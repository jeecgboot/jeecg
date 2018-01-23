<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>用户信息</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" refresh="false" dialog="true" action="userController.do?saveportrait" usePlugin="password" layout="table">
	<input id="id" type="hidden" value="${user.id }">
			<div class="container">
				<t:webUploader auto="true" buttonText="选择头像" name="fileName" buttonStyle="btn-blue btn-S" type="image" fileNumLimit="3" displayTxt="flase"></t:webUploader>
				</div>
<%--		<tbody>
		<tr>
			<td>头像上传：</td>
		</tr>
		<tr>
			<td>

			</td>
		</tr>
		</tbody>
	</table>--%>
</t:formvalid>
</body>