//新加些对象用来保存常用数据， 如：游戏列表为：zyfc.gameList	(下面数据也应放入此对象，但暂时不做处理)
var zyfc = new Object();
//获得游戏列表
$.get("cgReportController.do?datagrid&configId=dynamic_game_list", function(data) {
	zyfc.gameList = {};
	for(var i = 0; i < data.rows.length; i++) {
		var game = data.rows[i];
		zyfc.gameList[game.gmid] = game;
	}
});


//扩展_导出
function x_export() {
	jQuery.ajaxSettings.traditional = true;
	
	//判断记录是否大于10w条
	var xjs_panel = $(".panel:visible[class='panel']").has("#x_export");
	var rowNum = xjs_panel.find(".pagination-info").text();
	if(rowNum) {
		rowNum = rowNum.match(/共\d+/)[0].replace("共", "");
	}else {
		rowNum = 0;
	}
	if(rowNum == 0) {
		alert("没有导出的记录！");
		return;
	}else if(rowNum  > 100000) {
		alert("导出记录数量不能大于10w条！");
		return;
    }
	
	var e = event || x_export.caller.arguments[0];
	var target = e.target || e.srcElement;
    var configId = $(target).parents("div[id$='Listtb']:first").attr("id").replace("Listtb", "");
	var url = "exCoreController.do?exportExcel&configId=" + configId;
	var datagridId = configId + 'List';

	var queryParams = $('#'+datagridId).datagrid('options').queryParams;
	//获得数组参数
	$("#" + configId + "Listtb").find(":input[id][tag='ComboGrid']").each(function() {
		queryParams[$(this).attr("id")] = $(this).combogrid('getValues');
	});
	$('#'+datagridId+'tb').find('*').each(function() {
	    queryParams[$(this).attr('name')] = $(this).val();
	});
	var params = '&' + $.param(queryParams);
	var fields = '&field=';
	$("#" + datagridId).parents(".datagrid-wrap:first").find(".datagrid-header-row td:visible").each(function() {
		var field = $(this).attr("field");
		if(field && field != "ck" && field != "opt") {
			fields+=field+',';
		}
	});
	var loc = url + params + encodeURI(fields);
	$("<iframe src='" + loc + "&p=1" + "' style='display:none;'></iframe>").appendTo("body");
	if(rowNum > 50000) {
		setTimeout(function() {
			$("<iframe src='" + loc + "&p=2' style='display:none;'></iframe>").appendTo("body");
		}, 1000 * 5);
	}
}

//扩展_克隆
function x_copy() {
	var e = event || x_export.caller.arguments[0];
	var target = e.target || e.srcElement;
    var configId = $(target).parents("div[id$='Listtb']:first").attr("id").replace("Listtb", "");
	eval(configId + "copy()");
}

//每25钟自动连接一次服务器，防止session过期
setInterval(function() {
	$.get("loginController.do?login", function(data) { });
}, 1000 * 60 * 100);

//图表配置复制
function popMenuLinkGraph(tableName,content){
	var url = "<input type='text' style='width:380px;' disabled=\"disabled\" id='menuLink' title='graphReportController.do?list&id=' value='graphReportController.do?list&isIframe&id="+tableName+"' />";
	$.dialog({
		content: url,
		drag :false,
		lock : true,
		title:'菜单链接['+content+']',
		opacity : 0.3,
		width:400,
		height:50,
		cache:false,
	    cancelVal: '关闭',
	    cancel: function(){clip.destroy();},
	    button : [{
	    	id : "coptyBtn",
	    	name : "复制",
	    	callback : function () {
	    	}
	    }],
	    init : function () {
			clip = new ZeroClipboard.Client();
			clip.setHandCursor( true );
			
			clip.addEventListener('mouseOver', function(client){
				clip.setText( document.getElementById("menuLink").value );
			});
			clip.addEventListener('complete', function(client, text){
				alert("复制成功");
			});
			var menuLink = $("#menuLink").val();
			$($("input[type=button]")[0]).attr("id","coptyBtn");
			clip.setText(menuLink);
			clip.glue("coptyBtn");
	    }
	});  
}

//图表配置复制
function copy_url() {
    var e = event || x_export.caller.arguments[0];
    var target = e.target || e.srcElement;
    var configId = $(target).parents("tr:first").find("td[field='code']").text();
    popMenuLinkGraph(configId, configId);
}
//功能测试
function graph_test() {
	var e = event || x_export.caller.arguments[0];
    var target = e.target || e.srcElement;
    var configId = $(target).parents("tr:first").find("td[field='code']").text();
    var configName = $(target).parents("tr:first").find("td[field='name']").text();
	    
	addOneTab("表单数据列表 ["+configName+"]", "graphReportController.do?list&isIframe&id="+configId);
}

