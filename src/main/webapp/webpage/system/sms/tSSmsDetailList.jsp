<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="table" dialog="true">
	<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
		<tbody><th>系统信息</th>
		   <c:if test="${smsList != null || fn:length(smsList) != 0}">
		   		<c:forEach var="item" items="${smsList}">
					<tr>
						<td class="value"><span>${item.esContent}</span></td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${smsList == null || fn:length(smsList) == 0}">
				<tr>
					<td class="value"><span>暂无系统信息！</span></td>
				</tr>
			</c:if>
		</tbody>
	</table>
</t:formvalid>
</body>
</html>

