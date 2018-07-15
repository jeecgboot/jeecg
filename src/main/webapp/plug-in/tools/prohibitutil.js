$(document).ready(function() {
	// 禁止右键
	$(document).bind("contextmenu", function() {
		return false;
	});
	// 禁止选择
	$(document).bind("selectstart", function() {
		return false;
	});
	// 禁止Ctrl+C 和Ctrl+A
	$(document).keydown(function(event) {

		if ((event.ctrlKey && event.which == 67) || (event.ctrlKey && event.which == 86)) {
			return false;
		}
		if ((event.ctrlKey) && (event.keyCode == 82)) {
			return false;
		}
		if (event.keyCode == 116) {
			return false; // 屏蔽F5刷新键
		}
		if (event.keyCode == 8) {
			return false; // 屏蔽退格删除键
		}
		if ((event.altKey) && ((event.keyCode == 37) || // 屏蔽 Alt+ 方向键 ←
		(event.keyCode == 39))) // 屏蔽 Alt+ 方向键 →
		{
			event.returnValue = false;
			return false;
		}

	});
});