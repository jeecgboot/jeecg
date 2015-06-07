<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>审核操作</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="jeecgDemoController.do?saveAuthor">
	<input id="id" name="id" type="hidden" value="${jeecgDemo.id }">
	<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right" width="15%" nowrap><label class="Validform_label"> 备注: </label></td>
			<td class="value" width="85%"><input id="content" class="inputxt" name="content" value="${jgDemo.content }" datatype="s2-10"> <span class="Validform_checktip">备注范围在2~10位字符</span></td>
		</tr>
	</table>
</t:formvalid>
</body>