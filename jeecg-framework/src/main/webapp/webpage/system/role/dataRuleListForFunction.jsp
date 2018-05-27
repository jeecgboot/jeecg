<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<c:forEach items="${dataRuleList}" var="dataRule">
<span class="icon group_add">&nbsp;</span>
	<c:if test="${fn:contains(dataRulecodes, dataRule.id)}">
		<input style="width: 20px;" type="checkbox" name="operationCheckbox1" value="${dataRule.id}" checked="checked" />${dataRule.ruleName}
	 </c:if>
	<c:if test="${!fn:contains(dataRulecodes, dataRule.id)}">
		<input style="width: 20px;" type="checkbox" name="operationCheckbox1" value="${dataRule.id}" />${dataRule.ruleName}
	 </c:if>
	<br>
</c:forEach>
<script type="text/javascript">
function submitDataRule() {
	var functionId = "${functionId}";
	var roleId = $("#rid").val();
	var dataRulecodes = "";
	$("input[name='operationCheckbox1']").each(function(i){
		   if(this.checked){
			   dataRulecodes+=this.value+",";
		   }
	 });
	dataRulecodes=escape(dataRulecodes); 
	doSubmit("roleController.do?updateDataRule&functionId=" + functionId + "&roleId=" + roleId+"&dataRulecodes="+dataRulecodes);
}
</script>
