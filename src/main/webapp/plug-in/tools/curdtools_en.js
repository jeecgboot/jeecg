﻿// update--begin--author:zhangjiaqiang date:20170621 for:如何避免console.log引起javascript的兼容问题 
if(!window.console){
    window.console = {};
}
if(!window.console.log){
    window.console.log = function(msg){};
}

var basePath;
try{
	var local = window.location;  
	var contextPath = local.pathname.split("/")[1];  
	basePath = local.protocol+"//"+local.host+"/"+contextPath;
	//alert(basePath);
}catch(e){}


//﻿var jq = jQuery.noConflict();
/**
 * 增删改工具栏
 */
/*window.onerror = function() {
	return true;
};*/
var iframe;// iframe操作对象
var win;//窗口对象
var gridname="";//操作datagrid对象名称
var windowapi;
var W;
try {
	windowapi = frameElement.api, W = windowapi.opener;//内容页中调用窗口实例对象接口
} catch (e) {
}
/**
 * 设置 window的 zIndex
 * @param flag true: 不增量(因为 tip提示经常使用 zIndex, 所以如果是 tip的话 ,则不增量)
 * @returns
 */
function getzIndex(flag){
	var zindexNumber = getCookie("ZINDEXNUMBER");
	if(zindexNumber == null){
		zindexNumber = 2010;
		setCookie("ZINDEXNUMBER",zindexNumber);
		//zindexNumber = 1980;
	}else{
		if(zindexNumber < 2010){
			zindexNumber = 2010;
		}
		var n = flag?zindexNumber:parseInt(zindexNumber) + parseInt(10);
		setCookie("ZINDEXNUMBER",n);
	}
	return zindexNumber;
} 

function upload(curform) {
	upload();
}
/**
 *  Add event open window
 * @param title
 * @param addurl
 */
function add(title,addurl,gname,width,height) {
	gridname=gname;
	createwindow(title, addurl,width,height);
}
/**
 * 树列表添加事件打开窗口
 * @param title 编辑框标题
 * @param addurl//目标页面地址
 */
function addTreeNode(title,addurl,gname) {
	if (rowid != '') {
		addurl += '&id='+rowid;
	}
	gridname=gname;
	createwindow(title, addurl);
}
/**
 * 更新事件打开窗口
 * @param title 编辑框标题
 * @param addurl//目标页面地址
 * @param id//主键字段
 */

function update(title,url, id,width,height,isRestful) {
	gridname=id;
	var rowsData = $('#'+id).datagrid('getSelections');
	if (!rowsData || rowsData.length==0) {
		tip('Please select edit item');
		return;
	}
	if (rowsData.length>1) {
		tip('Please one item to edit');
		return;
	}
	
	if(isRestful!='undefined'&&isRestful){
		url += '/'+rowsData[0].id;
	}else{
		url += '&id='+rowsData[0].id;
	}
	createwindow(title,url,width,height);
}


/**
 * 如果页面是详细查看页面，无效化所有表单元素，只能进行查看
 */
$(function(){
	if(location.href.indexOf("load=detail")!=-1){
		$(":input").attr("disabled","true");
	}
});

/**
 * 查看详细事件打开窗口
 * @param title 查看框标题
 * @param addurl//目标页面地址
 * @param id//主键字段
 */
function detail(title,url, id,width,height) {
	var rowsData = $('#'+id).datagrid('getSelections');
	
	if (!rowsData || rowsData.length == 0) {
		tip('Please select view item');
		return;
	}
	if (rowsData.length > 1) {
		tip('Please select an item to view');
		return;
	}
    url += '&load=detail&id='+rowsData[0].id;
	createdetailwindow(title,url,width,height);
}

/**
 * 多记录刪除請求
 * @param title
 * @param url
 * @param gname
 * @return
 */
function deleteALLSelect(title,url,gname) {
	gridname=gname;
    var ids = [];
    var rows = $("#"+gname).datagrid('getSelections');
    if (rows.length > 0) {
    	$.dialog.setting.zIndex = getzIndex(true);
    	$.dialog.confirm('Do you want to delete this data for ever?', function(r) {
		   if (r) {
				for ( var i = 0; i < rows.length; i++) {
					ids.push(rows[i].id);
				}
				$.ajax({
					url : url,
					type : 'post',
					data : {
						ids : ids.join(',')
					},
					cache : false,
					success : function(data) {
						var d = $.parseJSON(data);
						if (d.success) {
							var msg = d.msg;
							tip(msg);
							reloadTable();
							$("#"+gname).datagrid('unselectAll');
							ids='';
						}
					}
				});
			}
		});
	} else {
		tip("Please select delete data");
	}
}

/**
 * 查看时的弹出窗口
 * 
 * @param title
 * @param addurl
 * @param saveurl
 */
function createdetailwindow(title, addurl,width,height) {
	width = width?width:700;
	height = height?height:400;
	if(width=="100%" || height=="100%"){
		width = window.top.document.body.offsetWidth;
		height =window.top.document.body.offsetHeight-100;
	}
	if(typeof(windowapi) == 'undefined'){
		$.dialog({
			content: 'url:'+addurl,
			zIndex: getzIndex(),
			lock : true,
			width:width,
			height: height,
			title:title,
			opacity : 0.3,
			cache:false, 
		    cancelVal: 'Close',
		    cancel: true /*为true等价于function(){}*/
		});
	}else{

		W.$.dialog({
			content: 'url:'+addurl,
			zIndex: getzIndex(),
			lock : true,
			width:width,
			height: height,
			parent:windowapi,
			title:title,
			opacity : 0.3,
			cache:false, 
		    cancelVal: 'Close',
		    cancel: function(){
		    	windowapi.zindex();
		    }
			//true /*为true等价于function(){}*/
		});

	}
	
}
/**
 * 全屏编辑
 * @param title 编辑框标题
 * @param addurl//目标页面地址
 * @param id//主键字段
 */
