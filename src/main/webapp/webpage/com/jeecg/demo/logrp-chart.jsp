<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery"></t:base>
<link rel="stylesheet" type="text/css" href="plug-in/ichart/css/gallery.css"></link>
<script type="text/javascript" src="plug-in/ichart/js/ichart-1.0.js"></script>
<!-- <script src="webpage/jeecg/cgdynamgraph/core/cgDynamGraphDesignMobile.js"></script> -->
 <style type="text/css">
	#canvasLineDiv{
	    position: absolute;
	    top: 550px;
	}
</style>
</head>
<script type="text/javascript">
$(function(){
	
	var logsData=eval('${logs}');
	var xAxisCategories = new Array();
	var yArr = new Array();
	for(var i = 0; i < logsData.length; i++){
		xAxisCategories[i] = logsData[i].name;
		yArr[i]=logsData[i].value;
	}
	var chart1=new iChart.Column2D({
		id:"mychart",
		render : 'canvasDiv',
		data: logsData,
		title : '用户浏览器使用次数统计柱状图',
		//showpercent:true,
		//decimalsnum:2,
		width : 800,
		height : 500,
		coordinate:{
			background_color:'#fefefe',
			scale:[{
				 position:'left',	
				 start_scale:0,
				 end_scale:4000,
				 scale_space:500,
				/*  listeners:{
					parseText:function(t,x,y){
						return {text:t+"%"}
					}
				} */
			}]
		}
	});
	chart1.draw();
	window.onresize=function(){  
		dosize(chart1);
	}  
	
	var data = [
	        	{
	        		name : '浏览器',
	        		value:yArr,
	        		color:'#1f7e92',
	        		line_width:3
	        	}
	       ];
	var chart2 = new iChart.LineBasic2D({
				render : 'canvasLineDiv',
				data: data,
				title : '用户浏览器使用次数统计折线图',
				width : 800,
				height : 400,
				coordinate:{height:'90%',background_color:'#f6f9fa'},
				sub_option:{
					hollow_inside:false,//设置一个点的亮色在外环的效果
					point_size:16
				},
				labels:xAxisCategories
			});
	chart2.draw();
	
	
});

 function dosize(obj){
	//var chart = $.get('mychart');//根据ID获取图表对象
	//chart.eventOn();
	//console.log(chart);
	//chart.push("column_width",null);//设置为null则每次重新计算柱子宽度
	// 获取窗口宽度
	if (window.innerWidth)
	var winWidth = window.innerWidth;
	else if ((document.body) && (document.body.clientWidth))
	winWidth = document.body.clientWidth;
	// 获取窗口高度
	if (window.innerHeight)
	var winHeight = window.innerHeight;
	else if ((document.body) && (document.body.clientHeight))
	winHeight = document.body.clientHeight;
	// 通过深入 Document 内部对 body 进行检测，获取窗口大小
	if (document.documentElement && document.documentElement.clientHeight && document.documentElement.clientWidth)
	{
	winHeight = document.documentElement.clientHeight;
	winWidth = document.documentElement.clientWidth;
	}
	chart.resize(winWidth*0.8,winHeight*0.8);
} 

</script>
<body>
<div style="height:1000px">
<div id="canvasDiv" style="width: 100%; position: absolute;left:0px"></div>

<div id="canvasLineDiv" style="width: 80%; height:50%"></div>
</div>
</body>

</html>
