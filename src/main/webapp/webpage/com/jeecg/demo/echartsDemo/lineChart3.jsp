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
    			"show": true,
    			"feature": {
    				"mark": {
    					"show": true,
    					"title": {
    						"markUndo": "删除辅助线",
    						"markClear": "清空辅助线",
    						"mark": "辅助线开关"
    					},
    					"lineStyle": {
    						"color": "#1e90ff",
    						"type": "dashed",
    						"width": 2
    					}
    				},
    				"dataView": {
    					"show": true,
    					"title": "数据视图",
    					"readOnly": false,
    					"lang": ["数据视图", "关闭", "刷新"]
    				},
    				"magicType": {
    					"show": true,
    					"title": {
    						"bar": "柱形图切换",
    						"stack": "堆积",
    						"tiled": "平铺",
    						"line": "折线图切换"
    					},
    					"type": ["line", "bar"]
    				},
    				"restore": {
    					"show": true,
    					"title": "还原"
    				},
    				"saveAsImage": {
    					"show": true,
    					"title": "保存为图片",
    					"type": "png",
    					"lang": ["点击保存"]
    				}
    			}
    		},
    		"tooltip": {
    			"trigger": "axis",
    			"formatter": "Temperature : <br/>{b}km : {c}°C"
    		},
    		"legend": {
    			"data": ["高度(km)与气温(°C)变化关系"]
    		},
    		"xAxis": [{
    			"type": "value",
    			"axisLabel": {
    				"formatter": "{value} °C"
    			}
    		}],
    		"yAxis": [{
    			"data": [0, 10, 20, 30, 40, 50, 60, 70, 80],
    			"type": "category",
    			"axisLine": {
    				"onZero": false
    			},
    			"axisLabel": {
    				"formatter": "{value} km"
    			},
    			"boundaryGap": false
    		}],
    		"series": [{
    			"data": [15, -50, -56.5, -46.5, -22.1, -2.5, -27.7, -55.7, -76.5],
    			"name": "高度(km)与气温(°C)变化关系",
    			"type": "line",
    			"itemStyle": {
    				"normal": {
    					"lineStyle": {
    						"shadowColor": "rgba(0,0,0,0.4)"
    					}
    				}
    			},
    			"smooth": true
    		}]
    	}
    myChart.setOption(option);
    </script>
</body>
</html>