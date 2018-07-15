//初始化下标
function resetTrNum(tableId) {
	$tbody = $("#" + tableId + "");
	$tbody
			.find('>tr')
			.each(
					function(i) {
						$(':input, select,button,a', this)
								.each(
										function() {
											var $this = $(this), name = $this
													.attr('name'), id = $this
													.attr('id'), onclick_str = $this
													.attr('onclick'), val = $this
													.val();
											if (name != null) {
												if (name.indexOf("#index#") >= 0) {
													$this.attr("name", name
															.replace('#index#',
																	i));
												} else {
													var s = name.indexOf("[");
													var e = name.indexOf("]");
													var new_name = name
															.substring(s + 1, e);
													$this.attr("name", name
															.replace(new_name,
																	i));
												}
											}
											if (id != null) {
												if (id.indexOf("#index#") >= 0) {
													$this.attr("id", id
															.replace('#index#',
																	i));
												} else {
													var s = id.indexOf("[");
													var e = id.indexOf("]");
													var new_id = id.substring(
															s + 1, e);
													$this
															.attr(
																	"id",
																	id
																			.replace(
																					new_id,
																					i));
												}
											}
											if (onclick_str != null) {
												if (onclick_str
														.indexOf("#index#") >= 0) {
													$this
															.attr(
																	"onclick",
																	onclick_str
																			.replace(
																					/#index#/g,
																					i));
												} else {
												}
											}
										});
						$(this).find('div[name=\'xh\']').html(i + 1);
					});
}
// 通用弹出式文件上传
function commonUpload(callback, inputId) {
	$.dialog({
		content : "url:systemController.do?commonUpload",
		lock : true,
		title : "文件上传",
		zIndex : getzIndex(),
		width : 700,
		height : 200,
		parent : windowapi,
		cache : false,
		ok : function() {
			var iframe = this.iframe.contentWindow;
			iframe.uploadCallback(callback, inputId);
			return true;
		},
		cancelVal : '关闭',
		cancel : function() {
		}
	});
}
// 通用弹出式文件上传-回调
function commonUploadDefaultCallBack(url, name, inputId) {
	$("#" + inputId + "_href").attr('href', url).html('下载');
	$("#" + inputId).val(url);
}
function browseImages(inputId, Img) {// 图片管理器，可多个上传共用
}
function browseFiles(inputId, file) {// 文件管理器，可多个上传共用
}
function decode(value, id) {// value传入值,id接受值
	var last = value.lastIndexOf("/");
	var filename = value.substring(last + 1, value.length);
	$("#" + id).text(decodeURIComponent(filename));
}

// 获取所有的表 添加到数组
function myFunction() {
	var arr = new Array();
	jQuery.each($(".tableList"), function(index, ipt) {
		arr.push($(ipt).val());
		for (var i = 0; i < arr.length; i++) {
			// debugger;
			if (arr[i] == null || arr[i] == "") {
				arr.splice(i, 1);
			}
		}
	});
	console.log(arr)
	return arr;
}
$(function() {
	$("input:radio[name='superQueryTableList[" + 0 + "].isMain']").attr(
			"readonly", "readonly");
	// 动态绑定事件 下拉框
	$("#add_superQueryField_table").on( "focus", "select.fieldTableList4", function() {
						var index = $(this).closest("tr").data("index");
						$( "select[name='superQueryFieldList[" + index + "].tableName']").empty();
						var list = myFunction();
						var content = "";
						for (var i = 0; i < list.length; i++) {
							content += '<option value=' + list[i] + '>'
									+ list[i] + '</option>';
							// $("select[name='superQueryFieldList["+i+"].tableName']").html(content);
						}
						$( "select[name='superQueryFieldList[" + index + "].tableName']").html(content);
					});
	// 单选框修改时的默认状态
	var $elements = $('.ismain');
	var len = ($elements.length / 2 - 1);
	for (var i = 0; i < len; i++) {
		if (i == 0) {
			$("input:radio[name='superQueryTableList[" + 0 + "].isMain']")
					.attr("readonly", true);
			// $("input:radio[name='superQueryTableList["+0+"].isMain']").val("Y");
			$("input[name='superQueryTableList[" + 0 + "].fkField']").attr(
					'disabled', true);
		}/*
			 * else{ var va=
			 * $("input:radio[name='superQueryTableList["+i+"].isMain']:checked").val();
			 * if(va=="Y"){
			 * $("input[name='superQueryTableList["+i+"].fkField']").eq(0).attr('disabled',true); } }
			 */
	}

	// 单选框
	$("#add_superQueryTable_table").on(
			"click",
			"input.ismain",
			function() {
				// 获取下标
				var index = $(this).closest("tr").data("index");
				// 是否被选中
				var val = $(
						"input:radio[name='superQueryTableList[" + index + "].isMain']:checked").val();
				// 如果被选为:"是" 当前行外键字段输入框不能输入 其他所有的单选都置为false
				/*
				 * if (val=="Y") { //只能选择一个 "是" var $elements = $('.ismain');
				 * var len = ($elements.length/2-1); for(var i = 0; i <=len;
				 * i++) {
				 * $("input:radio[name='superQueryTableList["+i+"].isMain']").eq(0).removeAttr("checked");
				 * $("input:radio[name='superQueryTableList["+i+"].isMain']").eq(1).attr("checked",true);
				 * $("input[name='superQueryTableList["+i+"].fkField']").attr('disabled',false); }
				 * $("input[name='superQueryTableList["+index+"].fkField']").attr('disabled',true);
				 * $("input:radio[name='superQueryTableList["+index+"].isMain']").eq(0).attr("checked",true);
				 * }else{ //如果被选为:"否" 外键字段输入框可以输入
				 * $("input[name='superQueryTableList["+index+"].fkField']").attr('disabled',false); }
				 */
				// debugger;
				var $elements = $('.ismain');
				var len = ($elements.length / 2 - 1);
				for (var i = 1; i <= len; i++) {

					if (val == "Y") {
						$(
								"input:radio[name='superQueryTableList[" + i
										+ "].isMain'] ").eq(1).attr("checked",
								true);
						$(
								"input:radio[name='superQueryTableList[" + i
										+ "].isMain'] ").eq(1).val("N");
						$(
								"input:radio[name='superQueryTableList[" + i
										+ "].isMain'] ").attr("readonly",
								"readonly");
					}
					if (val == "N") {
						// $("input:radio[name='superQueryTableList["+i+"].isMain']
						// ").attr("checked",true);
						$(
								"input:radio[name='superQueryTableList[" + i
										+ "].isMain'] ").attr("readonly",
								"readonly");
					}
				}

			})
});
