var DEFAULT_, 
OPTION_, 
TYPE_='Pie2D', 
TITLE_ = 'Online 动态图表配置',
DATA_, 
ANIMATION_ = true,
SHADOW_ = false, 
f = true, 
BACKGROUND_COLOR = '#FEFEFE',
COO_BACKGROUND_COLOR = '#FEFEFE', 
IMAGE_DATA = "";
 
var color = ['#a5c2d5', '#cbab4f', '#76a871', '#c12c44', '#9f7961', '#6f83a5'];
function doPie(){
	DEFAULT_ = {
		data : DATA_,
		sub_option : {
			label : {
				background_color : null,
				sign : false,
				padding : '0 4',
				border : {
					enable : false,
					color : '#666666'
				},
				fontsize : 12,
				fontweight : 600,
				color : '#982e35'
			}
		},
		showpercent : true,
		yHeight : 30,
		decimalsnum : 2
	};
}
function doColumn(){
	DEFAULT_ = {
			data : DATA_,
			text_space : TYPE_=='Column3D'?16:6,
			coordinate : {
				width : '86%',
				height : '80%',
				color_factor : 0.24,
				board_deep:10,//背面厚度
				pedestal_height:10,//底座高度
				left_board:false,//取消左侧面板
				axis : {
					color : '#c0d0e0',
					width : [0, 0, 1, 0]
				},
				scale : [{
					position : 'left',
					scale_enable : false,
					label : {
						fontsize : 11,
						color : '#4c4f48'
					}
				}]
			},
			label : {
				fontsize : 11,
				color : '#4c4f48'
			},
			zScale:0.5,
			bottom_scale:1.1,
			sub_option : {
				label : {
					fontsize : 11,
					fontweight : 600,
					color : '#4572a7'
				},
				border : {
					width : 2,
					color : '#ffffff'
				}
			}
		};
}
function doBar(){
	DEFAULT_ = {
			data : DATA_,
			coordinate : {
				width : '80%',
				height : '80%',
				axis : {
					color : '#c0d0e0',
					width:[1,1,1,4]
				},
				scale : [{
					position : 'bottom',
					scale_enable : false,
					label : {
						fontsize : 11,
						color : '#4c4f48'
					}
				}]
			},
			label : {
				fontsize : 11,
				color : '#4c4f48'
			},
			zScale:0.5,
			bottom_scale:1.1,
			sub_option : {
				label : {
					fontsize : 11,
					fontweight : 600,
					color : '#4572a7'
				},
				border : {
					width : 2,
					color : '#ffffff'
				}
			}
		};
}
function doLine(){
	var labels = [], data_l = [];
	for ( var i = 0; i < DATA_.length; i++) {
		labels.push(DATA_[i].name);
		data_l.push(DATA_[i].value);
	}
	if (data_l.length == 1) {
		alert("折线图至少需要2组数据才能画线哦!请定制数据或者选择其他图形.");
		return;
	}
	DEFAULT_ = {
		data_labels : labels,
		data : [{
			name : '',
			value : data_l,
			color : '#1f7e92',
			linewidth : 3
		}],

		labels:labels,

		sub_option : {
			label : {
				fontsize : 14,
				fontweight:600,
				color : '#4c4f48'
			},
			smooth : OPTION_ == '1',
			hollow_inside:false,
			point_size:16,
			hollow : true
		},
		coordinate : {
			width : '84%',
			height : '75%'
		}
	};
}
function doChart() {
	if (TYPE_ == 'Pie2D' || TYPE_ == 'Pie3D') {
		doPie();
	} else if (TYPE_ == 'Column2D' || TYPE_ == 'Column3D') {
		doColumn();
	} else if (TYPE_ == 'Bar2D') {
		doBar();
	} else if (TYPE_ == 'LineBasic2D' || TYPE_ == 'Area2D') {
		doLine();
	}
	if (TITLE_ != '') {
		DEFAULT_.title = TITLE_;
	}
	DEFAULT_.width = 800;
	DEFAULT_.height = 400;
	DEFAULT_.render = 'canvasDiv';
	DEFAULT_.animation = ANIMATION_;
	DEFAULT_.shadow = SHADOW_;
	DEFAULT_.shadow_blur = 3;
	DEFAULT_.background_color = BACKGROUND_COLOR;
	DEFAULT_.footnote = "Design by ichartjs";
	if (DEFAULT_.coordinate) {
		DEFAULT_.coordinate.background_color = COO_BACKGROUND_COLOR;
		DEFAULT_.coordinate.grid_color = iChart.dark(COO_BACKGROUND_COLOR, 0.3,0.1);
	}
	/**
	 * 使导出图片按钮有效
	 */
	DEFAULT_.listeners = {};
	DEFAULT_.listeners[ANIMATION_ ? 'afterAnimation' : 'draw'] = function(c) {
		download.disabled = false;
		IMAGE_DATA = this.target.canvas.toDataURL();
	}

	new iChart[TYPE_](DEFAULT_).draw();
}
function render() {
	if (!TYPE_)
		return;
	download.disabled = true;
	if (f) {
		doChart();
		f = false;
	} else {
		$canvas.fadeOut(300, function() {
			$(this).fadeIn(300);
			doChart();
		});
	}
}
var $form_tbody, $form_tr_temlate, $form_tr_head, $gallery_color_picker, $validateTips, download, download_a;
$(function() {
	$validateTips = $("#validateTips");
	$form_tbody = $("#form_tbody");
	download = document.getElementById("download");
	download_a = document.getElementById("download_a");
	$gallery_color_picker = $("#gallery_color_picker");
	$form_tr_temlate = $('<tr><td><input type="text" class="form_text" /></td><td><input type="text" class="form_text" /></td><td class="td_color"><input type="text" class="form_text"/></td><td><a href="javascript:void(0)" onclick="removeRow(this);">移除</a></td></tr>');
	$form_tr_head = $("#form_tr_head");

	$("#dialog-download").dialog({
		autoOpen : false,
		height : 448,
		width : 848,
		modal : true
	});

	$("#dialog-form").dialog({
		autoOpen : false,
		height : 400,
		width : 450,
		modal : true,
		buttons : {
			"应用我的数据" : function() {
				var title = $("#form_title").val();
				if (title == "") {
					$validateTips.html("提示:标题项不能为空!");
					return;
				}
				TITLE_ = title;

				var $inputs = $form_tbody.children("tr").find("input"), data = [], CHECK = true;
				for ( var i = 0; i < $inputs.length; i += 3) {
					if ($inputs[i].value == "" || $inputs[i + 1].value == "" || $inputs[i + 2].value == "") {
						CHECK = false;
						break;
					}
					data.push({
						name : $inputs[i].value,
						value : parseFloat($inputs[i + 1].value) || 0,
						color : $inputs[i + 2].value
					});
				}
				if (!CHECK) {
					$validateTips.html("提示:数据项不能为空!");
				} else {
					$validateTips.html("所有文本均为必填项.");
					DATA_ = data;
					render();
					$(this).dialog("close");
				}
			},
			'取消' : function() {
				$(this).dialog("close");
			}
		},
		close : function() {

		}
	}).click(function() {
		$gallery_color_picker.fadeOut();
	});

	var img = document.getElementById("canvas_img");
	var a_ = document.getElementById("download_a");

	$("#download").click(function(e) {
		if (iChart.isChrome) {
			a_.href = IMAGE_DATA;
		} else {
			img.src = IMAGE_DATA;
			$("#dialog-download").dialog("open");
			e.stopPropagation();
			e.preventDefault();
		}
	});

	var w = $(document.body).width();
	var datatype, type;
	$canvas = $("#canvasDiv");
	document.getElementById("gallery_animate").checked = true;
	document.getElementById("gallery_shadow").checked = false;
	download.disabled = true;
	h = 450;
	w = w - 280;
	w = w > 800 ? w : 800;
	$("#gallery_right_container").width(w).height(h);
	$("#gallery_right_bg").width(w).height(h);
	$("#gallery_preview").height(h);

	$(".draggable").draggable({
		helper : function(event) {
			return $(this).clone();
		},
		cursor : "move",
		stack : '#canvasDiv',
		cursorAt : {
			top : 25,
			left : 25
		},
		opacity : 0.7,
		start : function(event, ui) {
			type = $(this).attr('type');
			datatype = $(this).attr('datatype');
			TITLE_ = $(this).attr('title');
		}
	});

	$(".gallery_draggable").click(function() {
		TYPE_ = $(this).attr('type');
		OPTION_ = $(this).attr('option');
		render();
	});

	$("#gallery_right_bg").droppable({
		accept : ".draggable",
		hoverClass : "gallery_hover",
		drop : function(event, ui) {
			if (type == "data") {
				if (datatype == "2") {
					DATA_ = data2;
				} else if (datatype == "3") {
					DATA_ = data3;
				} else {
					DATA_ = data1;
				}
				if (!TYPE_)
					return;
			} else {
				TYPE_ = type;
			}
			render();
		}
	});

	$("#gallery_animate").click(function() {
		ANIMATION_ = this.checked;
		render();
	});

	$("#gallery_shadow").click(function() {
		SHADOW_ = this.checked;
		render();
	});

	$(".gallery_color").hover(function() {
		$(this).addClass("gallery_color_hover");
	}, function() {
		$(this).removeClass("gallery_color_hover");
	}).click(function() {
		if ($(this).attr('type') == "0") {
			BACKGROUND_COLOR = $(this).css('background-color');
			$(this).parents(".gallery_bg").css("background-color", BACKGROUND_COLOR);
		} else {
			COO_BACKGROUND_COLOR = $(this).css('background-color');
			$(this).parents(".gallery_bg").css("background-color", COO_BACKGROUND_COLOR);
		}
		render();
	});

	$(".gallery_bg").hover(function() {
		$(this).children(".gallery_bg_list").fadeIn();
	}, function() {
		$(this).children(".gallery_bg_list").fadeOut();
	});

	$("#custom-data").click(function() {
		$("#dialog-form").dialog("open");
	});
	var $current_color;
	$(".td_color .form_text").click(function(e) {
		$current_color = $(this);
		$gallery_color_picker.css("top", 6).fadeIn();

		e.stopPropagation();
	});

	$form_tr_temlate.find('.td_color .form_text').click(function(e) {
		$current_color = $(this);
		var i = $(this).parents("tr").prevAll().length;
		$gallery_color_picker.css("top", 6 + 29 * i).fadeIn();
		e.stopPropagation();
	});

	$("#gallery_color_picker .color").hover(function() {
		$(this).addClass("gallery_color_hover");
	}, function() {
		$(this).removeClass("gallery_color_hover");
	}).click(function() {
		var color = $(this).attr('color');
		$current_color.val(color);
		$current_color.parent("td").css("background-color", color);
	});

});
function addRow() {
	$form_tbody.append($form_tr_temlate.clone(true));
}
function removeRow(a) {
	$(a).parents("tr").remove();
}
