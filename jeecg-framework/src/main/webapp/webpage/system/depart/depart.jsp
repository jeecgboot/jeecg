<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>部门信息</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
	$(function() {
		$('#cc').combotree({
			url : 'departController.do?setPFunction&selfId=${depart.id}',
		});
	});
</script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" action="systemController.do?saveDepart">
	<input name="id" type="hidden" value="${depart.id }">
	<fieldset class="step">
	<div class="form"><label class="Validform_label"> 部门名称: </label> <input name="departname" class="inputxt" value="${depart.departname }" validType="t_s_depart,departname,id" datatype="s3-10">
	<span class="Validform_checktip">部门名称在3~10位字符</span></div>
	<div class="form"><label class="Validform_label"> 职能描述: </label> <input name="description" class="inputxt" value="${depart.description }"></div>
	<div class="form"><label class="Validform_label"> 上级部门: </label> <input id="cc" name="TSPDepart.id" value="${depart.TSPDepart.departname}"></div>
	</fieldset>
</t:formvalid>
</body>
</html>
