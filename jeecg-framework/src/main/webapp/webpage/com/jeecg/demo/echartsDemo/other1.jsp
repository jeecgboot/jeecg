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
    		"animation": false,
    		"title": {
    			"text": "tubiao"
    		},
    		"xAxis": [{
    			"data": ["周一", "周二", "周三", "周四", "周五", "周六", "周日"],
    			"type": "category"
    		}],
    		"yAxis": [{
    			"type": "value",
    			"splitArea": {
    				"show": true
    			}
    		}],
    		"series": [{
    			"data": [12, 5, 4, 10, 15, 7, 13],
    			"name": "蒸发量",
    			"type": "line",
    			"smooth": true
    		}, {
    			"data": [10, 15, 7, 13, 12, 5, 3],
    			"name": "降水量",
    			"type": "line"
    		}]
    	}
    myChart.setOption(option);
    </script>
</body>
</html>