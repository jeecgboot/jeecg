$(function() {
	$("#nav").hide();
	//easy ui树加载会在文档加载完执行,所以初始化菜单要延迟一秒 by jueyue
	// update-start--Author:gaofeng  Date:2014-01-09：由于不需展示左侧的树，因此降低刷新的延迟时间  
	setTimeout(InitLeftMenu,100);
	//update-start--Author:gaofeng  Date:2014-01-09：由于不需展示左侧的树，因此降低刷新的延迟时间 
	tabClose();
	tabCloseEven();
	// 释放内存
	$.fn.panel.defaults = $.extend({}, $.fn.panel.defaults, {
		onBeforeDestroy : function() {
			var frame = $('iframe', this);
			if (frame.length > 0) {
				//frame[0].contentWindow.document.write('');
				frame[0].contentWindow.close();
				frame.remove();
			}
			if ($.browser.msie) {
				CollectGarbage();
			}
		}
	});
	
	  $('#maintabs').tabs({ onSelect : function(title) {
	  	rowid="";
	  } });

});

var rowid="";
// 初始化左侧
function InitLeftMenu() {
	// update-start--Author:刘洋  Date:2015-04-11 for:修改左侧菜单栏，当侧拉左侧菜单栏宽度，菜单高度不能自适应的问题
	var navaa=$("#nav .panel");
    var winheight = document.body.clientHeight - 157;
    navaa.find(".panel-body").panel({//左侧菜单 宽度拉伸，自动调整
    	onResize:function(){ navaa.find(".panel-body").css("height",winheight); }
    });
    // update-end--Author:刘洋  Date:2014-04-11 for:修改左侧菜单栏，当侧拉左侧菜单栏宽度，菜单高度不能自适应的问题
	
	$('.easyui-accordion li div').click(function() {
		$('.easyui-accordion li div').removeClass("selected");
		$(this).parent().addClass("selected");
	}).hover(function() {
		$(this).parent().addClass("hover");
	}, function() {
		$(this).parent().removeClass("hover");
	});
	
	// update-start--Author:gaofeng  Date:2014-01-09 for:新增首页风格,一级菜单点击事件的切换操作
	 $(".shortcut li").live("click",function(){
	   $(this).find(".imag1").hide();
	   $(this).find(".imag2").show();
	   $(this).siblings().find(".imag2").hide();
	   $(this).siblings().find(".imag1").show();
	    var navaa=$("#nav .panel");
	    navaa.hide();
	    navaa.eq($(this).index()).show();//获取第几个一级菜单，并与之对应
	    navaa.find(".panel-header").hide();
	    navaa.find(".panel-body").show().css("border-bottom","0px").css("height","auto");
	    var winheight = document.body.clientHeight - 157;//计算左侧二级菜单的行高度，以便自动判断是否需要滚动条
	    navaa.find(".panel-body").css("height",winheight);
	 });
	// update-end--Author:gaofeng  Date:2014-01-09 for:新增首页风格,一级菜单点击事件的切换操作

	// begin author：屈然博 2013-8-04 for：避免监听树自带三角点击事件
	$('.easyui-tree').tree({
		onClick: function(node){
			openThisNoed(node);
		}
	});
	// begin author：屈然博 2013-8-04 for：避免监听树自带三角点击事件
    $.ajax({
        url: "loginController.do?primaryMenu",
        async:false,
        success: function (data) {
//            update-begin--Author:zhangguoming  Date:20140429 for：一级菜单右侧有双引号，且在ie下样式错位
//            $(".shortcut").html(data);
            $(".shortcut").html(data.replaceAll("\"", ""));
//            update-end--Author:zhangguoming  Date:20140429 for：一级菜单右侧有双引号，且在ie下样式错位
        }
    });
	// update-start--Author:Peak  Date:2014-01-09：新增首页风格,初始化第一个菜单的内容显示
	$(".shortcut li").eq(0).trigger("click");
	//update-end--Author:Peak  Date:2014-01-09：新增首页风格,初始化第一个菜单的内容显示
	$("#nav").show();
}

function openThisNoed(node) {
	
	if(node.state == "open"){
		$('.easyui-tree').tree('collapse', node.target);
		return;
	}
	var children = $('.easyui-tree').tree('getChildren', node.target);
	var pnode = null;
	try{
		pnode = $('.easyui-tree').tree('getParent', node.target);
	}catch(e){}
	if (pnode && children && children.length > 0) {
		$(pnode).each(function() {
					$('.easyui-tree').tree('collapse', this);
				});
		$('.easyui-tree').tree('expand', node.target);
	} else if (children && children.length > 0) {
		$('.easyui-tree').tree('collapseAll');
		$('.easyui-tree').tree('expand', node.target);
	}
	// begin author：屈然博 2013-7-12 for：叶子节点扩大点击范围
	if (children = null || children.length == 0) {
		var fun = $(node.target).find('a').attr("onclick");
		var params = fun.substring(7, fun.length - 1).replaceAll("'", "")
				.split(",");
		addTab(params[0], params[1], params[2]);
	}
	// end author：屈然博 2013-7-12 for：叶子节点扩大点击范围
	
}

String.prototype.replaceAll = function(s1,s2) { 
    return this.replace(new RegExp(s1,"gm"),s2); 
};
// 获取左侧导航的图标
function getIcon(menuid) {
	var icon = 'icon ';
	$.each(_menus.menus, function(i, n) {
		$.each(n.menus, function(j, o) {
			if (o.menuid == menuid) {
				icon += o.icon;
			}
		});
	});

	return icon;
}

