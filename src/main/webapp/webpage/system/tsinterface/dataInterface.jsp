<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>接口权限</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
		
	$(function() {
		$('#cc').combotree({
			url : 'functionController.do?setPFunction&type=1&selfId=${function.id}',
			panelHeight: 200,
			width: 157,
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
	
	
	function viewStyle(param) {
		var url = "<%=basePath%>/functionIconStyle.jsp?style = "+ param;
		//add("图标样式预览",url,'functionIconStyle',700,450);
		window.open(url,"_blank");
	}
</script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" refresh="true" action="functionController.do?saveFunction">
	<input name="id" type="hidden" value="${function.id}">
	<input name="functionType" id="functionType" type="hidden"  value="1">
	<fieldset class="step">
	<div class="form">
        <label class="Validform_label"> <t:mutiLang langKey="menu.name"/>: </label>
        <input name="functionName" class="inputxt" value="${function.functionName}" datatype="*2-50">
        <span class="Validform_checktip"> <t:mutiLang langKey="menuname.rang4to15"/> </span>
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
   
	<div class="form" id="funorder">
	<label class="Validform_label"> 
	<t:mutiLang langKey="menu.order"/>: </label> <input name="functionOrder" class="inputxt" value="${function.functionOrder}" datatype="n1-3"></div>
	</fieldset>
</t:formvalid> 
</body>
</html>
