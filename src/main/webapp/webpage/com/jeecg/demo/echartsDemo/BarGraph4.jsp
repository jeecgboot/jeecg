<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="plug-in/echart/echarts.js"></script>
</head>
<body>
<div id="main"></div>
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
    			"text": "ECharts例子个数统计",
    			"link": "http://echarts.baidu.com/doc/example.html",
    			"subtext": "Rainbow bar example"
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
    			"trigger": "item"
    		},
    		"grid": {
    			"y": 80,
    			"borderWidth": 0,
    			"y2": 60
    		},
    		"xAxis": [{
    			"data": ["Line", "Bar", "Scatter", "K", "Pie", "Radar", "Chord", "Force", "Map", "Gauge", "Funnel"],
    			"type": "category"
    		}],
    		"yAxis": [{
    			"show": false,
    			"type": "value"
    		}],
    		"series": [{
    			"data": [12, 21, 10, 4, 12, 5, 6, 5, 25, 23, 7],
    			"name": "ECharts例子个数统计",
    			"type": "bar",
    			"itemStyle": {
    				"normal": {
    					"label": {
    						"show": true,
    						"formatter": "{b}\n{c}",
    						"position": "top"
    					},
    					"color": "function(params) {                        var colorList = [                          '#C1232B','#B5C334','#FCCE10','#E87C25','#27727B',                           '#FE8463','#9BCA63','#FAD860','#F3A43B','#60C0DD',                           '#D7504B','#C6E579','#F4E001','#F0805A','#26C0C0'                        ];                        return colorList[params.dataIndex]                    }"
    				}
    			}
    		}]
    	}

    myChart.setOption(option);
    </script>
</body>
</html>