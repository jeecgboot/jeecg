/*左侧菜单点击*/
$(".side-menu").on('click', 'li a', function(e) {
	var animationSpeed = 300;
	var $this = $(this);
	var checkElement = $this.next();
	if (checkElement.is('.menu-item-child') && checkElement.is(':visible')) {
	  checkElement.slideUp(animationSpeed, function() {
		checkElement.removeClass('menu-open');
	  });
	  checkElement.parent("li").removeClass("active");
	}
	//如果菜单是不可见的
	else if ((checkElement.is('.menu-item-child')) && (!checkElement.is(':visible'))) {
	  //获取上级菜单
	  var parent = $this.parents('ul').first();
	  //从父级开始找所有打开的菜单并关闭
	  var ul = parent.find('ul:visible').slideUp(animationSpeed);
	  //在父级中移出menu-open标记
	  ul.removeClass('menu-open');
	  //获取父级li
	  var parent_li = $this.parent("li");
	  //打开菜单时添加menu-open标记
	  checkElement.slideDown(animationSpeed, function() {
		//添加样式active到父级li
		checkElement.addClass('menu-open');
		parent.find('li.active').removeClass('active');
		parent_li.addClass('active');
	  });
	}else{
		$(".side-menu").find("li.active").removeClass('active');
		$this.parent("li").addClass("active");
	}
	//防止有链接跳转
	e.preventDefault();
	
	addIframe($this);
});
var tab_padding_common_arg = 15;//顶部tab之间的padding值
/*添加tabs*/
function addFineuiTab(options){
	 var h = options.url,
     m = options.id,
     label = options.title,
     isHas = false;
	 
	 if (h == "" || $.trim(h).length == 0) {
			return false;
		}
		
		var fullWidth = $(window).width();
		if(fullWidth >= 750){
			$(".layout-side").show();
		}else{
			$(".layout-side").hide();
		}
		
		$(".content-tab").each(function() {
			if ($(this).data("id") == h) {
				if (!$(this).hasClass("active")) {
					$(this).addClass("active").siblings(".content-tab").removeClass("active");
					addTab(this);
				}
				isHas = true;
			}
		});
		if(isHas){
			$(".body-iframe").each(function() {
				if ($(this).data("id") == h) {
					$(this).show().siblings(".body-iframe").hide();
				}
			});
		}
		if (!isHas) {
			var tab = "<a href='javascript:;' class='content-tab active' data-id='"+h+"'>"+ label +" <i class='icon-font'>&#xe633;</i></a>";
			//<div class='sepmm'></div>
			$(".content-tab").removeClass("active");
			
			var oldwd = $(".tab-nav-content").width();
			$("#tytabbottomsepar").css("left",oldwd+27);
			$(".tab-nav-content").append(tab);
			var newwd = $(".tab-nav-content").width();
			$("#tytabbottomsepar").css("width",newwd-oldwd);
			
			//console.log('$(".tab-nav-content").width()oldwd--newwd||'+oldwd+"--"+newwd);
			//修改iframe高度为99% 防止窗口下坠
			var iframe = "<iframe class='body-iframe ccrame' name='iframe"+ m +"' width='100%' height='99%' src='"+ h +"' frameborder='0' data-id='"+ h +"' seamless></iframe>";
			$(".layout-main-body").find("iframe.body-iframe").hide().parents(".layout-main-body").append(iframe);
			addTab($(".content-tab.active"));
		}
		
		var imageMenuData = [
	        [{
	            text: "关闭标签",
	            func: function() {
	            	closePage2($(this));
	            }
	        },{
	        	text: "关闭其他",
	        	 func: function() {closeOtherTabs();}
	        },{
	        	text: "关闭全部",
	        	func: function() {closeAllTabs();}
	       }]
	    ];
	    try{
	        $("a[data-id='"+h+"']").smartMenu(imageMenuData, {
	            name:"name"+uuid()
	        });
	    }catch(e){
	        console.log(e);
	    }
	    
		return false;
	 
}
/*添加iframe*/
function addIframe(cur){
	var $this = cur;
	var h = $this.attr("href"),
		m = $this.data("index"),
		label = $this.find("span").text();
	var options = {url:h,id:m,title:label};
	addFineuiTab(options);
}

