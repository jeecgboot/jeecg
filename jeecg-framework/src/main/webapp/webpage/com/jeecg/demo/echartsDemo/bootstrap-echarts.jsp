<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width" />
<meta name="renderer" content="webkit">
<title>Bootstrap-Eaharts-DEMO</title>
<link href="plug-in/bootstrap3.3.5/css/bootstrap.min.css" rel="stylesheet"/>
</head>
<body>
<div class="container-fluid">
	<div class="row">
		<div class="col-md-8">
			<div id="main1" style="height:400px;"></div>
		</div>
		<div class="col-md-4">
			<div id="main2" style="height:400px;"></div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-6">
			<div id="main3" style="height:400px;"></div>
		</div>
		<div class="col-md-6">
			<div id="main4" style="height:400px;"></div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-4">
			<div id="main5" style="height:400px;"></div>
		</div>
		<div class="col-md-4">
			<div id="main6" style="height:400px;"></div>
		</div>
		<div class="col-md-4">
			<div id="main7" style="height:400px;"></div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-2">
			<div id="main8" style="height:400px;"></div>
		</div>
		<div class="col-md-6">
			<div id="main9" style="height:400px;"></div>
		</div>
		<div class="col-md-4">
			<div id="main10" style="height:400px;"></div>
		</div>
	</div>
	<div class="row">
		<div class="col-md-12">
			<div id="main11" style="height:400px;"></div>
		</div>
	</div>
	<button style="float:right;" type="button" class="btn btn-default" onclick="clickPrint()">打印</button>
