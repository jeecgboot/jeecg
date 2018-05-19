//时间格式化
Date.prototype.format = function (format,value) {
	/*
	 * eg:format="yyyy-MM-dd hh:mm:ss";
	 */
	if (!format) {
		format = "yyyy-MM-dd hh:mm:ss";
	}
	if(value==''||value==null){
		return '';
	}
	var strdata=value.replace(/-/g,"/");
	var index=strdata.indexOf(".");
	if(index>0)
	{
		strdata=strdata.substr(0,index);
	}
	var date= new Date(Date.parse(strdata));
	var o = {
		"M+" : date.getMonth() + 1, // month
		"d+" : date.getDate(), // day
		"h+" : date.getHours(), // hour
		"m+" : date.getMinutes(), // minute
		"s+" : date.getSeconds(), // second
		"q+" : Math.floor((date.getMonth() + 3) / 3), // quarter
		"S" : date.getMilliseconds()
		// millisecond
	};
	
	if (/(y+)/.test(format)) {
		format = format.replace(RegExp.$1, strdata.substr(4-RegExp.$1.length,RegExp.$1.length));
	}
	
	for (var k in o) {
		if (new RegExp("(" + k + ")").test(format)) {
			format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
		}
	}
	return format;
};