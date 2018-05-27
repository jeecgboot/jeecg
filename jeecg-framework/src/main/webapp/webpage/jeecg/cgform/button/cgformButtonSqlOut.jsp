<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>SQL导出</title>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table">
	<input id="formId" name="formId" type="hidden" value="${formId}">
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> 表名: </label></td>
			<td class="value"><input class="inputxt" id="tableName" name="tableName" value="${tableName}" datatype="*"> <span class="Validform_checktip"></span></td>
		</tr>
	</table>
</t:formvalid>
<div id="tableList" style="height: 400px;"></div>
</body>
<script type="text/javascript">
 function getTableList() {
	 var tableName =$('#tableName').val();
	 $.ajax({
			async : false,
			cache : false,
			type : 'POST',
			contentType : 'application/json', 
			dataType:"json",
			url : "cgformButtonSqlOutInController.do?list&tableName="+tableName,// 请求的action路径
			error : function() {// 请求失败处理函数
				alert("出错了");
				frameElement.api.close();
			},
			success : function(data) {
				var d = data;
				if (d.success) {
					//document.getElementById("tableList").innerHTML.val(d.obj);
					$('#tableList').html(d.obj);
				}else{
					document.getElementById("tableList").innerHTML.val("");
				}
			}
		});
	 
 };
 
</script>
</html>