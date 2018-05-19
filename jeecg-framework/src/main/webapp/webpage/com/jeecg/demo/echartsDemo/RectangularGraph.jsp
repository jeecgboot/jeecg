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
    	    title : {
    	        text: '手机占有率',
    	        subtext: '虚构数据'
    	    },
    	    tooltip : {
    	        trigger: 'item',
    	        formatter: "{b}: {c}"
    	    },
    	    toolbox: {
    	        show : true,
    	        feature : {
    	            mark : {show: true},
    	            dataView : {show: true, readOnly: false},
    	            restore : {show: true},
    	            saveAsImage : {show: true}
    	        }
    	    },
    	    calculable : false,
    	    series : [
    	        {
    	            name:'矩形图',
    	            type:'treemap',
    	            itemStyle: {
    	                normal: {
    	                    label: {
    	                        show: true,
    	                        formatter: "{b}"
    	                    },
    	                    borderWidth: 1
    	                },
    	                emphasis: {
    	                    label: {
    	                        show: true
    	                    }
    	                }
    	            },
    	            data:[
    	                {
    	                    name: '三星',
    	                    value: 6
    	                },
    	                {
    	                    name: '小米',
    	                    value: 4
    	                },
    	                {
    	                    name: '苹果',
    	                    value: 4
    	                },
    	                {
    	                    name: '华为',
    	                    value: 2
    	                },
    	                {
    	                    name: '联想',
    	                    value: 2
    	                },
    	                {
    	                    name: '魅族',
    	                    value: 1
    	                },
    	                {
    	                    name: '中兴',
    	                    value: 1
    	                }
    	            ]
    	        }
    	    ]
    	};
    	                    
    myChart.setOption(option);
    </script>
</body>
</html>