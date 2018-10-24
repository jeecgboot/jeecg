<!DOCTYPE t:base PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px">
<t:datagrid name="cgUploadFileList" idField="id" fit="true" fitColumns="true" title="" actionUrl="" autoLoadData="false" pagination="false">
	<t:dgCol title="主键" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="文件名称" field="attachmenttitle" formatterjs="concatNameAndExt" width="120"></t:dgCol>
	<t:dgCol title="realpath" field="realpath" hidden="true"></t:dgCol>
	<t:dgCol title="swfpath" field="swfpath" hidden="true"></t:dgCol>
	<t:dgCol title="extend" field="extend" hidden="true"></t:dgCol>
	<t:dgCol title="createdate" field="createdate" hidden="true"></t:dgCol>
	<t:dgCol title="操作" field="opt"></t:dgCol>
    <t:dgFunOpt title="预览" funname="iview(id)" urlclass="ace_button"  urlfont="fa-desktop" />
    <t:dgFunOpt title="下载" funname="idown(id)" urlclass="ace_button"  urlfont="fa-download" />
</t:datagrid>
</div>
</div>
<script>
function iview(id){
	var url = "commonController.do?openViewFile&fileid="+id+"&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity";
	openwindow('预览',url,'cgUploadFileList',700,500);
}
function idown(id){
	location.href = "commonController.do?viewFile&fileid="+id+"&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity";
}
function concatNameAndExt(value,row){
	if(!value){
		return "";
	}
	return value+"."+(row.extend?row.extend:"");
}

$(function(){
	$('#cgUploadFileList').datagrid('loadData',${datagridData});
});
</script>

