<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<t:base type="jquery,easyui,tools"></t:base>
<title>TABS</title>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:datagrid name="documentList" title="以TAB方式打开添加页面" actionUrl="systemController.do?documentList&typecode=news" idField="id" fit="true">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="标题" field="documentTitle" width="20"></t:dgCol>
	<t:dgCol title="创建时间" field="createdate"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
</t:datagrid>
<div id="documentListtb" style="padding: 5px; height: 25px">
<div style="float: left;"><a href="#" class="easyui-linkbutton" plain="true" icon="icon-add" onclick="add('弹出框添加','systemController.do?addNews')">弹出框打开添加页面</a> <a href="#"
	class="easyui-linkbutton" plain="true" icon="icon-edit" onclick="addbytab()">TAB方式打开添加页面</a></div>
</div>
</body>
<script type="text/javascript">
 function addbytab(){
	addOneTab("添加新闻", "systemController.do?addNews");
 }
 
 </script>
</html>