//关闭其他选项卡
function closeOtherTabs(){
    $('#tab-contents-div').children("[data-id]").not(":first").not(".active").each(function () {
        $('.body-iframe[data-id="' + $(this).data('id') + '"]').remove();
        $(this).remove();
    });
    $('#tab-contents-div').css("margin-left", "0");
    $("#tytabbottomsepar").css("left",$("#myhomeAtag").width()+2*tab_padding_common_arg+27);
	$("#tytabbottomsepar").css("width",$('#tab-contents-div').children(".active").width()+2*tab_padding_common_arg);
}
// 关闭全部
function closeAllTabs(){
    $('#tab-contents-div').children("[data-id]").not(":first").each(function () {
        $('.body-iframe[data-id="' + $(this).data('id') + '"]').remove();
        $(this).remove();
    });
    $('#tab-contents-div').children("[data-id]:first").each(function () {
        $('.body-iframe[data-id="' + $(this).data('id') + '"]').show();
        $(this).addClass("active");
    });
    $('#tab-contents-div').css("margin-left", "0");
    $("#tytabbottomsepar").css("left",27);
	$("#tytabbottomsepar").css("width",78);
}
function uuid() {
    var s = [];
    var hexDigits = "0123456789abcdef";
    for (var i = 0; i < 36; i++) {
        s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
    }
    s[14] = "4";  // bits 12-15 of the time_hi_and_version field to 0010
    s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1);  // bits 6-7 of the clock_seq_hi_and_reserved to 01
    s[8] = s[13] = s[18] = s[23] = "-";

    var uuid = s.join("");
    return uuid;
}

/*添加tab*/
function addTab(cur) {
	var prev_all = tabWidth($(cur).prevAll()),
		next_all = tabWidth($(cur).nextAll());
	//console.log('prev_all+"--"+next_all:'+prev_all+"--"+next_all);
	var other_width = tabWidth($(".layout-main-tab").children().not(".tab-nav"));
	var navWidth = $(".layout-main-tab").outerWidth(true)-other_width;//可视宽度
	var hidewidth = 0;
	//debugger;
	
	if ($(".tab-nav-content").width() < navWidth) {
		hidewidth = 0
	} else {
		if (next_all <= (navWidth - $(cur).outerWidth(true) - $(cur).next().outerWidth(true))) {
			if ((navWidth - $(cur).next().outerWidth(true)) > next_all) {
				hidewidth = prev_all;
				var m = cur;
				while ((hidewidth - $(m).outerWidth()) > ($(".tab-nav-content").outerWidth() - navWidth)) {
					hidewidth -= $(m).prev().outerWidth();
					m = $(m).prev()
				}
			}
		} else {
			if (prev_all > (navWidth - $(cur).outerWidth(true) - $(cur).prev().outerWidth(true))) {
				hidewidth = prev_all - $(cur).prev().outerWidth(true)
			}
		}
	}
	//console.log(hidewidth);
	$(".tab-nav-content").animate({
		marginLeft: 0 - hidewidth + "px"
	},
	"fast");
	
	//激活条显示
	$("#tytabbottomsepar").css("left",prev_all+27-hidewidth);
	var newwd = $(cur).width();
	$("#tytabbottomsepar").css("width",newwd+31);
	
}

/*获取宽度*/
function tabWidth(tabarr) {
	var allwidth = 0;
	$(tabarr).each(function() {
		if(this.tagName=='A'||this.tagName=='a'){
			allwidth += $(this).outerWidth(true);
		}
	});
	return allwidth;
}

/*左按钮事件*/
$(".btn-left").on("click", leftBtnFun);
/*右按钮事件*/
$(".btn-right").on("click", rightBtnFun);
/*选项卡切换事件*/
$(".tab-nav-content").on("click", ".content-tab", navChange);
/*选项卡关闭事件*/
$(".tab-nav-content").on("click", ".content-tab i", closePage);
/*选项卡双击关闭事件*/
$(".tab-nav-content").on("dblclick", ".content-tab", closePage);


/*左按钮方法*/
function leftBtnFun() {
	var ml = Math.abs(parseInt($(".tab-nav-content").css("margin-left")));
	var other_width = tabWidth($(".layout-main-tab").children().not(".tab-nav"));
	var navWidth = $(".layout-main-tab").outerWidth(true)-other_width;//可视宽度
	var hidewidth = 0;
	if ($(".tab-nav-content").width() < navWidth) {
		return false
	} else {
		var tabIndex = $(".content-tab:first");
		var n = 0;
		while ((n + $(tabIndex).outerWidth(true)) <= ml) {
			n += $(tabIndex).outerWidth(true);
			tabIndex = $(tabIndex).next();
		}
		n = 0;
		if (tabWidth($(tabIndex).prevAll()) > navWidth) {
			while ((n + $(tabIndex).outerWidth(true)) < (navWidth) && tabIndex.length > 0) {
				n += $(tabIndex).outerWidth(true);
				tabIndex = $(tabIndex).prev();
			}
			hidewidth = tabWidth($(tabIndex).prevAll());
		}
	}
	$(".tab-nav-content").animate({
		marginLeft: 0 - hidewidth + "px"
	},
	"fast");
}

