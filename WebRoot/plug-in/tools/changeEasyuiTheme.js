//<a href="#" onclick="changeThemeFun('default')">默认|</a><a href="#" onclick="changeThemeFun('green')">绿|</a><a href="#" onclick="changeThemeFun('gray')">灰|</a><a href="#" onclick="changeThemeFun('pink')">红|</a><a href="#" onclick="changeThemeFun('orange')">橘黄|</a>
function changeThemeFun(themeName) {/* 更换主题 */
	var $easyuiTheme = $('#easyuiTheme');
	var url = $easyuiTheme.attr('href');
	var href = url.substring(0, url.indexOf('themes')) + 'themes/' + themeName + '/easyui.css';
	$easyuiTheme.attr('href', href);

	var $iframe = $('iframe');
	if ($iframe.length > 0) {
		for ( var i = 0; i < $iframe.length; i++) {
			var ifr = $iframe[i];
			$(ifr).contents().find('#easyuiTheme').attr('href', href);
		}
	}

	$.cookie('easyuiThemeName', themeName, {
		expires : 7
	});
};
if ($.cookie('easyuiThemeName')) {
	changeThemeFun($.cookie('easyuiThemeName'));
}