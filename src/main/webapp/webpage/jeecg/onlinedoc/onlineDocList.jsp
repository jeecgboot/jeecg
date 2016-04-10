<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<link rel="stylesheet" href="plug-in/ztree/css/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js"></script>
<SCRIPT type="text/javascript">
	<!--
	var setting = {
		async: {
			enable: true,
			url:"onlineDocSortController.do?tree"
		},
		data: {
			key: {
				name: "text"
			}
		},
		callback: {
			onAsyncSuccess: zTreeOnAsyncSuccess,
			onClick: zTreeOnClick
		}
	};
	
	var treeObj;
	var currentNode = null;
	$(document).ready(function(){
		$.fn.zTree.init($("#ztree"), setting);
		treeObj = $.fn.zTree.getZTreeObj("ztree");
	});
	
	function zTreeOnAsyncSuccess(event, treeId, treeNode, msg) {
		treeObj.expandAll(true);
		currentNode = treeObj.getNodesByFilter(function (node) { return node.level == 0 }, true).id;
	}
	
	function zTreeOnClick(event, treeId, treeNode) {
		if(treeNode.parentTId == null){
			$('#onlineDocList').datagrid('load', {});
		}else{
			$('#onlineDocList').datagrid('load', {    
				treeNode: treeNode.id
			});
		}
		currentNode = treeNode.id;
	};
	
	function getCurrentNode(){
		return currentNode;
	}
	
	function downloadLink(value,row,index){
		
		if( row.path != ""){
			return '<a href=\"' + row.path + '\" target="_blank" style="color: green;">[下载]</a>';
		}else{
			return '<a href=javascript:void(0);" style="color: red">[下载]</a>';
		}
		
	}
	//-->
</SCRIPT>
<div class="easyui-layout" fit="true">
	<div region="west" style="width: 150px;" title="文档目录" split="true" collapsed="false">
		<div class="easyui-panel" style="padding:0px;border:0px" fit="true" border="false">
			<ul id="ztree" class="ztree"></ul>
		</div>
	</div>
	<div region="center" style="padding:0px;border:0px">
		<t:datagrid name="onlineDocList" checkbox="true" fitColumns="false" title="在线文档" actionUrl="onlineDocController.do?datagrid" idField="id" fit="true" queryMode="group">
			<t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
			<t:dgCol title="创建人登录名称"  field="createBy" hidden="true" queryMode="single"  width="120"></t:dgCol>
			<t:dgCol title="更新人名称"  field="updateName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
			<t:dgCol title="更新人登录名称"  field="updateBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
			<t:dgCol title="更新日期"  field="updateDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
			<t:dgCol title="所属部门"  field="sysOrgCode"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
			<t:dgCol title="所属公司"  field="sysCompanyCode"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
			<t:dgCol title="流程状态"  field="bpmStatus"    queryMode="single" dictionary="bpm_status" hidden="true" width="120"></t:dgCol>
			<t:dgCol title="文件名"  field="oldName"    queryMode="single"  width="120"></t:dgCol>
			<t:dgCol title="文件名"  field="newName"  hidden="true"  queryMode="single"  width="120" query="ture"></t:dgCol>
			<t:dgCol title="描述"  field="description"    queryMode="single"  width="120"></t:dgCol>
			<t:dgCol field="treeNode" title="文档目录" width="120" dictionary="t_s_online_doc_sort,id,name"></t:dgCol>
			<t:dgCol title="创建人名称"  field="createName" queryMode="single"  width="120"></t:dgCol>
			<t:dgCol title="上载时间"  field="createDate" formatter="yyyy-MM-dd hh:mm:ss" queryMode="single"  width="120"></t:dgCol>
			<t:dgCol title="下载地址"  field="path" queryMode="single"  width="120" formatterjs="downloadLink"></t:dgCol>
			<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
			<t:dgDelOpt title="删除" url="onlineDocController.do?doDel&id={id}" />
			<t:dgToolBar title="录入" icon="icon-add" url="onlineDocController.do?goAdd" funname="add"></t:dgToolBar>
			<t:dgToolBar title="编辑" icon="icon-edit" url="onlineDocController.do?goUpdate" funname="update"></t:dgToolBar>
			<t:dgToolBar title="批量删除"  icon="icon-remove" url="onlineDocController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
			<t:dgToolBar title="查看" icon="icon-search" url="onlineDocController.do?goUpdate" funname="detail"></t:dgToolBar>
			<t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
			<t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
			<t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
		</t:datagrid>
	</div>
</div>
<script src = "webpage/jeecg/onlinedoc/onlineDocList.js"></script>		
<script type="text/javascript">
	$(document).ready(function(){
 		//给时间控件加上样式
 		$("#onlineDocListtb").find("input[name='createDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 		$("#onlineDocListtb").find("input[name='updateDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
	});
 
	//导入
	function ImportXls() {
		openuploadwin('Excel导入', 'onlineDocController.do?upload', "onlineDocList");
	}
	
	//导出
	function ExportXls() {
		JeecgExcelExport("onlineDocController.do?exportXls","onlineDocList");
	}
	
	//模板下载
	function ExportXlsByT() {
		JeecgExcelExport("onlineDocController.do?exportXlsByT","onlineDocList");
	}
</script>