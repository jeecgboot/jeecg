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
    	        trigger: 'axis',
    	        showDelay : 0,
    	        axisPointer:{
    	            show: true,
    	            type : 'cross',
    	            lineStyle: {
    	                type : 'dashed',
    	                width : 1
    	            }
    	        },
    	        zlevel: 1
    	    },
    	    legend: {
    	        data:['sin','cos']
    	    },
    	    toolbox: {
    	        show : true,
    	        feature : {
    	            mark : {show: true},
    	            dataZoom : {show: true},
    	            dataView : {show: true, readOnly: false},
    	            restore : {show: true},
    	            saveAsImage : {show: true}
    	        }
    	    },
    	    xAxis : [
    	        {
    	            type : 'value',
    	            scale:true
    	        }
    	    ],
    	    yAxis : [
    	        {
    	            type : 'value',
    	            scale:true
    	        }
    	    ],
    	    series : [
    	        {
    	            name:'sin',
    	            type:'scatter',
    	            large: true,
    	            symbolSize: 3,
    	            data: (function () {
    	                var d = [];
    	                var len = 10000;
    	                var x = 0;
    	                while (len--) {
    	                    x = (Math.random() * 10).toFixed(3) - 0;
    	                    d.push([
    	                        x,
    	                        //Math.random() * 10
    	                        (Math.sin(x) - x * (len % 2 ? 0.1 : -0.1) * Math.random()).toFixed(3) - 0
    	                    ]);
    	                }
    	                //console.log(d)
    	                return d;
    	            })()
    	        },
    	        {
    	            name:'cos',
    	            type:'scatter',
    	            large: true,
    	            symbolSize: 2,
    	            data: (function () {
    	                var d = [];
    	                var len = 20000;
    	                var x = 0;
    	                while (len--) {
    	                    x = (Math.random() * 10).toFixed(3) - 0;
    	                    d.push([
    	                        x,
    	                        //Math.random() * 10
    	                        (Math.cos(x) - x * (len % 2 ? 0.1 : -0.1) * Math.random()).toFixed(3) - 0
    	                    ]);
    	                }
    	                //console.log(d)
    	                return d;
    	            })()
    	        }
    	    ]
    	};

    myChart.setOption(option);
    </script>
</body>
</html>