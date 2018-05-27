    //提示信息
	function validationMessage(obj, Validatemsg) {
	    try {
	        removeMessage(obj);

	        var objOffset= obj.offset();
	        if(obj.is(":hidden")){
	        	objOffset = obj.parent().offset();
	        }
	        obj.focus();
	        var $poptip_error = $('<div class="poptip"><span class="poptip-arrow poptip-arrow-top"><em>◆</em></span>' + Validatemsg + '</div>').css("left",objOffset.left + 'px').css("top", objOffset.top + obj.parent().height() + 5 + 'px')

	        $('body').append($poptip_error);
	        if (obj.hasClass('form-control') || obj.hasClass('ui-select')) {
	            obj.parent().addClass('has-error');
	        }
	        if (obj.hasClass('ui-select')) {
	            $('.input-error').remove();
	        }
	        obj.change(function () {
	            if (obj.val()) {
	                removeMessage(obj);
	            }
	        }); 
	        if (obj.hasClass('ui-select')) {
	            $(document).click(function (e) {
	                if (obj.attr('data-value')) {
	                    removeMessage(obj);
	                }
	                e.stopPropagation();
	            });
	        }
	        return false;  
	    } catch (e) {
	        alert(e)
	    }
	}
	//移除提示
	function removeMessage(obj) {
	    obj.parent().removeClass('has-error');
	    $('.poptip').remove();
	    $('.input-error').remove();
	}
	
	function DateJsonFormat(date,fmt) { 
		//{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
	     var o = { 
	        "M+" : date.month,                 //月份 
	        "d+" : date.date,                    //日 
	        "H+" : date.hours,                   //小时 
	        "m+" : date.minutes,                 //分 
	        "s+" : date.seconds,                 //秒 
	        "q+" : Math.floor((date.month+3)/3), //季度 
	        "S"  : 0             //毫秒 
	    }; 
	    if(/(y+)/.test(fmt)) {
	            fmt=fmt.replace(RegExp.$1, (date.year+"").substr(4 - RegExp.$1.length)); 
	    }
	     for(var k in o) {
	        if(new RegExp("("+ k +")").test(fmt)){
	             fmt = fmt.replace(RegExp.$1, (RegExp.$1.length==1) ? (o[k]) : (("00"+ o[k]).substr((""+ o[k]).length)));
	         }
	     }
	    return fmt; 
	}  
	
	
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