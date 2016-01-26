jform_graphreport_headFw = 700;
jform_graphreport_headFh = 400;

//??
	function jform_graphreport_headadd(){
		add('图表配置','jformGraphreportHeadController.do?goAdd','jform_graphreport_headList',jform_graphreport_headFw,jform_graphreport_headFh);
	}
	//??
	function jform_graphreport_headupdate(){
		update('图表配置','jformGraphreportHeadController.do?goUpdate','jform_graphreport_headList',jform_graphreport_headFw,jform_graphreport_headFh);
	}
	//??
	function jform_graphreport_headcopy(){
		copy('??????','cgFormBuildController.do?ftlForm&tableName=jform_graphreport_head','jform_graphreport_headList',jform_graphreport_headFw,jform_graphreport_headFh);
	}
	//??
	function jform_graphreport_headview(){
		detail('??','cgFormBuildController.do?ftlForm&tableName=jform_graphreport_head','jform_graphreport_headList',jform_graphreport_headFw,jform_graphreport_headFh);
	}

function graph_test() {
	var e = event || x_export.caller.arguments[0];
    var target = e.target || e.srcElement;
    var configId = $(target).parents("tr:first").find("td[field='code']").text();
    var configName = $(target).parents("tr:first").find("td[field='name']").text();
	    
	addOneTab("表单数据列表 ["+configName+"]", "graphReportController.do?list&isIframe&id="+configId);
}

function copy_url() {
    var e = event || x_export.caller.arguments[0];
    var target = e.target || e.srcElement;
    var configId = $(target).parents("tr:first").find("td[field='code']").text();
    popMenuLinkGraph(configId, configId);
}
//图表配置复制
function popMenuLinkGraph(tableName,content){
        $.dialog({
        	content: "url:cgFormHeadController.do?popmenulink&url=graphReportController.do?list&isIframe&title="+tableName,
			drag :false,
			lock : true,
			title:'菜单链接' + '['+content+']',
			opacity : 0.3,
			width:400,
			height:80,drag:false,min:false,max:false
		}).zindex();
	}
function popMenuLinkGraph2(tableName,content){
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

