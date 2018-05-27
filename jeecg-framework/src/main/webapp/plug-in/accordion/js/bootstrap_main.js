$(function() {
	initTopMenu();
	loadIndexPage();
});
/**
 * 初始化顶部菜单
 * @returns void
 */
function initTopMenu() {
	$.ajax( {
		url : "loginController.do?top",
		type : "POST",
		dataType : "text",
		async : false,
		cache : false,
		success : function(data) {
			$(".bootstrap-menu").prepend(data);
			$.parser.parse($("#header"));
		}
	});
}
/**
 * 加载首页
 * @returns void
 */
function loadIndexPage() {
	$.ajax( {
		url : "loginController.do?home",
		type : "POST",
		dataType : "text",
		async : false,
		cache : false,
		success : function(data) {
			$("#wrapper").html(data);
			$.parser.parse($('#wrapper'));
		}
	});
}
/**
 * 菜单点击事件
 * @param {String} subtitle 名字
 * @param {String} url 地址
 * @param {String} icon 图标
 * @returns void
 */
function showContent(subtitle, url){
	if(isNull(url)){
		return;
	}
	
	//判断是否进行iframe方式打开
	if(url.indexOf('isHref') != -1){
		
	}else{
		$("#wrapper").html( '<iframe  scrolling="no" frameborder="0"  src="'+url+'" style="width:100%;min-height:480px;"></iframe>');
		$.parser.parse($('#wrapper'));
		//设置iframe高度自适应
		$("#wrapper iframe").load(function(){
			 $(this).contents().find("div:eq(0)").next().attr("style","height:480px;overflow-y: auto;");  
		}); 
		return;
	}
	$.ajax( {
		url : url,
		type : "POST",
		dataType : "text",
		async : false,
		cache : false,
		success : function(data) {
			$("#wrapper").html(data);
			$.parser.parse($('#wrapper'));
		}
	});
}

/**
 * 判断空
 * @param {String} val
 * @returns {Boolean}
 */
function isNull(val){
	if(!val){
		return true;
	}
	if(val == null || val == "" || val == "undefined" || val == "null" || val == "NULL"){
		return true;
	}
	return false;
}
