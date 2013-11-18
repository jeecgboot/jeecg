/*Copyright(c)2009,www.supersite.me*/var imageUrl = 'plug-in/iColorPicker/images/color.png';
function iColorShow(id, id2) {
	var eICP = jQuery("#" + id2).position();
	jQuery("#iColorPicker").css({
		'top' : eICP.top + (jQuery("#" + id).outerHeight()) + "px",
		'left' : (eICP.left+400) + "px",
		'position' : 'absolute'
	}).fadeIn("fast");
	jQuery("#iColorPickerBg").css({
		'position' : 'fixed',
		'top' : 0,
		'left' : 0,
		'width' : '100%',
		'height' : '100%'
	}).fadeIn("fast");
	var def = jQuery("#" + id).val();
	jQuery('#colorPreview span').text(def);
	jQuery('#colorPreview').css('background', def);
	jQuery('#color').val(def);
	var hxs = jQuery('#iColorPicker');
	for (i = 0; i < hxs.length; i++) {
		var tbl = document.getElementById('hexSection' + i);
		var tblChilds = tbl.childNodes;
		for (j = 0; j < tblChilds.length; j++) {
			var tblCells = tblChilds[j].childNodes;
			for (k = 0; k < tblCells.length; k++) {
				jQuery(tblChilds[j].childNodes[k]).unbind().mouseover(
						function(a) {
							var aaa = "#" + jQuery(this).attr('hx');
							jQuery('#colorPreview').css('background', aaa);
							jQuery('#colorPreview span').text(aaa)
						}).click(function() {
					var aaa = "#" + jQuery(this).attr('hx');
					jQuery("#" + id).val(aaa).css("background", aaa);
					jQuery("#iColorPickerBg").hide();
					jQuery("#iColorPicker").fadeOut();
					jQuery(this)
				})
			}
		}
	}
}
this.iColorPicker = function() {
	jQuery("input.iColorPicker")
			.each(
					function(i) {
						if (i == 0) {
							jQuery(document.createElement("div"))
									.attr("id", "iColorPicker")
									.css('display', 'none')
									.html(
											'<table class="pickerTable" id="pickerTable0"><thead id="hexSection0"><tr><td style="background:#f00;" hx="f00"></td><td style="background:#ff0" hx="ff0"></td><td style="background:#0f0" hx="0f0"></td><td style="background:#0ff" hx="0ff"></td><td style="background:#00f" hx="00f"></td><td style="background:#f0f" hx="f0f"></td><td style="background:#fff" hx="fff"></td><td style="background:#ebebeb" hx="ebebeb"></td><td style="background:#e1e1e1" hx="e1e1e1"></td><td style="background:#d7d7d7" hx="d7d7d7"></td><td style="background:#cccccc" hx="cccccc"></td><td style="background:#c2c2c2" hx="c2c2c2"></td><td style="background:#b7b7b7" hx="b7b7b7"></td><td style="background:#acacac" hx="acacac"></td><td style="background:#a0a0a0" hx="a0a0a0"></td><td style="background:#959595" hx="959595"></td></tr><tr><td style="background:#ee1d24" hx="ee1d24"></td><td style="background:#fff100" hx="fff100"></td><td style="background:#00a650" hx="00a650"></td><td style="background:#00aeef" hx="00aeef"></td><td style="background:#2f3192" hx="2f3192"></td><td style="background:#ed008c" hx="ed008c"></td><td style="background:#898989" hx="898989"></td><td style="background:#7d7d7d" hx="7d7d7d"></td><td style="background:#707070" hx="707070"></td><td style="background:#626262" hx="626262"></td><td style="background:#555" hx="555"></td><td style="background:#464646" hx="464646"></td><td style="background:#363636" hx="363636"></td><td style="background:#262626" hx="262626"></td><td style="background:#111" hx="111"></td><td style="background:#000" hx="000"></td></tr><tr><td style="background:#f7977a" hx="f7977a"></td><td style="background:#fbad82" hx="fbad82"></td><td style="background:#fdc68c" hx="fdc68c"></td><td style="background:#fff799" hx="fff799"></td><td style="background:#c6df9c" hx="c6df9c"></td><td style="background:#a4d49d" hx="a4d49d"></td><td style="background:#81ca9d" hx="81ca9d"></td><td style="background:#7bcdc9" hx="7bcdc9"></td><td style="background:#6ccff7" hx="6ccff7"></td><td style="background:#7ca6d8" hx="7ca6d8"></td><td style="background:#8293ca" hx="8293ca"></td><td style="background:#8881be" hx="8881be"></td><td style="background:#a286bd" hx="a286bd"></td><td style="background:#bc8cbf" hx="bc8cbf"></td><td style="background:#f49bc1" hx="f49bc1"></td><td style="background:#f5999d" hx="f5999d"></td></tr><tr><td style="background:#f16c4d" hx="f16c4d"></td><td style="background:#f68e54" hx="f68e54"></td><td style="background:#fbaf5a" hx="fbaf5a"></td><td style="background:#fff467" hx="fff467"></td><td style="background:#acd372" hx="acd372"></td><td style="background:#7dc473" hx="7dc473"></td><td style="background:#39b778" hx="39b778"></td><td style="background:#16bcb4" hx="16bcb4"></td><td style="background:#00bff3" hx="00bff3"></td><td style="background:#438ccb" hx="438ccb"></td><td style="background:#5573b7" hx="5573b7"></td><td style="background:#5e5ca7" hx="5e5ca7"></td><td style="background:#855fa8" hx="855fa8"></td><td style="background:#a763a9" hx="a763a9"></td><td style="background:#ef6ea8" hx="ef6ea8"></td><td style="background:#f16d7e" hx="f16d7e"></td></tr><tr><td style="background:#ee1d24" hx="ee1d24"></td><td style="background:#f16522" hx="f16522"></td><td style="background:#f7941d" hx="f7941d"></td><td style="background:#fff100" hx="fff100"></td><td style="background:#8fc63d" hx="8fc63d"></td><td style="background:#37b44a" hx="37b44a"></td><td style="background:#00a650" hx="00a650"></td><td style="background:#00a99e" hx="00a99e"></td><td style="background:#00aeef" hx="00aeef"></td><td style="background:#0072bc" hx="0072bc"></td><td style="background:#0054a5" hx="0054a5"></td><td style="background:#2f3192" hx="2f3192"></td><td style="background:#652c91" hx="652c91"></td><td style="background:#91278f" hx="91278f"></td><td style="background:#ed008c" hx="ed008c"></td><td style="background:#ee105a" hx="ee105a"></td></tr><tr><td style="background:#9d0a0f" hx="9d0a0f"></td><td style="background:#a1410d" hx="a1410d"></td><td style="background:#a36209" hx="a36209"></td><td style="background:#aba000" hx="aba000"></td><td style="background:#588528" hx="588528"></td><td style="background:#197b30" hx="197b30"></td><td style="background:#007236" hx="007236"></td><td style="background:#00736a" hx="00736a"></td><td style="background:#0076a4" hx="0076a4"></td><td style="background:#004a80" hx="004a80"></td><td style="background:#003370" hx="003370"></td><td style="background:#1d1363" hx="1d1363"></td><td style="background:#450e61" hx="450e61"></td><td style="background:#62055f" hx="62055f"></td><td style="background:#9e005c" hx="9e005c"></td><td style="background:#9d0039" hx="9d0039"></td></tr><tr><td style="background:#790000" hx="790000"></td><td style="background:#7b3000" hx="7b3000"></td><td style="background:#7c4900" hx="7c4900"></td><td style="background:#827a00" hx="827a00"></td><td style="background:#3e6617" hx="3e6617"></td><td style="background:#045f20" hx="045f20"></td><td style="background:#005824" hx="005824"></td><td style="background:#005951" hx="005951"></td><td style="background:#005b7e" hx="005b7e"></td><td style="background:#003562" hx="003562"></td><td style="background:#002056" hx="002056"></td><td style="background:#0c004b" hx="0c004b"></td><td style="background:#30004a" hx="30004a"></td><td style="background:#4b0048" hx="4b0048"></td><td style="background:#7a0045" hx="7a0045"></td><td style="background:#7a0026" hx="7a0026"></td></tr></thead><tbody><tr><td style="border:1px solid #000;background:#fff;cursor:pointer;height:60px;-moz-background-clip:-moz-initial;-moz-background-origin:-moz-initial;-moz-background-inline-policy:-moz-initial;" colspan="16" align="center" id="colorPreview"><span style="color:#000;border:1px solid rgb(0, 0, 0);padding:5px;background-color:#fff;font:11px Arial, Helvetica, sans-serif;"></span></td></tr></tbody></table><style>#iColorPicker input{margin:2px}</style>')
									.appendTo("body");
							jQuery(document.createElement("div")).attr("id",
									"iColorPickerBg").click(function() {
								jQuery("#iColorPickerBg").hide();
								jQuery("#iColorPicker").fadeOut()
							}).appendTo("body");
							jQuery('table.pickerTable td').css({
								'width' : '12px',
								'height' : '14px',
								'border' : '1px solid #000',
								'cursor' : 'pointer'
							});
							jQuery('#iColorPicker table.pickerTable').css({
								'border-collapse' : 'collapse'
							});
							jQuery('#iColorPicker').css({
								'border' : '1px solid #ccc',
								'background' : '#333',
								'padding' : '5px',
								'color' : '#fff',
								'z-index' : 9999
							})
						}
						jQuery('#colorPreview').css({
							'height' : '50px'
						});
						jQuery(this)
								.css("backgroundColor", jQuery(this).val())
								.after(
										'<a href="javascript:void(null)" id="icp_'
												+ this.id
												+ '" onclick="iColorShow(\''
												+ this.id
												+ '\',\'icp_'
												+ this.id
												+ '\')"><img src="'
												+ imageUrl
												+ '" style="border:0;margin:0 0 0 3px" align="absmiddle" ></a>')
					})
};
jQuery(function() {
	iColorPicker()
})