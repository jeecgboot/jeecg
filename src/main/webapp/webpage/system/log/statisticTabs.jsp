<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!-- context path -->
<t:base type="jquery,easyui"></t:base>
<script type="text/javascript" src="plug-in/Highcharts-2.2.5/js/highcharts.src.js"></script>
<script type="text/javascript" src="plug-in/Highcharts-2.2.5/js/modules/exporting.src.js"></script>
<t:tabs id="tt" iframe="false">
	<t:tab href="logController.do?userBroswer&reportType=line" icon="icon-search" title="user.analysis.line" id="pnode"></t:tab>
	<t:tab href="logController.do?userBroswer&reportType=pie" icon="icon-search" title="user.analysis.pie" id="pnode"></t:tab>
	<t:tab href="logController.do?userBroswer&reportType=column" icon="icon-search" title="user.analysis.histogram" id="pnode"></t:tab>
</t:tabs>
<script type="text/javascript">
		$(document).ready(function() {
			//为不需要打印的元素添加打印隐藏识别类
			$(".tabs-header").addClass("no-print");
		})
</script>
<!-- update-end--Author:xuelin  Date:20170329 for：[#1823]【bug】报表点击打印后，页面乱的问题解决---------------------- -->