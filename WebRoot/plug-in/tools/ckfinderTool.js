function decode(value, id) {// value传入值,id接受值
	var last = value.lastIndexOf("/");
	var filename = value.substring(last + 1, value.length);
	$("#" + id).text(decodeURIComponent(filename));
}
function browse(inputId, file, type) {// 文件管理器，可多个上传共用
	var finder = new CKFinder();
	finder.selectActionFunction = function(fileUrl, data) {// 设置文件被选中时的函数
		$("#" + inputId).attr("value", fileUrl);
		if ("Images" != type) { // equals函数无效? 改为符号判断 --- Alexander
			$("#" + file).attr("href", fileUrl);
			decode(fileUrl, file);
		} else {
			$("#" + file).attr("src", fileUrl);
			$("#" + file).attr("hidden", false);
		}
	};
	finder.resourceType = type;// 指定ckfinder只为type进行管理
	finder.selectActionData = inputId; // 接收地址的input ID
	finder.removePlugins = 'help';// 移除帮助(只有英文)
	finder.defaultLanguage = 'zh-cn';
	finder.popup();
}