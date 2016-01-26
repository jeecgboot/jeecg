<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
	<div region="center" style="padding:1px;width: 100%">
		<t:datagrid name="addDemoList" title="DEMO维护" actionUrl="demoController.do?demoGrid" idField="id" treegrid="true" pagination="true" fit="false">
			<t:dgCol title="编号" field="id" treefield="id" hidden="true"></t:dgCol>
			<t:dgCol title="DEMO名称" field="functionName" width="100" treefield="text"></t:dgCol>
			<t:dgCol title="DEMO地址" field="functionUrl" treefield="src"></t:dgCol>
			<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
			<t:dgDelOpt url="demoController.do?delDemo&id={id}" title="删除"></t:dgDelOpt>
		</t:datagrid>
		<div id="addDemoListtb" style="padding: 5px; height: 25px">
			<div style="float: left;">
				<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-add" onclick="addLayout('DEMO录入','demoController.do?demoLayout','addDemoList')">添加</a>
				<a href="javascript:void(0)" class="easyui-linkbutton" plain="true" icon="icon-edit" onclick="updateLayout('DEMO编辑','demoController.do?demoLayout','addDemoList')">编辑</a>
			</div>
		</div>
	</div>
	<div id="formContent" region="south">
		<iframe id="formContenFrame" width="100%" height="450px" scrolling="auto"></iframe>
	</div>
</div>
<script type="text/javascript">
	function addLayout(title,url,grid){
		gridname = grid;
		$("#formContenFrame").attr("src",url);
	}
	
	function updateLayout(title,url,grid){
		gridname = grid;
		var rowsData = $('#'+grid).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('请选择编辑项目');
			return;
		}
		if (rowsData.length>1) {
			tip('请选择一条记录再编辑');
			return;
		}
		url += '&id='+rowsData[0].id;
		$("#formContenFrame").attr("src",url);
	}
</script>