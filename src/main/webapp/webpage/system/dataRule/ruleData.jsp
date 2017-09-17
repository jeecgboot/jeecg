<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>操作信息</title>
<t:base type="jquery,easyui,tools"></t:base>
 <script type="text/javascript">
</script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" action="functionController.do?saverule">
	<input name="id" type="hidden" value="${operation.id}">
	<fieldset class="step">
        <div class="form">
            <label class="Validform_label"> 规则名称: </label>
            <input name="ruleName" class="inputxt" value="${operation.ruleName}" datatype="s2-20" style="width: 280px;"/>
            <span class="Validform_checktip"> <t:mutiLang langKey="operatename.rang2to20"/></span>
        </div>
       <!-- update-begin-author:taoYan date:20170814 for:编辑页面如果条件规则是自定义sql表达式则隐藏规则字段 -->
      <div class="form" <c:if test="${operation.ruleConditions=='USE_SQL_RULES'}">style="display:none;" </c:if>>
      <!-- update-end-author:taoYan date:20170814 for:编辑页面如果条件规则是自定义sql表达式则隐藏规则字段 -->
            <label class="Validform_label"> 规则字段: </label>
            <input name="ruleColumn" class="inputxt" value="${operation.ruleColumn}" style="width: 280px;"/>
        </div>
        <div class="form">
            <label class="Validform_label"> 条件规则: </label>
<!-- update-begin-author:taoYan date:20170811 for:TASK #2166 【数据权限】数据权限规则支持复杂配置 -->
            <t:dictSelect id="ruleConditions" field="ruleConditions" typeGroupCode="rulecon" hasLabel="false" defaultVal="${operation.ruleConditions}"></t:dictSelect>
        </div>
           <input name="TSFunction.id" value="${functionId}" type="hidden">
         <div class="form">
            <label class="Validform_label"> 规则值: </label>
            <input name="ruleValue" class="inputxt" value="${operation.ruleValue}" style="width: 390px;"/>
        </div>
	</fieldset>
</t:formvalid>
<script>
$("#ruleConditions").change(function(){
	if("USE_SQL_RULES" == $(this).val()){
		var inp = $("input[name='ruleColumn']");
		inp.parent("div").fadeOut();
		inp.val("");
	}else{
		$("input[name='ruleColumn']").parent("div").show();
	}
});
</script>
<!-- update-end-author:taoYan date:20170811 for:TASK #2166 【数据权限】数据权限规则支持复杂配置 -->
</body>
</html>
