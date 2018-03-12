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
    				"dataZoom": {
    					"show": true,
    					"title": {
    						"dataZoom": "区域缩放",
    						"dataZoomReset": "区域缩放后退"
    					}
    				},
    				"dataView": {
    					"show": true,
    					"title": "数据视图",
    					"readOnly": false,
    					"lang": ["数据视图", "关闭", "刷新"]
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
    			"showDelay": 0,
    			"axisPointer": {
    				"type": "cross",
    				"lineStyle": {
    					"type": "dashed",
    					"width": 1
    				}
    			}
    		},
    		"legend": {
    			"data": ["scatter1", "scatter2"]
    		},
    		"xAxis": [{
    			"type": "value",
    			"scale": true,
    			"power": 1,
    			"splitNumber": 4
    		}],
    		"yAxis": [{
    			"type": "value",
    			"scale": true,
    			"power": 1,
    			"splitNumber": 4
    		}],
    		"series": [{
    			"data": [{
    				"value": [-41, 84, 13]
    			}, {
    				"value": [-29, 10, 17]
    			}, {
    				"value": [-63, 88, 3]
    			}, {
    				"value": [92, 68, 17]
    			}, {
    				"value": [18, -3, 81]
    			}, {
    				"value": [-9, -1, 13]
    			}, {
    				"value": [86, -97, 75]
    			}, {
    				"value": [-71, 76, 64]
    			}, {
    				"value": [-35, -47, 24]
    			}, {
    				"value": [24, -85, 41]
    			}, {
    				"value": [52, -71, 23]
    			}, {
    				"value": [-59, 46, 86]
    			}, {
    				"value": [12, -53, 54]
    			}, {
    				"value": [-17, -77, 92]
    			}, {
    				"value": [-9, 70, 86]
    			}, {
    				"value": [-9, 56, 65]
    			}, {
    				"value": [-77, -67, 38]
    			}, {
    				"value": [34, 12, 72]
    			}, {
    				"value": [68, -87, 83]
    			}, {
    				"value": [48, -69, 75]
    			}, {
    				"value": [52, 4, 71]
    			}, {
    				"value": [-37, -49, 95]
    			}, {
    				"value": [-81, 42, 25]
    			}, {
    				"value": [-3, -1, 99]
    			}, {
    				"value": [-85, -63, 41]
    			}, {
    				"value": [-17, 26, 68]
    			}, {
    				"value": [-19, 84, 14]
    			}, {
    				"value": [92, -25, 60]
    			}, {
    				"value": [84, 100, 60]
    			}, {
    				"value": [44, -9, 9]
    			}, {
    				"value": [-5, -13, 86]
    			}, {
    				"value": [22, -33, 37]
    			}, {
    				"value": [4, 32, 5]
    			}, {
    				"value": [-75, 48, 67]
    			}, {
    				"value": [-11, 70, 17]
    			}, {
    				"value": [50, 62, 24]
    			}, {
    				"value": [14, 84, 61]
    			}, {
    				"value": [78, -31, 26]
    			}, {
    				"value": [58, -39, 4]
    			}, {
    				"value": [-35, 70, 41]
    			}, {
    				"value": [20, -25, 97]
    			}, {
    				"value": [30, -51, 13]
    			}, {
    				"value": [-77, -39, 8]
    			}, {
    				"value": [88, 46, 6]
    			}, {
    				"value": [-89, 84, 31]
    			}, {
    				"value": [-91, -17, 94]
    			}, {
    				"value": [-73, -25, 90]
    			}, {
    				"value": [-31, -21, 38]
    			}, {
    				"value": [20, -79, 35]
    			}, {
    				"value": [-5, -63, 76]
    			}, {
    				"value": [-49, 54, 16]
    			}, {
    				"value": [6, -9, 91]
    			}, {
    				"value": [52, -75, 45]
    			}, {
    				"value": [4, 98, 3]
    			}, {
    				"value": [76, 16, 7]
    			}, {
    				"value": [-41, 48, 89]
    			}, {
    				"value": [70, -25, 84]
    			}, {
    				"value": [-87, 8, 26]
    			}, {
    				"value": [96, -27, 40]
    			}, {
    				"value": [-85, 54, 92]
    			}, {
    				"value": [76, 64, 99]
    			}, {
    				"value": [78, 96, 80]
    			}, {
    				"value": [26, 14, 84]
    			}, {
    				"value": [68, -97, 4]
    			}, {
    				"value": [36, -99, 30]
    			}, {
    				"value": [-81, 68, 24]
    			}, {
    				"value": [14, 24, 18]
    			}, {
    				"value": [-79, 38, 5]
    			}, {
    				"value": [-1, 24, 71]
    			}, {
    				"value": [8, 40, 76]
    			}, {
    				"value": [-49, -87, 58]
    			}, {
    				"value": [40, -11, 12]
    			}, {
    				"value": [-81, -31, 92]
    			}, {
    				"value": [80, 14, 22]
    			}, {
    				"value": [-57, 54, 45]
    			}, {
    				"value": [66, -53, 41]
    			}, {
    				"value": [38, 72, 98]
    			}, {
    				"value": [-83, 100, 46]
    			}, {
    				"value": [70, 28, 74]
    			}, {
    				"value": [-39, -75, 89]
    			}, {
    				"value": [6, 80, 48]
    			}, {
    				"value": [4, -27, 20]
    			}, {
    				"value": [-25, 60, 70]
    			}, {
    				"value": [46, -77, 62]
    			}, {
    				"value": [90, 74, 82]
    			}, {
    				"value": [-75, 66, 78]
    			}, {
    				"value": [-77, -85, 89]
    			}, {
    				"value": [-79, -59, 96]
    			}, {
    				"value": [-17, -37, 85]
    			}, {
    				"value": [-97, 22, 95]
    			}, {
    				"value": [68, -1, 29]
    			}, {
    				"value": [-49, 58, 87]
    			}, {
    				"value": [20, 0, 22]
    			}, {
    				"value": [-65, -13, 5]
    			}, {
    				"value": [-69, -91, 67]
    			}, {
    				"value": [-25, 56, 81]
    			}, {
    				"value": [40, -29, 15]
    			}, {
    				"value": [68, 40, 2]
    			}, {
    				"value": [-53, -79, 22]
    			}, {
    				"value": [-75, 60, 22]
    			}],
    			"name": "scatter1",
    			"type": "scatter",
    			"symbolSize": "function (value){                return Math.round(value[2] / 5);            }"
    		}, {
    			"data": [{
    				"value": [-75, 94, 40]
    			}, {
    				"value": [-91, -5, 10]
    			}, {
    				"value": [-79, 36, 52]
    			}, {
    				"value": [-85, -35, 57]
    			}, {
    				"value": [18, -83, 92]
    			}, {
    				"value": [28, 64, 29]
    			}, {
    				"value": [14, -85, 21]
    			}, {
    				"value": [94, 86, 49]
    			}, {
    				"value": [-17, 4, 50]
    			}, {
    				"value": [-1, 34, 18]
    			}, {
    				"value": [74, -73, 63]
    			}, {
    				"value": [-15, -53, 50]
    			}, {
    				"value": [-53, -35, 36]
    			}, {
    				"value": [-59, -83, 38]
    			}, {
    				"value": [90, 40, 78]
    			}, {
    				"value": [-81, -45, 81]
    			}, {
    				"value": [48, 96, 81]
    			}, {
    				"value": [42, 8, 21]
    			}, {
    				"value": [-61, 54, 39]
    			}, {
    				"value": [20, -95, 76]
    			}, {
    				"value": [-81, 2, 61]
    			}, {
    				"value": [2, -13, 36]
    			}, {
    				"value": [-89, 60, 64]
    			}, {
    				"value": [48, 40, 49]
    			}, {
    				"value": [20, 64, 64]
    			}, {
    				"value": [94, -19, 85]
    			}, {
    				"value": [68, -35, 33]
    			}, {
    				"value": [-31, -43, 4]
    			}, {
    				"value": [100, -37, 35]
    			}, {
    				"value": [-69, -33, 49]
    			}, {
    				"value": [76, 80, 60]
    			}, {
    				"value": [8, 94, 89]
    			}, {
    				"value": [-61, 80, 38]
    			}, {
    				"value": [-67, 70, 42]
    			}, {
    				"value": [-71, 86, 41]
    			}, {
    				"value": [8, 82, 2]
    			}, {
    				"value": [-83, -45, 37]
    			}, {
    				"value": [-7, 16, 95]
    			}, {
    				"value": [-45, 10, 85]
    			}, {
    				"value": [92, 30, 50]
    			}, {
    				"value": [66, -67, 27]
    			}, {
    				"value": [94, 30, 56]
    			}, {
    				"value": [80, 12, 4]
    			}, {
    				"value": [-87, -3, 80]
    			}, {
    				"value": [-41, 36, 95]
    			}, {
    				"value": [-63, 46, 88]
    			}, {
    				"value": [22, 10, 26]
    			}, {
    				"value": [-83, -79, 33]
    			}, {
    				"value": [-31, 82, 6]
    			}, {
    				"value": [-97, 46, 19]
    			}, {
    				"value": [10, 62, 13]
    			}, {
    				"value": [-69, 56, 73]
    			}, {
    				"value": [-27, 26, 98]
    			}, {
    				"value": [42, -57, 12]
    			}, {
    				"value": [32, -95, 6]
    			}, {
    				"value": [50, 90, 35]
    			}, {
    				"value": [-29, 44, 58]
    			}, {
    				"value": [2, 48, 22]
    			}, {
    				"value": [-11, -73, 29]
    			}, {
    				"value": [-37, 68, 31]
    			}, {
    				"value": [96, -19, 37]
    			}, {
    				"value": [-47, -37, 37]
    			}, {
    				"value": [-95, -33, 5]
    			}, {
    				"value": [-1, 48, 61]
    			}, {
    				"value": [58, 46, 76]
    			}, {
    				"value": [42, -99, 98]
    			}, {
    				"value": [16, -3, 77]
    			}, {
    				"value": [-19, -23, 8]
    			}, {
    				"value": [46, 46, 10]
    			}, {
    				"value": [48, -83, 85]
    			}, {
    				"value": [-61, 76, 33]
    			}, {
    				"value": [80, 36, 13]
    			}, {
    				"value": [-7, -25, 73]
    			}, {
    				"value": [74, -97, 34]
    			}, {
    				"value": [30, -15, 75]
    			}, {
    				"value": [64, -71, 62]
    			}, {
    				"value": [32, 20, 90]
    			}, {
    				"value": [6, -97, 61]
    			}, {
    				"value": [94, -33, 89]
    			}, {
    				"value": [-77, 2, 91]
    			}, {
    				"value": [-21, -93, 3]
    			}, {
    				"value": [72, 30, 7]
    			}, {
    				"value": [98, -41, 29]
    			}, {
    				"value": [-81, -21, 19]
    			}, {
    				"value": [-9, 44, 52]
    			}, {
    				"value": [-75, -57, 96]
    			}, {
    				"value": [44, -1, 90]
    			}, {
    				"value": [-31, 6, 57]
    			}, {
    				"value": [-63, -51, 10]
    			}, {
    				"value": [-11, -23, 86]
    			}, {
    				"value": [-81, -37, 79]
    			}, {
    				"value": [54, 14, 51]
    			}, {
    				"value": [38, -91, 100]
    			}, {
    				"value": [34, -13, 83]
    			}, {
    				"value": [-95, 82, 31]
    			}, {
    				"value": [36, 52, 38]
    			}, {
    				"value": [98, -25, 46]
    			}, {
    				"value": [36, 48, 93]
    			}, {
    				"value": [64, 88, 92]
    			}, {
    				"value": [58, -9, 85]
    			}],
    			"name": "scatter2",
    			"type": "scatter",
    			"symbolSize": "function (value){                return Math.round(value[2] / 5);            }"
    		}]
    	}
                        

    myChart.setOption(option);
    </script>
    
</body>
</html>