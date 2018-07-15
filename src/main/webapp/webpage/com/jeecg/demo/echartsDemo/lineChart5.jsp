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
    		"title": {
    			"x": "center",
    			"text": "对数轴示例"
    		},
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
    			"trigger": "item",
    			"formatter": "{a} <br/>{b} : {c}"
    		},
    		"legend": {
    			"x": "left",
    			"data": ["2的指数", "3的指数"]
    		},
    		"xAxis": [{
    			"data": ["一", "二", "三", "四", "五", "六", "七", "八", "九"],
    			"type": "category",
    			"name": "x",
    			"splitLine": {
    				"show": false
    			}
    		}, {
    			"type": "value",
    			"axisLabel": {
    				"formatter": "{value} °C"
    			}
    		}],
    		"yAxis": [{
    			"type": "log"
    		}],
    		"series": [{
    			"data": [1, 3, 9, 27, 81, 247, 741, 2223, 6669],
    			"name": "3的指数",
    			"type": "line"
    		}, {
    			"data": [1, 2, 4, 8, 16, 32, 64, 128, 256],
    			"name": "2的指数",
    			"type": "line"
    		}]
    	}
    myChart.setOption(option);
    </script>
</body>
</html>