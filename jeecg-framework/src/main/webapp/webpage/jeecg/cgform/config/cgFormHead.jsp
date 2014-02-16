<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.jeecgframework.web.cgform.common.CgAutoListConstant"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>智能表单-表单维护</title>
<t:base type="jquery,easyui,jqueryui-sortable,tools"></t:base>
<script type="text/javascript" src="plug-in/cgform/js/cgformField.js"></script>
<style type="text/css">
.table-list {
	margin: 0;
	width: auto;
	margin-left: 0px;
	margin-right: 0px;
	overflow: hidden;
}

.table-list td,.table-list th {
	text-align: center;
}

.t_table {
	overflow: auto; /*让内容表格外面的div自动有滚动条*/
	margin-left: 0px;
	margin-right: 0px;
	width: auto;
	max-height: 240px;
}

#tab_div_database tr {
	border-bottom: 1px solid #e6e6e6;
	cursor: n-resize;
}
/*update-end--Author:liuht  Date:20131207 for[333]：OL模块，增加一个特效 调整字段顺序（上下挪动）*/
</style>
</head>
<body style="overflow-y: hidden; overflow-x: hidden;" scroll="no">
<!-- 增加beforeSubmit页面逻辑删除-->
<t:formvalid formid="formobj" dialog="true" usePlugin="password" beforeSubmit="deleteUnUsedFiled();" layout="table" tiptype="1" action="cgFormHeadController.do?save">
	<!-- tiptype="1" -->
	<input id="id" name="id" type="hidden" value="${cgFormHeadPage.id}">
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> 表名: </label></td>
			<td class="value" colspan="3">
			  <input class="inputxt" id="tableName" name="tableName" value="${cgFormHeadPage.tableName}"
				prefixName="" <c:if test="${not empty cgFormHeadPage.tableName}">readonly="readonly"</c:if> datatype="*" validType="cgform_head,table_Name,id" nullmsg="请输入表名！"> 
				<span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 主键策略:</label></td>
			<td class="value" id="jformPkTypeTd" <c:if test="${cgFormHeadPage.jformPkType ne 'SEQUENCE'}">colspan="3"</c:if>><select id="jformPkType" name="jformPkType" onchange="jformPkTypeChange();">
				<option value="UUID" <c:if test="${cgFormHeadPage.jformPkType eq 'UUID'}"> selected='selected'</c:if>>UUID(36位唯一编码)</option>
				<option value="NATIVE" <c:if test="${cgFormHeadPage.jformPkType eq 'NATIVE'}"> selected='selected'</c:if>>NATIVE(自增长方式)</option>
				<option value="SEQUENCE" <c:if test="${cgFormHeadPage.jformPkType eq 'SEQUENCE'}"> selected='selected'</c:if>>SEQUENCE(序列方式)</option>
			</select></td>
			<td align="right" id="jformPkSequenceN" <c:if test="${cgFormHeadPage.jformPkType ne 'SEQUENCE'}">style="display: none;"</c:if>><label class="Validform_label"> 序列名:</label></td>
			<td class="value" id="jformPkSequenceV" <c:if test="${cgFormHeadPage.jformPkType ne 'SEQUENCE'}">style="display: none;"</c:if>><input id="jformPkSequence" name="jformPkSequence" type="text"
				class="inputxt" value="${cgFormHeadPage.jformPkSequence}" /> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;"> 序列名:</label></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 表描述: </label></td>
			<td class="value"><input class="inputxt" id="content" name="content" value="${cgFormHeadPage.content}" datatype="s2-100"> <span class="Validform_checktip"></span></td>
			<td align="right"><label class="Validform_label"> 表类型: </label></td>
			<td class="value"><select id="jformType" name="jformType" onchange="jformTypeChange();">
				<option value="1" <c:if test="${cgFormHeadPage.jformType eq '1'}"> selected='selected'</c:if>>单表</option>
				<option value="2" <c:if test="${cgFormHeadPage.jformType eq '2'}"> selected="selected"</c:if>>主表</option>
				<option value="3" <c:if test="${cgFormHeadPage.jformType eq '3'}"> selected="selected"</c:if>>附表</option>
			</select>
			<div id="relation_type_div" style="display: none;"><input type="radio" name="relationType"
				<c:if test="${cgFormHeadPage.relationType eq '0' || cgFormHeadPage.relationType ==null }">checked="checked"</c:if> value="0">一对多</input> <input type="radio" name="relationType"
				<c:if test="${cgFormHeadPage.relationType eq '1' }">checked="checked"</c:if> value="1">一对一</input> &nbsp;序号：<input class="inputxt" style="width: 30px" id="tabOrder" name="tabOrder"
				value="${cgFormHeadPage.tabOrder}" datatype="n" ignore="ignore"></div>
			</td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 是否为树形: </label></td>
			<td class="value"><select id="isTree" name="isTree">
				<option value="N" <c:if test="${cgFormHeadPage.isTree eq 'N'}"> selected='selected'</c:if>>否</option>
				<option value="Y" <c:if test="${cgFormHeadPage.isTree eq 'Y'}"> selected='selected'</c:if>>是</option>
			</select></td>
			<td align="right"><label class="Validform_label"> 是否分页:</label></td>
			<td class="value"><select id="isPagination" name="isPagination">
				<option value="Y" <c:if test="${cgFormHeadPage.isPagination eq 'Y'}"> selected='selected'</c:if>>是</option>
				<option value="N" <c:if test="${cgFormHeadPage.isPagination eq 'N'}"> selected="selected"</c:if>>否</option>
			</select></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> 是否显示复选框: </label></td>
			<td class="value"><select id="isCheckbox" name="isCheckbox">
				<option value="N" <c:if test="${cgFormHeadPage.isCheckbox eq 'N'}"> selected="selected"</c:if>>否</option>
				<option value="Y" <c:if test="${cgFormHeadPage.isCheckbox eq 'Y'}"> selected="selected"</c:if>>是</option>
			</select></td>
			<td align="right"><label class="Validform_label"> 查询模式: </label></td>
			<td class="value"><select id="querymode" name="querymode">
				<option value="single" <c:if test="${cgFormHeadPage.querymode eq 'single'}"> selected="selected"</c:if>>单条件查询</option>
				<option value="group" <c:if test="${cgFormHeadPage.querymode eq 'group'}"> selected="selected"</c:if>>组合查询</option>
			</select></td>
		</tr>
		<c:if test="${cgFormHeadPage.jformType eq '2'}">
			<tr id="fb_tb">
				<td align="right"><label class="Validform_label">附表</label></td>
				<td class="value" colspan="3"><input class="inputxt" style="width: 440px" disabled="disabled" value="${cgFormHeadPage.subTableStr}"></td>
			</tr>
		</c:if>
	</table>
  <div id="tabs" class="easyui-tabs" tabPosition="top" fit="false" style="margin: 0px; padding: 0px; overflow: hidden; width: auto;">
    <div title="数据库属性" width="auto" style="width: auto; margin: 0px; padding: 0px; overflow: hidden;">
      <div style="height: 25px;" class="datagrid-toolbar"><a id="addColumnBtn" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addColumnBtnClick();" href="#">添加</a> <a
		id="delColumnBtn" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="delColumnBtnClick();" href="#">删除</a></div>
      <table id="tab_div_database_title" class="table-list" style="height: 25px;">
      </table>
      <div class="t_table" id="t_table_database">
        <table id="tab_div_database" class="table-list">
        </table>
      </div>
    </div>
    <div title="页面属性" style="overflow: hidden;">
      <table id="tab_div_page_title" class="table-list" style="height: 25px;">
      </table>
      <div class="t_table" id="t_table_page">
        <table id="tab_div_page" class="table-list">
        </table>
      </div>
    </div>
    <div title="校验字典" style="overflow: hidden;">
      <table id="tab_div_check_title" class="table-list" style="height: 25px;">
      </table>
      <div class="t_table" id="t_table_check">
        <table id="tab_div_check" class="table-list">
        </table>
      </div>
    </div>
    <div title="外键" style="overflow: hidden;">
      <table id="tab_div_key_title" class="table-list" style="height: 25px;">
      </table>
      <div class="t_table" id="t_table_key">
        <table id="tab_div_key" class="table-list">
        </table>
      </div>
    </div>
  </div>
</t:formvalid>

<iframe id="iframe_check" src="plug-in/cgform/fields/cgformOfCheck.html" style="display: none"></iframe>
<iframe id="iframe_database" src="plug-in/cgform/fields/cgformOfDatabase.html" style="display: none"></iframe>
<iframe id="iframe_key" src="plug-in/cgform/fields/cgformOfForeignKey.html" style="display: none"></iframe>
<iframe id="iframe_page" src="plug-in/cgform/fields/cgformOfPage.html" style="display: none"></iframe>
</body>