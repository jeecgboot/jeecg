<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<html>
<head>
<title>Popup示例</title>
<t:base type="jquery,easyui,tools"></t:base>
</head>
<body style="overflow-y: hidden" scroll="no">
<div class="formDetails"><label>用户选择： <input id="myText" readonly="readonly" type="text" class="searchbox-inputtext15" onclick="inputClick(this,'mobilephone','test');"> </label> <label>清算期
<input type="text" readonly="readonly" name="period" value="" id="add_period" maxlength="8" /> </label> <label>开账人 <input type="text" readonly="readonly" name="billingInfo.billedCompany" value=""
	id="add_billedCompany" maxlength="8" /> </label> <label>被开账人 <input type="text" name="billingInfo.reverseBilledCompany" value="" id="add_reverseBilledCompany" maxlength="8"
	style="text-transform: uppercase;" onfocus="tips('add_reverseBilledCompany','被开账公司清算代码,不可为空')" onblur="outtips();numCodeExit(this)" /> </label> <label>账单号 <input type="text"
	name="billingInfo.number" value="" maxlength="33" id="add_number" onfocus="tips('add_number','账单号不能含有“-”字符,不可为空')" onblur="outtips();" /> </label> <label>账单金额 <input type="text"
	name="billingInfo.amount" value="" maxlength="15" id="add_amount" onfocus="tips('add_amount','最多录入11位整数，2位小数，负数用“-”表示，不可为空')" onblur="outtips()" /> </label> <label>类型 <select id="jformType"
	name="jformType" onchange="jformTypeChange();">
	<option value="1">单表</option>
	<option value="2" selected="selected">主表</option>
	<option value="3">附表</option>
</select> </label> <label class="row">备注(不可超过150字) <textarea type="text" style="width: 90%;" rows="4" name="billingInfo.remark" value="" id="add_remark"></textarea> </label>
<div class="button-row">
<button name="button" onclick="addAdjustBill()" type="button">确 定</button>
<button name="button" type="reset">清 空</button>
<button name="button" onclick="cancelAll()" type="button">关 闭</button>
</div>

</div>

</body>
</html>