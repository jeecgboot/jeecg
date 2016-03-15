<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center"  style="padding:0px;border:0px"><t:datagrid name="webOfficeList" title="WebOffice例子" actionUrl="webOfficeController.do?datagrid" idField="id" fit="true">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="文档编号" field="docid"></t:dgCol>
	<t:dgCol title="文档标题" field="doctitle"></t:dgCol>
	<t:dgCol title="文档种类" field="doctype"></t:dgCol>
	<t:dgCol title="创建时间" field="docdate" formatter="yyyy-MM-dd hh:mm:ss"></t:dgCol>
	<t:dgCol title="文档内容" field="doccontent" hidden="true"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
	<t:dgFunOpt funname="editOfficeDocument(id)" title="文档编辑" />
	<t:dgDelOpt title="删除" url="webOfficeController.do?del&id={id}" />
	<t:dgToolBar title="新建文档" icon="icon-add" url="webOfficeController.do?newDocument&fileType=doc" funname="add"></t:dgToolBar>
</t:datagrid></div>
</div>
<script type="text/javascript">
function editOfficeDocument(docid) {
	createwindow("文档编辑",'webOfficeController.do?newDocument&id='+docid);
}
</script>