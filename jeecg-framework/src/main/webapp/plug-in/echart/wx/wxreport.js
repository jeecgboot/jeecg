   var fansChart = echarts.init(document.getElementById('fans_chart'));
   var bindChart = echarts.init(document.getElementById('bind_chart'));
   var readChart = echarts.init(document.getElementById('read_chart'));
   var fans_option =  {
			title : {
				text: '周粉丝数同比、环比统计',
				left:'center'
			},
			tooltip : {
				trigger: 'axis',
           	    formatter: '{b}<br/>{a0}:{c0}%<br/>{a1}:{c1}%'
			},
			legend: {
				data:['同比','环比'],
				top: 'bottom',
				left:'center'
			},
			toolbox: {
				show : true,
				right:'10%',
		        top: 'top',
				feature : {
					dataView : {show: false, readOnly: false},
					magicType : {show: true, type: ['line', 'bar']},
					restore : {show: false},
					saveAsImage : {show: true}
				}
			},
			calculable : true,
			xAxis : [
				{
					type : 'category',
					data : []
				}
			],
			yAxis : [
				{
					type : 'value',
					axisLabel: {
						formatter: '{value}%'
					}
				}
			],
			series : [
				{
					name:'同比',
					type:'bar',
					itemStyle: {
		                normal: {color: '#e34a0a'}
		            },
					data:[]
					
				},
				{
					name:'环比',
					type:'bar',
					itemStyle: {
		                normal: {color: '#48d40e'}
		            },
					data:[]
					
				}
			]
		};
   fansChart.setOption(fans_option);
  
   var bind_option = {
		   title : {
				text: '周绑定率环比统计',
				left:'center'
			},
			color: ['#3398DB'],
			tooltip : {
				trigger: 'axis',
				formatter: '{b}:{c}%',
				axisPointer : {            // 坐标轴指示器，坐标轴触发有效
					type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
				}
			},
			toolbox: {
				show : true,
				right:'10%',
		        top: 'top',
				feature : {
					magicType : {show: true, type: ['line', 'bar']},
					restore : {show: false},
					saveAsImage : {show: true}
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
					data : [],
					axisTick: {
						alignWithLabel: true
					}
				}
			],
			yAxis : [
				{
					type : 'value',
					axisLabel: {
						formatter: '{value}%'
					}
				}
			],
			series : [
				{
					name:'绑定率',
					type:'bar',
					barWidth: '60%',
					data:[]
				}
			]
		};
  bindChart.setOption(bind_option);
  
  var read_option = {
		   title : {
				text: '周阅读量环比统计',
				left:'center'
			},
			color: ['#3398DB'],
			tooltip : {
				trigger: 'axis',
				formatter: '{b}:{c}%',
				axisPointer : {            // 坐标轴指示器，坐标轴触发有效
					type : 'shadow'        // 默认为直线，可选为：'line' | 'shadow'
				}
			},
			toolbox: {
				show : true,
				right:'10%',
		        top: 'top',
				feature : {
					magicType : {show: true, type: ['line', 'bar']},
					restore : {show: false},
					saveAsImage : {show: true}
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
					data :[],
					axisTick: {
						alignWithLabel: true
					}
				}
			],
			yAxis : [
				{
					type : 'value',
					axisLabel: {
						formatter: '{value}%'
					}
				}
			],
			series : [
				{
					name:'绑定率',
					type:'bar',
					barWidth: '60%',
					data:[]
				}
			]
		};
 readChart.setOption(read_option);
 
 
 function initChartData(options){
    var acc_arr=options.acc_arr;
	var fans_yoy_arr=options.fans_yoy_arr;
	var fans_wow_arr=options.fans_wow_arr;
	var bind_wow_arr=options.bind_wow_arr;
	var read_wow_arr=options.read_wow_arr;
	
	// 填入数据
    fansChart.setOption({
        xAxis: [{
				type : 'category',
				data: acc_arr
			}],
        series: [{
           name:'同比',
		   data:fans_yoy_arr
        },
		{
           name:'环比',
		   data:fans_wow_arr
        }]
    });
	
	bindChart.setOption({
         xAxis: [{
				type : 'category',
				data: acc_arr
			}],
        series: [{
          name:'绑定率',
		  data:bind_wow_arr
        }]
    });

	readChart.setOption({
         xAxis: [{
				type : 'category',
				data: acc_arr
			}],
        series: [{
          name:'阅读量',
		  data:read_wow_arr
        }]
    });
 }