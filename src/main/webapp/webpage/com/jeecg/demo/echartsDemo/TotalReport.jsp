<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script type="text/javascript" src="plug-in/echart/echarts.js"></script>
<script type="text/javascript" src="plug-in/Highcharts-2.2.5/js/highcharts.src.js"></script>
<script type="text/javascript" src="plug-in/Highcharts-2.2.5/js/modules/exporting.src.js"></script>
<div id="main" style="width:100%;height:400px;"></div>
    <script type="text/javascript">
    var myChart = echarts.init(document.getElementById('main'));
    $.ajax({
     	type: "POST",
        url: "jeecgListDemoController.do?getTotalReport",
        dataType:"text",
        contentType: 'charset=utf-8',
        success: function(option){
        		data = eval("("+option+")");
        		myChart.setOption(data);
        	 }
         });    
     </script>
<div style="width: 100%; height: 333px;">
<t:datagrid name="TotalReportList" title="broswer.count.statistics" actionUrl="jeecgListDemoController.do?listAllStatisticByJdbc"  fitColumns="true" idField="id" fit="true">
		<t:dgCol title="common.code" field="id" hidden="true"></t:dgCol>
		<t:dgCol title="lang.broswer" field="broswer" width="130"></t:dgCol>
		<t:dgCol title="number.broswer" field="broswercount" width="130"></t:dgCol>
		<t:dgCol title="common.proportion" field="rate" width="130"></t:dgCol>
	</t:datagrid>
</div>