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

    var idx = 1;
    option = {
    		"timeline": {
    			"data": ["2013-01-01", "2013-02-01", "2013-03-01", "2013-04-01", "2013-05-01", {
    				"name": "2013-06-01",
    				"symbol": "emptyStart6",
    				"symbolSize": 8
    			}, "2013-07-01", "2013-08-01", "2013-09-01", "2013-10-01", "2013-11-01", {
    				"name": "2013-12-01",
    				"symbol": "star6",
    				"symbolSize": 8
    			}],
    			"autoPlay": true
    		},
    		"options": [{
    			"title": {
    				"text": "浏览器占比变化",
    				"subtext": "纯属虚构"
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
    					"restore": {
    						"show": true,
    						"title": "还原"
    					},
    					"saveAsImage": {
    						"show": true,
    						"title": "保存为图片",
    						"type": "png",
    						"lang": ["点击保存"]
    					},
    					"magicType": {
    						"show": true,
    						"title": {
    							"bar": "柱形图切换",
    							"stack": "堆积",
    							"tiled": "平铺",
    							"line": "折线图切换"
    						},
    						"type": ["pie", "funnel"],
    						"option": {
    							"funnel": {
    								"type": "funnel",
    								"width": "50%",
    								"x": "25%",
    								"funnelAlign": "left",
    								"max": 1548
    							}
    						}
    					}
    				}
    			},
    			"tooltip": {
    				"trigger": "item",
    				"formatter": "{a} <br/>{b} : {c} ({d}%)"
    			},
    			"legend": {
    				"data": ["Chrome", "Firefox", "Safari", "IE9+", "IE8-"]
    			},
    			"series": [{
    				"data": [{
    					"value": 208,
    					"name": "Chrome"
    				}, {
    					"value": 224,
    					"name": "Firefox"
    				}, {
    					"value": 352,
    					"name": "Safari"
    				}, {
    					"value": 656,
    					"name": "IE9+"
    				}, {
    					"value": 1288,
    					"name": "IE8-"
    				}],
    				"name": "浏览器（数据纯属虚构）",
    				"type": "pie",
    				"label": {
    					"normal": {
    						"show": true,
    						"formatter": "{b}{c}({d}%)"
    					}
    				},
    				"center": ["50%", "45%"],
    				"radius": "50%"
    			}]
    		}, {
    			"series": [{
    				"data": [{
    					"value": 336,
    					"name": "Chrome"
    				}, {
    					"value": 288,
    					"name": "Firefox"
    				}, {
    					"value": 384,
    					"name": "Safari"
    				}, {
    					"value": 672,
    					"name": "IE9+"
    				}, {
    					"value": 1296,
    					"name": "IE8-"
    				}],
    				"name": "浏览器（数据纯属虚构）",
    				"type": "pie"
    			}]
    		}, {
    			"series": [{
    				"data": [{
    					"value": 464,
    					"name": "Chrome"
    				}, {
    					"value": 352,
    					"name": "Firefox"
    				}, {
    					"value": 416,
    					"name": "Safari"
    				}, {
    					"value": 688,
    					"name": "IE9+"
    				}, {
    					"value": 1304,
    					"name": "IE8-"
    				}],
    				"name": "浏览器（数据纯属虚构）",
    				"type": "pie"
    			}]
    		}, {
    			"series": [{
    				"data": [{
    					"value": 592,
    					"name": "Chrome"
    				}, {
    					"value": 416,
    					"name": "Firefox"
    				}, {
    					"value": 448,
    					"name": "Safari"
    				}, {
    					"value": 704,
    					"name": "IE9+"
    				}, {
    					"value": 1312,
    					"name": "IE8-"
    				}],
    				"name": "浏览器（数据纯属虚构）",
    				"type": "pie"
    			}]
    		}, {
    			"series": [{
    				"data": [{
    					"value": 720,
    					"name": "Chrome"
    				}, {
    					"value": 480,
    					"name": "Firefox"
    				}, {
    					"value": 480,
    					"name": "Safari"
    				}, {
    					"value": 720,
    					"name": "IE9+"
    				}, {
    					"value": 1320,
    					"name": "IE8-"
    				}],
    				"name": "浏览器（数据纯属虚构）",
    				"type": "pie"
    			}]
    		}, {
    			"series": [{
    				"data": [{
    					"value": 848,
    					"name": "Chrome"
    				}, {
    					"value": 544,
    					"name": "Firefox"
    				}, {
    					"value": 512,
    					"name": "Safari"
    				}, {
    					"value": 736,
    					"name": "IE9+"
    				}, {
    					"value": 1328,
    					"name": "IE8-"
    				}],
    				"name": "浏览器（数据纯属虚构）",
    				"type": "pie"
    			}]
    		}, {
    			"series": [{
    				"data": [{
    					"value": 976,
    					"name": "Chrome"
    				}, {
    					"value": 608,
    					"name": "Firefox"
    				}, {
    					"value": 544,
    					"name": "Safari"
    				}, {
    					"value": 752,
    					"name": "IE9+"
    				}, {
    					"value": 1336,
    					"name": "IE8-"
    				}],
    				"name": "浏览器（数据纯属虚构）",
    				"type": "pie"
    			}]
    		}, {
    			"series": [{
    				"data": [{
    					"value": 1104,
    					"name": "Chrome"
    				}, {
    					"value": 672,
    					"name": "Firefox"
    				}, {
    					"value": 576,
    					"name": "Safari"
    				}, {
    					"value": 768,
    					"name": "IE9+"
    				}, {
    					"value": 1344,
    					"name": "IE8-"
    				}],
    				"name": "浏览器（数据纯属虚构）",
    				"type": "pie"
    			}]
    		}, {
    			"series": [{
    				"data": [{
    					"value": 1232,
    					"name": "Chrome"
    				}, {
    					"value": 736,
    					"name": "Firefox"
    				}, {
    					"value": 608,
    					"name": "Safari"
    				}, {
    					"value": 784,
    					"name": "IE9+"
    				}, {
    					"value": 1352,
    					"name": "IE8-"
    				}],
    				"name": "浏览器（数据纯属虚构）",
    				"type": "pie"
    			}]
    		}, {
    			"series": [{
    				"data": [{
    					"value": 1360,
    					"name": "Chrome"
    				}, {
    					"value": 800,
    					"name": "Firefox"
    				}, {
    					"value": 640,
    					"name": "Safari"
    				}, {
    					"value": 800,
    					"name": "IE9+"
    				}, {
    					"value": 1360,
    					"name": "IE8-"
    				}],
    				"name": "浏览器（数据纯属虚构）",
    				"type": "pie"
    			}]
    		}, {
    			"series": [{
    				"data": [{
    					"value": 1488,
    					"name": "Chrome"
    				}, {
    					"value": 864,
    					"name": "Firefox"
    				}, {
    					"value": 672,
    					"name": "Safari"
    				}, {
    					"value": 816,
    					"name": "IE9+"
    				}, {
    					"value": 1368,
    					"name": "IE8-"
    				}],
    				"name": "浏览器（数据纯属虚构）",
    				"type": "pie"
    			}]
    		}, {
    			"series": [{
    				"data": [{
    					"value": 1616,
    					"name": "Chrome"
    				}, {
    					"value": 928,
    					"name": "Firefox"
    				}, {
    					"value": 704,
    					"name": "Safari"
    				}, {
    					"value": 832,
    					"name": "IE9+"
    				}, {
    					"value": 1376,
    					"name": "IE8-"
    				}],
    				"name": "浏览器（数据纯属虚构）",
    				"type": "pie"
    			}]
    		}]
    	}           
    myChart.setOption(option);
    </script>
</body>
</html>