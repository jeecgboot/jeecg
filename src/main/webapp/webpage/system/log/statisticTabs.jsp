<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!-- context path -->
<!-- update-begin--Author:xuelin  Date:20170428 for：#1755 【美化】用户分析报表，多tab格式，是否可以美化  需要改底层-------------------- -->
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript" src="plug-in/Highcharts-2.2.5/js/highcharts.src.js"></script>
<script type="text/javascript" src="plug-in/Highcharts-2.2.5/js/modules/exporting.src.js"></script>
<t:tabs id="tt" iframe="false">
	<t:tab href="logController.do?userBroswer&reportType=line" icon="fa fa-line-chart" title="user.analysis.line" id="pnode"></t:tab>
	<t:tab href="logController.do?userBroswer&reportType=pie" icon="fa fa-pie-chart" title="user.analysis.pie" id="pnode"></t:tab>
	<t:tab href="logController.do?userBroswer&reportType=column" icon="fa fa-bar-chart" title="user.analysis.histogram" id="pnode"></t:tab>
</t:tabs>
<!-- update-end--Author:xuelin  Date:20170428 for：#1755 【美化】用户分析报表，多tab格式，是否可以美化  需要改底层-------------------- -->
<!-- update-begin--Author:xuelin  Date:20170329 for：[#1823]【bug】报表点击打印后，页面乱的问题解决-------------------- -->
<script type="text/javascript">
		$(document).ready(function() {
			//为不需要打印的元素添加打印隐藏识别类
			$(".tabs-header").addClass("no-print");
		});
		/* update-begin--Author:xuelin  Date:20170427 for：#1755 【美化】用户分析报表，多tab格式，是否可以美化 / 优化[#1823]【bug】隐藏的Tab打印后也错乱-------------------- */
		$(window).resize(function(){
			var tabs = $('#tt').tabs('tabs');
			for(var i = 0; i < tabs.length; i++){
				tabs[i].panel('refresh');
			}
		});		
		/* update-end--Author:xuelin  Date:20170427 for：#1755 【美化】用户分析报表，多tab格式，是否可以美化/ 优化[#1823]【bug】隐藏的Tab打印后也错乱-------------------- */
</script>
<!-- update-end--Author:xuelin  Date:20170329 for：[#1823]【bug】报表点击打印后，页面乱的问题解决---------------------- -->