//公告管理-查看区服
function x_openServerList(id) {
    //addTab('渠道收入数据(广告)','cgAutoListController.do?list&id=v_rpt_day_pay_ad&clickFunctionId=2c90aa6744866c7a0144875fc92c013e','pictures')
    addlisttab('db_mnet__dbo__v_game_server_notice_jjqy&noticeid='+id,'【jjqy】区服公告','0')
}

//四合一图表隐藏相关列
function x_groupReport() {
	return;
	
	var xjs_panel = $("#maintabs .panel.datagrid:visible");
	var isGroupReport = $("#isGroupReport", xjs_panel);
	if(isGroupReport.length == 1) {
		var datagridId = xjs_panel .find(".datagrid-toolbar").attr("id").replace("tb", "");
		var queryParams = {serverid: $(":input[name='serverid']", xjs_panel).val(), ad_channel_id: $(":input[name='ad_channel_id']", xjs_panel).val()}
		//如果已选中汇总，隐藏相关列
		if(isGroupReport.attr("checked")) {
			if($(":checked#isGroupReport", xjs_panel).val() == 1) {
				//根据数据条件隐藏相应数据列
				if(queryParams.serverid != undefined) {
					$('#' + datagridId).datagrid("hideColumn", "serverid");
				}
				if(queryParams.ad_channel_id != undefined) {
					$('#' + datagridId).datagrid("hideColumn", "ad_channel_id");
					$('#' + datagridId).datagrid("hideColumn", "ad_channel_name");
				}
				/*if(!queryParams.serverid && queryParams.serverid != undefined) {
					$('#' + datagridId).datagrid("hideColumn", "serverid");
				}
				if(!queryParams.ad_channel_id && queryParams.ad_channel_id != undefined) {
					$('#' + datagridId).datagrid("hideColumn", "ad_channel_id");
					$('#' + datagridId).datagrid("hideColumn", "ad_channel_name");
				}*/
			}
		}else {
			//否则显示相关列
			if(queryParams.serverid != undefined) {
				$('#' + datagridId).datagrid("showColumn", "serverid");
			}
			if(queryParams.ad_channel_id != undefined) {
				$('#' + datagridId).datagrid("showColumn", "ad_channel_id");
			}
		}
	}
}

//根据游戏显示相应区服
function x_showOnlyServer() {
	var xjs_panel = $("#maintabs .panel.datagrid:visible");
	var serveridObj = xjs_panel.find("#serverid");
	var gmid = xjs_panel.find("#gmid").val();
	//把gmid换成csdkid
	if(gmid) {
		gmid = zyfc.gameList[gmid].csdkid || gmid;
	}
	var currServerid = serveridObj.combo("getValue");
	var data = $("option", serveridObj).map(function() {
		var serverId = $(this).val();
		var serverOption = null;
		if(serverId) {
			if(gmid == "appsg") {
				if(serverId.indexOf(".") == -1) {
					serverOption = {value: serverId, text: $(this).text()};
					if(currServerid == serverId) {
						serverOption.selected = true;
					}
				}
			}else {
				if(!gmid || serverId.indexOf(gmid + ".") != -1) {
					serverOption =  {value: serverId, text: $(this).text()};
					if(currServerid == serverId) {
						serverOption.selected = true;
					}
				}
			}
		}
		return serverOption;
	});
	serveridObj.combobox('setValue', '');
	serveridObj.combobox("loadData", x_getSCOptionOther("**全部区服**").concat(data.get()));
}



//根据游戏显示相应渠道
function x_showOnlyChannel() {
	var xjs_panel = $("#maintabs .panel.datagrid:visible");
	var gmidObj = xjs_panel.find("#gmid");
	var text = $("option[value='"+gmidObj.val()+"']", gmidObj).text();
	var serveridObj = xjs_panel.find("#ad_channel_id");
	var currServerid = serveridObj.combo("getValue");
	var data = $("option", serveridObj).map(function() {
		var serverOption = null;
		if(gmidObj.val() == "appsg") {
			if(new RegExp(text).test($(this).text())) {
				serverOption = {value:$(this).val(), text:$(this).text()}
				if(currServerid == $(this).val()) {
					serverOption.selected = true;
				}
			}
		}else {
			if(new RegExp("啪啪三国").test($(this).text()) == false) {
				if($(this).val()) {
					serverOption = {value:$(this).val(), text:$(this).text()}
					if(currServerid == $(this).val()) {
						serverOption.selected = true;
					}
				}
			}
		}
		return serverOption;
	});
	data = x_getSCOptionOther("**全部渠道**").concat(data.get());
	serveridObj.combobox('setValue', '');
	serveridObj.combobox("loadData", data);
}

//获得区服和渠道附加选项
function x_getSCOptionOther(showText) {
	var optionOther = [{value:"", text:""}];
	if($("#maintabs .panel.datagrid:visible #isGroupReport:checked").length > 0) {
		optionOther.push({value:"-1", text:showText});
	}
	return optionOther;
}