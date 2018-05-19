try {
$.fn.panel.defaults.onBeforeDestroy = function() {/* tab关闭时回收内存 */
	var frame = $('iframe', this);
		if (frame.length > 0) {
			frame[0].contentWindow.document.write('');
			frame[0].contentWindow.close();
			frame.remove();
			if ($.browser.msie) {
				CollectGarbage();
			}
		} else {
			$(this).find('.combo-f').each(function() {
				var panel = $(this).data().combo.panel;
				panel.panel('destroy');
			});
		}
};

$.parser.onComplete = function() {/* 页面所有easyui组件渲染成功后，隐藏等待信息 */
	if ($.browser.msie && $.browser.version < 7) {/* 解决IE6的PNG背景不透明BUG */
	}
	window.setTimeout(function() {
		try {
			window.top.$.messager.progress('close');
		} catch (e) {
		}
	}, 200);
};

} catch (e) {
}
