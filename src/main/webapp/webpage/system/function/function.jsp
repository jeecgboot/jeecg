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
//            update-start--Author:zhangguoming  Date:20140901 for：为combotree下拉框的添加滚动条
			panelHeight: 200,
			width: 157,
//            update-end--Author:zhangguoming  Date:20140901 for：为combotree下拉框的添加滚动条
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
                $("#functionId").val(null);
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
	<div class="form">
        <label class="Validform_label"> <t:mutiLang langKey="menu.name"/>: </label>
        <input name="functionName" class="inputxt" value="${function.functionName}" datatype="s2-50">
        <span class="Validform_checktip"> <t:mutiLang langKey="menuname.rang4to15"/> </span>
    </div>
    <div class="form">
        <label class="Validform_label"> <t:mutiLang langKey="funcType"/>: </label>
        <select name="functionType" id="functionType" datatype="*">
            <option value="0" <c:if test="${function.functionType eq 0}">selected="selected"</c:if>>
                <t:mutiLang langKey="funcType.page"/>
            </option>
            <option value="1" <c:if test="${function.functionType>0}"> selected="selected"</c:if>>
                <t:mutiLang langKey="funcType.from"/>
            </option>
        </select>
        <span class="Validform_checktip"></span>
    </div>
	<div class="form">
        <label class="Validform_label"> <t:mutiLang langKey="menu.level"/>: </label>
        <select name="functionLevel" id="functionLevel" datatype="*">
            <option value="0" <c:if test="${function.functionLevel eq 0}">selected="selected"</c:if>>
                <t:mutiLang langKey="main.function"/>
            </option>
            <option value="1" <c:if test="${function.functionLevel>0}"> selected="selected"</c:if>>
                <t:mutiLang langKey="sub.function"/>
            </option>
        </select>
        <span class="Validform_checktip"></span>
    </div>
	<div class="form" id="pfun">
        <label class="Validform_label"> <t:mutiLang langKey="parent.function"/>: </label>
        <input id="cc" <c:if test="${function.TSFunction.functionLevel eq 0}"> value="${function.TSFunction.id}"</c:if>
		<c:if test="${function.TSFunction.functionLevel > 0}"> value="${function.TSFunction.functionName}"</c:if>>
        <input id="functionId" name="TSFunction.id" style="display: none;" value="${function.TSFunction.id}">
    </div>
	<div class="form" id="funurl">
        <label class="Validform_label">
            <t:mutiLang langKey="menu.url"/>:
        </label>
        <input name="functionUrl" class="inputxt" value="${function.functionUrl}">
    </div>
    <div class="form">
        <label class="Validform_label"> <t:mutiLang langKey="common.icon"/>: </label>
        <select name="TSIcon.id">
            <c:forEach items="${iconlist}" var="icon">
                <option value="${icon.id}" <c:if test="${icon.id==function.TSIcon.id || (function.id eq null && icon.iconClas eq 'default') }">selected="selected"</c:if>>
                    <t:mutiLang langKey="${icon.iconName}"/>
                </option>
            </c:forEach>
        </select>
    </div>
    <%--update-begin--Author:zhangguoming  Date:20140509 for：云桌面图标管理--%>
    <div class="form">
        <label class="Validform_label"> <t:mutiLang langKey="desktop.icon"/>: </label>
        <select name="TSIconDesk.id">
            <c:forEach items="${iconDeskList}" var="icon">
                <option value="${icon.id}" <c:if test="${icon.id==function.TSIconDesk.id || (function.id eq null && icon.iconClas eq 'System Folder') }">selected="selected"</c:if>>
                    <t:mutiLang langKey="${icon.iconName}"/>
                </option>
            </c:forEach>
        </select>
    </div>
    <%--update-end--Author:zhangguoming  Date:20140509 for：云桌面图标管理--%>
	<div class="form" id="funorder"><label class="Validform_label"> <t:mutiLang langKey="menu.order"/>: </label> <input name="functionOrder" class="inputxt" value="${function.functionOrder}" datatype="n1-3"></div>
	</fieldset>
</t:formvalid> 
</body>
</html>
