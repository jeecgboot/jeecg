<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center"  style="padding:0px;border:0px"><t:datagrid name="fList" title="文件下载" actionUrl="systemController.do?documentList&typecode=files" idField="id" fit="true">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="标题" field="documentTitle" width="20" query="true"></t:dgCol>
	<t:dgCol title="创建时间" field="createdate"></t:dgCol>
	<t:dgCol title="类名" field="subclassname" hidden="true"></t:dgCol>
	<t:dgCol title="操作" field="opt"></t:dgCol>
	<t:dgDefOpt url="commonController.do?viewFile&fileid={id}&subclassname={subclassname}" title="下载"></t:dgDefOpt>
	<t:dgOpenOpt width="800" height="700" url="commonController.do?openViewFile&fileid={id}&subclassname={subclassname}" title="预览"></t:dgOpenOpt>
	<t:dgDelOpt url="systemController.do?delDocument&id={id}" title="删除"></t:dgDelOpt>
	<t:dgToolBar title="文件录入" icon="icon-add" funname="add" url="systemController.do?addFiles"></t:dgToolBar>
	<!-- 		update-begin--Author:huangzq  Date:20151205 for：[733]上传下载，没有编辑功能-->
	<t:dgToolBar title="编辑" icon="icon-edit" funname="update" url="systemController.do?editFiles"></t:dgToolBar>
	<!-- 		update-end--Author:huangzq  Date:20151205 for：[733]上传下载，没有编辑功能-->
</t:datagrid></div>
</div>
