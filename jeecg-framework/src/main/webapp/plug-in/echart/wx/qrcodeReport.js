   var provinceChart = echarts.init(document.getElementById('province_chart'));//省份
   var cityChart = echarts.init(document.getElementById('city_chart'));//地市
   var departChart = echarts.init(document.getElementById('depart_chart'));//部门
   var namecnChart = echarts.init(document.getElementById('namecn_chart'));//人员
  
   //======省份begin======
   var province_option = {
		   title : {
				text: '省份统计',
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
					type : 'value'
				}
			],
			series : [
				{
					name:'扫码次数',
					type:'bar',
					barWidth: '60%',
					data:[]
				}
			]
		};
   provinceChart.setOption(province_option);
   //======省份end======
   
   //======地市begin======
   var city_option = {
		   title : {
				text: '地市统计',
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
					type : 'value'
				}
			],
			series : [
				{
					name:'扫码次数',
					type:'bar',
					barWidth: '60%',
					data:[]
				}
			]
		};
   cityChart.setOption(city_option);
   //======地市end======
   
   //======部门begin======
   var depart_option = {
		   title : {
				text: '部门统计',
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
					type : 'value'
				}
			],
			series : [
				{
					name:'扫码次数',
					type:'bar',
					barWidth: '60%',
					data:[]
				}
			]
		};
   departChart.setOption(depart_option);
   //======部门end======
   
   //======人员begin======
   var namecn_option = {
		   title : {
				text: '人员统计',
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
					type : 'value'
				}
			],
			series : [
				{
					name:'扫码次数',
					type:'bar',
					barWidth: '60%',
					data:[]
				}
			]
		};
   namecnChart.setOption(namecn_option);
   //======人员end======

 function initProvinceChartData(options){
    //alert("初始化省");
    //alert(JSON.stringify(options));
    var province_arr=options.province_arr;
	var qrcodeTotal_arr=options.qrcodeTotal_arr;
	// 填入数据
    provinceChart.setOption({
	    xAxis: [{
				type : 'category',
				data: province_arr
			}],
	    series: [{
	       name:'扫码次数',
		   data:qrcodeTotal_arr
	       }] 
    });
 } 
 
 function initCityChartData(options){
   // alert("初始化市");
    //alert(JSON.stringify(options));
	 var city_arr=options.city_arr;
	 var qrcodeTotal_arr=options.qrcodeTotal_arr;
	 cityChart.setOption({
	    xAxis: [{
				type : 'category',
				data: city_arr
			}],
	    series: [{
	       name:'扫码次数',
		   data:qrcodeTotal_arr
	       }] 
    });
 }
 
  function initDepartChartData(options){
     //alert("初始化部门");
     //alert(JSON.stringify(options));
	 var depart_arr=options.depart_arr;
	 var qrcodeTotal_arr=options.qrcodeTotal_arr;
	 departChart.setOption({
	    xAxis: [{
				type : 'category',
				data: depart_arr
			}],
	    series: [{
	       name:'扫码次数',
		   data:qrcodeTotal_arr
	       }] 
    });
 }
 
 function initNamecnChartData(options){
     //alert("初始化人员");
     //alert(JSON.stringify(options));
	 var namecn_arr=options.namecn_arr;
	 var qrcodeTotal_arr=options.qrcodeTotal_arr;
	 namecnChart.setOption({
	    xAxis: [{
				type : 'category',
				data: namecn_arr
			}],
	    series: [{
	       name:'扫码次数',
		   data:qrcodeTotal_arr
	       }] 
    });
 }
 
 