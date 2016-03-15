<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
<div class="easyui-layout" fit="true">
	<div region="west" style="width: 220px;" split="true">
		<div class="easyui-panel" title='Online分类菜单' style="padding: 10px;"
			fit="true" border="false" id="function-panel">
			<ul id="onlineCategoryTree"></ul>
		</div>
	</div>
	<div id="tt"></div>
	<div region="center"  style="padding:0px;border:0px">
		<t:datagrid name="cgformCategoryList" title="Online Table 分类"
			actionUrl="cgformCategoryController.do?datagrid&category.code=cgformCategoryController"
			idField="id" fit="true">
			<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
			<t:dgCol title="表单名称" field="form_isDbSynch" hidden="true"></t:dgCol>
			<t:dgCol title="表单ID" field="form_id" hidden="true"></t:dgCol>
			<t:dgCol title="表单名称" field="form_content" width="100" query="true"></t:dgCol>
			<t:dgCol title="分类" field="category_name" width="100"></t:dgCol>
			<t:dgCol title="表单地址" field="form_tableName"
				extendParams="formatter:formNameFormatter;" width="200"></t:dgCol>
			<t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
			<t:dgDelOpt title="common.delete"
				url="cgformCategoryController.do?del&id={id}" />
			<t:dgFunOpt exp="form_isDbSynch#eq#Y&&jformType#ne#3"
				funname="addbytab(form_id,form_content)" title="form.template"></t:dgFunOpt>
			<t:dgToolBar title="录入" icon="icon-add" width="600" height="300"
				url="cgformCategoryController.do?addorupdate" funname="add"></t:dgToolBar>
			<t:dgToolBar title="编辑" icon="icon-edit" width="600" height="300"
				url="cgformCategoryController.do?addorupdate" funname="update"></t:dgToolBar>
		</t:datagrid>
	</div>
</div>
<
<script type="text/javascript">
	function addbytab(id, content) {
		addOneTab('<t:mutiLang langKey="form.template"/>',
				"cgformFtlController.do?cgformFtl2&formid=" + id);
	}

	function formNameFormatter(value, row, index) {
		return "cgAutoListController.do?list&id" + value;
	}
	
	var _finalUrl = "cgformCategoryController.do?datagrid&category.code=";

	$('#onlineCategoryTree').tree({
		url : "categoryController.do?tree&selfCode=02",
		onClick : function(node) {
			var loadUrl = $("#cgformCategoryList").datagrid('options').url;
			loadUrl = loadUrl.replace(_finalUrl,'');
			loadUrl = loadUrl.substr(loadUrl.indexOf("&"));
			loadUrl = _finalUrl + node.id + loadUrl;
			$("#cgformCategoryList").datagrid('options').url = loadUrl;
			$("#cgformCategoryList").datagrid('load');
		}
	});
</script>