/*右按钮方法*/
function rightBtnFun() {
	var ml = Math.abs(parseInt($(".tab-nav-content").css("margin-left")));
	var other_width = tabWidth($(".layout-main-tab").children().not(".tab-nav"));
	var navWidth = $(".layout-main-tab").outerWidth(true)-other_width;//可视宽度
	var hidewidth = 0;
	if ($(".tab-nav-content").width() < navWidth) {
		return false
	} else {
		var tabIndex = $(".content-tab:first");
		var n = 0;
		while ((n + $(tabIndex).outerWidth(true)) <= ml) {
			n += $(tabIndex).outerWidth(true);
			tabIndex = $(tabIndex).next();
		}
		n = 0;
		while ((n + $(tabIndex).outerWidth(true)) < (navWidth) && tabIndex.length > 0) {
			n += $(tabIndex).outerWidth(true);
			tabIndex = $(tabIndex).next()
		}
		hidewidth = tabWidth($(tabIndex).prevAll());
		if (hidewidth > 0) {
			$(".tab-nav-content").animate({
				marginLeft: 0 - hidewidth + "px"
			},
			"fast");
		}
	}
}

/*选项卡切换方法*/
function navChange() {
	if (!$(this).hasClass("active")) {
		var k = $(this).data("id");
		$(".body-iframe").each(function() {
			if ($(this).data("id") == k) {
				$(this).show().siblings(".body-iframe").hide();
				/*var siblings_obj = $(this).siblings(".body-iframe");
				$(this).siblings(".body-iframe").animate({left:'200px',position:'relative'},'slow',function(){siblings_obj.hide()});
				$(this).show();*/
				return false
			}
		});
		$(this).addClass("active").siblings(".content-tab").removeClass("active");
		var dateIndex =  $(this).attr("data-id");
		$("a[href='"+dateIndex+"']").closest(".side-menu").find('.active').removeClass("active");
		$("a[href='"+dateIndex+"']").parent("li").addClass("active");
		addTab(this);
	}
}
//获取tab的left
function getTabActiveBarLeft(){
	var a = $("#tytabbottomsepar").css("left");
	return parseInt(a.substring(0,a.indexOf("p")));
}
/*选项卡关闭方法*/
function closePage() {
	var url = $(this).parents(".content-tab").data("id");
	var cur_width = $(this).parents(".content-tab").width();
	if ($(this).parents(".content-tab").hasClass("active")) {
		if ($(this).parents(".content-tab").next(".content-tab").size()) {
			//后面还有元素则后面元素激活
			var next_obj = $(this).parents(".content-tab").next(".content-tab:eq(0)");
			var next_url = next_obj.data("id");
			next_obj.addClass("active");
			$(".body-iframe").each(function() {
				if ($(this).data("id") == next_url) {
					$(this).show().siblings(".body-iframe").hide();
					return false
				}
			});
			var n = parseInt($(".tab-nav-content").css("margin-left"));
			if (n < 0) {
				$(".tab-nav-content").animate({
					marginLeft: (n + cur_width) + "px"
				},
				"fast")
			}
			$(this).parents(".content-tab").remove();
			$(".body-iframe").each(function() {
				if ($(this).data("id") == url) {
					$(this).remove();
					return false
				}
			})
			$("#tytabbottomsepar").css("width",next_obj.width()+2*tab_padding_common_arg);
		}
		if ($(this).parents(".content-tab").prev(".content-tab").size()) {
			var prev_obj = $(this).parents(".content-tab").prev(".content-tab:last");
			var pre_width = prev_obj.width()+2*tab_padding_common_arg;
			var prev_url = prev_obj.data("id");
			prev_obj.addClass("active");
			$(".body-iframe").each(function() {
				if ($(this).data("id") == prev_url) {
					$(this).show().siblings(".body-iframe").hide();
					return false
				}
			});
			$(this).parents(".content-tab").remove();
			$(".body-iframe").each(function() {
				if ($(this).data("id") == url) {
					$(this).remove();
					return false
				}
			})
			$("#tytabbottomsepar").css("left",getTabActiveBarLeft()-pre_width);
			$("#tytabbottomsepar").css("width",pre_width);
			
		}
	} else {
		$(this).parents(".content-tab").remove();
		$(".body-iframe").each(function() {
			if ($(this).data("id") == url) {
				$(this).remove();
				return false
			}
		});
		addTab($(".content-tab.active"))
	}
	return false
}