function editfs(title,url) {
	var name=gridname;
	 if (rowid == '') {
		tip('Please select edit item');
		return;
	}
	url += '&id='+rowid;

	width = window.top.document.body.offsetWidth;
	height =window.top.document.body.offsetHeight-100;
	openwindow(title,url,name,width,height);

}
// 删除调用函数
function delObj(url,name) {
	gridname=name;
	createdialog('Delete Confirm ', 'Delete this record, Confirm ?', url,name);
}
// 删除调用函数
function confuploadify(url, id) {
	$.dialog.setting.zIndex = getzIndex(true);
	$.dialog.confirm('Delete confirm', function(){
		deluploadify(url, id);
	}, function(){
	});
}
/**
 * 执行删除附件
 * 
 * @param url
 * @param index
 */
function deluploadify(url, id) {
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		url : url,// 请求的action路径
		error : function() {// 请求失败处理函数
		},
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success) {
				$("#" + id).remove();// 移除SPAN
				m.remove(id);// 移除MAP对象内字符串
			}

		}
	});
}
// 普通询问操作调用函数

function confirm(url, content,name,noShade) {
	createdialog('Tip Message ', content, url,name);
}

/**
 * Tip Message
 */
function tip_old(msg) {
	$.dialog.setting.zIndex = getzIndex(true);
	$.dialog.tips(msg, 1);
}
/**
 * Tip Message
 */
function tip(msg) {
	try{
		$.dialog.setting.zIndex = getzIndex(true);
//		$.messager.show({
//			title : 'Tip Message',
//			msg : msg,
//			timeout : 1000 * 6
//		});

		var navigatorName = "Microsoft Internet Explorer"; 

		if(navigator.appName == navigatorName||"default,shortcut".indexOf(getCookie("JEECGINDEXSTYLE"))>=0){

			$.messager.show({
				title : 'Tip Message',
				msg : msg,
				timeout : 1000 * 6
			});
		}else{
			var icon = 7;
			if(msg.indexOf("success") > -1){
				icon = 1;
			}else if(msg.indexOf("fail") > -1){
				icon = 2;
			}
			layer.open({
				title:'Tip Message',
				offset:'rb',
				content:msg,
				time:3000,
				btn:false,
				shade:false,
				icon:icon,
				shift:2
			});
		}

	}catch(e){
		alertTipTop(msg,'10%');
	}
}

/**
 * Layer风格alert提示
 */
function alerLayerTip(msg) {
	if(msg==null || msg==''){
		msg = "系统异常，请看系统日志!";
	}
	try{
		var navigatorName = "Microsoft Internet Explorer"; 

		if( navigator.appName == navigatorName ||"default,shortcut".indexOf(getCookie("JEECGINDEXSTYLE"))>=0){

			$.messager.alert('提示信息',msg);
		}else{
			layer.open({
				title:'提示信息',
				content:msg,
				time:6000,
				btn:false,
				shade:false,
				icon:2
			});
		}
	}catch(e){
		alert(msg);
	}
}

/**
 * Tip Message像alert一样 定位顶部的位置
 */
function alertTipTop(msg,top,title) {
	$.dialog.setting.zIndex = getzIndex(true);
	title = title?title:"Tip Message";
	$.dialog({
			title:title,
			zIndex: getzIndex(),
			icon:'tips.gif',
			top:top,
			content: msg
		});
}

/**
 * Tip Message像alert一样
 */
function alertTip(msg,title) {
	$.dialog.setting.zIndex = getzIndex(true);
	title = title?title:"Tip Message";
	$.dialog({
			title:title,
			zIndex: getzIndex(),
			icon:'tips.gif',
			content: msg
		});
}
/**
 * 创建添加或编辑窗口
 * 
 * @param title
 * @param addurl
 * @param saveurl
 */
function createwindow(title, addurl,width,height) {
	width = width?width:700;
	height = height?height:400;
	if(width=="100%" || height=="100%"){
		width = window.top.document.body.offsetWidth;
		height =window.top.document.body.offsetHeight-100;
	}
    //--author：JueYue---------date：20140427---------for：弹出bug修改,设置了zindex()函数
	if(typeof(windowapi) == 'undefined'){
		$.dialog({
			content: 'url:'+addurl,
			lock : true,
			zIndex: getzIndex(),
			width:width,
			height:height,
			title:title,
			opacity : 0.3,
			cache:false,
			okVal: 'Submit',
		    ok: function(){
		    	iframe = this.iframe.contentWindow;
				saveObj();
				return false;
		    },
		    cancelVal: 'Close',
		    cancel: true /*为true等价于function(){}*/
		});
	}else{

		/*W.*/$.dialog({//使用W，即为使用顶级页面作为openner，造成打开的次级窗口获取不到关联的主窗口
			content: 'url:'+addurl,
			lock : true,
			width:width,
			zIndex: getzIndex(),
			height:height,
			parent:windowapi,
			title:title,
			opacity : 0.3,
			cache:false,
		    ok: function(){
		    	iframe = this.iframe.contentWindow;
				saveObj();
				return false;
		    },
		    cancelVal: 'Close',
		    cancel: true /*为true等价于function(){}*/
		});

	}
    //--author：JueYue---------date：20140427---------for：弹出bug修改,设置了zindex()函数
	
}
/**
 * 创建上传页面窗口
 * 
 * @param title
 * @param addurl
 * @param saveurl
 */
