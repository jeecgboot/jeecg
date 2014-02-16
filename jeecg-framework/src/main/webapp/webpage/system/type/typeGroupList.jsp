<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
function typeGridTree_AddType() {
	var treeCtrlId = "typeGridTree";
	var node = $("#"+treeCtrlId).treegrid('getSelected');
	if (node == null) {
		tip("请选择一个字典组");
		return;
	}
	if (node.state == "closed" || node.children) {
	} else {//叶结点
		node = $("#"+treeCtrlId).treegrid('getParent', node.id); //获取当前节点的父节点
	}
	var groupid = node.id.substring(1);
	add("参数值录入("+node.text+")", "systemController.do?addorupdateType&typegroupid="+groupid, treeCtrlId);
}
function typeGridTree_UpdateType() {
	var treeCtrlId = "typeGridTree";
	var node = $("#"+treeCtrlId).treegrid('getSelected');
	if (node == null) {
		tip("请选择一个编辑对象。");
		return;
	}
	var nodeid = node.id.substring(1);
	if (node.state == "closed" || node.children) {
		createwindow("字典编辑", "systemController.do?aouTypeGroup&id="+nodeid);
	} else {//叶结点
		var pnode = $("#"+treeCtrlId).treegrid('getParent', node.id); //获取当前节点的父节点
		var groupid = pnode.id.substring(1);
		createwindow("参数值编辑", "systemController.do?addorupdateType&typegroupid="+groupid+"&id="+nodeid);
	}
}
</script>
<t:datagrid name="typeGridTree" title="数据字典管理" actionUrl="systemController.do?typeGridTree" idField="id" treegrid="true" pagination="false">
	<t:dgCol title="编号" field="id" treefield="id" hidden="false"></t:dgCol>
	<t:dgCol title="字典名称" field="typename" width="100" treefield="text"></t:dgCol>
	<t:dgCol title="字典编码" field="code" width="100" treefield="code"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
	<t:dgDelOpt url="systemController.do?delTypeGridTree&id={id}" title="删除"></t:dgDelOpt>
	<t:dgToolBar title="字典项录入" icon="icon-add" url="systemController.do?aouTypeGroup" funname="add"></t:dgToolBar>
	<t:dgToolBar title="参数值录入" icon="icon-add" funname="typeGridTree_AddType"></t:dgToolBar>
	<t:dgToolBar title="编辑" icon="icon-edit" funname="typeGridTree_UpdateType"></t:dgToolBar>
</t:datagrid>
<input type="hidden" id="typeGroupId" name="typeGroupId" value="">
