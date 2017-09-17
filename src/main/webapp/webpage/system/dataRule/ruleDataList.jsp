<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:datagrid name="operationList" title="operate.manage.data" actionUrl="functionController.do?ruledategrid&functionId=${functionId}" idField="id">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="规则名称" field="ruleName" width="50"></t:dgCol>
    <t:dgCol title="规则字段" field="ruleColumn" width="50"></t:dgCol>
    <t:dgCol title="规则条件" field="ruleConditions" width="50"></t:dgCol>
    <t:dgCol title="规则值" field="ruleValue" width="50"></t:dgCol>
    <t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
	<!-- 	//update-begin--Author:zhangjq  Date:20160904 for：1332 【系统图标统一调整】讲{系统管理模块}{在线开发}的链接按钮，改成ace风格 -->
	<t:dgDelOpt url="functionController.do?delrule&id={id}" title="common.delete" urlclass="ace_button"  urlfont="fa-trash-o"></t:dgDelOpt>
	<t:dgFunOpt funname="editoperation(id,operationname)" title="common.edit" urlclass="ace_button"  urlfont="fa-edit"></t:dgFunOpt>
	<!-- 	//update-end--Author:zhangjq  Date:20160904 for：1332 【系统图标统一调整】讲{系统管理模块}{在线开发}的链接按钮，改成ace风格 -->
	<t:dgToolBar title="common.add.param" langArg="common.operation" icon="icon-add" url="functionController.do?addorupdaterule&functionId=${functionId}" funname="add"></t:dgToolBar>
	</t:datagrid>
<script type="text/javascript">
function editoperation(operationId,operationname)
{
	createwindow("<t:mutiLang langKey="common.edit.param" langArg="common.operation"/>","functionController.do?addorupdaterule&functionId=${functionId}&id="+operationId);
}
</script>