function openuploadwin(title, url,name,width, height) {
	gridname=name;
	$.dialog({
	    content: 'url:'+url,
		zIndex: getzIndex(),
	    cache:false,
	    button: [
	        {
	            name: "Begin Upload",
	            callback: function(){
	            	iframe = this.iframe.contentWindow;
					iframe.upload();
					return false;
	            },
	            focus: true
	        },
	        {
	            name: "Cancel Upload",
	            callback: function(){
	            	iframe = this.iframe.contentWindow;
					iframe.cancel();
	            }
	        }
	    ]
	});
}
/**
 * 创建查询页面窗口
 * 
 * @param title
 * @param addurl
 * @param saveurl
 */
function opensearchdwin(title, url, width, height) {
	$.dialog({
		content: 'url:'+url,
		zIndex: getzIndex(),
		title : title,
		lock : true,
		height : height,
		cache:false,
		width : width,
		opacity : 0.3,
		button : [ {
			name :'Query',
			callback : function() {
				iframe = this.iframe.contentWindow;
				iframe.searchs();
			},
			focus : true
		}, {
			name : 'Cancel',
			callback : function() {

			}
		} ]
	});
}
/**
 * 创建不带按钮的窗口
 * 
 * @param title
 * @param addurl
 * @param saveurl
 */
function openwindow(title, url,name, width, height) {

	if(width=="100%" || height=="100%"){
		width = window.top.document.body.offsetWidth;
		height =window.top.document.body.offsetHeight-100;
	}

	gridname=name;
	if (typeof (width) == 'undefined'&&typeof (height) != 'undefined')
	{
		if(typeof(windowapi) == 'undefined'){
			$.dialog({
				content: 'url:'+url,
				zIndex: getzIndex(),
				title : title,
				cache:false,
				lock : true,
				width: 'auto',
			    height: height
			});
		}else{
			$.dialog({
				content: 'url:'+url,
				zIndex: getzIndex(),
				title : title,
				cache:false,
				parent:windowapi,
				lock : true,
				width: 'auto',
			    height: height
			});
		}
	}
	if (typeof (height) == 'undefined'&&typeof (width) != 'undefined')
	{
		if(typeof(windowapi) == 'undefined'){
			$.dialog({
				content: 'url:'+url,
				zIndex: getzIndex(),
				title : title,
				lock : true,
				width: width,
				cache:false,
			    height: 'auto'
			});
		}else{
			$.dialog({
				content: 'url:'+url,
				zIndex: getzIndex(),
				title : title,
				lock : true,
				parent:windowapi,
				width: width,
				cache:false,
			    height: 'auto'
			});
		}
	}
	if (typeof (width) == 'undefined'&&typeof (height) == 'undefined')
	{
		if(typeof(windowapi) == 'undefined'){
			$.dialog({
				content: 'url:'+url,
				zIndex: getzIndex(),
				title : title,
				lock : true,
				width: 'auto',
				cache:false,
			    height: 'auto'
			});
		}else{
			$.dialog({
				content: 'url:'+url,
				zIndex: getzIndex(),
				title : title,
				lock : true,
				parent:windowapi,
				width: 'auto',
				cache:false,
			    height: 'auto'
			});
		}
	}
	
	if (typeof (width) != 'undefined'&&typeof (height) != 'undefined')
	{
		if(typeof(windowapi) == 'undefined'){
			$.dialog({
				width: width,
			    height:height,
				content: 'url:'+url,
				zIndex: getzIndex(),
				title : title,
				cache:false,
				lock : true
			});
		}else{
			$.dialog({
				width: width,
			    height:height,
				content: 'url:'+url,
				zIndex: getzIndex(),
				parent:windowapi,
				title : title,
				cache:false,
				lock : true
			});
		}
	}
}

/**
 * 创建询问窗口
 * 
 * @param title
 * @param content
 * @param url
 */

function createdialog(title, content, url,name,noShade) {
	$.dialog.setting.zIndex = getzIndex(true);

	var navigatorName = "Microsoft Internet Explorer"; 

	if( navigator.appName == navigatorName ||"default,shortcut".indexOf(getCookie("JEECGINDEXSTYLE"))>=0){

		$.dialog.confirm(content, function(){
			doSubmit(url,name);
			rowid = '';
		}, function(){
		});
	}else{
		layer.open({
			title:title,
			content:content,
			icon:7,
			shade: !noShade?0.3:0,
			yes:function(index){
				doSubmit(url,name);
				rowid = '';
			},
			btn:['ok','cancel'],
			btn2:function(index){
				layer.close(index);
			}
		});
	}

}
/**
 * 执行保存
 * 
 * @param url
 * @param gridname
 */
function saveObj() {
	$('#btn_sub', iframe.document).click();
}

/**
 * 执行AJAX提交FORM
 * 
 * @param url
 * @param gridname
 */
