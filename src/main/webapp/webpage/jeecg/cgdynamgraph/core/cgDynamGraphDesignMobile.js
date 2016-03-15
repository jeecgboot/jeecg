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
	DEFAULT_.width =$(document.body).width();
	DEFAULT_.height = $(window).height();
	DEFAULT_.render = 'canvasDiv';
	DEFAULT_.animation = ANIMATION_;
	DEFAULT_.shadow = SHADOW_;
	DEFAULT_.shadow_blur = 3;
	DEFAULT_.background_color = BACKGROUND_COLOR;
	DEFAULT_.footnote = "";
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

	var w = $(document.body).width();
	var datatype, type;
	$canvas = $("#canvasDiv");
	$(".gallery_draggable").click(function() {
		TYPE_ = $(this).attr('type');
		OPTION_ = $(this).attr('option');
		render();
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
