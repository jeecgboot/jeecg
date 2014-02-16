<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:datagrid name="addDemoList" title="DEMO维护" actionUrl="demoController.do?demoGrid" idField="id" treegrid="true" pagination="false">
	<t:dgCol title="编号" field="id" treefield="id" hidden="false"></t:dgCol>
	<t:dgCol title="DEMO名称" field="functionName" width="100" treefield="text"></t:dgCol>
	<t:dgCol title="DEMO地址" field="functionUrl" treefield="src"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
	<t:dgDelOpt url="demoController.do?delDemo&id={id}" title="删除"></t:dgDelOpt>
</t:datagrid>
<div id="addDemoListtb" style="padding: 5px; height: 25px">
<div style="float: left;"><a href="#" class="easyui-linkbutton" plain="true" icon="icon-add" onclick="add('DEMO录入','demoController.do?aorudemo','addDemoList')">弹出框方式添加</a> <a href="#"
	class="easyui-linkbutton" plain="true" icon="icon-add" onclick="addbytab()">TAB方式添加</a> <a href="#" class="easyui-linkbutton" plain="true" icon="icon-edit"
	onclick="update('DEMO编辑','demoController.do?aorudemo','addDemoList')">编辑</a></div>
</div>
</body>
<SCRIPT type="text/javascript">
	function addbytab() {
		addOneTab("TAB方式添加", "demoController.do?aorudemo&type=table&isIframe");
	}
</SCRIPT>
