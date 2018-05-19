// 获取请求参数
// 使用示例
// location.href = http://localhost:8080/index.html?id=123
// T.p('id') --> 123;
var url = function(name) {
	var reg = new RegExp("(^|&)"+ name +"=([^&]*)(&|$)");
	var r = window.location.search.substr(1).match(reg);
	if(r!=null)return  unescape(r[2]); return null;
}

////全局配置
//$.ajaxSetup({
//	dataType: "json",
//	cache: false,
//	complete:function(XMLHttpRequest,textStatus){
//		if(textStatus=="parsererror"){
//            top.layer.open({
//			  title: '系统提示',
//			  area: '338px',
//			  icon: 3,
//			  move: false,
//			  anim: -1,
//			  isOutAnim: false,
//			  content: '注：登录超时,请稍后重新登录.',
//			  btn: ['立即退出'],
//			  btnAlign: 'c',
//			  yes: function(){
//				  toUrl('sys/logout');
//			  }
//			});
//			setTimeout(function(){
//				toUrl("sys/logout");
//			}, 2000);
//        } else if(textStatus=="error"){
//           dialogMsg("请求超时，请稍候重试...", "error");
//        }
//	}
//})

//权限判断
function hasPermission(permission) {
    if(isNullOrEmpty(window.parent.perms)) {
    	return false;
    }
	if (window.parent.perms.indexOf(permission) > -1) {
        return true;
    } else {
        return false;
    }
}

toUrl = function(href) {
	window.location.href = href;
}

$.fn.bootstrapTableEx = function(opt){
	var defaults = {
		url: '',
		dataField: "rows",
		dataType: 'json',
		selectItemName: 'id',
		clickToSelect: true,
		pagination: true,
		smartDisplay: false,
		pageSize: 10,
		pageList: [10, 20, 30, 40, 50],
        paginationLoop: false,
		sidePagination: 'server',
		queryParamsType : null,
		columns: []
	}
	var option = $.extend({}, defaults, opt);
    if(!option.pagination){
        option.responseHandler = function(res) {
            return res.rows;
        }
    }
	$(this).bootstrapTable(option);
}

formatDate = function (v, format) {
    if (!v) return "";
    var d = v;
    if (typeof v === 'string') {
        if (v.indexOf("/Date(") > -1)
            d = new Date(parseInt(v.replace("/Date(", "").replace(")/", ""), 10));
        else
            d = new Date(Date.parse(v.replace(/-/g, "/").replace("T", " ").split(".")[0]));//.split(".")[0] 用来处理出现毫秒的情况，截取掉.xxx，否则会出错
    }
    var o = {
        "M+": d.getMonth() + 1,
        "d+": d.getDate(),
        "h+": d.getHours(),
        "m+": d.getMinutes(),
        "s+": d.getSeconds(),
        "q+": Math.floor((d.getMonth() + 3) / 3),
        "S": d.getMilliseconds()
    };
    if (/(y+)/.test(format)) {
        format = format.replace(RegExp.$1, (d.getFullYear() + "").substr(4 - RegExp.$1.length));
    }
    for (var k in o) {
        if (new RegExp("(" + k + ")").test(format)) {
            format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));
        }
    }
    return format;
}

function today() {
    var dd = new Date();
    return formatDate(dd, 'yyyy-MM-dd');
}

function countDay(dayCount) {
    var dd = new Date();
    dd.setDate(dd.getDate()+dayCount);//获取AddDayCount天后的日期
    var y = dd.getFullYear();
    var m = (dd.getMonth()+1)<10?"0"+(dd.getMonth()+1):(dd.getMonth()+1);//获取当前月份的日期，不足10补0
    var d = dd.getDate()<10?"0"+dd.getDate():dd.getDate();//获取当前几号，不足10补0
    return y+"-"+m+"-"+d;
}

isNullOrEmpty = function (obj) {
    if ((typeof (obj) == "string" && obj == "") || obj == null || obj == undefined) {
        return true;
    } else {
        return false;
    }
}

isNotNullOrEmpty = function (obj) {
    if ((typeof (obj) == "string" && obj == "") || obj == null || obj == undefined) {
        return false;
    } else {
        return true;
    }
}

checkedArray = function (id) {
    var isOK = true;
    if (id == undefined || id == "" || id == 'null' || id == 'undefined') {
        isOK = false;
        dialogMsg('您没有选中任何数据项！');
    }
    return isOK;
}

checkedRow = function (id) {
    var isOK = true;
    if (id == undefined || id == "" || id == 'null' || id == 'undefined') {
        isOK = false;
        dialogMsg('您没有选中任何数据项！');
    } else if (id.length > 1) {
        isOK = false;
        dialogMsg('您只能选择一条数据项！');
    }
    return isOK;
}

reload = function () {
    location.reload();
    return false;
}

dialogOpen = function(opt){
	var defaults = {
		title : '',
		width: '700',
		height: '400',
		lock : true,//锁屏
		opacity : 0.3,//锁屏透明度
		cache:false,
		cancelVal: '关闭',
	    content: '',
	    zIndex: 9999,
	    ok:function(){
	    	var iframe = this.iframe.contentWindow;
	    	iframe.vm.acceptClick();
	    	return false;
	    },
	    cancel:true,
	    init:function(){ }
	}
	var option = $.extend({}, defaults, opt);
	if(option.width=="100%" || option.height=="100%"){
		option.width = window.top.document.body.offsetWidth;
		option.height =window.top.document.body.offsetHeight-100;
	}
	$.dialog(option);
}

