<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>用户删除</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
	$(function(){
		$("input[name='deleteRadio']").click(function(){
			$("#deleteType").val($(this).val());
		});
	})
	
</script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" refresh="true" dialog="true" action="userController.do?delete" layout="table">
	<input id="id" name="id" type="hidden" value="${user.id }" />
	<input id="deleteType" name="deleteType" type="hidden" value="deleteTrue" />
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tbody>
			<th>删除策略</th>
			<tr>
				<td class="value"><input type="radio" value="delete" name="deleteRadio"  /><span>逻辑删除</span></td>
			</tr>
			<tr>
				<td class="value"><input type="radio" value="deleteTrue" name="deleteRadio" checked="checked"/> <span>物理删除</span></td>
			</tr>
		</tbody>
	</table>
</t:formvalid>
</body>
</html>
