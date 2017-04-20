<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>组织机构集合</title>
<t:base type="jquery"></t:base>
<link rel="stylesheet" type="text/css" href="plug-in/ztree/css/zTreeStyle.css">
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript">
	var setting = {
	  check: {
			enable: true,
			chkboxType: { "Y": "", "N": "" }
		},
		data: {
			simpleData: {
				enable: true
			}
		},callback: {
			onExpand: zTreeOnExpand
		}
	};
	
	//加载展开方法
	function zTreeOnExpand(event, treeId, treeNode){
		 var treeNodeId = treeNode.id;
		 $.post(
			'departController.do?getDepartInfo',
			{parentid:treeNodeId,orgIds:$("#orgIds").val()},
			function(data){
				var d = $.parseJSON(data);
				if (d.success) {
					var dbDate = eval(d.msg);
					var tree = $.fn.zTree.getZTreeObj("departSelect");

					if (!treeNode.zAsync){
						tree.addNodes(treeNode, dbDate);
						treeNode.zAsync = true;
					} else{
						tree.reAsyncChildNodes(treeNode, "refresh");
					}
					//tree.addNodes(treeNode, dbDate);
				}
			}
		);
	}
	
	//首次进入加载level为1的
	$(function(){
		$.post(
			'departController.do?getDepartInfo',
		    {orgIds:$("#orgIds").val()},
			function(data){
				var d = $.parseJSON(data);
				if (d.success) {
					var dbDate = eval(d.msg);
					$.fn.zTree.init($("#departSelect"), setting, dbDate);
				}
			}
		);
	});
</script>
</head>
<body style="overflow-y: hidden" scroll="no">
<input id="orgIds" name="orgIds" type="hidden" value="${orgIds}">
<ul id="departSelect" class="ztree" style="margin-top: 30px;"></ul>
<%-- <t:datagrid name="departList" title="common.department.list" actionUrl="departController.do?departSelectDataGrid" idField="id" checkbox="true" showRefresh="false">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.department.name" field="departname" width="50"></t:dgCol>
</t:datagrid> --%>
</body>
</html>
<!-- update--end--by:jg_renjie--at:20160318 for:#942 【组件封装】组织机构弹出模式，目前是列表，得改造成树方式 -->