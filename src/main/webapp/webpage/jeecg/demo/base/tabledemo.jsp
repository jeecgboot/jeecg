<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>DEMO添加</title>
<t:base type="jquery,easyui,tools"></t:base>
<SCRIPT type="text/javascript">
  function test(data) {
	//alert(data.msg);
	$.messager.confirm('提示信息', data.msg, function(r){
	document.location="demoController.do?demoList";
			});
		//closetab('TAB方式添加');
	}
  </SCRIPT>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="table" dialog="false" action="demoController.do?saveDemo" btnsub="btn" callback="test">
	<input type="hidden" name="id" id="id" value="${demo.id}">
	<table cellpadding="0" width="100%" cellspacing="1" class="formtable">
		<tr>
			<td align="right" height="40" width="10%"><span class="filedzt">DEMO名称：</span></td>
			<td class="value" width="90%"><input name="demotitle" id="demotitle" value="${demo.demotitle}" datatype="s4-10" errormsg="4~10位字符之间 !" checktip="4~10位字符,且不为空"> <span
				class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right" height="40"><span class="filedzt"> DEMO地址：</span></td>
			<td class="value"><input name="demourl" id="demourl" value="${demo.demourl}"></td>
		</tr>
		<tr>
			<td align="right" height="40"><span class="filedzt"> 上级DEMO：</span></td>
			<td class="value"><t:comboTree url="demoController.do?pDemoList" name="TSDemo.id" id="pdemo" value="${demo.TSDemo.id }"></t:comboTree></td>
		</tr>
		<tr>
			<td align="right" height="40"><span class="filedzt"> 排序：</span></td>
			<td class="value"><input name="demoorder" id="demoorder" value="${demo.demoorder }" datatype="n" errormsg="必须数字" checktip="序列号必须为数字"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr height="40">
			<td class="upload" colspan="6"><a href="#" class="easyui-linkbutton" id="btn" iconCls="icon-ok">提交</a> 
			<a href="#" class="easyui-linkbutton" id="btn_reset" iconCls="icon-back">重置</a>
			<a href="javascript:history.go(-1)" class="easyui-linkbutton" id="btn_reset" iconCls="icon-back">返回</a>
			</td>
		</tr>
	</table>
</t:formvalid>
</body>
</html>