function ajaxSubForm(url) {
	$('#myform', iframe.document).form('submit', {
		url : url,
		onSubmit : function() {
			iframe.editor.sync();
		},
		success : function(r) {
			tip('Cancel');
			reloadTable();
		}
	});
}
/**
 * 执行查询
 * 
 * @param url
 * @param gridname
 */
function search() {

	$('#btn_sub', iframe.document).click();
	iframe.search();
}

/**
 * 执行操作
 * 
 * @param url
 * @param index
 */
function doSubmit(url,name,data) {
	gridname=name;
	//--author：JueYue ---------date：20140227---------for：把URL转换成POST参数防止URL参数超出范围的问题
	var paramsData = data;
	if(!paramsData){
		paramsData = new Object();
		if (url.indexOf("&") != -1) {
			var str = url.substr(url.indexOf("&")+1);
			url = url.substr(0,url.indexOf("&"));
			var strs = str.split("&");
			for(var i = 0; i < strs.length; i ++) {
				paramsData[strs[i].split("=")[0]]=(strs[i].split("=")[1]);
			}
		}      
	}
	//--author：JueYue ---------date：20140227---------for：把URL转换成POST参数防止URL参数超出范围的问题
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		data : paramsData,
		url : url,// 请求的action路径
		error : function() {// 请求失败处理函数
		},
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success) {
				var msg = d.msg;
				tip(msg);
				reloadTable();
			}
		}
	});
	
	
}
/**
 * 退出确认框
 * 
 * @param url
 * @param content
 * @param index
 */
function exit(url, content) {
	$.dialog.setting.zIndex = getzIndex(true);
	$.dialog.confirm(content, function(){
		window.location = url;
	}, function(){
	});
}
/**
 * 模板页面ajax提交
 * 
 * @param url
 * @param gridname
 */
function ajaxdoSub(url, formname) {
	$('#' + formname).form('submit', {
		url : url,
		onSubmit : function() {
			editor.sync();
		},
		success : function(r) {
			tip('Cancel');
		}
	});
}
/**
 * ajax提交FORM
 * 
 * @param url
 * @param gridname
 */
function ajaxdoForm(url, formname) {
	$('#' + formname).form('submit', {
		url : url,
		onSubmit : function() {
		},
		success : function(r) {
			tip('Cancel');
		}
	});
}

function opensubwin(title, url, saveurl, okbutton, closebutton) {
	$.dialog({
		content: 'url:'+url,
		zIndex: getzIndex(),
		title : title,
		lock : true,
		opacity : 0.3,
		button : [ {
			name : okbutton,
			callback : function() {
				iframe = this.iframe.contentWindow;
				win = frameElement.api.opener;// 来源页面
				$('#btn_sub', iframe.document).click();
				return false;
			}
		}, {
			name : closebutton,
			callback : function() {
			}
		} ]

	});
}

function openauditwin(title, url, saveurl, okbutton, backbutton, closebutton) {
	$.dialog({
		content: 'url:'+url,
		zIndex: getzIndex(),
		title : title,
		lock : true,
		opacity : 0.3,
		button : [ {
			name : okbutton,
			callback : function() {
				iframe = this.iframe.contentWindow;
				win = $.dialog.open.origin;// 来源页面
				$('#btn_sub', iframe.document).click();
				return false;
			}
		}, {
			name : backbutton,
			callback : function() {
				iframe = this.iframe.contentWindow;
				win = frameElement.api.opener;// 来源页面
				$('#formobj', iframe.document).form('submit', {
					url : saveurl + "&code=exit",
					onSubmit : function() {
						$('#code').val('exit');
					},
					success : function(r) {
						$.dialog.tips('Cancel', 2);
						win.location.reload();
					}
				});

			}
		}, {
			name : closebutton,
			callback : function() {
			}
		} ]

	});
}
/*获取Cookie值*/
function getCookie(c_name)
{
	if (document.cookie.length > 0) {
		c_start = document.cookie.indexOf(c_name + "=")
		if (c_start != -1) {
			c_start = c_start + c_name.length + 1
			c_end = document.cookie.indexOf(";", c_start)
			if (c_end == -1)
				c_end = document.cookie.length
			return unescape(document.cookie.substring(c_start, c_end))
		}
	}
	return ""
}

/* 设置 cookie  */
function setCookie(c_name, value, expiredays){
	var exdate=new Date();
	exdate.setDate(exdate.getDate() + expiredays);
	document.cookie=c_name+ "=" + escape(value) + ((expiredays==null) ? "" : ";expires="+exdate.toGMTString());
}

function createTabId(str){
　　　　var val="";
　　　　for(var i = 0; i < str.length; i++){
　　　　　　　　val += str.charCodeAt(i).toString(16);
　　　　}
　　　　return val;
　　}

