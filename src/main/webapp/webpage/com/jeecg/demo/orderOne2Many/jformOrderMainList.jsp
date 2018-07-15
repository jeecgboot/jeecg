<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
   <div region="center" style="padding:0px;border:0px;overflow-x:hidden;">
   <iframe id="mainList" src="${webRoot}/jformOrderMainController.do?mainlist" frameborder="0" height="49%" width="100%"></iframe>
   <div id="accDiv" class="easyui-accordion" style="padding-right:15px;overflow-x:hidden;box-sizing: border-box;">
		<div title="订单客户信息" data-options="iconCls:'icon-ok'" style="overflow:auto;box-sizing: border-box;">
			<iframe id="customerList" height="400" src="${webRoot}/jformOrderMainController.do?customerlist" frameborder="0" width="100%" ></iframe>
		</div>
		<div title="title" data-options="iconCls:'icon-ok'" style="overflow:auto;">
			放置子表的框框
		</div>
  </div>
  </div>
</div>
<script type="text/javascript">
	function getCustomerList(id){
		$("#customerList")[0].contentWindow.getCustomerList(id);
	}

	$(function(){
		var abc = parseInt(document.body.clientWidth)-17;
		$("#accDiv").css("width", abc);
	});

	
</script>