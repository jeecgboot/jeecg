$(function() {
	InitLeftMenu();
	tabClose();
	tabCloseEven();
	// 释放内存
	$.fn.panel.defaults = $.extend({}, $.fn.panel.defaults, {
		onBeforeDestroy : function() {
			var frame = $('iframe', this);
			if (frame.length > 0) {
				frame[0].contentWindow.document.write('');
				frame[0].contentWindow.close();
				frame.remove();
			}
			if ($.browser.msie) {
				CollectGarbage();
			}
		}
	});
	$('#maintabs').tabs({
		onSelect : function(title) {
			var currTab = $('#maintabs').tabs('getTab', title);
			var iframe = $(currTab.panel('options').content);
			var src = $("." + title).attr("href");
			currTab.find('iframe').attr('src', src);
		}
	});
});
// 初始化左侧
function InitLeftMenu() {
	$("#nav").accordion({
		animate : false
	});
	$.each(_menus.menus, function(i, n) {
		var menulist = '';
		menulist += '<ul>';
		$.each(n.menus, function(j, o) {
			menulist += '<li><div><a class="' + o.menuname
					+ '" target="tabiframe" ref="' + o.menuid + '" href="'
					+ o.url + '" ><span class="icon ' + o.icon
					+ '" >&nbsp;</span><span class="nav">' + o.menuname
					+ '</span></a></div></li> ';
		})
		menulist += '</ul>';

		$('#nav').accordion('add', {
			title : n.menuname,
			content : menulist,
			iconCls : 'icon ' + n.icon
		});

	});

	$('.easyui-accordion li a').click(function() {
		var tabTitle = $(this).children('.nav').text();

		var url = $(this).attr("href");
		var menuid = $(this).attr("ref");
		var icon = getIcon(menuid, icon);
		addOneTab(tabTitle, url, icon);
		$('.easyui-accordion li div').removeClass("selected");
		$(this).parent().addClass("selected");
	}).hover(function() {
		$(this).parent().addClass("hover");
	}, function() {
		$(this).parent().removeClass("hover");
	});

	// 选中第一个
	var panels = $('#nav').accordion('panels');
	var t = panels[0].panel('options').title;
	$('#nav').accordion('select', t);
}
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
	$.messager.progress({
		text : loading,
		interval : 1000
	});
	if (!$('#maintabs').tabs('exists', subtitle)) {
		$('#maintabs').tabs('add', {
			title : subtitle,
			content : createFrame(),
			closable : true,
			icon : icon
		});
	} else {
		$('#maintabs').tabs('select', subtitle);
		$.messager.progress('close');
	}

	// $('#maintabs').tabs('select',subtitle);
	tabClose();

}
var title_now;
function addOneTab(subtitle, url, icon) {
	$.messager.progress({
		text : loading,
		interval : 1000
	});
	if ($('#maintabs').tabs('exists', title_now)) {
		$('#maintabs').tabs('select', title_now);
		$('#maintabs').tabs('update', {
			tab : $('#maintabs').tabs('getSelected'),
			options : {
				title : subtitle,
				content : createFrame(),
				closable : false,
				icon : icon
			}
		});
	} else {
		$('#maintabs').tabs('add', {
			title : subtitle,
			content : createFrame(),
			closable : false,
			icon : icon
		});
	}
	title_now = subtitle;
	// $('#maintabs').tabs('select',subtitle);
	tabClose();

}

function createFrame() {
	var s = '<iframe name="tabiframe"  scrolling="no" frameborder="0"  src="about:blank" style="width:100%;height:99%;"></iframe>';
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
			$('#maintabs').tabs('close', t);
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
			$('#maintabs').tabs('close', t);
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
		sy.pngFun();
		sy.bgPngFun($('span'));
	}
	window.setTimeout(function() {
		$.messager.progress('close');
	}, 1000);
};