// 添加标签
function addOneTab(subtitle, url, icon) {
	var indexStyle = getCookie("JEECGINDEXSTYLE");
	if(indexStyle=='sliding'||indexStyle=='bootstrap'){
		//shortcut和bootstrap风格的tab跳转改为直接跳转
		window.location.href=url;
	}else if(indexStyle=='acele'||indexStyle=='ace'){
		var id = "";
		//if(url.indexOf("=")!=-1){
		//	id = url.substring(url.indexOf("=")+1);
		//}else{
			id = createTabId(subtitle);
		//}
		window.top.addTabs({id:id,title:subtitle,close: true,url: url});
	}else if(indexStyle=='hplus'){
		var id = "";
		id = createTabId(subtitle);
		window.top.addTabs({id:id,title:subtitle,close: true,url: url});

	}else if(indexStyle=='fineui'){
		var id = "";
		id = createTabId(subtitle);
		window.top.addFineuiTab({id:id,title:subtitle,close: true,url: url});

	}else{
		if (icon == '') {
			icon = 'icon folder';
		}
		window.top.$.messager.progress({
			text : 'Page loading...',
			interval : 300
		});
		window.top.$('#maintabs').tabs({
			onClose : function(subtitle, index) {
				window.top.$.messager.progress('close');
			}
		});
		if (window.top.$('#maintabs').tabs('exists', subtitle)) {
			window.top.$('#maintabs').tabs('select', subtitle);
			if (url.indexOf('isHref') != -1) {
				window.top.$('#maintabs').tabs('update', {
					tab : window.top.$('#maintabs').tabs('getSelected'),
					options : {
						title : subtitle,
						href:url,
						//content : '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:99.4%;"></iframe>',
						closable : true,
						icon : icon
					}
				});
			}else {
				window.top.$('#maintabs').tabs('update', {
					tab : window.top.$('#maintabs').tabs('getSelected'),
					options : {
						title : subtitle,
						content : '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:99.4%;"></iframe>',
						//content : '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:99.4%;"></iframe>',
						closable : true,
						icon : icon
					}
				});
			}
		} else {
			if (url.indexOf('isHref') != -1) {
				window.top.$('#maintabs').tabs('add', {
					title : subtitle,
					href:url,
					closable : true,
					icon : icon
				});
			}else {
				window.top.$('#maintabs').tabs('add', {
					title : subtitle,
					content : '<iframe src="' + url + '" frameborder="0" style="border:0;width:100%;height:99.4%;"></iframe>',
					closable : true,
					icon : icon
				});
			}
		}
	}
}
// 关闭自身TAB刷新父TABgrid
function closetab(title) {
	//暂时先不刷新
	//window.top.document.getElementById('tabiframe').contentWindow.reloadTable();
	//window.top.document.getElementById('maintabs').contentWindow.reloadTable();
	window.top.$('#maintabs').tabs('close', title);
	//tip("添加成功");
}

//popup  
//object: this  name:需要选择的列表的字段  code:动态报表的code
function inputClick(obj,name,code) {
	 if(name==""||code==""){
		 alert("Popup parameter not prepare");
		 return;
	 }

	 var inputClickUrl = basePath + "/cgReportController.do?popup&id="+code;

	 if(typeof(windowapi) == 'undefined'){
		 $.dialog({
				content: "url:"+inputClickUrl,
				zIndex: getzIndex(),
				lock : true,
				title:"Select",
				width:800,
				height: 400,
				cache:false,
			    ok: function(){
			    	iframe = this.iframe.contentWindow;
			    	var selected = iframe.getSelectRows();
			    	if (selected == '' || selected == null ){
				    	alert("Please select");
			    		return false;
				    }else {
					    var str = "";
				    	$.each( selected, function(i, n){
					    	if (i==0)
					    	str+= n[name];
					    	else
				    		str+= ","+n[name];
				    	});
				    	$(obj).val("");
				    	//$('#myText').searchbox('setValue', str);
					    $(obj).val(str);
				    	return true;
				    }
					
			    },
			    cancelVal: 'Close',
			    cancel: true /*为true等价于function(){}*/
			});
		}else{
			$.dialog({
				content: "url:"+inputClickUrl,
				zIndex: getzIndex(),
				lock : true,
				title:"Select",
				width:800,
				height: 400,
				parent:windowapi,
				cache:false,
			    ok: function(){
			    	iframe = this.iframe.contentWindow;
			    	var selected = iframe.getSelectRows();
			    	if (selected == '' || selected == null ){
				    	alert("Please select");
			    		return false;
				    }else {
					    var str = "";
				    	$.each( selected, function(i, n){
					    	if (i==0)
					    	str+= n[name];
					    	else
				    		str+= ","+n[name];
				    	});
				    	$(obj).val("");
				    	//$('#myText').searchbox('setValue', str);
					    $(obj).val(str);
				    	return true;
				    }
					
			    },
			    cancelVal: 'Close',
			    cancel: true /*为true等价于function(){}*/
			});
		}
}
/*
	自定义url的弹出
	obj:要填充的控件,可以为多个，以逗号分隔
	name:列表中对应的字段,可以为多个，以逗号分隔（与obj要对应）
	url：弹出页面的Url
*/
function popClick(obj,name,url) {
	$.dialog.setting.zIndex = getzIndex(true);
	var names = name.split(",");
	var objs = obj.split(",");
	 if(typeof(windowapi) == 'undefined'){
		 $.dialog({
				content: "url:"+url,
				zIndex: getzIndex(),
				lock : true,
				title:"Select",
				width:700,
				height: 400,
				cache:false,
			    ok: function(){
			    	iframe = this.iframe.contentWindow;
			    	var selected = iframe.getSelectRows();
			    	if (selected == '' || selected == null ){
				    	alert("Please select");
			    		return false;
				    }else {
				    	for(var i1=0;i1<names.length;i1++){
						    var str = "";
					    	$.each( selected, function(i, n){
						    	if (i==0)
						    	str+= n[names[i1]];
						    	else{
									str+= ",";
									str+=n[names[i1]];
								}
					    	});
							if($("#"+objs[i1]).length>=1){
								$("#"+objs[i1]).val("");
								$("#"+objs[i1]).val(str);
							}else{
								$("input[name='"+objs[i1]+"']").val("");
								$("input[name='"+objs[i1]+"']").val(str);
							}
						 }
				    	return true;
				    }
					 
			    },
			    cancelVal: 'Close',
			    cancel: true /*为true等价于function(){}*/
			});
		}else{
			$.dialog({
				content: "url:"+url,
				zIndex: getzIndex(),
				lock : true,
				title:"Select",
				width:700,
				height: 400,
				parent:windowapi,
				cache:false,
			     ok: function(){
			    	iframe = this.iframe.contentWindow;
			    	var selected = iframe.getSelectRows();
			    	if (selected == '' || selected == null ){
				    	alert("Please select");
			    		return false;
				    }else {
				    	for(var i1=0;i1<names.length;i1++){
						    var str = "";
					    	$.each( selected, function(i, n){
						    	if (i==0)
						    	str+= n[names[i1]];
						    	else{
									str+= ",";
									str+=n[names[i1]];
								}
					    	});
					    	if($("#"+objs[i1]).length>=1){
								$("#"+objs[i1]).val("");
								$("#"+objs[i1]).val(str);
							}else{
								$("[name='"+objs[i1]+"']").val("");
								$("[name='"+objs[i1]+"']").val(str);
							}
						 }
				    	return true;
				    }
					
			    },
			    cancelVal: 'Close',
			    cancel: true /*为true等价于function(){}*/
			});
		}
}
/**
 * Jeecg Excel 导出
 * 代入查询条件
 */
