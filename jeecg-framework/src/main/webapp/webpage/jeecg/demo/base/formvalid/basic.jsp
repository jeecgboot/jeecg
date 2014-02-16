<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:formvalid formid="formobj" dialog="false" layout="div" action="demoController.do?saveDemo">
	<input type="hidden" id="id" />
	<fieldset class="step">
	<div class="form"><label class="Validform_label"> 非空验证： </label> <input name="demotitle" id="demotitle" datatype="*" errormsg="该字段不为空"> <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label"> URL验证： </label> <input name="demourl" id="demourl" datatype="url" errormsg="必须是URL"> <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label"> 至少选择2项： </label> 
	<input name="shoppingsite1" class="rt2" id="shoppingsite21" type="checkbox" value="1" datatype="need2" nullmsg="请选择您的爱好！" />
	阅读 <input name="shoppingsite1" class="rt2" id="shoppingsite22" type="checkbox" value="2" /> 
	音乐 <input name="shoppingsite1" class="rt2" id="shoppingsite23" type="checkbox" value="3" /> 
	运动 <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label"> 邮箱： </label> <input name="demoorder" id="demoorder" datatype="e" errormsg="邮箱非法"> <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label"> 手机号： </label> <input name="phone" id="phone" datatype="m" errormsg="手机号非法"> <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label"> 金额： </label> <input name="money" id="money" datatype="d" errormsg="金额非法"> <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label"> 日期： </label> <input name="date" id="date" class="easyui-datebox"> <span class="Validform_checktip"></span></div>
	<div class="form"><label class="Validform_label"> 时间： </label> <input name="time" id="time" class="easyui-datetimebox"> <span class="Validform_checktip"></span></div>
	</fieldset>
	<a href="#" class="easyui-linkbutton" onclick="openwindow('表单验证源码','demoController.do?demoCode&id=1','表单验证源码',1000,600)">查看源码</a>
</t:formvalid>
