<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title><t:mutiLang langKey="permission.collection"/></title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
	function op() {
		var a = "";
		jq('input[type="checkbox"][name="operatons"]:checked').each(function() {
			a = a + jq(this).val() + ",";
		});
		var obj = new Object();
		obj.fq =a;
		obj.roleId = jq("#roleId").val();
		//保存
		jq.ajax({
			async : false,
			cache : false,
			type : 'POST',
			data:obj,
			url : 'roleController.do?saveOperate', // 请求的action路径
			error : function() {// 请求失败处理函数
			},
			success : function(data) {
				var d = jq.parseJSON(data);
				if (d.success) {
					jq.dialog.tips('操作成功', 2);
				}

			}
		});
	}
</script>
</head>
<body>
<t:datagrid name="functionList" title="permission.manage" actionUrl="roleController.do?setOperate&roleId=${roleId}" idField="functionid" treegrid="true" pagination="false">
	<t:dgCol title="common.id" field="id" treefield="id" hidden="true"></t:dgCol>
	<t:dgCol title="permission.name" field="functionName" width="100" treefield="text"></t:dgCol>
	<t:dgCol title="common.operation" field="TOperations" width="300" treefield="operations"></t:dgCol>
</t:datagrid>
<div id="functionListtb" style="padding: 5px; height: 30px">
<div style="float: left;"><input type="hidden" name="roleId" id="roleId" value="${roleId }"> <a href="#" class="easyui-linkbutton" plain="true" icon="icon-add" onclick="op();">保存</a> <a
	href="#" class="easyui-linkbutton" plain="true" icon="icon-back" onClick="history.go(-1)">返回</a></div>
</div>
</body>
</html>