function JeecgExcelExport(url,datagridId){
	var queryParams = $('#'+datagridId).datagrid('options').queryParams;
	$('#'+datagridId+'tb').find('*').each(function() {
	    queryParams[$(this).attr('name')] = $(this).val();
	});
	var params = '&';
	$.each(queryParams, function(key, val){
		params+='&'+key+'='+val;
	}); 
	var fields = '&field=';
	$.each($('#'+ datagridId).datagrid('options').columns[0], function(i, val){
		if(val.field != 'opt'){
			fields+=val.field+',';
		}
	});

    var id='&id=';
    $.each($('#'+ datagridId).datagrid('getSelections'), function(i, val){
        id+=val.id+",";
    });
    window.location.href = url+ encodeURI(fields+params+id);

}
/**
 * 自动完成的解析函数
 * @param data
 * @returns {Array}
 */
function jeecgAutoParse(data){
	var parsed = [];
    	$.each(data.rows,function(index,row){
    		parsed.push({data:row,result:row,value:row.id});
    	});
			return parsed;
}
//add--start--Author:xugj date:20160531 for: TASK #1089 【demo】针对jeecgdemo，实现一个新的页面方式
/**
 * 更新跳转新页面
 * @param title 编辑框标题 未实现标题改变
 * @param addurl//目标页面地址
 * @param id//主键字段
 */
function updateNotCreateWin(title,url, id,isRestful) {
	var rowsData = $('#'+id).datagrid('getSelections');
	if (!rowsData || rowsData.length==0) {
		tip('Please select edit item');
		return;
	}
	if (rowsData.length>1) {
		tip('Please one item to edit');
		return;
	}
	if(isRestful!='undefined'&&isRestful){
		url += '/'+rowsData[0].id;
	}else{
		url += '&id='+rowsData[0].id;
	}
	window.location.href=url
}
/**
 * 查看详情跳转新页面
 * @param title 编辑框标题 未实现标题改变
 * @param id//主键字段
 */
function viewNotCreateWin(title,url, id,isRestful)
{

	var rowsData = $('#'+id).datagrid('getSelections');
	if (!rowsData || rowsData.length==0) {
		tip('Please select edit item');
		return;
	}
	if (rowsData.length>1) {
		tip('Please one item to edit');
		return;
	}
	if(isRestful!='undefined'&&isRestful){
		url += '/'+rowsData[0].id;
	}else{
		url += '&id='+rowsData[0].id;
	}
	window.location.href=url
}
//add--end--Author:xugj date:20160531 for: TASK #1089 【demo】针对jeecgdemo，实现一个新的页面方式

