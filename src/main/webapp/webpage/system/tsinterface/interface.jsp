<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>接口权限信息</title>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
		
	$(function() {
		$('#cc').combotree({
			url : 'interfaceController.do?setPInterface&selfId=${tsInterface.id}',
			panelHeight: 200,
			width: 157,
			onClick: function(node){
				$("#interfaceId").val(node.id);
			}
		});
		
		if($('#interfaceLevel').val()=='1'){
			$('#pfun').show();
		}else{
			$('#pfun').hide();
		}
		
		
		$('#interfaceLevel').change(function(){
			if($(this).val()=='1'){
				$('#pfun').show();
				var t = $('#cc').combotree('tree');
				var nodes = t.tree('getRoots');
				if(nodes.length>0){
					$('#cc').combotree('setValue', nodes[0].id);
					$("#interfaceId").val(nodes[0].id);
				}
			}else{
				var t = $('#cc').combotree('tree');
				var node = t.tree('getSelected');
				if(node){
					$('#cc').combotree('setValue', null);
				}
                $("#interfaceId").val(null);
				$('#pfun').hide();
			}
		});
	});
	
	function viewStyle(param) {
		var url = "<%=basePath%>/functionIconStyle.jsp?style = "+ param;
		window.open(url,"_blank");
	}
</script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true" refresh="true" action="interfaceController.do?saveInterface">
	<input name="id" type="hidden" value="${tsInterface.id}">
	<fieldset class="step">
	<div class="form">
        <label class="Validform_label"> 接口权限编码: </label>
        <input name="interfaceCode" class="inputxt" value="${tsInterface.interfaceCode}" datatype="*">
        <span class="Validform_checktip"></span>
    </div>
	<div class="form">
        <label class="Validform_label"> <t:mutiLang langKey="接口权限名称"/>: </label>
        <input name="interfaceName" class="inputxt" value="${tsInterface.interfaceName}" datatype="*2-50">
        <span class="Validform_checktip"> <t:mutiLang langKey="menuname.rang2to15"/> </span>
    </div>
	<div class="form">
        <label class="Validform_label"> <t:mutiLang langKey="接口权限等级"/>: </label>
        <select name="interfaceLevel" id="interfaceLevel" datatype="*">
            <option value="0" <c:if test="${tsInterface.interfaceLevel eq 0}">selected="selected"</c:if>>
                <t:mutiLang langKey="main.function"/>
            </option>
            <option value="1" <c:if test="${tsInterface.interfaceLevel>0}"> selected="selected"</c:if>>
                <t:mutiLang langKey="sub.function"/>
            </option>
        </select>
        <span class="Validform_checktip"></span>
    </div>
	<div class="form" id="pfun">
        <label class="Validform_label"> <t:mutiLang langKey="父级接口"/>: </label>
        <input id="cc" <c:if test="${tsInterface.tSInterface.interfaceLevel eq 0}"> value="${tsInterface.tSInterface.id}"</c:if>
		<c:if test="${tsInterface.tSInterface.interfaceLevel > 0}"> value="${tsInterface.tSInterface.interfaceName}"</c:if>>
        <input id="interfaceId" name="tSInterface.id" style="display: none;" value="${tsInterface.tSInterface.id}">
    </div>
	<div class="form" id="inturl">
        <label class="Validform_label">
            <t:mutiLang langKey="接口权限地址"/>:
        </label>
        <input name="interfaceUrl" class="inputxt" value="${tsInterface.interfaceUrl}" style="width:70%">
    </div>
    <div class="form">
        <label class="Validform_label"> 请求方式: </label>
        <input name="interfaceMethod" class="inputxt" value="${tsInterface.interfaceMethod}" datatype="*">
        <span class="Validform_checktip">示例：GET|POST|PUT|DELETE</span>
    </div>
	<div class="form" id="intorder"><label class="Validform_label"> 
	<t:mutiLang langKey="接口权限排序"/>: </label> 
	<input name="interfaceOrder" class="inputxt" value="${tsInterface.interfaceOrder}" datatype="n1-3">
	</div>
	 
	</fieldset>
</t:formvalid> 
</body>
</html>
