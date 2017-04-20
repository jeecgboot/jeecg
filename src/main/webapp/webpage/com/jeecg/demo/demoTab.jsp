<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>tab</title>
<t:base type="jquery,easyui,tools"></t:base>
<SCRIPT type="text/javascript">
  function test(data) {
	  $.messager.confirm('提示信息', data.msg, function(r){
			document.location="jeecgListDemoController.do?list";
		});
		closetab('TAB方式添加');
	}
  </SCRIPT>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="false" action="" btnsub="btn" callback="test">
	<fieldset class="step">
	
	<a href="#" class="easyui-linkbutton" id="btn" iconCls="icon-ok">提交</a> 
	<a href="#" class="easyui-linkbutton" id="btn_reset" iconCls="icon-back">重置</a>
	<a href="javascript:history.go(-1)" class="easyui-linkbutton" id="btn_reset" iconCls="icon-back">返回</a>
	</fieldset>
</t:formvalid>
</body>
</html>