</div>
</body>
<script type="text/javascript" src="plug-in/jquery/jquery-1.9.1.js"></script>
<script type="text/javascript" src="plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
<script type="text/javascript" src="plug-in/printthis/printThis.js"></script>
<script type="text/javascript" src="plug-in/echart/echarts.min.js"></script>
<script type="text/javascript">
	var myChart1 = echarts.init(document.getElementById('main1'));
	var myChart2 = echarts.init(document.getElementById('main2'));
	var myChart3 = echarts.init(document.getElementById('main3'));
	var myChart4 = echarts.init(document.getElementById('main4'));
	var myChart5 = echarts.init(document.getElementById('main5'));
	var myChart6 = echarts.init(document.getElementById('main6'));
	var myChart7 = echarts.init(document.getElementById('main7'));
	var myChart8 = echarts.init(document.getElementById('main8'));
	var myChart9 = echarts.init(document.getElementById('main9'));
	var myChart10 = echarts.init(document.getElementById('main10'));
	var myChart11= echarts.init(document.getElementById('main11'));
	// 指定图表的配置项和数据
	var option = {
	    title: {
	        text: '基础雷达图'
	    },
	    tooltip: {},
	    legend: {
	        data: ['预算分配（Allocated Budget）', '实际开销（Actual Spending）']
	    },
	    radar: {
	        // shape: 'circle',
	        name: {
	            textStyle: {
	                color: '#fff',
	                backgroundColor: '#999',
	                borderRadius: 3,
	                padding: [3, 5]
	           }
	        },
	        indicator: [
	           { name: '销售（sales）', max: 6500},
	           { name: '管理（Administration）', max: 16000},
	           { name: '信息技术（Information Techology）', max: 30000},
	           { name: '客服（Customer Support）', max: 38000},
	           { name: '研发（Development）', max: 52000},
	           { name: '市场（Marketing）', max: 25000}
	        ]
	    },
	    series: [{
	        name: '预算 vs 开销（Budget vs spending）',
	        type: 'radar',
	        // areaStyle: {normal: {}},
	        data : [
	            {
	                value : [4300, 10000, 28000, 35000, 50000, 19000],
	                name : '预算分配（Allocated Budget）'
	            },
	             {
	                value : [5000, 14000, 28000, 31000, 42000, 21000],
	                name : '实际开销（Actual Spending）'
	            }
	        ]
	    }]
	};
	// 使用刚指定的配置项和数据显示图表。
	myChart1.setOption(option);
	option = {
	    title : {
	        text: '某站点用户访问来源',
	        subtext: '纯属虚构',
	        x:'center'
	    },
	    tooltip : {
	        trigger: 'item',
	        formatter: "{a} <br/>{b} : {c} ({d}%)"
	    },
	    legend: {
	        orient: 'vertical',
	        left: 'left',
	        data: ['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
	    },
	    series : [
	        {
	            name: '访问来源',
	            type: 'pie',
	            radius : '55%',
	            center: ['50%', '60%'],
	            data:[
	                {value:335, name:'直接访问'},
	                {value:310, name:'邮件营销'},
	                {value:234, name:'联盟广告'},
	                {value:135, name:'视频广告'},
	                {value:1548, name:'搜索引擎'}
	            ],
	            itemStyle: {
	                emphasis: {
	                    shadowBlur: 10,
	                    shadowOffsetX: 0,
	                    shadowColor: 'rgba(0, 0, 0, 0.5)'
	                }
	            }
	        }
	    ]
	};
	myChart2.setOption(option);
	option = {
	    title: {
	        text: 'ECharts 入门示例'
	    },
	    tooltip: {},
	    legend: {
	        data:['销量']
	    },
	    xAxis: {
	        data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
	    },
	    yAxis: {},
	    series: [{
	        name: '销量',
	        type: 'bar',
	        data: [5, 20, 36, 10, 10, 20]
	    }]
	};
	myChart3.setOption(option);
	option = {
	    title: {
	        text: '堆叠区域图'
	    },
	    tooltip : {
	        trigger: 'axis',
	        axisPointer: {
	            type: 'cross',
	            label: {
	                backgroundColor: '#6a7985'
	            }
	        }
	    },
	    legend: {
	        data:['联盟广告','视频广告','直接访问','搜索引擎']
	    },
	    toolbox: {
	        feature: {
	            saveAsImage: {}
	        }
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    xAxis : [
	        {
	            type : 'category',
	            boundaryGap : false,
	            data : ['周一','周二','周三','周四','周五','周六','周日']
	        }
	    ],
	    yAxis : [
	        {
	            type : 'value'
	        }
	    ],
	    series : [
	        {
	            name:'联盟广告',
	            type:'line',
	            stack: '总量',
	            areaStyle: {normal: {}},
	            data:[220, 182, 191, 234, 290, 330, 310]
	        },
	        {
	            name:'视频广告',
	            type:'line',
	            stack: '总量',
	            areaStyle: {normal: {}},
	            data:[150, 232, 201, 154, 190, 330, 410]
	        },
	        {
	            name:'直接访问',
	            type:'line',
	            stack: '总量',
	            areaStyle: {normal: {}},
	            data:[320, 332, 301, 334, 390, 330, 320]
	        },
	        {
	            name:'搜索引擎',
	            type:'line',
	            stack: '总量',
	            label: {
	                normal: {
	                    show: true,
	                    position: 'top'
	                }
	            },
	            areaStyle: {normal: {}},
	            data:[820, 932, 901, 934, 1290, 1330, 1320]
	        }
	    ]
	};
	myChart4.setOption(option);
	var colors = ['#5793f3', '#d14a61', '#675bba'];
	option = {
	    color: colors,

	    tooltip: {
	        trigger: 'none',
	        axisPointer: {
	            type: 'cross'
	        }
	    },
	    legend: {
	        data:['2015 降水量', '2016 降水量']
	    },
	    grid: {
	        top: 70,
	        bottom: 50
	    },
	    xAxis: [
	        {
	            type: 'category',
	            axisTick: {
	                alignWithLabel: true
	            },
	            axisLine: {
	                onZero: false,
	                lineStyle: {
	                    color: colors[1]
	                }
	            },
	            axisPointer: {
	                label: {
	                    formatter: function (params) {
	                        return '降水量  ' + params.value
	                            + (params.seriesData.length ? '：' + params.seriesData[0].data : '');
	                    }
	                }
	            },
	            data: ["2016-1", "2016-2", "2016-3", "2016-4", "2016-5", "2016-6", "2016-7", "2016-8", "2016-9", "2016-10", "2016-11", "2016-12"]
	        },
	        {
	            type: 'category',
	            axisTick: {
	                alignWithLabel: true
	            },
	            axisLine: {
	                onZero: false,
	                lineStyle: {
	                    color: colors[0]
	                }
	            },
	            axisPointer: {
	                label: {
	                    formatter: function (params) {
	                        return '降水量  ' + params.value
	                            + (params.seriesData.length ? '：' + params.seriesData[0].data : '');
	                    }
	                }
	            },
	            data: ["2015-1", "2015-2", "2015-3", "2015-4", "2015-5", "2015-6", "2015-7", "2015-8", "2015-9", "2015-10", "2015-11", "2015-12"]
	        }
	    ],
	    yAxis: [
	        {
	            type: 'value'
	        }
	    ],
	    series: [
	        {
	            name:'2015 降水量',
	            type:'line',
	            xAxisIndex: 1,
	            smooth: true,
	            data: [2.6, 5.9, 9.0, 26.4, 28.7, 70.7, 175.6, 182.2, 48.7, 18.8, 6.0, 2.3]
	        },
	        {
	            name:'2016 降水量',
	            type:'line',
	            smooth: true,
	            data: [3.9, 5.9, 11.1, 18.7, 48.3, 69.2, 231.6, 46.6, 55.4, 18.4, 10.3, 0.7]
	        }
	    ]
	};
	myChart5.setOption(option);
	option = {
	    tooltip : {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    legend: {
	        data: ['直接访问', '邮件营销','联盟广告']
	    },
	    grid: {
	        left: '3%',
	        right: '4%',
	        bottom: '3%',
	        containLabel: true
	    },
	    xAxis:  {
	        type: 'value'
	    },
	    yAxis: {
	        type: 'category',
	        data: ['周一','周二','周三','周四','周五','周六','周日']
	    },
	    series: [
	        {
	            name: '直接访问',
	            type: 'bar',
	            stack: '总量',
	            label: {
	                normal: {
	                    show: true,
	                    position: 'insideRight'
	                }
	            },
	            data: [320, 302, 301, 334, 390, 330, 320]
	        },
	        {
	            name: '邮件营销',
	            type: 'bar',
	            stack: '总量',
	            label: {
	                normal: {
	                    show: true,
	                    position: 'insideRight'
	                }
	            },
	            data: [120, 132, 101, 134, 90, 230, 210]
	        },
	        {
	            name: '联盟广告',
	            type: 'bar',
	            stack: '总量',
	            label: {
	                normal: {
	                    show: true,
	                    position: 'insideRight'
	                }
	            },
	            data: [220, 182, 191, 234, 290, 330, 310]
	        }
	    ]
	};
	myChart6.setOption(option);
	option = {
	    tooltip : {
	        formatter: "{a} <br/>{b} : {c}%"
	    },
	    toolbox: {
	        feature: {
	            restore: {},
	            saveAsImage: {}
	        }
	    },
	    series: [
	        {
	            name: '业务指标',
	            type: 'gauge',
	            detail: {formatter:'{value}%'},
	            data: [{value: 50, name: '完成率'}]
	        }
	    ]
	};

	myChart7.setOption(option);

	option = {
	    tooltip: {
	        trigger: 'item',
	        formatter: "{a} <br/>{b}: {c} ({d}%)"
	    },
	    legend: {
	        orient: 'vertical',
	        x: 'left',
	        data:['直接访问','邮件营销','联盟广告','视频广告','搜索引擎']
	    },
	    series: [
	        {
	            name:'访问来源',
	            type:'pie',
	            radius: ['50%', '70%'],
	            avoidLabelOverlap: false,
	            label: {
	                normal: {
	                    show: false,
	                    position: 'center'
	                },
	                emphasis: {
	                    show: true,
	                    textStyle: {
	                        fontSize: '30',
	                        fontWeight: 'bold'
	                    }
	                }
	            },
	            labelLine: {
	                normal: {
	                    show: false
	                }
	            },
	            data:[
	                {value:335, name:'直接访问'},
	                {value:310, name:'邮件营销'},
	                {value:234, name:'联盟广告'},
	                {value:135, name:'视频广告'},
	                {value:1548, name:'搜索引擎'}
	            ]
	        }
	    ]
	};

	myChart8.setOption(option);
	var labelRight = {
	    normal: {
	        position: 'right'
	    }
	};
	option = {
	    title: {
	        text: '交错正负轴标签',
	        subtext: 'From ExcelHome',
	        sublink: 'http://e.weibo.com/1341556070/AjwF2AgQm'
	    },
	    tooltip : {
	        trigger: 'axis',
	        axisPointer : {            // 坐标轴指示器，坐标轴触发有效
	            type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
	        }
	    },
	    grid: {
	        top: 80,
	        bottom: 30
	    },
	    xAxis: {
	        type : 'value',
	        position: 'top',
	        splitLine: {lineStyle:{type:'dashed'}},
	    },
	    yAxis: {
	        type : 'category',
	        axisLine: {show: false},
	        axisLabel: {show: false},
	        axisTick: {show: false},
	        splitLine: {show: false},
	        data : ['ten', 'nine', 'eight', 'seven', 'six', 'five', 'four', 'three', 'two', 'one']
	    },
	    series : [
	        {
	            name:'生活费',
	            type:'bar',
	            stack: '总量',
	            label: {
	                normal: {
	                    show: true,
	                    formatter: '{b}'
	                }
	            },
	            data:[
	                {value: -0.07, label: labelRight},
	                {value: -0.09, label: labelRight},
	                0.2, 0.44,
	                {value: -0.23, label: labelRight},
	                0.08,
	                {value: -0.17, label: labelRight},
	                0.47,
	                {value: -0.36, label: labelRight},
	                0.18
	            ]
	        }
	    ]
	};
	myChart9.setOption(option);
	
	option = {
	    angleAxis: {
	    },
	    radiusAxis: {
	        type: 'category',
	        data: ['周一', '周二', '周三', '周四'],
	        z: 10
	    },
	    polar: {
	    },
	    series: [{
	        type: 'bar',
	        data: [1, 2, 3, 4],
	        coordinateSystem: 'polar',
	        name: 'A',
	        stack: 'a'
	    }, {
	        type: 'bar',
	        data: [2, 4, 6, 8],
	        coordinateSystem: 'polar',
	        name: 'B',
	        stack: 'a'
	    }, {
	        type: 'bar',
	        data: [1, 2, 3, 4],
	        coordinateSystem: 'polar',
	        name: 'C',
	        stack: 'a'
	    }],
	    legend: {
	        show: true,
	        data: ['A', 'B', 'C']
	    }
	};

	myChart10.setOption(option);
	
	option = {
	    title: {
	        text: '未来一周气温变化',
	        subtext: '纯属虚构'
	    },
	    tooltip: {
	        trigger: 'axis'
	    },
	    legend: {
	        data:['最高气温','最低气温']
	    },
	    toolbox: {
	        show: true,
	        feature: {
	            dataZoom: {
	                yAxisIndex: 'none'
	            },
	            dataView: {readOnly: false},
	            magicType: {type: ['line', 'bar']},
	            restore: {},
	            saveAsImage: {}
	        }
	    },
	    xAxis:  {
	        type: 'category',
	        boundaryGap: false,
	        data: ['周一','周二','周三','周四','周五','周六','周日']
	    },
	    yAxis: {
	        type: 'value',
	        axisLabel: {
	            formatter: '{value} °C'
	        }
	    },
	    series: [
	        {
	            name:'最高气温',
	            type:'line',
	            data:[11, 11, 15, 13, 12, 13, 10],
	            markPoint: {
	                data: [
	                    {type: 'max', name: '最大值'},
	                    {type: 'min', name: '最小值'}
	                ]
	            },
	            markLine: {
	                data: [
	                    {type: 'average', name: '平均值'}
	                ]
	            }
	        },
	        {
	            name:'最低气温',
	            type:'line',
	            data:[1, -2, 2, 5, 3, 2, 0],
	            markPoint: {
	                data: [
	                    {name: '周最低', value: -2, xAxis: 1, yAxis: -1.5}
	                ]
	            },
	            markLine: {
	                data: [
	                    {type: 'average', name: '平均值'},
	                    [{
	                        symbol: 'none',
	                        x: '90%',
	                        yAxis: 'max'
	                    }, {
	                        symbol: 'circle',
	                        label: {
	                            normal: {
	                                position: 'start',
	                                formatter: '最大值'
	                            }
	                        },
	                        type: 'max',
	                        name: '最高点'
	                    }]
	                ]
	            }
	        }
	    ]
	};

	myChart11.setOption(option);
	
	function clickPrint() {
		$("div.container-fluid").printThis({
	      debug: false,               // 显示用于调试的iframe
	      importCSS: true,            // 导入页面CSS 
	      importStyle: false,         // 导入样式标签 
	      printContainer: true,       // 抓取外部容器以及选择器的内容 
	      loadCSS: null, 			  // 路径额外的CSS文件-用于多个阵列[] 
	      pageTitle: "Bootstrap EChartsDemo",              // 将标题添加到打印页面
	      removeInline: false,        // 从打印元素中删除所有内联样式 
	      printDelay: 333,            // 可变打印延迟; 取决于复杂性，可能需要更高的值 
	      header: null,               // 前缀为html 
	      footer: null,               // 后缀为html 
	      base: false ,               // 保留BASE标记或接受URL的字符串
	      formValues: true,           // 保留输入/表单值 
	      canvas: true,              // 复制canvas元素（实验性）
	      doctypeString: "...",       // 为旧标记 
	      removeScripts: false,       // 从打印内容中删除脚本标记
	      copyTagClasses: false       // 从html＆body标签复制类 
		});
	}

</script>
</html>