//add--start--Author:gengjiajia date:20160802 for: TASK #1175 批量添加数据的时popup多值的传递
//popup  
//object: pobj当前操作的文本框. tablefield:对应字典TEXT,要从popup报表中获取的字段.inputnames:对应字典CODE,当前需要回填数据的文本框名称. pcode:动态报表的code
function popupClick(pobj,tablefield,inputnames,pcode) {
	 $.dialog.setting.zIndex = getzIndex(true);
	 if(inputnames==""||pcode==""){
		 alert("popup参数配置不全");
		 return;
	 }
	 if(typeof(windowapi) == 'undefined'){
		 $.dialog({
				content: "url:cgReportController.do?popup&id="+pcode,
				zIndex: getzIndex(),
				lock : true,
				title:"选择",
				width:800,
				height: 400,
				cache:false,
			    ok: function(){
			    	iframe = this.iframe.contentWindow;
			    	var selected = iframe.getSelectRows();
			    	if (selected == '' || selected == null ){
				    	alert("请选择");
			    		return false;
				    }else {
				    	//对应数据库字段不为空的情况下,根据表单中字典TEXT的值来取popup的值
				    	if(tablefield != "" && tablefield != null){
					    	var fields = tablefield.split(",");
					    	var inputfield = inputnames.split(",");
					    	for(var i1=0;i1<fields.length;i1++){
							   var str = "";
						    	$.each( selected, function(i, n){ 
						    		if (i==0)
								    	str+= n[fields[i1]];
							    	else{
										str+= ",";
										str+=n[fields[i1]];
									}
								 });
						    	var inputname = $(pobj).attr("name"); 
						    	var inputs = inputname.split(".");
						    	//判断传入的this格式是否为 "AA[#index#].aa"的形式
						    	if(str.indexOf("undefined")==-1){
						    		if(inputs.length>1){
						    			﻿//update--begin--author:scott date:20171031 for:TASK #2385 online和代码生成器 一对多行popup多字段赋值问题解决-----------
						    			var inpu = inputs[0]+"."+inputfield[i1];
						    			﻿//update--end--author:scott date:20171031 for:TASK #2385 online和代码生成器 一对多行popup多字段赋值问题解决------------- 
						    			$("input[name='"+inpu+"']").val(str);
						    		}else{
						    			$("input[name='"+inputfield[i1]+"']").val(str);
						    		}
						    	}else{
						    		if(inputs.length>1){
						    			﻿//update--begin--author:scott date:20171031 for:TASK #2385 online和代码生成器 一对多行popup多字段赋值问题解决-----------
						    			var inpu = inputs[0]+"."+inputfield[i1];
						    			﻿//update--end--author:scott date:20171031 for:TASK #2385 online和代码生成器 一对多行popup多字段赋值问题解决-----------
						    			$("input[name='"+inpu+"']").val("");
						    		}else{
						    			$("input[name='"+inputfield[i1]+"']").val("");
						    		}
						    	}
					    	}
				    	}else{
				    		//对应数据库字段为空的情况下并且字典CODE传入多个值时，根据表单中字典CODE的值从popup中来取值
				    		var inputfield = inputnames.split(",");
				    		if(inputfield.length>1){
				    			for(var i1=0;i1<inputfield.length;i1++){
									   var str = "";
								    	$.each( selected, function(i, n){ 
							    			if (i==0)
							    				str+= n[inputfield[i1]];
							    			else{
							    				str+= ",";
							    				str+=n[inputfield[i1]];
							    			}
										 });
								    	var inputname = $(pobj).attr("name"); 
								    	var inputs = inputname.split(".");
								    	if(str.indexOf("undefined")==-1){
								    		if(inputs.length>1){
								    			﻿//update--begin--author:scott date:20171031 for:TASK #2385 online和代码生成器 一对多行popup多字段赋值问题解决-----------
								    			var inpu = inputs[0]+"."+inputfield[i1];
								    			﻿//update--end--author:scott date:20171031 for:TASK #2385 online和代码生成器 一对多行popup多字段赋值问题解决-----------
								    			$("input[name='"+inpu+"']").val(str);
								    		}else{
								    			$("input[name='"+inputfield[i1]+"']").val(str);
								    		}
								    	}else{
								    		if(inputs.length>1){
								    			﻿//update--begin--author:scott date:20171031 for:TASK #2385 online和代码生成器 一对多行popup多字段赋值问题解决-----------
								    			var inpu = inputs[0]+"."+inputfield[i1];
								    			﻿//update--end--author:scott date:20171031 for:TASK #2385 online和代码生成器 一对多行popup多字段赋值问题解决-----------
								    			$("input[name='"+inpu+"']").val("");
								    		}else{
								    			$("input[name='"+inputfield[i1]+"']").val("");
								    		}
								    	}
							    	}
				    		}else{
				    			//对应数据库字段为空的情况下并且字典CODE传入一个值时，根据表单中字典TEXT的值从popup中来取值
				    			 var str = "";
						    	$.each( selected, function(i, n){
							    	if (i==0)
							    	str+= n[inputfield];
							    	else
						    		str+= ","+n[inputfield];
						    	});
						    	var inputname = $(pobj).attr("name"); 
						    	var inputs = inputname.split(".");
						    	if(str.indexOf("undefined")==-1){
						    		if(inputs.length>1){
						    			var inpu = inputs[i1]+"."+inputfield[i1];
						    			$("input[name='"+inpu+"']").val(str);
						    		}else{
						    			$("input[name='"+inputfield+"']").val(str);
						    		}
						    	}else{
						    		if(inputs.length>1){
						    			var inpu = inputs[i1]+"."+inputfield[i1];
						    			$("input[name='"+inpu+"']").val("");
						    		}else{
						    			$("input[name='"+inputfield+"']").val("");
						    		}
						    	}
				    		}
				    	}
				    	return true;
				    }
					
			    },
			    cancelVal: '关闭',
			    cancel: true // 为true等价于function(){}
			});
		}else{
			$.dialog({
				content: "url:cgReportController.do?popup&id="+pcode,
				zIndex: getzIndex(),
				lock : true,
				title:"选择",
				width:800,
				height: 400,
				parent:windowapi,
				cache:false,
			    ok: function(){
			    	iframe = this.iframe.contentWindow;
			    	var selected = iframe.getSelectRows();
			    	if (selected == '' || selected == null ){
				    	alert("请选择");
			    		return false;
				    }else {
				    	//对应数据库字段不为空的情况下,根据表单中字典TEXT的值来取popup的值
				    	if(tablefield != "" && tablefield != null){
					    	var fields = tablefield.split(",");
					    	var inputfield = inputnames.split(",");
					    	for(var i1=0;i1<fields.length;i1++){
							   var str = "";
						    	$.each( selected, function(i, n){ 
						    		if (i==0)
								    	str+= n[fields[i1]];
							    	else{
										str+= ",";
										str+=n[fields[i1]];
									}
								 });
						    	var inputname = $(pobj).attr("name"); 
						    	var inputs = inputname.split(".");
						    	//判断传入的this格式是否为 "AA[#index#].aa"的形式
						    	if(str.indexOf("undefined")==-1){
						    		if(inputs.length>1){
						    			var inpu = inputs[i1]+"."+inputfield[i1];
						    			$("input[name='"+inpu+"']").val(str);
						    		}else{
						    			$("input[name='"+inputfield[i1]+"']").val(str);
						    		}
						    	}else{
						    		if(inputs.length>1){
						    			var inpu = inputs[i1]+"."+inputfield[i1];
						    			$("input[name='"+inpu+"']").val("");
						    		}else{
						    			$("input[name='"+inputfield[i1]+"']").val("");
						    		}
						    	}
					    	}
				    	}else{
				    		//对应数据库字段为空的情况下并且字典CODE传入多个值时，根据表单中字典CODE的值从popup中来取值
				    		var inputfield = inputnames.split(",");
				    		if(inputfield.length>1){
				    			for(var i1=0;i1<inputfield.length;i1++){
									   var str = "";
								    	$.each( selected, function(i, n){ 
							    			if (i==0)
							    				str+= n[inputfield[i1]];
							    			else{
							    				str+= ",";
							    				str+=n[inputfield[i1]];
							    			}
										 });
								    	var inputname = $(pobj).attr("name"); 
								    	var inputs = inputname.split(".");
								    	if(str.indexOf("undefined")==-1){
								    		if(inputs.length>1){
								    			var inpu = inputs[i1]+"."+inputfield[i1];
								    			$("input[name='"+inpu+"']").val(str);
								    		}else{
								    			$("input[name='"+inputfield[i1]+"']").val(str);
								    		}
								    	}else{
								    		if(inputs.length>1){
								    			var inpu = inputs[i1]+"."+inputfield[i1];
								    			$("input[name='"+inpu+"']").val("");
								    		}else{
								    			$("input[name='"+inputfield[i1]+"']").val("");
								    		}
								    	}
							    	}
				    		}else{
				    			//对应数据库字段为空的情况下并且字典CODE传入一个值时，根据表单中字典TEXT的值从popup中来取值
				    			 var str = "";
						    	$.each( selected, function(i, n){
							    	if (i==0)
							    	str+= n[inputfield];
							    	else
						    		str+= ","+n[inputfield];
						    	});
						    	var inputname = $(pobj).attr("name"); 
						    	var inputs = inputname.split(".");
						    	if(str.indexOf("undefined")==-1){
						    		if(inputs.length>1){
						    			var inpu = inputs[i1]+"."+inputfield[i1];
						    			$("input[name='"+inpu+"']").val(str);
						    		}else{
						    			$("input[name='"+inputfield+"']").val(str);
						    		}
						    	}else{
						    		if(inputs.length>1){
						    			var inpu = inputs[i1]+"."+inputfield[i1];
						    			$("input[name='"+inpu+"']").val("");
						    		}else{
						    			$("input[name='"+inputfield+"']").val("");
						    		}
						    	}
				    		}
				    	}
				    	return true;
				    }
					
			    },
			    cancelVal: '关闭',
			    cancel: true // 为true等价于function(){}
			});
		}
	}
