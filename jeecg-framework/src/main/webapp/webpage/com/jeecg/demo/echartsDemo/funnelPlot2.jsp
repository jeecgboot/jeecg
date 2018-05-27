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
    	    title: {
    	        text: '漏斗图',
    	        subtext: '纯属虚构'
    	    },
    	    tooltip: {
    	        trigger: 'item',
    	        formatter: "{a} <br/>{b} : {c}%"
    	    },
    	    toolbox: {
    	        feature: {
    	            dataView: {readOnly: false},
    	            restore: {},
    	            saveAsImage: {}
    	        }
    	    },
    	    legend: {
    	        data: ['展现','点击','访问','咨询','订单']
    	    },
    	    series: [
    	        {
    	            name: '预期',
    	            type: 'funnel',
    	            left: '10%',
    	            width: '80%',
    	            label: {
    	                normal: {
    	                    formatter: '{b}预期'
    	                },
    	                emphasis: {
    	                    position:'inside',
    	                    formatter: '{b}预期: {c}%'
    	                }
    	            },
    	            labelLine: {
    	                normal: {
    	                    show: false
    	                }
    	            },
    	            itemStyle: {
    	                normal: {
    	                    opacity: 0.7
    	                }
    	            },
    	            data: [
    	                {value: 60, name: '访问'},
    	                {value: 40, name: '咨询'},
    	                {value: 20, name: '订单'},
    	                {value: 80, name: '点击'},
    	                {value: 100, name: '展现'}
    	            ]
    	        },
    	        {
    	            name: '实际',
    	            type: 'funnel',
    	            left: '10%',
    	            width: '80%',
    	            maxSize: '80%',
    	            label: {
    	                normal: {
    	                    position: 'inside',
    	                    formatter: '{c}%',
    	                    textStyle: {
    	                        color: '#fff'
    	                    }
    	                },
    	                emphasis: {
    	                    position:'inside',
    	                    formatter: '{b}实际: {c}%'
    	                }
    	            },
    	            itemStyle: {
    	                normal: {
    	                    opacity: 0.5,
    	                    borderColor: '#fff',
    	                    borderWidth: 2
    	                }
    	            },
    	            data: [
    	                {value: 30, name: '访问'},
    	                {value: 10, name: '咨询'},
    	                {value: 5, name: '订单'},
    	                {value: 50, name: '点击'},
    	                {value: 80, name: '展现'}
    	            ]
    	        }
    	    ]
    	};

    myChart.setOption(option);
    </script>
</body>
</html>