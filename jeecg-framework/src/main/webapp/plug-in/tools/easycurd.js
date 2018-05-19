/**
 * 刪除請求
 * 
 * @param url
 * @param index
 */
function Del(url, index) {
	$.messager.confirm('删除提示', '你确定永久删除该数据吗?', function(r) {
		if (r) {
			delSubmit(url, index);
		}
	});
}
$(function() {
	$.messager.defaults = {
		ok : "确定",
		cancel : "取消"
	};
});
/**
 * 执行方法前询问
 * 
 * @param url
 * @param index
 */
function confirm(url, message, index) {
	$.messager.confirm('提示信息', message, function(r) {
		if (r) {
			changeStatus(url, index);
		}

	});
}
/**
 * 執行保存
 * 
 * @param url
 * @param gridname
 */
function saveDeclare(url) {
	$('#fm').form('submit', {
		url : url,
		onSubmit : function() {
			return $(this).form('validate');
		},
		success : function(r) {
			$("#test").dialog("close");
			reloadTable();

		}
	});
}

/**
 * 添加
 * 
 * @param title
 * @param addurl
 * @param saveurl
 * @param id
 * @param gridname
 */
function add(title, addurl, saveurl) {
	openaddorupwin(title, addurl, saveurl);
}
/**
 * 更新
 * 
 * @param title
 * @param addurl
 * @param saveurl
 * @param id
 * @param gridname
 */
function update(title, addurl, saveurl, id) {
	var val = getSelected(id);
	if (val == '') {
		$.messager.show({
			title : title,
			msg : '请选择编辑项目',
			timeout : 2000,
			showType : 'slide'
		});
		return;
	}
	addurl += '&' + id + '=' + val;
	openaddorupwin(title, addurl, saveurl);
}
/**
 * 添加更新打開窗口
 * 
 * @param title
 * @param addurl
 * @param saveurl
 * @param id
 * @param gridname
 */
function openaddorupwin(title, addurl, saveurl) {
	$.createWin({
		title : title,
		winId : 'test',
		url : addurl,
		height : 420,
		target : 'body',
		width : 650,
		iconCls : 'icon-save',
		modal : false,
		buttons : [ {
			text : '确定',
			iconCls : 'icon-ok',
			handler : function() {
				saveDeclare(saveurl);
			}
		}, {
			text : '重置',
			iconCls : 'icon-cancel',
			handler : function() {
				$("#test").dialog("close");

			}
		} ],
		onComplete : function() {
		}
	// tools:[{iconCls:"icon-add"}],
	// toolbar:[{text:'按钮',iconCls:"icon-add"}]
	});
}

/**
 * 添加活更新打開窗口
 * 
 * @param title
 * @param addurl
 * @param saveurl
 * @param id
 * @param gridname
 */
function openwin(title, addurl, width, height) {
	$.createWin({
		title : title,
		winId : 'test',
		url : addurl,
		width : width === undefined ? 500 : width,
		height : height === undefined ? 300 : height,
		target : 'body',
		iconCls : 'icon-save',
		modal : true,
		onComplete : function() {
		}
	});
}
/**
 * 执行询问方法
 * 
 * @param url
 * @param index
 */
function changeStatus(url, index) {
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		url : url,// 请求的action路径
		error : function() {// 请求失败处理函数
		},
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success) {
				$.messager.show({
					title : '提示消息',
					msg : '提交成功',
					timeout : 2000,
					showType : 'slide'
				});
				reloadTable();
			}
		}
	});
}
/**
 * 删除执行
 * 
 * @param url
 * @param index
 */
function delSubmit(url, index) {
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		url : url,// 请求的action路径
		error : function() {// 请求失败处理函数
		},
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success) {
				$.messager.show({
					title : '提示消息',
					msg : '删除成功',
					timeout : 2000,
					showType : 'slide'
				});
				reloadTable();
			}
		}
	});
}
/**
 * 窗口打开
 */
$(function() {
	$('body').append(
			'<div id="myWindow" class="easyui-dialog" closed="true"></div>');
});
function openwindow(title, href, width, height, modal, minimizable, maximizable) {

	var $win;
	$win = $('#myWindow').dialog(
			{
				title : title,
				width : width === undefined ? 600 : width,
				height : height === undefined ? 400 : height,
				top : ($(window).height() - 420) * 0.5,
				left : ($(window).width() - 350) * 0.5,

				content : '<iframe scrolling="no" frameborder="0" src="' + href
						+ '" style="width:100%;height:100%;"></iframe>',
				// href : href === undefined ? null : href,
				modal : modal === undefined ? true : modal,
				minimizable : minimizable === undefined ? false : minimizable,
				maximizable : maximizable === undefined ? false : maximizable,
				shadow : true,
				cache : false,
				closed : false,
				collapsible : false,
				draggable : true,
				resizable : true,
				loadingMessage : '正在加载数据，请稍等片刻......',
				buttons : [ {
					text : '关闭',
					iconCls : "icon-add",
					handler : function() {
						$("#myWindow").dialog("close");
					}
				} ]
			});
}
/**
 * 模板页面ajax提交
 * 
 * @param url
 * @param gridname
 */
function ajaxdoSub(url, formname) {
	$('#' + formname).form('submit', {
		url : url,
		onSubmit : function() {
			$("#infocontent").val($('#content').html());
		},
		success : function(r) {
			$.messager.show({
				title : '提示消息',
				msg : '保存成功',
				timeout : 2000,
				showType : 'slide'
			});
		}
	});
}
/**
 * ajax提交FORM
 * 
 * @param url
 * @param gridname
 */
function ajaxdoForm(url, formname) {
	$('#' + formname).form('submit', {
		url : url,
		onSubmit : function() {
		},
		success : function(r) {
			$.messager.show({
				title : '提示消息',
				msg : '保存成功',
				timeout : 2000,
				showType : 'slide'
			});
		}
	});
}