<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<c:forEach items="${operationList}" var="operation">
	<c:if test="${fn:contains(operationcodes, operation.id)}">
		<span class="icon ${operation.TSIcon.iconClas}">&nbsp;</span>
		<input style="width: 20px;" type="checkbox" name="operationCheckbox" value="${operation.id}" checked="checked" />${operation.operationname}
	 </c:if>
	<c:if test="${!fn:contains(operationcodes, operation.id)}">
		<span class="icon group_add">&nbsp;</span>
		<input style="width: 20px;" type="checkbox" name="operationCheckbox" value="${operation.id}" />${operation.operationname}
	 </c:if>
	<br>
</c:forEach>
<script type="text/javascript">
//页面操作权限提交
function submitOperation() {
	var functionId = "${functionId}";
	var groupId = $("#groupId").val();
	var operationcodes = "";
	$("input[name='operationCheckbox']").each(function(i){
		   if(this.checked){
			   operationcodes+=this.value+",";
		   }
	 });
	operationcodes=escape(operationcodes); 
	doSubmit("departAuthGroupController.do?updateDepartOperation&functionId=" + functionId + "&groupId=" + groupId+"&operationcodes="+operationcodes);
}
</script>
