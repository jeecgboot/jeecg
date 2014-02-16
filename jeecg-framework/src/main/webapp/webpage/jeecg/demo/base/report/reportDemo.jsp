<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!-- context path -->
<t:base type="jquery,easyui"></t:base>
<script type="text/javascript" src="plug-in/Highcharts-2.2.5/js/highcharts.src.js"></script>
<script type="text/javascript" src="plug-in/Highcharts-2.2.5/js/modules/exporting.src.js"></script>

<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	$(function() {
		$(document).ready(function() {
			var chart;
			$.ajax({
				type : "POST",
				url : "reportDemoController.do?studentCount&reportType=line",
				success : function(jsondata) {
					data = eval(jsondata);
					chart = new Highcharts.Chart({
						chart : {
							renderTo : 'containerline',
							plotBackgroundColor : null,
							plotBorderWidth : null,
							plotShadow : false
						},
						title : {
							text : '班级学生人数比例分析-<b>折线图</b>'
						},
						xAxis : {
							categories : [ '1班', '2班', '3班', '4班', '5班']
						},
						tooltip : {
							shadow: false,
							percentageDecimals : 1,
							formatter: function() {
            					return  '<b>'+this.point.name + '</b>:' +  Highcharts.numberFormat(this.percentage, 1) +'%';
         					}

						},
						exporting:{  
			                filename:'pie',  
			                 url:'${ctxPath}/reportDemoController.do?export'  
			            },  
						plotOptions : {
							pie : {
								allowPointSelect : true,
								cursor : 'pointer',
								showInLegend : true,
								dataLabels : {
									enabled : true,
									color : '#000000',
									connectorColor : '#000000',
									formatter : function() {
										return '<b>' + this.point.name + '</b>: ' + Highcharts.numberFormat(this.percentage, 1)+"%";
									}
								}
							}
						},
						series : data
					});
				}
			});
		});
	});
</script>


<script type="text/javascript">
	$(function() {
		$(document).ready(function() {
			var chart;
			$.ajax({
				type : "POST",
				url : "reportDemoController.do?studentCount&reportType=column",
				success : function(jsondata) {
					
					data = eval(jsondata);
					console.log(data);
					chart = new Highcharts.Chart({
						chart : {
							renderTo : 'containerCol',
							plotBackgroundColor : null,
							plotBorderWidth : null,
							plotShadow : false
						},
						title : {
							text : '班级学生人数比例分析-<b>柱状图</b>'
						},
						xAxis : {
							categories : [ '1班', '2班', '3班', '4班', '5班']
						},
						tooltip : {
							 percentageDecimals : 1,
							 formatter: function() {
            					return  '<b>'+this.point.name + '</b>:' +  Highcharts.numberFormat(this.percentage, 1) +'%';
         					}

						},
						exporting:{ 
			                filename:'column',  
			                url:'${ctxPath}/reportDemoController.do?export'//
			            },
						plotOptions : {
							column : {
								allowPointSelect : true,
								cursor : 'pointer',
								showInLegend : true,
								dataLabels : {
									enabled : true,
									color : '#000000',
									connectorColor : '#000000',
									formatter : function() {
										return '<b>' + this.point.name + '</b>: ' +Highcharts.numberFormat(this.percentage, 1)+"%";
									}
								}
							}
						},
						series : data
					});
				}
			});
		});
	});
</script>


<script type="text/javascript">
	$(function() {
		$(document).ready(function() {
			var chart;
			$.ajax({
				type : "POST",
				url : "reportDemoController.do?studentCount&reportType=pie",
				success : function(jsondata) {
					data = eval(jsondata);
					chart = new Highcharts.Chart({
						chart : {
							renderTo : 'containerPie',
							plotBackgroundColor : null,
							plotBorderWidth : null,
							plotShadow : false
						},
						title : {
							text : '班级学生人数比例分析-<b>饼状图</b>'
						},
						xAxis : {
							categories : [ '1班', '2班', '3班', '4班', '5班']
						},
						tooltip : {
							shadow: false,
							percentageDecimals : 1,
							formatter: function() {
            					return  '<b>'+this.point.name + '</b>:' +  Highcharts.numberFormat(this.percentage, 1) +'%';
         					}

						},
						exporting:{  
			                filename:'pie',  
			                 url:'${ctxPath}/reportDemoController.do?export'  
			            },  
						plotOptions : {
							pie : {
								allowPointSelect : true,
								cursor : 'pointer',
								showInLegend : true,
								dataLabels : {
									enabled : true,
									color : '#000000',
									connectorColor : '#000000',
									formatter : function() {
										return '<b>' + this.point.name + '</b>: ' + Highcharts.numberFormat(this.percentage, 1)+"%";
									}
								}
							}
						},
						series : data
					});
				}
			});
		});
	});
</script>
<span id="containerline" style="float: left; width: 30%; height: 60%"></span>
<span id="containerCol" style="float: left; width: 38%; height: 60%"></span>
<span id="containerPie" style="width: 30%; height: 60%"></span>

<div style="width: 98%; height: 280px"><t:datagrid name="studentStatisticList" title="班级学生人数统计" actionUrl="reportDemoController.do?listAllStatisticByJdbc" idField="id" fit="true">
	<t:dgCol title="编号" field="id" hidden="false"></t:dgCol>
	<t:dgCol title="班级" field="classname" width="130"></t:dgCol>
	<t:dgCol title="人数" field="personcount" width="130"></t:dgCol>
	<t:dgCol title="比例" field="rate" width="130"></t:dgCol>
</t:datagrid></div>