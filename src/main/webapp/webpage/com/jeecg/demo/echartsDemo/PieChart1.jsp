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
    			"title": {
    				"x": "center",
    				"y": "center",
    				"itemGap": 20,
    				"text": "你幸福吗？",
    				"subtext": "From ExcelHome",
    				"sublink": "http://e.weibo.com/1341556070/AhQXtjbqh",
    				"textStyle": {
    					"color": "rgba(30,144,255,0.8)",
    					"fontSize": 35,
    					"fontFamily": "微软雅黑",
    					"fontWeight": "bolder"
    				}
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
    					}
    				}
    			},
    			"tooltip": {
    				"show": true,
    				"formatter": "{a} <br/>{b} : {c} ({d}%)"
    			},
    			"legend": {
    				"x": "(function(){return document.getElementById('main').offsetWidth / 2;})()",
    				"y": 56,
    				"itemGap": 12,
    				"orient": "vertical",
    				"data": ["68%的人表示过的不错", "29%的人表示生活压力很大", "3%的人表示“我姓曾”"]
    			},
    			"series": [{
    				"data": [{
    					"name": "68%的人表示过的不错",
    					"value": 68
    				}, {
    					"name": "invisible",
    					"value": 32,
    					"itemStyle": {
    						"normal": {
    							"label": {
    								"show": false
    							},
    							"labelLine": {
    								"show": false
    							},
    							"color": "rgba(0,0,0,0)"
    						},
    						"emphasis": {
    							"color": "rgba(0,0,0,0)"
    						}
    					}
    				}],
    				"name": "1",
    				"type": "pie",
    				"itemStyle": {
    					"normal": {
    						"label": {
    							"show": false
    						},
    						"labelLine": {
    							"show": false
    						}
    					}
    				},
    				"radius": [125, 150],
    				"clockWise": false
    			}, {
    				"data": [{
    					"name": "29%的人表示生活压力很大",
    					"value": 29
    				}, {
    					"name": "invisible",
    					"value": 71,
    					"itemStyle": {
    						"normal": {
    							"label": {
    								"show": false
    							},
    							"labelLine": {
    								"show": false
    							},
    							"color": "rgba(0,0,0,0)"
    						},
    						"emphasis": {
    							"color": "rgba(0,0,0,0)"
    						}
    					}
    				}],
    				"name": "2",
    				"type": "pie",
    				"itemStyle": {
    					"normal": {
    						"label": {
    							"show": false
    						},
    						"labelLine": {
    							"show": false
    						}
    					}
    				},
    				"radius": [100, 125],
    				"clockWise": false
    			}, {
    				"data": [{
    					"name": "3%的人表示“我姓曾”",
    					"value": 3
    				}, {
    					"name": "invisible",
    					"value": 97,
    					"itemStyle": {
    						"normal": {
    							"label": {
    								"show": false
    							},
    							"labelLine": {
    								"show": false
    							},
    							"color": "rgba(0,0,0,0)"
    						},
    						"emphasis": {
    							"color": "rgba(0,0,0,0)"
    						}
    					}
    				}],
    				"name": "3",
    				"type": "pie",
    				"itemStyle": {
    					"normal": {
    						"label": {
    							"show": false
    						},
    						"labelLine": {
    							"show": false
    						}
    					}
    				},
    				"radius": [75, 100],
    				"clockWise": false
    			}]
    		}
    myChart.setOption(option);
    </script>
</body>
</html>