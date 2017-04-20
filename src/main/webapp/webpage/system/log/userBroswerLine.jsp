<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
<script type="text/javascript">
	$(function() {
		$(document).ready(function() {
			var chart;
			$.ajax({
				type : "POST",
				url : "logController.do?getBroswerBar&reportType=${reportType}",
				success : function(jsondata) {
					data = eval(jsondata);

					var xAxisCategories = new Array();
					for(var i = 0; i < data[0].data.length; i++){
						xAxisCategories[i] = data[0].data[i].name;
					}

					chart = new Highcharts.Chart({
						chart : {
							renderTo : 'containerline',
							plotBackgroundColor : null,
							plotBorderWidth : null,
							plotShadow : false
						},
						title : {
							text : "<t:mutiLang langKey="user.browser.analysis"/>"
						},
						xAxis : {
							categories : xAxisCategories
						},
						tooltip : {
							pointFormat : '{series.name}: <b>{point.y}</b>',
							percentageDecimals : 1

						},
						exporting:{  
			                filename:'折线图',  
			                 url:'${ctxPath}/logController.do?export'  
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
										return '<b>' + this.point.name + '</b>: ' + this.y;
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
<div id="containerline" style="width: 80%; height: 80%"></div>


