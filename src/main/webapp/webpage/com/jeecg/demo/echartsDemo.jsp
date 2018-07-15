<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<!-- context path -->
<t:base type="jquery,easyui"></t:base>
<script type="text/javascript" src="plug-in/Highcharts-2.2.5/js/highcharts.src.js"></script>
<script type="text/javascript" src="plug-in/Highcharts-2.2.5/js/modules/exporting.src.js"></script>
<script type="text/javascript" src="plug-in/echart/echarts.min.js"></script>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
//Echarts线性报表
	$(function() {
		$(document).ready(function() {
			var chart = echarts.init(document.getElementById('containerline'));
			$.ajax({
				type : "POST",
				url : "jeecgListDemoController.do?broswerCount&reportType=line",
				success : function(jsondata) {
					jsondata=JSON.parse(jsondata);
					var data=jsondata[0].data;
					var xAxisData=[];
					var seriesData=[];
					for(var i in data){
						xAxisData.push(data[i].name);
						seriesData.push(data[i].percentage);
					}
					var option = {
				            tooltip: {},
				            legend: {
				                data:[jsondata[0].name],
				                left:'center'
				            },
				            xAxis: {
				            	type: 'category',
				                data: xAxisData,
				                axisLabel:{
				                	interval:0,//横轴信息全部显示
				                	rotate:-30,//-10角度倾斜展示
				                }
				            },
				            yAxis: {},
				            series: [{
				                name: jsondata[0].name,
				                type: 'line',
				                data: seriesData
				            }]
				        };
					chart.setOption(option);
				}
			});
		});
	});
</script>


<script type="text/javascript">
//Echarts柱状报表
	$(function() {
		$(document).ready(function() {
			var chart = echarts.init(document.getElementById('containerCol'));
			$.ajax({
				type : "POST",
				url : "jeecgListDemoController.do?broswerCount&reportType=column",
				success : function(jsondata) {
					jsondata=JSON.parse(jsondata);
					var data=jsondata[0].data;
					var xAxisData=[];
					var seriesData=[];
					for(var i in data){
						xAxisData.push(data[i].name);
						seriesData.push(data[i].percentage);
					}
					var option = {
				            tooltip: {},
				            legend: {
				                data:[jsondata[0].name],
				                left:'center'
				            },
				            xAxis: {
				            	type: 'category',
				                data: xAxisData,
				                axisLabel:{
				                	interval:0,//横轴信息全部显示
				                	rotate:-30,//-10角度倾斜展示
				                }
				            },
				            yAxis: {},
				            series: [{
				                name: jsondata[0].name,
				                type: 'bar',
				                data: seriesData
				            }]
				        };
					chart.setOption(option);
				}
			});
		});
	});
</script>


<script type="text/javascript">
//Echarts饼型报表
	$(function() {
		$(document).ready(function() {
			var chart = echarts.init(document.getElementById('containerPie'));
			$.ajax({
				type : "POST",
				url : "jeecgListDemoController.do?broswerCount&reportType=pie",
				success : function(jsondata) {
					jsondata=JSON.parse(jsondata);
					var data=jsondata[0].data;
					var xAxisData=[];
					var seriesData=[];
					var picData = [];
					for(var i in data){
						xAxisData.push(data[i].name);
						seriesData.push(data[i].percentage);
						picData.push({"value":data[i].percentage,"name":data[i].name});
					}
					option = {
						    title : {
						        text: jsondata[0].name,
						        x:'right'
						    },
						    tooltip : {
						        trigger: 'item',
						        formatter: "{a} <br/>{b} : {c} ({d}%)"
						    },
						    legend: {
						        orient: 'vertical',
						        left: 'left',
						        data: xAxisData
						    },
						    series : [
						        {
						            name: jsondata[0].name,
						            type: 'pie',
						            radius : '55%',
						            center: ['67%', '60%'],
						            data:picData,
						            itemStyle: {
						                emphasis: {
						                    shadowBlur: 10,
						                    shadowOffsetX: 0,
						                    shadowColor: 'rgba(0, 0, 0, 0.5)'
						                }
						            }
						        }
						    ]
						};
					chart.setOption(option);
				}
			});
		});
	});
</script>
</head>
<body>
<div style="width:100%;height:300px;">
	<div id="containerline" style="float:left; width: 30%;height:100%;"></div>
	<div id="containerCol" style="float: left; width: 38%;height:100%;"></div>
	<div id="containerPie" style="float: left; width: 30%; height:100%;"></div>
</div>
<div style="width: 100%; height: 333px;">
	<t:datagrid name="broswerStatisticList" title="broswer.count.statistics" actionUrl="jeecgListDemoController.do?listAllStatisticByJdbc" idField="id" fit="true">
		<t:dgCol title="common.code" field="id" hidden="true"></t:dgCol>
		<t:dgCol title="lang.broswer" field="broswer" width="130"></t:dgCol>
		<t:dgCol title="number.broswer" field="broswercount" width="130"></t:dgCol>
		<t:dgCol title="common.proportion" field="rate" width="130"></t:dgCol>
	</t:datagrid>
</div>
<script type="text/javascript">
	$(function(){
		$(document.body).css("width","99.3%");
	});
</script>
</body>
</html>