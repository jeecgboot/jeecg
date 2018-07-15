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
    	    calculable: true,
    	    series: [
    	        {
    	            name:'漏斗图',
    	            type:'funnel',
    	            left: '10%',
    	            top: 60,
    	            //x2: 80,
    	            bottom: 60,
    	            width: '80%',
    	            // height: {totalHeight} - y - y2,
    	            min: 0,
    	            max: 100,
    	            minSize: '0%',
    	            maxSize: '100%',
    	            sort: 'descending',
    	            gap: 2,
    	            label: {
    	                normal: {
    	                    show: true,
    	                    position: 'inside'
    	                },
    	                emphasis: {
    	                    textStyle: {
    	                        fontSize: 20
    	                    }
    	                }
    	            },
    	            labelLine: {
    	                normal: {
    	                    length: 10,
    	                    lineStyle: {
    	                        width: 1,
    	                        type: 'solid'
    	                    }
    	                }
    	            },
    	            itemStyle: {
    	                normal: {
    	                    borderColor: '#fff',
    	                    borderWidth: 1
    	                }
    	            },
    	            data: [
    	                {value: 60, name: '访问'},
    	                {value: 40, name: '咨询'},
    	                {value: 20, name: '订单'},
    	                {value: 80, name: '点击'},
    	                {value: 100, name: '展现'}
    	            ]
    	        }
    	    ]
    	};

    myChart.setOption(option);
    </script>
</body>
</html>