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
    		"calculable": true,
    		"toolbox": {
    			"show": true
    		},
    		"tooltip": {
    			"trigger": "axis"
    		},
    		"legend": {
    			"data": ["邮件营销", "联盟广告", "直接访问", "搜索引擎"]
    		},
    		"xAxis": [{
    			"data": ["周一", "周二", "周三", "周四", "周五", "周六", "周日"],
    			"type": "category",
    			"boundaryGap": false
    		}],
    		"yAxis": [{
    			"type": "value"
    		}],
    		"series": [{
    			"data": [120, 132, 301, 134, {
    				"value": 90,
    				"symbol": "droplet",
    				"symbolSize": 5
    			}, 230, 210],
    			"name": "邮件营销",
    			"type": "line",
    			"stack": "总量",
    			"symbol": "none",
    			"smooth": true
    		}, {
    			"data": [120, 82, {
    				"value": 201,
    				"symbol": "star",
    				"symbolSize": 15,
    				"itemStyle": {
    					"normal": {
    						"label": {
    							"show": true,
    							"textStyle": {
    								"fontSize": 20,
    								"fontFamily": "微软雅黑",
    								"fontWeight": "bold"
    							}
    						}
    					}
    				}
    			}, {
    				"value": 134,
    				"symbol": "none"
    			}, 190, {
    				"value": 230,
    				"symbol": "emptypin",
    				"symbolSize": 8
    			}, 110],
    			"name": "联盟广告",
    			"type": "line",
    			"stack": "总量",
    			"symbol": "image://http://echarts.baidu.com/doc/asset/ico/favicon.png",
    			"symbolSize": 8,
    			"smooth": true
    		}]
    	}

    myChart.setOption(option);
    </script>
</body>
</html>