/* 随机数*/
function getRandomId() {
	var Rand = Math.random();
	return (1 + Math.round(Rand * 99999));
}

//通用弹出式文件上传
function rowEditUpload(obj, input, isnew) {
	var content = "url:systemController.do?commonUpload";//老版上传走这个逻辑
	$.dialog({
		content : content,
		lock : true,
		title : "文件上传",
		zIndex : getzIndex(),
		width : 700,
		height : 200,
		parent : windowapi,
		cache : false,
		ok : function() {
			var iframe = this.iframe.contentWindow;
			var url = iframe.backOnlyUrl();
			$("input[id='" + input + "']").val(url);
			$(obj).html("<i class=\"fa fa-upload\"></i>重新上传");
			if ($(obj).next('.rowedit-file-tip').length == 0) {
				var container = $(obj).closest("td");
				$('<span class="rowedit-file-tip"><label class="upload-ok"><i>√</i></label></span>').appendTo(container);
			} else {
				$(obj).next('span.rowedit-file-tip').html('<label class="upload-ok"><i>√</i></label>');
			}
			return true;
		},
		cancelVal : '关闭',
		cancel : function() {
		}
	});
}


	$.extend($.fn.datagrid.defaults.editors,{
		filecontrol : {
			// 文件上传行编辑扩展
			init : function(container, options) {
				var input;
				var inp = 'tempfile_' + getRandomId();
				var btnclass = "rowedit-file-control";
				if (!!options && !!options.btnclass) {
					btnclass = options.btnclass;
				}
				if (!!options && options.control == 'uploadfy') {
					//TODO 老版上传在此写逻辑 一样是一个input和一个btn 
				} else {
					input = $('<input id="'+ inp+ '" type="hidden" class="filecontrol"/>').appendTo(container);
					var btn = $(
							'<a onclick="rowEditUpload(this,\''+ inp+ '\',\'1\')" class="'+ btnclass
									+ '" href="javascript:void(0);" style="text-decoration:none;margin-left:8px"><i class="fa fa-upload"></i>点击上传</a>')
							.appendTo(container);
				}
				return input;
			},
			getValue : function(target) {
				return $(target).parent().find('input.filecontrol').val();
			},
			setValue : function(target, value) {
				$(target).val(value);
			},
			resize : function(target, width) {
				var input = $(target);
				if ($.boxModel == true) {
					input.width(width- (input.outerWidth() - input.width()));
				} else {
					input.width(width);
				}
			}
		}
	});