/**
 * 关闭tab  
 * @param $obj_a a标签对象
 * @returns
 */
function closePage2($obj_a) {
	var url = $obj_a.data("id");
	var cur_width = $obj_a.width();
	if ($obj_a.hasClass("active")) {
		if ($obj_a.next(".content-tab").size()) {
			var next_url = $obj_a.next(".content-tab:eq(0)").data("id");
			$obj_a.next(".content-tab:eq(0)").addClass("active");
			var next_obj = $obj_a.next(".content-tab:eq(0)");
			$(".body-iframe").each(function() {
				if ($(this).data("id") == next_url) {
					$(this).show().siblings(".body-iframe").hide();
					return false
				}
			});
			var n = parseInt($(".tab-nav-content").css("margin-left"));
			if (n < 0) {
				$(".tab-nav-content").animate({
					marginLeft: (n + cur_width) + "px"
				},
				"fast")
			}
			$obj_a.remove();
			$(".body-iframe").each(function() {
				if ($(this).data("id") == url) {
					$(this).remove();
					return false
				}
			})
			
			$("#tytabbottomsepar").css("width",next_obj.width()+2*tab_padding_common_arg);
			
		}
		if ($obj_a.prev(".content-tab").size()) {
			var prev_url = $obj_a.prev(".content-tab:last").data("id");
			var pre_width = $obj_a.prev(".content-tab:last").width()+2*tab_padding_common_arg;
			$obj_a.prev(".content-tab:last").addClass("active");
			$(".body-iframe").each(function() {
				if ($(this).data("id") == prev_url) {
					$(this).show().siblings(".body-iframe").hide();
					return false
				}
			});
			$obj_a.remove();
			$(".body-iframe").each(function() {
				if ($(this).data("id") == url) {
					$(this).remove();
					return false
				}
			})
			$("#tytabbottomsepar").css("left",getTabActiveBarLeft()-pre_width);
			$("#tytabbottomsepar").css("width",pre_width);
		}
	} else {
		$obj_a.remove();
		$(".body-iframe").each(function() {
			if ($(this).data("id") == url) {
				$(this).remove();
				return false
			}
		});
		addTab($(".content-tab.active"))
	}
	return false;
}

/*循环菜单*/
function initMenu(menu,parent){
	for(var i=0; i<menu.length; i++){   
		var item = menu[i];
		var str = "";
		try{
			if(item.isHeader == "1"){
				str = "<li class='menu-header'><i  style='background-image:url("+item.icon+");'>&nbsp;&nbsp;&nbsp;&nbsp;</i>"+item.name+"</li>";
				//$(parent).append(str);
				if(item.childMenus != ""){
					initMenu(item.childMenus,parent);
				}
			}else{
				//item.icon = "&nbsp;&nbsp;&nbsp;&nbsp;" ;
				if(item.childMenus == ""){
					str = "<li><a href='"+item.url+"'><i  style='background-image:url("+item.icon+");'>&nbsp;&nbsp;&nbsp;&nbsp;</i><span>"+item.name+"</span></a></li>";
					$(parent).append(str);
				}else{
					str = "<li><a href='"+item.url+"'><i style='background-image:url("+item.icon+");'>&nbsp;&nbsp;&nbsp;&nbsp;</i><span>"+item.name+"</span><i class='icon-font icon-right'>&#xe501;</i></a>";
					str +="<ul class='menu-item-child' id='menu-child-"+item.id+"'></ul></li>";
					$(parent).append(str);
					var childParent = $("#menu-child-"+item.id);
					initMenu(item.childMenus,childParent);
				}
			}
		}catch(e){}
	}
}



/*头部下拉框移入移出*/
$(document).on("mouseenter",".header-bar-nav",function(){
	$(this).addClass("open");
});
$(document).on("mouseleave",".header-bar-nav",function(){
	$(this).removeClass("open");
});

