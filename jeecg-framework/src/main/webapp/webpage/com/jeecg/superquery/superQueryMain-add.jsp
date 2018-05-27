<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>高级查询</title>
<style>
.ui-button {
	display: inline-block;
	padding: 2px 2px;
	margin-bottom: 0;
	font-size: 8px;
	font-weight: normal;
	line-height: 1.42857143;
	text-align: center;
	white-space: nowrap;
	vertical-align: middle;
	-ms-touch-action: manipulation;
	touch-action: manipulation;
	cursor: pointer;
	-webkit-user-select: none;
	-moz-user-select: none;
	-ms-user-select: none;
	user-select: none;
	background-image: none;
	border: 1px solid transparent;
	border-radius: 4px;
}
</style>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script type="text/javascript">
	$(document).ready(function() {
		$('#tt').tabs({
			onSelect : function(title) {
				$('#tt .panel-body').css('width', 'auto');
			}
		});
		$(".tabs-wrap").css('width', '100%');
	});
</script>
</head>
<body style="overflow-x: hidden;">
	<t:formvalid formid="formobj" dialog="true" usePlugin="password"
		layout="table" tiptype="1" action="superQueryMainController.do?doAdd">
		<input id="id" name="id" type="hidden"
			value="${superQueryMainPage.id }" />
		<table cellpadding="0" cellspacing="1" class="formtable">
			<tr>
				<td align="right"><label class="Validform_label">查询规则名称:</label>
				</td>
				<td class="value"><input id="queryName" name="queryName"  
					type="text" style="width: 150px" class="inputxt"  datatype="*" />
					<span class="Validform_checktip"></span> <label
					class="Validform_label" style="display: none;">查询规则名称</label></td>
				<td align="right"><label class="Validform_label">查询规则编码:</label>
				</td>
				<td class="value">
				<input id="queryCode" name="queryCode" type="text" style="width: 150px" class="inputxt"  datatype="*" validType="super_query_main,query_code,id" />
					<span class="Validform_checktip"></span> <label
					class="Validform_label" style="display: none;">查询规则编码</label></td>
			</tr>
			<tr>
				<td align="right"><label class="Validform_label">查询类型:</label>
				</td>
				<td class="value">
				  <t:dictSelect field="queryType" type="list" typeGroupCode="sel_type" datatype="*" defaultVal="${superQueryMainPage.queryType}" hasLabel="false" title="查询类型"></t:dictSelect> 
				<!-- <select name="queryType" datatype="*" title="查询类型" >
				<option value="Z" selected="selected">主子表</option>
				<option value="D">单表</option>
				</select> -->
						 <span class="Validform_checktip"></span>
					<label class="Validform_label" style="display: none;">查询类型</label>
				</td>
				<td align="right"><label class="Validform_label">说明:</label></td>
				<td class="value"><input id="content" name="content"
					type="text" style="width: 150px" class="inputxt" ignore="ignore" />
					<span class="Validform_checktip"></span> <label
					class="Validform_label" style="display: none;">说明</label></td>
			</tr>

		</table>
		<div style="width: auto; height: 200px;">
			<%-- 增加一个div，用于调节页面大小，否则默认太小 --%>
			<div style="width: 800px; height: 1px;"></div>
			<t:tabs id="tt" iframe="false" tabPosition="top" fit="false">
				<t:tab
					href="superQueryMainController.do?superQueryTableList&id=${superQueryMainPage.id}"
					icon="icon-sum" title="表集合" id="superQueryTable"></t:tab>
				<t:tab
					href="superQueryMainController.do?superQueryFieldList&id=${superQueryMainPage.id}"
				    	icon="icon-comturn" title="字段配置" id="superQueryField">
				    	</t:tab>
			</t:tabs>
		</div>
	</t:formvalid>
	<!-- 添加 附表明细 模版 -->
	<table style="display: none">
		<tbody id="add_superQueryTable_table_template">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh"></div></td>
				<td align="center"><input style="width: 20px;" type="checkbox"
					name="ck" /></td>
				<td align="left">
				<input name="superQueryTableList[#index#].seq" maxlength="32" type="text" class="inputxt" style="width: 60px;" ignore="ignore" /> 
				<label class="Validform_label" style="display: none;">序号</label></td>
				<td align="left">
				<!-- <input  id="abc" class="aaa" name="superQueryTableList[#index#].tableName" type="text" onchange="myFunction(this.value)" /> -->
				<input id="tableList"  name="superQueryTableList[#index#].tableName" maxlength="32" type="text" class="inputxt tableList" style="width: 180px;"   onchange="myFunction()" /> 
					<label class="Validform_label" style="display: none;">表名</label></td>
				<td align="left">
				<input  name="superQueryTableList[#index#].instruction" maxlength="32" type="text" class="inputxt" style="width: 120px;"/> 
					<label class="Validform_label" style="display: none;">说明</label></td>
					
				<td align="left">
				<%-- <t:dictSelect field="superQueryTableList[#index#].isMain" type="radio" typeGroupCode="is_main" defaultVal="" hasLabel="false" title="是否是主表"> </t:dictSelect> --%>
						是 <input class="ismain" name="superQueryTableList[#index#].isMain" type="radio" value="Y" disabled="disabled" />&nbsp;
						否<input class="ismain" name="superQueryTableList[#index#].isMain" type="radio" value="N" checked="checked" readonly="readonly" />
					 <label class="Validform_label" style="display: none;">是否是主表</label>
				</td>
				<td align="left"><input name="superQueryTableList[#index#].fkField" maxlength="32" type="text" class="inputxt" style="width: 120px;"  datatype="*" />
					<label class="Validform_label" style="display: none;">外键字段</label>
				</td>
			</tr>
		</tbody>
		<tbody id="add_superQueryField_table_template">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh"></div></td>
				<td align="center"><input style="width: 20px;" type="checkbox"
					name="ck" /></td>
				<td align="left"><input name="superQueryFieldList[#index#].seq" maxlength="32" type="text" class="inputxt" style="width: 60px;" ignore="ignore" /> 
					<label class="Validform_label" style="display: none;">序号</label></td>
				<td align="left">
					<%-- <t:dictSelect field="superQueryFieldList[#index#].tableName" type="list"    typeGroupCode=""  defaultVal="" hasLabel="false"  title="表名"></t:dictSelect> --%>
					<select  name="superQueryFieldList[#index#].tableName" class="fieldTableList4" style="width:180px" datatype="*">
						<option>---请选择---</option>
				</select>
				 <label class="Validform_label" style="display: none;">表名</label>
				</td>
				<td align="left"><input name="superQueryFieldList[#index#].name" maxlength="32" type="text" class="inputxt" style="width: 120px;" ignore="ignore" /> 
				<label class="Validform_label" style="display: none;">字段名</label>
				</td>
				<td align="left"><input name="superQueryFieldList[#index#].txt" maxlength="32" type="text" class="inputxt" style="width: 120px;" ignore="ignore" /> 
				<label class="Validform_label" style="display: none;">字段文本</label></td>
				<td align="left">
				<t:dictSelect field="superQueryFieldList[#index#].ctype" type="list" typeGroupCode="field_type" defaultVal="" hasLabel="false" title="字段类型">
						</t:dictSelect> 
						<label class="Validform_label" style="display: none;">字段类型</label></td>
				<td align="left">
				<t:dictSelect field="superQueryFieldList[#index#].stype" type="list" typeGroupCode="s_type" defaultVal="" hasLabel="false" title="控件类型">
				</t:dictSelect>
					<label class="Validform_label" style="display: none;">控件类型</label>
				</td>
				<td align="left">
				<input name="superQueryFieldList[#index#].dictTable" maxlength="32" type="text" class="inputxt" style="width: 120px;" ignore="ignore" />
					<label class="Validform_label" style="display: none;">字典Table</label>
				</td>
				<td align="left"><input name="superQueryFieldList[#index#].dictCode" maxlength="32" type="text" class="inputxt" style="width: 120px;" ignore="ignore" />
					<label class="Validform_label" style="display: none;">字典Code</label>
				</td>
				<td align="left"><input
					name="superQueryFieldList[#index#].dictText" maxlength="32"
					type="text" class="inputxt " style="width: 120px;" ignore="ignore" />
					<label class="Validform_label" style="display: none;">字典Text</label>
				</td>
			</tr>
		</tbody>
	</table>
</body>
<script type="text/javascript">

</script>
<script  src="webpage/com/jeecg/superquery/superQueryMain.js"></script>