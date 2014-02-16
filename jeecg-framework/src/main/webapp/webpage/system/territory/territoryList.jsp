<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<div id="system_territory_territoryList" class="easyui-layout" fit="true">
<div region="center" style="padding: 1px;"><t:datagrid name="territoryList" title="地域管理" actionUrl="territoryController.do?territoryGrid" idField="id" treegrid="true" pagination="false">
	<t:dgCol title="编号" field="id" treefield="id" hidden="false"></t:dgCol>
	<t:dgCol title="地域名称" field="territoryName" treefield="text"></t:dgCol>
	<t:dgCol title="区域码" field="territorySrc" treefield="src"></t:dgCol>
	<t:dgCol title="显示顺序" field="territorySort" treefield="order"></t:dgCol>
	<t:dgCol title="操作" field="opt"></t:dgCol>
	<t:dgDelOpt url="territoryController.do?del&id={id}" title="删除"></t:dgDelOpt>
	<t:dgToolBar title="地域录入" icon="icon-add" url="territoryController.do?addorupdate" funname="addFun"></t:dgToolBar>
	<t:dgToolBar title="地域编辑" icon="icon-edit" url="territoryController.do?addorupdate" funname="update"></t:dgToolBar>
</t:datagrid></div>
</div>

<script type="text/javascript">
$(function() {
	var li_east = 0;
});
function addFun(title,url, id) {
	var rowData = $('#'+id).datagrid('getSelected');
	if (rowData) {
		url += '&TSTerritory.id='+rowData.id;
	}
	add(title,url,'territoryList');
}
</script>