function addTab(subtitle, url, icon) {
	// begin author：屈然博 2013-7-12 for：解决firefox 点击一次请求两次的问题
	var progress = $("div.messager-progress");
	if(progress.length){return;}
	// begin author：屈然博 2013-7-12 for：解决firefox 点击一次请求两次的问题
	rowid="";
	$.messager.progress({
		text : loading,
		interval : 200
	});
	if (!$('#maintabs').tabs('exists', subtitle)) {
		//判断是否进行iframe方式打开tab，默认为href方式
		if(url.indexOf('isHref') != -1){
			$('#maintabs').tabs('add', {
				title : subtitle,
				href : url,
				closable : true,
				icon : icon
			});		
		}else{
			$('#maintabs').tabs('add', {
				title : subtitle,
				content : '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:99.4%;"></iframe>',
				closable : true,
				icon : icon
			});		
		}

	} else {
		$('#maintabs').tabs('select', subtitle);
		$.messager.progress('close');
	}

	// $('#maintabs').tabs('select',subtitle);
	tabClose();

}
var title_now;
function addLeftOneTab(subtitle, url, icon) {
	rowid="";
	if ($('#maintabs').tabs('exists', title_now)) {
		$('#maintabs').tabs('select', title_now);
			if(title_now!=subtitle)
			{
			addmask();
			$('#maintabs').tabs('update', {
				tab : $('#maintabs').tabs('getSelected'),
				options : {
					title : subtitle,
					href : url,
					cache:false,
					closable : false,
					icon : icon
				}
			});
		}
	} else {
		addmask();
		$('#maintabs').tabs('add', {
			title : subtitle,
			href : url,
			closable : false,
			icon : icon
		});
	}
	if ($.browser.msie) {
		CollectGarbage();
	}
	title_now = subtitle;
	// $('#maintabs').tabs('select',subtitle);
	// tabClose();

}
function addmask() {
	$.messager.progress({
		text : loading,
		interval : 100
	});
}
function createFrame(url) {
	var s = '<iframe name="tabiframe" id="tabiframe"  scrolling="no" frameborder="0"  src="'+url+'" style="width:100%;height:99.5%;overflow-y:hidden;"></iframe>';
	return s;
}

function tabClose() {
	/* 双击关闭TAB选项卡 */
	$(".tabs-inner").dblclick(function() {
		var subtitle = $(this).children(".tabs-closable").text();
		$('#tabs').tabs('close', subtitle);
	})
	/* 为选项卡绑定右键 */
	$(".tabs-inner").bind('contextmenu', function(e) {
		$('#mm').menu('show', {
			left : e.pageX,
			top : e.pageY
		});

		var subtitle = $(this).children(".tabs-closable").text();

		$('#mm').data("currtab", subtitle);
		// $('#maintabs').tabs('select',subtitle);
		return false;
	});
}
// 绑定右键菜单事件
function tabCloseEven() {
	// 刷新
	$('#mm-tabupdate').click(function() {
		var currTab = $('#maintabs').tabs('getSelected');
		var url = $(currTab.panel('options').content).attr('src');
		$('#maintabs').tabs('update', {
			tab : currTab,
			options : {
				content : createFrame(url)
			}
		})
	})
	// 关闭当前
	$('#mm-tabclose').click(function() {
		var currtab_title = $('#mm').data("currtab");
		$('#maintabs').tabs('close', currtab_title);
	})
	// 全部关闭
	$('#mm-tabcloseall').click(function() {
		$('.tabs-inner span').each(function(i, n) {
			var t = $(n).text();
//            update-begin--Author:zhangguoming  Date:20140905 for：不关闭首页
            if (t != '首页') {
                $('#maintabs').tabs('close', t);
            }
//            update-end--Author:zhangguoming  Date:20140905 for：不关闭首页
		});
	});
	// 关闭除当前之外的TAB
	$('#mm-tabcloseother').click(function() {
		$('#mm-tabcloseright').click();
		$('#mm-tabcloseleft').click();
	});
	// 关闭当前右侧的TAB
	$('#mm-tabcloseright').click(function() {
		var nextall = $('.tabs-selected').nextAll();
		if (nextall.length == 0) {
			// msgShow('系统提示','后边没有啦~~','error');
			alert('后边没有啦~~');
			return false;
		}
		nextall.each(function(i, n) {
			var t = $('a:eq(0) span', $(n)).text();
			$('#maintabs').tabs('close', t);
		});
		return false;
	});
	// 关闭当前左侧的TAB
	$('#mm-tabcloseleft').click(function() {
		var prevall = $('.tabs-selected').prevAll();
		if (prevall.length == 0) {
			alert('到头了，前边没有啦~~');
			return false;
		}
		prevall.each(function(i, n) {
			var t = $('a:eq(0) span', $(n)).text();
//            update-begin--Author:zhangguoming  Date:20140612 for：不关闭首页
            if (t != '首页') {
                $('#maintabs').tabs('close', t);
            }
//            update-end--Author:zhangguoming  Date:20140612 for：不关闭首页
		});
		return false;
	});

	// 退出
	$("#mm-exit").click(function() {
		$('#mm').menu('hide');
	});
}

$.parser.onComplete = function() {/* 页面所有easyui组件渲染成功后，隐藏等待信息 */
	if ($.browser.msie && $.browser.version < 7) {/* 解决IE6的PNG背景不透明BUG */
	}
	window.setTimeout(function() {
		$.messager.progress('close');
	}, 200);
};
