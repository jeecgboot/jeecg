<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script type="text/javascript" src="plug-in/ztree/js/ztreeCreator.js" ></script>
<link rel="stylesheet" href="plug-in/ztree/css/zTreeStyle.css" type="text/css"/>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
<style>
/* 隐藏滚动条 */
#w {
	overflow-x: hidden;
	overflow-y: hidden;
}
/*隐藏滚动条  */
/* 页面样式 */

ul {
	list-style-type: none;
	list-style-image: none;
}

.conditionType {
	display: block;
	margin-bottom: 6px;
	padding: 6px 0 8px;
	width: 100%;
}

select {
	padding-right: 2px !important;
}

select {
	padding: 5px 7px;
}

textarea, input[type=text], input[type=password], select {
	font-family: "Verdana", "微软雅黑", "宋体", "Lucida Grande";
	padding: 3px;
	border: 1px solid #ddd;
	outline: 0;
	box-sizing: border-box;
}

#dsUL .conditionSelect {
	width: 200px;
}
/* 
.datagrid .panel-body {
	position: relative;
	overflow: auto;
}*/
/*页面样式  */
</style>
<div class="easyui-layout" fit="true">
	<div region="center" style="padding: 0px; border: 0px">
		<t:datagrid name="superQueryMainList" checkbox="true" complexSuperQuery="cgform" fitColumns="true" title="高级查询" actionUrl="superQueryMainController.do?datagrid" idField="id" fit="true" queryMode="group">
			<t:dgCol title="主键" field="id" hidden="true" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="查询规则名称" field="queryName" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="查询规则编码" field="queryCode" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="查询类型" field="queryType" queryMode="single" dictionary="sel_type" width="120"></t:dgCol>
			<t:dgCol title="说明" field="content" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
			<t:dgDelOpt title="删除" url="superQueryMainController.do?doDel&id={id}" urlclass="ace_button" urlfont="fa-trash-o" />
			<t:dgToolBar title="录入" icon="icon-add" url="superQueryMainController.do?goAdd" funname="add" width="100%" height="100%"></t:dgToolBar>
			<t:dgToolBar title="编辑" icon="icon-edit" url="superQueryMainController.do?goUpdate" funname="update" width="100%" height="100%"></t:dgToolBar>
			<t:dgToolBar title="批量删除" icon="icon-remove" url="superQueryMainController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
			<t:dgToolBar title="查看" icon="icon-search" url="superQueryMainController.do?goUpdate" funname="detail" width="100%" height="100%"></t:dgToolBar>
			<t:dgFunOpt funname="superQueryMainListSuperQuery(queryCode)" title="功能测试" urlfont="fa-search" urlclass="ace_button"></t:dgFunOpt>
		</t:datagrid>
	</div>
</div>