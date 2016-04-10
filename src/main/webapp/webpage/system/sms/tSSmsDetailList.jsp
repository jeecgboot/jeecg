<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery,tools"></t:base>
<!-- bootstrap & fontawesome -->
<link rel="stylesheet" href="plug-in/ace/css/bootstrap.css" />
<link rel="stylesheet" href="plug-in/ace/css/font-awesome.css" />
<link rel="stylesheet" type="text/css" href="plug-in/accordion/css/accordion.css">
<script src="plug-in/ace/js/jquery.js"></script>
<script src="plug-in/ace/js/bootstrap.js"></script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="table" dialog="true">
	<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable table table-hover">
		<thead>
			<tr>
				<th>内容</th>
				<th>发送时间</th>
			</tr>
		</thead>
		<tbody><%--<th>系统信息</th>--%>
		   <c:if test="${smsList != null || fn:length(smsList) != 0}">
		   		<c:forEach var="item" items="${smsList}">
					<tr>
						<td class="value"><span>${item.esContent}</span></td>
						<td class="value"><span>${item.esSendtime}</span></td>
					</tr>
				</c:forEach>
			</c:if>
			<c:if test="${smsList == null || fn:length(smsList) == 0}">
				<tr>
					<td class="value"><span>暂无系统信息！</span></td>
					<td class="value"><span>暂无系统信息！</span></td>
				</tr>
			</c:if>
		</tbody>
	</table>
</t:formvalid>
</body>
</html>

