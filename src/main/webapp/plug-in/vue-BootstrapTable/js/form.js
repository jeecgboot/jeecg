$.SaveForm = function(options) {
	var defaults = {
		url : "",
		param : {},
		type : "post",
		dataType : "json",
		success : function(){},
		close : true
	};
	var options = $.extend(defaults, options);
	dialogLoading(true);
	window.setTimeout(function() {
		$.ajax({
			url : options.url,
			data : options.param,
			type : options.type,
			dataType : options.dataType,
			contentType : options.contentType,
			success : function(data) {
				if (data.success) {
					dialogMsg(data.msg, 'success');
					options.success(data);
					if (options.close == true) {
						frameElement.api.close()
					}
				} else {
					dialogAlert(data.msg, 'error');
				}
			},
			error : function(XMLHttpRequest, textStatus, errorThrown) {
				dialogLoading(false);
                if(textStatus=="parsererror"){
                    top.layer.open({
                        title: '系统提示',
                        area: '338px',
                        icon: 3,
                        move: false,
                        anim: -1,
                        isOutAnim: false,
                        content: '注：登录超时,请稍后重新登录.',
                        btn: ['立即退出'],
                        btnAlign: 'c',
                        yes: function(){
                            toUrl('sys/logout');
                        }
                    });
                    setTimeout(function(){
                        toUrl("sys/logout");
                    }, 2000);
                } else if(textStatus=="error"){
                    dialogMsg("请求超时，请稍候重试...", "error");
                } else {
                    dialogMsg(errorThrown, 'error');
				}
			},
			beforeSend : function() {
				dialogLoading(true);
			},
			complete : function() {
				dialogLoading(false);
			}
		});
	}, 500);
}

$.RemoveForm = function(options) {
	var defaults = {
		msg : "注：您确定要删除吗？该操作将无法恢复",
		url : "",
		param : [],
		type : "get",
		dataType : "json",
		success : null
	};
	var options = $.extend(defaults, options);
	dialogConfirm(options.msg, function() {
		dialogLoading(true);
		window.setTimeout(function() {
			var postdata = options.param;
			$.ajax({
				url : options.url,
				data : postdata,
				type : options.type,
				dataType : options.dataType,
				contentType : options.contentType,
				success : function(data) {
					if (data.success) {
						dialogMsg(data.msg, 'success');
						options.success(data);
					} else {
						dialogAlert(data.msg, 'error');
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
                    dialogLoading(false);
                    if(textStatus=="parsererror"){
                        top.layer.open({
                            title: '系统提示',
                            area: '338px',
                            icon: 3,
                            move: false,
                            anim: -1,
                            isOutAnim: false,
                            content: '注：登录超时,请稍后重新登录.',
                            btn: ['立即退出'],
                            btnAlign: 'c',
                            yes: function(){
                                toUrl('sys/logout');
                            }
                        });
                        setTimeout(function(){
                            toUrl("sys/logout");
                        }, 2000);
                    } else if(textStatus=="error"){
                        dialogMsg("请求超时，请稍候重试...", "error");
                    } else {
                        dialogMsg(errorThrown, 'error');
                    }
                },
				beforeSend : function() {
					dialogLoading(true);
				},
				complete : function() {
					dialogLoading(false);
				}
			});
		}, 500);
	});
}

$.SetForm = function(options) {
	var defaults = {
		url : "",
		param : [],
		type : "post",
		dataType : "json",
		success : null
	};
	var options = $.extend(defaults, options);
	$.ajax({
		url : options.url,
		data : options.param,
		type : options.type,
		dataType : options.dataType,
		contentType : options.contentType,
		success : function(data) {
			if (data.success) {
				options.success(data);
			} else {
				dialogAlert(data.msg, 'error');
			}
		},
		error : function(XMLHttpRequest, textStatus, errorThrown) {
            dialogLoading(false);
            if(textStatus=="parsererror"){
                top.layer.open({
                    title: '系统提示',
                    area: '338px',
                    icon: 3,
                    move: false,
                    anim: -1,
                    isOutAnim: false,
                    content: '注：登录超时,请稍后重新登录.',
                    btn: ['立即退出'],
                    btnAlign: 'c',
                    yes: function(){
                        toUrl('sys/logout');
                    }
                });
                setTimeout(function(){
                    toUrl("sys/logout");
                }, 2000);
            } else if(textStatus=="error"){
                dialogMsg("请求超时，请稍候重试...", "error");
            } else {
                dialogMsg(errorThrown, 'error');
            }
		},
		beforeSend : function() {
			dialogLoading(true);
		},
		complete : function() {
			dialogLoading(false);
		}
	});
}

$.ConfirmForm = function(options) {
	var defaults = {
		msg : "您确定要保存当前数据项修改操作吗？",
		url : "",
		param : {},
		type : "post",
		dataType : "json",
		close : true,
		success : function(){}
	};
	var options = $.extend(defaults, options);
	dialogConfirm(options.msg, function() {
		$.SaveForm(options);
	});
}

$.ConfirmAjax = function(options) {
	var defaults = {
		msg : "您确定要保存当前操作结果吗？",
		url : "",
		param : {},
		type : "post",
		dataType : "json",
		contentType : options.contentType,
		success : null,
		close : true
	};
	var options = $.extend(defaults, options);
	dialogConfirm(options.msg, function() {
		dialogLoading(true);
		window.setTimeout(function() {
			var postdata = options.param;
			$.ajax({
				url : options.url,
				data : JSON.stringify(postdata),
				type : options.type,
				dataType : options.dataType,
				contentType : options.contentType,
				success : function(data) {
					if (data.code == '500') {
						dialogAlert(data.msg, 'error');
					} else if (data.code == '0') {
						dialogMsg(data.msg, 'success');
						options.success(data);
					}
				},
				error : function(XMLHttpRequest, textStatus, errorThrown) {
                    dialogLoading(false);
                    if(textStatus=="parsererror"){
                        top.layer.open({
                            title: '系统提示',
                            area: '338px',
                            icon: 3,
                            move: false,
                            anim: -1,
                            isOutAnim: false,
                            content: '注：登录超时,请稍后重新登录.',
                            btn: ['立即退出'],
                            btnAlign: 'c',
                            yes: function(){
                                toUrl('sys/logout');
                            }
                        });
                        setTimeout(function(){
                            toUrl("sys/logout");
                        }, 2000);
                    } else if(textStatus=="error"){
                        dialogMsg("请求超时，请稍候重试...", "error");
                    } else {
                        dialogMsg(errorThrown, 'error');
                    }
				},
				beforeSend : function() {
					dialogLoading(true);
				},
				complete : function() {
					dialogLoading(false);
				}
			});
		}, 500);
	});
}
