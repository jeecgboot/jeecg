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
<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	$(function() {
		$(document).ready(function() {
			var chart;
			$.ajax({
				type : "POST",
				url : "jeecgListDemoController.do?broswerCount&reportType=line",
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
							text : '<t:mutiLang langKey="broswer.count.analysis"/>-<b><t:mutiLang langKey="common.line.chart"/></b>'
						},
						xAxis : {
							categories : [ '1', '2', '3', '4', '5','6','7','8']
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
			                 url:'${ctxPath}/jeecgListDemoController.do?export'  
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
				url : "jeecgListDemoController.do?broswerCount&reportType=column",
				success : function(jsondata) {
					data = eval(jsondata);
					//console.log(data);//Highcharts报表插件bug,IE8下不能出现该语句,否则报表不显示					
					chart = new Highcharts.Chart({
						chart : {
							renderTo : 'containerCol',
							plotBackgroundColor : null,
							plotBorderWidth : null,
							plotShadow : false
						},
						title : {
							text : '<t:mutiLang langKey="broswer.count.analysis"/>-<b><t:mutiLang langKey="common.histogram"/></b>'
						},
						xAxis : {
							categories : [ 'Chrome', 'Firefox', 'IE', 'MSIE 7.0', 'MSIE 8.0','MSIE 9.0','rv:11.0','Safari']
						},
						tooltip : {
							 percentageDecimals : 1,
							 formatter: function() {
            					return  '<b>'+this.point.name + '</b>:' +  Highcharts.numberFormat(this.percentage, 1) +'%';
         					}

						},
						exporting:{ 
			                filename:'column',  
			                url:'${ctxPath}/jeecgListDemoController.do?export'
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
										return  Highcharts.numberFormat(this.percentage, 1)+"%";
									}
								}
							}
						},
						series:data//,IE8不喜欢多余的逗号
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
				url : "jeecgListDemoController.do?broswerCount&reportType=pie",
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
							text : '<t:mutiLang langKey="broswer.count.analysis"/>-<b><t:mutiLang langKey="common.pie.chart"/></b>'
						},
						xAxis : {
							categories : [ '1', '2', '3', '4', '5']
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
			                 url:'${ctxPath}/jeecgListDemoController.do?export'  
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
</head>
<body>
<span id="containerline" style="float: left; width: 30%; height:60%;"></span>
<span id="containerCol" style="float: left; width: 38%;height:60%;"></span>
<span id="containerPie" style="float: left; width: 30%; height:60%;"></span>
<!--update-begin--Author:xuelin  Date:20170804 for：TASK #2246 【IE兼容问题】两个报表，不兼容IE8，代码优化     固定高度,否则部分浏览器下(chrome,IE8),数据表不显示------------------- -->
<div style="width: 100%; height: 333px;">
<!--update-end--Author:xuelin  Date:20170804 for：TASK #2246 【IE兼容问题】两个报表，不兼容IE8，代码优化     固定高度,否则部分浏览器下(chrome,IE8),数据表不显示------------------- -->
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
<!-- add-update--Author:jg_renjie  Date:20150613 for：页面自适应页面，不会出现左右滚动条 -->
</body>
</html>