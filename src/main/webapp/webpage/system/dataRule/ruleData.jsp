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
            <input name="ruleName" class="inputxt" value="${operation.ruleName}" datatype="s2-20">
            <span class="Validform_checktip"> <t:mutiLang langKey="operatename.rang2to20"/></span>
        </div>
      <div class="form">
            <label class="Validform_label"> 规则字段: </label>
            <input name="ruleColumn" class="inputxt" value="${operation.ruleColumn}">
        </div>
        <div class="form">
            <label class="Validform_label"> 条件规则: </label>
            
            
            	<t:dictSelect field="ruleConditions" typeGroupCode="rulecon" hasLabel="false" defaultVal="${operation.ruleConditions}"></t:dictSelect>
					
    
        </div>
           <input name="TSFunction.id" value="${functionId}" type="hidden">
         <div class="form">
            <label class="Validform_label"> 规则值: </label>
            <input name="ruleValue" class="inputxt" value="${operation.ruleValue}">
        </div>
	</fieldset>
</t:formvalid>
</body>
</html>
