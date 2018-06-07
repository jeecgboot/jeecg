<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@include file="/context/mytags.jsp" %>
<!DOCTYPE html>
<html>
<head>
    <t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" action="systemController.do?saveType">
    <input name="id" type="hidden" value="${type.id }">
    <input name="TSTypegroup.id" type="hidden" value="${typegroupid}">
    <fieldset class="step">
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="lang.dictionary.type"/>: </label>
            <input readonly="true" class="inputxt" value="${typegroupname }">
        </div>
        <%--// add-end--Author:zhangguoming  Date:20140928 for：添加显示字段--%>
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="dict.name"/>: </label>
            <input name="typename" class="inputxt" value="${type.typename }" datatype="s1-10">
            <span class="Validform_checktip">类型范围在1~10位字符</span>
        </div>
        <div class="form">
            <label class="Validform_label"> <t:mutiLang langKey="dict.code"/>: </label>
            <input name="typecode" class="inputxt" value="${type.typecode }" datatype="*"
                   ajaxurl="systemController.do?checkType&code=${type.typecode }&typeGroupCode=${typegroup.typegroupcode}">
            <span class="Validform_checktip">类型编码在1~10位字符</span>
        </div>
    </fieldset>
</t:formvalid>
</body>
</html>