/*左侧菜单展开和关闭按钮事件*/
$(document).on("click",".layout-side-arrow",function(){
	if($(".layout-side").hasClass("close")){
		$(".layout-side").removeClass("close");
		$(".layout-main").removeClass("full-page");
		$(".layout-footer").removeClass("full-page");
		$(this).removeClass("close");
		$(".layout-side-arrow-icon").removeClass("close");
	}else{
		$(".layout-side").addClass("close");
		$(".layout-main").addClass("full-page");
		$(".layout-footer").addClass("full-page");
		$(this).addClass("close");
		$(".layout-side-arrow-icon").addClass("close");
	}
});

/*头部菜单按钮点击事件*/
$(".header-menu-btn").click(function(){
	$(".layout-side").removeClass("close");
	$(".layout-main").removeClass("full-page");
	$(".layout-footer").removeClass("full-page");
	$(".layout-side-arrow").removeClass("close");
	$(".layout-side-arrow-icon").removeClass("close");
	
	$(".layout-side").slideToggle();
});

/*左侧菜单响应式*/
$(window).resize(function() {  
	var width = $(this).width();  
	if(width >= 750){
		$(".layout-side").show();
	}else{
		$(".layout-side").hide();
	}
});

/*皮肤选择*/
$(".dropdown-skin li a").click(function(){
	var v = $(this).attr("data-val");
	var hrefStr=$("#layout-skin").attr("href");
	var hrefRes=hrefStr.substring(0,hrefStr.lastIndexOf('skin/'))+'skin/'+v+'/skin.css';
	$(window.frames.document).contents().find("#layout-skin").attr("href",hrefRes);
	setCookie("scclui-skin", v);
});

/*获取cookie中的皮肤*/
function getSkinByCookie(){
	var v = getCookie("scclui-skin");
	var hrefStr=$("#layout-skin").attr("href");
	if(v == null || v == ""){
		v="qingxin";
	}
	if(hrefStr != undefined){
		var hrefRes=hrefStr.substring(0,hrefStr.lastIndexOf('skin/'))+'skin/'+v+'/skin.css';
		$("#skin").attr("href",hrefRes);
	}
}

/*随机颜色*/
function getMathColor(){
	var arr = new Array();
	arr[0] = "#ffac13";
	arr[1] = "#83c44e";
	arr[2] = "#2196f3";
	arr[3] = "#e53935";
	arr[4] = "#00c0a5";
	arr[5] = "#16A085";
	arr[6] = "#ee3768";

	var le = $(".menu-item > a").length;
	for(var i=0;i<le;i++){
		var num = Math.round(Math.random()*5+1);
		var color = arr[num-1];
		$(".menu-item > a").eq(i).find("i:first").css("color",color);
	}
}

$(function(){
	//通过遍历给菜单项加上data-index属性
	$(".F_menuItem").each(function (index) {
	    if (!$(this).attr('index')) {
	        $(this).attr('data-index', index);
	    }
	});
})

/*
  初始化加载
*/
/*$(function(){
	获取皮肤
	//getSkinByCookie();

	菜单json
	var menu = [{"id":"1","name":"主菜单","parentId":"0","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"1","childMenus":[
					{"id":"3","name":"商品管理","parentId":"1","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":[
						{"id":"4","name":"品牌管理","parentId":"3","url":"test1.html","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":""},
						{"id":"5","name":"分类管理","parentId":"3","url":"test2.html","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":""}
					]},
					{"id":"6","name":"订单管理","parentId":"1","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":[
						{"id":"7","name":"已付款","parentId":"6","url":"home3.html","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":""},
						{"id":"8","name":"未付款","parentId":"6","url":"home4.html","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":""}
					]},
					{"id":"9","name":"新功能","parentId":"1","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":""},
					{"id":"10","name":"多级","parentId":"1","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":[
						{"id":"11","name":"一级","parentId":"10","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":""},
						{"id":"12","name":"一级","parentId":"10","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":[
							{"id":"13","name":"二级","parentId":"12","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":""},
							{"id":"14","name":"二级","parentId":"12","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":[
								{"id":"15","name":"三级","parentId":"14","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":""},
								{"id":"16","name":"三级","parentId":"14","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":[
									{"id":"17","name":"四级","parentId":"16","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":""},
									{"id":"18","name":"四级","parentId":"16","url":"","icon":"../common/icon/house.png","order":"1","isHeader":"0","childMenus":""}
								]}
							]}
						]}
					]}
				]}
				];
//	initMenu(menu,$(".side-menu"));
	//$(".side-menu > li").addClass("menu-item");
	
	获取菜单icon随机色
	//getMathColor();
});*/ 