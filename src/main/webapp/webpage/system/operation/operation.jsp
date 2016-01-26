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
<t:formvalid formid="formobj" layout="div" dialog="true" action="functionController.do?saveop">
	<input name="id" type="hidden" value="${operation.id}">
	<fieldset class="step">
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="operate.name"/>: </label>
            <input name="operationname" class="inputxt" value="${operation.operationname}" datatype="s2-20">
            <span class="Validform_checktip"> <t:mutiLang langKey="operatename.rang2to20"/></span>
        </div>
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="operate.code"/>: </label>
            <input name="operationcode" class="inputxt" value="${operation.operationcode}">
        </div>
        <!-- 图标字段现在不用暂时隐藏-->
        <div class="form" style="display: none;">
            <label class="Validform_label"> <t:mutiLang langKey="common.icon.name"/>: </label>
            <select name="TSIcon.id">
                <c:forEach items="${iconlist}" var="icon">
                    <option value="${icon.id}" <c:if test="${icon.id==function.TSIcon.id }">selected="selected"</c:if>>${icon.iconName}</option>
                </c:forEach>
            </select>
        </div>
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="operation.type"/>: </label>
            <select name="operationType">
                <option value="0" <c:if test="${operation.operationType eq 0}">selected="selected"</c:if>>
                <t:mutiLang langKey="common.hide"/>
	            </option>
	            <option value="1" <c:if test="${operation.operationType>0}"> selected="selected"</c:if>>
	                <t:mutiLang langKey="operationType.disabled"/>
	            </option>
            </select>
        </div>
        <input name="TSFunction.id" value="${functionId}" type="hidden">
        <input name="status" type="hidden" value="0">
        <%-- <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="common.status"/> </label>
        <select name="status">
                <option value="0" <c:if test="${operation.status eq 0}">selected="selected"</c:if>>
                	<t:mutiLang langKey="common.enable"/>
	            </option>
	            <option value="1" <c:if test="${operation.status>0}"> selected="selected"</c:if>>
	                <t:mutiLang langKey="common.disable"/>
	            </option>
            </select>
            <span class="Validform_checktip"><t:mutiLang langKey="operatestatus.number"/></span>
        </div> --%>
	</fieldset>
</t:formvalid>
</body>
</html>
