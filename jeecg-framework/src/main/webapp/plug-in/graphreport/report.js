var reportUtil = {};
reportUtil.splineOptions = {
	chart: {
        type: 'spline'
    },
	title: {
	    text: null  //无标题
	},
	credits: {
		enabled: false //不显版权
	},
	xAxis: {
		categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun','Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
	},
	yAxis: {
		title: {
			text: ''  //y轴文字
		},
		plotLines: [{
			value: 0,
			width: 1,
			color: '#808080'
		}]
	},
	tooltip: {
		crosshairs: true
        //shared: true
		//headerFormat: '<span style="color: rgb(90, 90, 90);">{point.key} ({point.percentage:.1f}%)</span><br/>',  //百分比（用于饼图）
		//headerFormat: '<span style="color: rgb(90, 90, 90);">{series.name}</span><br/>',
		//pointFormat: '<span style="color: rgb(90, 90, 90);">{point.x}点: {point.y}</span>'
	},
	series: [{
		name: 'Tokyo',  //x轴文字
		data: [7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2, 26.5, 23.3, 18.3, 13.9, 9.6]
	}]
}

/**
 * 获得曲线参数
 * @param categories	x轴显示数据
 * @param series		数据列表
 * @param yText			y轴文字	
 * @returns 参数对象
 */
reportUtil.getSplineOptions = function(categories, series, yText) {
	var options = {};
	$.extend(options, reportUtil.splineOptions);
	
	options.xAxis.categories = categories;  //x轴显示数据
	options.series = series; //数据列表
	options.yAxis.title.text = yText;	//y轴文字	
	
	return options;
}

$(function() {
	$(document).ajaxSend(function(evt, request, settings){
		showLoading();
	});
	$(document).ajaxComplete(function(evt, request, settings){
		removeLoading();
	});
})

/**
 * 显示加载效果（需要引入spin.min.js）
 */
function showLoading() {
	if($("#showLoadingDiv").length == 0) {
		$("body").append($("<div id=showLoadingDiv>").css({
				position: "fixed",
				_position: "absolute",
				width: "100%",
				height: $(window.document).height(),
				top: "0",
				left: "0", 
				opacity: "0.6",
				filter: "alpha(opacity = 60)", 
				background: "white",
				display: "none",
				"z-index": "9999"
			})
			.append($("<div>").css({
					width: "100px",
					height: "100px",
					position: "absolute",
					top: $(window).height()/2,
					left: "50%"
				})
				.append(new Spinner().spin().el)
		));
	}
	$(".spinner").css("position", "static");	
	$("#showLoadingDiv").fadeIn(200);
}

/**
 * 移除加载效果
 */
function removeLoading() {
	$("#showLoadingDiv").fadeOut(200);
}

/**
 * 计算天数差的函数
 */
function dateDiff(sDate1,  sDate2){    //sDate1和sDate2是2006-12-18格式  
    var aDate, oDate1, oDate2, iDays  
    aDate = sDate1.split("-")  
    oDate1 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0])    //转换为12-18-2006格式  
    aDate = sDate2.split("-")  
    oDate2 = new Date(aDate[1] + '-' + aDate[2] + '-' + aDate[0])  
    iDays = parseInt(Math.abs(oDate1 - oDate2) / 1000 / 60 / 60 /24)    //把相差的毫秒数转换为天数  
    return iDays  
}

/**
 * 获得两日期之间
 */
function getBetweenDay(startDate, endDate) {
	var dayCount = dateDiff(endDate, startDate);
	
	var spliteStartDate = startDate.split("-");
	var startYear = parseInt(spliteStartDate[0]);
	var startMonth = parseInt(spliteStartDate[1]);
	var startDay = parseInt(spliteStartDate[2]);
	
	var result = new Array();
	for(var i = 0; i <= dayCount; i++) {
		var d = new Date(startYear, startMonth - 1, startDay + i);
		result.push(d.getFullYear() + "-" + (d.getMonth() + 1) + "-" + d.getDate());
	}
	return result;
}

/**
 * 控制台打印信息（对IE做了兼容）
 */
function log(msg) {
	try {
		if(console) {
			console.log(msg);
		}
	} catch (e) {
		// TODO: handle exception
	}
}