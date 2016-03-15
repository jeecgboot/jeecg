<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px">
<t:datagrid name="tFinanceList" title="多附件管理" actionUrl="tFinanceController.do?datagrid" fitColumns="true" idField="id" fit="true" queryMode="group">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="类别" field="category" query="true"></t:dgCol>
	<t:dgCol title="年份" field="happenyear"></t:dgCol>
	<t:dgCol title="拨款时间" field="paytime" formatter="yyyy-MM-dd hh:mm:ss" query="true" queryMode="group"></t:dgCol>
	<t:dgCol title="收款单位" field="collectorg"></t:dgCol>
	<t:dgCol title="拨款文件类别" field="approfiletype"></t:dgCol>
	<t:dgCol title="指标文号" field="zbwno"></t:dgCol>
	<t:dgCol title="金额合计" field="moneytotal" query="true"></t:dgCol>
	<t:dgCol title="支出科目" field="expenseaccount"></t:dgCol>
	<t:dgCol title="操作" field="opt"></t:dgCol>
	<t:dgDelOpt title="删除" url="tFinanceController.do?del&id={id}" />
	<t:dgToolBar title="录入" icon="icon-add" url="tFinanceController.do?addorupdate" funname="add"></t:dgToolBar>
	<t:dgToolBar title="编辑" icon="icon-edit" url="tFinanceController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar title="查看" icon="icon-search" url="tFinanceController.do?addorupdate" funname="detail"></t:dgToolBar>
</t:datagrid>
</div>
</div>
<script type="text/javascript">
	$(document).ready(function(){
		$("input[name='paytime_begin']").attr("class","easyui-datebox");
		$("input[name='paytime_end']").attr("class","easyui-datebox");
		$("input[name='buyprojectorg']").prev().css("width","105px");
	});
 </script>