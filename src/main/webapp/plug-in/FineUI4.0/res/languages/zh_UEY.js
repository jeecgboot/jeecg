(function(F){
	$.extend(F.TabStrip.prototype,{
		closeTabText:"ئېتېكىتكىنى ئېتىش",
		closeOtherTabsText:"باشقا ئېتىكتىكىلارنى ئېتىش",
		closeAllTabsText:"بارلىق ئېتىكتىكىلانى ئېتىش"
	});
	
	$.extend(F.MessageBox.prototype,{
		buttonText:{
			ok:"مۇقىملاشتۇرۇش",
			yes:"ھەئە",
			no:"ياق",
			cancel:"بىكار قىلىش"
		}
	});
		
	$.extend(F.Grid.prototype,{
		sortASCText:"يۇقىرىدىن تۆۋەنگە",
		sortDESCText:"تۆۋەندىن يۇقىرىغا",
		columnsText:"قۇر",
		unlockText:"قۇلۇپنى ئېچىش",
		lockText:"قۇلۇپلاش",
		filtersText:"سۈزۈش",
		filtersCancelText:"سۈزۈشنى بىكار قىلىش",
		filterOKText:"مۇقىملاشتۇرۇش",
		filterCancelText:"بىكار قىلىش",
		filterMatchAll:"ھەممىگە تەقسىملەش",
		filterMatchAny:"خالىغانچە تەقسىملەش"
	});

	$.extend(F.PagingToolbar.prototype,{
		beforeText:"ىنچى",
		afterText:"بەت{0}جەمئىي , بەت",
		firstText:"بىرىنچى بەت",
		prevText:"ئالدىنقى بەت",
		nextText:"كېيىنكى بەت",
		lastText:"ئەڭ ئاخىرقى بەت",
		displayMsg:"كۆرسىتىش {0} - {1}  لېنتا，جەمئىي {2} لېنتا",
		emptyMsg:"سانلىق مەلۇمات يوق"
	});
	
	$.extend(F.TextBox.prototype,{
		minLengthText:"كىرگۈزۈلگەن بەتنىڭ ئەڭ كىچىك ئۇزۇنلۇقى بولسا {0} ھېرىپ",
		maxLengthText:"كىرگۈزۈلگەن بەتنىڭ ئەڭ چوڭ ئۇزۇنلۇقى بولسا {0} ھېرىپ",
		requiredText:"بۇ كىرگۈزۈلگەن بەت چوقۇم كىرگۈزۈشكە تېگىشلىك بەت"
	});
	
	$.extend(F.NumberBox.prototype,{
		minText:"بۇ بەتنىڭ ئەڭ كىچىك قىممىتى {0}",
		maxText:"بۇ بەتنىڭ ئەڭ چوڭ قىممىتى {0}",
		nanText:"{0}ئۈنۈمى يوق قىممىتى بولسا",
		negativeText:"كىرگۈزۈلگەن بەت مەنپىي سان بولماسلىقى كېرەك"
	});
	
	$.extend(F.CheckBoxList.prototype,{
		requiredText:"ئەڭ ئاز دېگەندە بىر بەتنى تاللاڭ"
	});
	
	$.extend(F.FileUpload.prototype,{
		buttonText:"كۆرۈش..."
	});

	$.extend(F.DatePicker.prototype,{
		minText:"كىرگۈزۈلىدىغان بۇ بەتنىڭ چېسلاسى چوقۇم {0}دىن كىيىن",
		maxText:"كىرگۈزۈلىدىغان بۇ بەتنىڭ چېسلاسى چوقۇم  {0} دىن بۇرۇن",
		invalidText:"{0} بولسا ئىناۋەتسىز چېسلا - چوقۇم فورماتقا ماس كېلىشى كېرەك： {1}"
	});
	
	$.extend(F.ajax,{
		errorMsg:"خاتالىق كۆرۈلدى！{0} ({1})",
		timeoutErrorMsg:"ئىلتىماس ۋاقتى ئېشىپ كەتتى، بەتنى يېڭىلاپ قايتىدىن ئىلتىماس قىلىڭ！",
		networkErrorMsg: "网络错误，请刷新页面并重试！"
	});
	
	$.extend(F.util,{
		alertTitle:"دىئالوگ رامكىسىنى كۆرسىتىش",
		confirmTitle:"دىئالوگ رامكىسىنى مۇقىملاشتۇرۇش",
		promptTitle:"كىرگۈزۈڭ",
		notifyTitle:"ئۇقتۇرۇش",
	    //formAlertMsg:"تۆۋەندىكى <strong>{0}<\/strong> ئۈچۈن ئىناۋەتلىك قىممەت كىرگۈزۈڭ！",
		formAlertTitle:"تالون تولۇق ئەمەس",
		loading:"ھازىر يۈكلەۋاتىدۇ..."
	});
	
	$.extend(F.wnd,{
		closeButtonTooltip:"بۇ كۆزنەكنى ئېتىش",
		formChangeConfirmMsg:"نۆۋەتتىكى تالون ئۆزگەرتىلگەن، ئۆزگەرتىشتىن ۋاز كېچەمسىز？"
	});


	F.lang('calendar', {
	    closeText: "ئېتىش",
	    prevText: "&#x3C;ئالدىنقى ئاي",
	    nextText: "كېيىنكى ئاي&#x3E;",
	    currentText: "بۈگۈن",
	    monthNames: ["بىرىنچى ئاي", "ئىككىنچى ئاي", "ئۈچىنچى ئاي", "تۆتىنچى ئاي", "بەشىنچى ئاي", "ئالتىنچى ئاي", "يەتتىنچى ئاي", "سەككىزىنچى ئاي", "توققۇزىنچى ئاي", "ئونىنچى ئاي", "ئون بىرىنچى ئاي", "ئون ئىككىنچى ئاي"],
	    monthNamesShort: ["بىرىنچى ئاي", "ئىككىنچى ئاي", "ئۈچىنچى ئاي", "تۆتىنچى ئاي", "بەشىنچى ئاي", "ئالتىنچى ئاي", "يەتتىنچى ئاي", "سەككىزىنچى ئاي", "توققۇزىنچى ئاي", "ئونىنچى ئاي", "ئون بىرىنچى ئاي", "ئون ئىككىنچى ئاي"],
	    dayNames: ["يەكشەنبە", "دۈشەنبە", "سەيشەنبە", "چارشەنبە", "پەيشەنبە", "جۈمە", "شەنبە"],
	    dayNamesShort: ["يەكشەنبە", "دۈشەنبە", "سەيشەنبە", "چارشەنبە", "پەيشەنبە", "جۈمە", "شەنبە"],
	    dayNamesMin: ["يەكشەنبە", "بىر", "ئىككى", "ئۈچ", "تۆت", "بەش", "ئالتە"],
	    weekHeader: "ھەپتە",
	    dateFormat: "yy-mm-dd",
	    firstDay: 1,
	    isRTL: !1,
	    showMonthAfterYear: !0,
	    yearSuffix: "يىل"
	});


})(F);
