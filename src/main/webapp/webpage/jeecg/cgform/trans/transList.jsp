<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px">
<t:datagrid name="transList" title="smart.form.setting" fitColumns="false" pagination="false" checkbox="true" fit="true" queryMode="group" actionUrl="cgformTransController.do?datagrid" idField="id" sortName="id">
	<t:dgCol title="table.name" field="id" query="true" width="300"></t:dgCol>
	<t:dgToolBar id="generateForm" title="generate.form" icon="icon-edit"  url="cgformTransController.do?transEditor" funname="dataEditor"></t:dgToolBar>
</t:datagrid>
</div>
</div>
<script type="text/javascript">
	function dataEditor(title, url, id, a, b) {

		var formOnclick= $('#generateForm').attr("onclick");
		$('#generateForm').removeAttr('onclick');
		var ids = [];
		var rows = $("#" + id).datagrid('getSelections');
		if (rows.length > 0) {
			for ( var i = 0; i < rows.length; i++)
				ids.push(rows[i].id);
			$.ajax({
						url : url + "&id=" + ids,
						type : 'post',
						cache : false,
						success : function(data) {
							$('#generateForm').attr("onclick",formOnclick);

							var c = $.parseJSON(data);
							var d = "";
							var e = "";
							$.each(c.obj, function(key, value) {
								if (key == "no")
									d = value;
								else
									e = value;
							});
							W.tip('<t:mutiLang langKey="generate.success"/>' + ":" + e);
							W.reloadtablePropertyList();
							windowapi.close();
						}
					});
		} else{
			tip('<t:mutiLang langKey="please.select.generate.item"/>');
		}
	}
</script>