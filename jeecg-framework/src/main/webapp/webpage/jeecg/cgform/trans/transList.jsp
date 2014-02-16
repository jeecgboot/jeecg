<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding: 1px;"><t:datagrid name="transList" title="智能表单配置" fitColumns="false" pagination="false" checkbox="true" fit="true" queryMode="group"
	actionUrl="cgformTransController.do?datagrid" idField="id" sortName="id">
	<t:dgCol title="表名" field="id" query="true" width="300"></t:dgCol>
	<t:dgToolBar title="生成表单" icon="icon-edit" url="cgformTransController.do?transEditor" funname="dataEditor"></t:dgToolBar>
</t:datagrid></div>
</div>
<script type="text/javascript">
	function dataEditor(title, url, id, a, b) {
		var ids = [];
		var rows = $("#" + id).datagrid('getSelections');
		if (rows.length > 0) {
			for ( var i = 0; i < rows.length; i++)
				ids.push(rows[i].id);
			$
					.ajax({
						url : url + "&id=" + ids,
						type : 'post',
						cache : false,
						success : function(data) {
							var c = $.parseJSON(data);
							var d = "";
							var e = "";
							$.each(c.obj, function(key, value) {
								if (key == "no")
									d = value;
								else
									e = value;
							});
							W.tip("生成成功:" + e);
							W.reloadtablePropertyList();
							windowapi.close();
						}
					});
		} else
			tip("请选择要生成表单的项!");
	}
</script>