<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<c:set var="ctxPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html >
<script type="text/javascript">
	$(function() {
		$(document).ready(function() {
			var chart;
			$.ajax({
				type : "POST",
				url : "logController.do?getBroswerBar&reportType=${reportType}",
				success : function(jsondata) {
					data = eval(jsondata);
					chart = new Highcharts.Chart({
						chart : {
							renderTo : 'containerCol',
							plotBackgroundColor : null,
							plotBorderWidth : null,
							plotShadow : false
						},
						title : {
							text : "<t:mutiLang langKey="user.browser.analysis"/>"
						},
						xAxis : {
							categories : [ 'IE9', 'MSIE 7.0', 'MSIE 8.0', 'MSIE 7.0', 'Firefox', 'Chrome' ]
						},
						tooltip : {
							 percentageDecimals : 1,
							 formatter: function() {
            					return  '<b>'+this.point.name + '</b>:' +  Highcharts.numberFormat(this.percentage, 1) +'%';
         					}

						},
						exporting:{  
			                filename:'column',  
			                url:'${ctxPath}/logController.do?export'//
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
<div id="containerCol" style="width: 80%; height: 80%"></div>


