<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="plug-in/echart/echarts.js"></script>
</head>
<body>
<div id="main" ></div>
    <script type="text/javascript">

    var echartsWarp= document.getElementById('main');     
    var resizeWorldMapContainer = function () {//用于使chart自适应高度和宽度,通过窗体高宽计算容器高宽  
        echartsWarp.style.width = window.innerWidth-20+'px';  
        echartsWarp.style.height = window.innerHeight-20+'px';  
    };        
    resizeWorldMapContainer ();//设置容器高宽  
    var myChart = echarts.init(echartsWarp);

    option = {
    	    tooltip : {
    	        formatter: "{a} <br/>{b} : {c}%"
    	    },
    	    toolbox: {
    	        feature: {
    	            restore: {},
    	            saveAsImage: {}
    	        }
    	    },
    	    series: [
    	        {
    	            name: '业务指标',
    	            type: 'gauge',
    	            detail: {formatter:'{value}%'},
    	            data: [{value: 50, name: '完成率'}]
    	        }
    	    ]
    	};

    	setInterval(function () {
    	    option.series[0].data[0].value = (Math.random() * 100).toFixed(2) - 0;
    	    myChart.setOption(option, true);
    	},2000);

    
    myChart.setOption(option);
    </script>
</body>
</html>