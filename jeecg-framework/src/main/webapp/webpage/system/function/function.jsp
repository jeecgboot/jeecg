<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>菜单信息</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
		
	$(function() {
		$('#cc').combotree({
			url : 'functionController.do?setPFunction&selfId=${function.id}',
			panelHeight:'auto',
			onClick: function(node){
				$("#functionId").val(node.id);
			}
		});
		
		if($('#functionLevel').val()=='1'){
			$('#pfun').show();
		}else{
			$('#pfun').hide();
		}
		
		
		$('#functionLevel').change(function(){
			if($(this).val()=='1'){
				$('#pfun').show();
				var t = $('#cc').combotree('tree');
				var nodes = t.tree('getRoots');
				if(nodes.length>0){
					$('#cc').combotree('setValue', nodes[0].id);
					$("#functionId").val(nodes[0].id);
				}
			}else{
				var t = $('#cc').combotree('tree');
				var node = t.tree('getSelected');
				if(node){
					$('#cc').combotree('setValue', null);
				}
				$('#pfun').hide();
			}
		});
	});
</script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" refresh="true" action="functionController.do?saveFunction">
	<input name="id" type="hidden" value="${function.id}">
	<fieldset class="step">
	<div class="form"><label class="Validform_label"> 菜单名称: </label> <input name="functionName" class="inputxt" value="${function.functionName}" datatype="s4-15"> <span
		class="Validform_checktip">菜单名称范围4~15位字符,且不为空</span></div>
	<div class="form"><label class="Validform_label"> 菜单等级: </label> <select name="functionLevel" id="functionLevel" datatype="*">
		<option value="0" <c:if test="${function.functionLevel eq 0}">selected="selected"</c:if>>一级菜单</option>
		<option value="1" <c:if test="${function.functionLevel>0}"> selected="selected"</c:if>>下级菜单</option>
	</select> <span class="Validform_checktip"></span></div>
	<div class="form" id="pfun"><label class="Validform_label"> 父菜单: </label> <input id="cc" <c:if test="${function.TSFunction.functionLevel eq 0}">
					value="${function.TSFunction.id}"</c:if>
		<c:if test="${function.TSFunction.functionLevel > 0}">
					value="${function.TSFunction.functionName}"</c:if>> <input id="functionId" name="TSFunction.id" style="display: none;"
		value="${function.TSFunction.id}"></div>
	<div class="form" id="funurl"><label class="Validform_label"> 菜单地址: </label> <input name="functionUrl" class="inputxt" value="${function.functionUrl}"></div>
	<div class="form"><label class="Validform_label"> 图标名称: </label> <select name="TSIcon.id">
		<c:forEach items="${iconlist}" var="icon">
			<option value="${icon.id}" <c:if test="${icon.id==function.TSIcon.id || (function.id eq null && icon.iconClas eq 'pictures') }">selected="selected"</c:if>>${icon.iconName}</option>
		</c:forEach>
	</select></div>
	<div class="form" id="funorder"><label class="Validform_label"> 菜单顺序: </label> <input name="functionOrder" class="inputxt" value="${function.functionOrder}" datatype="n1-3"></div>
	</fieldset>
</t:formvalid>
</body>
</html>
