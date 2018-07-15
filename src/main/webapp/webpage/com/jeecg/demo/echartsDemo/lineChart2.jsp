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
    			"text": "某楼盘销售情况",
    			"subtext": "纯属虚构"
    		},
    		"toolbox": {
    			"show": true,
    			"padding": 20,
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
    					"type": ["line", "bar", "stack", "tiled"]
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
    			"trigger": "axis"
    		},
    		"legend": {
    			"data": ["意向", "预购", "成交"]
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
    			"data": [10, 12, 21, 54, 260, 830, 710],
    			"name": "成交",
    			"type": "line",
    			"itemStyle": {
    				"normal": {
    					"areaStyle": {
    						"type": "default"
    					}
    				}
    			},
    			"smooth": true
    		}, {
    			"data": [30, 182, 434, 791, 390, 30, 10],
    			"name": "预购",
    			"type": "line",
    			"itemStyle": {
    				"normal": {
    					"areaStyle": {
    						"type": "default"
    					}
    				}
    			},
    			"smooth": true
    		}, {
    			"data": [1320, 1132, 601, 234, 120, 90, 20],
    			"name": "意向",
    			"type": "line",
    			"itemStyle": {
    				"normal": {
    					"areaStyle": {
    						"type": "default"
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