dialogContent = function(opt){
	var defaults = {
		title : '系统窗口',
		width: '',
		height: '',
		content : null,
		data : {},
		btn: ['确定', '取消'],
		success: null,
		yes: null
	}
	var option = $.extend({}, defaults, opt);
	return top.layer.open({
	  	type : 1,
		title : option.title,
		closeBtn : 1,
		anim: -1,
		isOutAnim: false,
		shadeClose : false,
		shade : 0.3,
		area : [option.width, option.height],
		shift : 5,
		content : option.content,
		btn: option.btn,
		success: option.success,
		yes: option.yes
    });
}

dialogAjax = function(opt){
	var defaults = {
		title : '系统窗口',
		width: '',
		height: '',
		url : null,
		data : {},
		btn: ['确定', '取消'],
		success: null,
		yes: null
	}
	var option = $.extend({}, defaults, opt);
	$.post(option.url, null, function(content){
		layer.open({
		  	type : 1,
			title : option.title,
			closeBtn : 1,
			anim: -1,
			isOutAnim: false,
			shadeClose : false,
			shade : 0.3,
			area : [option.width, option.height],
			shift : 5,
			content : content,
			btn: option.btn,
			success: option.success,
			yes: option.yes
	    });
	});
}

dialogAlert = function (content, type) {
	var msgType = {
		success:1,
		error:2,
		warn:3,
		info:7
	};
	if(isNullOrEmpty(type)){
		type='info';
	}
	top.layer.alert(content, {
        icon: msgType[type],
        title: "系统提示",
        anim: -1,
        btnAlign: 'c',
		isOutAnim: false
    });
}

dialogConfirm = function (content, callBack) {
	top.layer.confirm(content, {
		area: '338px',
		icon: 7,
        anim: -1,
		isOutAnim: false,
        title: "系统提示",
        btn: ['确认', '取消'],
        btnAlign: 'c',
    	yes: callBack
    });
}

dialogMsg = function(msg, type) {
	var msgType = {
		success:1,
		error:2,
		warn:3,
		info:7
	};
	if(isNullOrEmpty(type)){
		type='info';
	}
	top.layer.msg(msg, {
		icon: msgType[type],
		time: 2000
	}); 
}

dialogClose = function() {
	
}

dialogLoading = function(flag) {
	if(flag){
		top.layer.load(0, {
			shade: [0.1,'#fff'],
			time: 2000
		});
	}else{
		top.layer.closeAll('loading');
	}
}

$.fn.GetWebControls = function (keyValue) {
    var reVal = "";
    $(this).find('input,select,textarea').each(function (r) {
        var id = $(this).attr('id');
        var type = $(this).attr('type');
        switch (type) {
            case "checkbox":
                if ($("#" + id).is(":checked")) {
                    reVal += '"' + id + '"' + ':' + '"1",'
                } else {
                    reVal += '"' + id + '"' + ':' + '"0",'
                }
                break;
            default:
                var value = $("#" + id).val();
                if (value == "") {
                    value = "&nbsp;";
                }
                reVal += '"' + id + '"' + ':' + '"' + $.trim(value) + '",'
                break;
        }
    });
    reVal = reVal.substr(0, reVal.length - 1);
    if (!keyValue) {
        reVal = reVal.replace(/&nbsp;/g, '');
    }
    reVal = reVal.replace(/\\/g, '\\\\');
    reVal = reVal.replace(/\n/g, '\\n');
    var postdata = jQuery.parseJSON('{' + reVal + '}');
    return postdata;
};

$.fn.SetWebControls = function (data) {
    var $id = $(this)
    for (var key in data) {
        var id = $id.find('#' + key);
        if (id.attr('id')) {
            var type = id.attr('type');
            var value = $.trim(data[key]).replace(/&nbsp;/g, '');
            switch (type) {
                case "checkbox":
                    if (value == 1) {
                        id.attr("checked", 'checked');
                    } else {
                        id.removeAttr("checked");
                    }
                    break;
                default:
                    id.val(value);
                    break;
            }
        }
    }
}

tabiframeId = function () {
    var iframeId = top.$(".DP_iframe:visible").attr("id");
    return iframeId;
}

$.currentIframe = function () {
    var tabId = tabiframeId();
	if(isNullOrEmpty(tabId)) {//单页iframe嵌套
		return $(window.parent.document).contents().find('#main')[0].contentWindow;
    }
    return $(window.parent.document).contents().find('#'+tabiframeId())[0].contentWindow;//多层tab页嵌套
}


//提示信息
function ValidationMessage(obj, Validatemsg) {
    try {
        removeMessage(obj);
//        dialogMsg(Validatemsg);
        obj.focus();
        var $poptip_error = $('<div class="poptip"><span class="poptip-arrow poptip-arrow-top"><em>◆</em></span>' + Validatemsg + '</div>').css("left", obj.offset().left + 'px').css("top", obj.offset().top + obj.parent().height() + 5 + 'px')
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