//add--end--Author:gengjiajia date:20160802 for: TASK #1175 批量添加数据的时popup多值的传递

/*
 * 鼠标放在图片上方，显示大图
 */
var bigImgIndex = null;
function tipImg(obj){
	try{
		var navigatorName = "Microsoft Internet Explorer"; 
		if( navigator.appName != navigatorName ){ 
			if(obj.nodeName == 'IMG'){
				var e = window.event;
				var x = e.clientX+document.body.scrollLeft + document.documentElement.scrollLeft
				var y = e.clientY+document.body.scrollTop + document.documentElement.scrollTop 
				var src = obj.src;
				var width = obj.naturalWidth;
				var height = obj.naturalHeight;
				bigImgIndex = layer.open({
					content:[src,'no'],
					type:2,
					offset:[y+"px",x+"px"],
					title:false,
					area:[width+"px",height+"px"],
					shade:0,
					closeBtn:0
				});
			}
		}
	}catch(e){
		
	}
	
}

function moveTipImg(){
	try{
		if(bigImgIndex != null){
			layer.close(bigImgIndex);
		}
	}catch(e){
		
	}
}
function treeFormater(value,row,index){
	if(value != null && value != ''){
			var result = $.ajax({
				url:'categoryController.do?tree',
				type:'POST',
				dataType:'JSON',
				data:{
					selfCode:value
				},
				async:false
			});
		var responseText = result.responseText;
		if(typeof responseText == 'string'){
			responseText = JSON.parse(responseText);
		}
		if(responseText.length != undefined && responseText.length > 0 && responseText[0].text != undefined){
			return responseText[0].text;
		}
		else
			return value;
		}else{
			return value;
		}
}
//<!-- update-begin-author:zhangjiaqiang date:20170815 for:TASK #2274 【online】Online 表单支持树控件 -->