<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page trimDirectiveWhitespaces="true"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>ckeditor+ckfinder例子</title>
<t:base type="ckfinder,ckeditor,jquery,easyui,tools,DatePicker"></t:base>
<link rel="stylesheet" type="text/css" href="plug-in/jquery-ui/css/ui-lightness/jquery-ui-1.9.2.custom.min.css">
</head>
<body>
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="jeecgDemoCkfinderController.do?save">
	<input id="id" name="id" type="hidden" value="${jeecgDemoCkfinderPage.id}">
	<table style="width: 870px; height: 500px;" cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> 图片: </label></td>
			<td class="value"><t:ckfinder name="image" uploadType="Images" value="${jeecgDemoCkfinderPage.image}" width="100" height="60" buttonClass="ui-button" buttonValue="上传图片"></t:ckfinder></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 附件: </label></td>
			<td class="value"><t:ckfinder name="attachment" uploadType="Files" value="${jeecgDemoCkfinderPage.attachment}" buttonClass="ui-button" buttonValue="上传附件"></t:ckfinder></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 备注: </label></td>
			<td class="value"><t:ckeditor name="remark" isfinder="true" value="${jeecgDemoCkfinderPage.remark}" type="width:750"></t:ckeditor></td>
		</tr>
	</table>
</t:formvalid>
</body>