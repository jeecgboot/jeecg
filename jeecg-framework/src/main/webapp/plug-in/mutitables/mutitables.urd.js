function updatePms(title,url, id,width,height,isRestful) {
	//var rowsData = $('#'+id).datagrid('getSelections');
	var rowsData = $('#'+id).datagrid('getChecked');
	if (!rowsData || rowsData.length==0) {
		topWinTip('请选择编辑项目');
		return;
	}
	if (rowsData.length>1) {
		topWinTip('请选择一条记录再编辑');
		return;
	}
	if(isRestful!='undefined'&&isRestful){
		url += '/'+rowsData[0].id;
	}else{
		url += '&id='+rowsData[0].id;
	}
	gridname = id;
	createwindow(title,url,width,height);
}

function detailPms(title,url, id,width,height) {
	var rowsData = $('#'+id).datagrid('getChecked');
	if (!rowsData || rowsData.length == 0) {
		topWinTip('请选择查看项目');
		return;
	}
	if (rowsData.length > 1) {
		topWinTip('请选择一条记录再查看');
		return;
	}
    url += '&load=detail&id='+rowsData[0].id;
	createdetailwindow(title,url,width,height);
}
function updateByMenu(title,url,dgname,width,height) {
	createwindow(title,url,width,height);
}
function detailByMenu(title,url,dgname,width,height) {
	url += '&load=detail';
	createdetailwindow(title,url,width,height);
}
function delObjPms(id,url){
	//不带遮罩
	deleteRecord(id,url)
}
function deleteMainRecord(id,url,index){
	deleteRecord(id,url,'',true);
}

function deleteRecord(id,url,tip,flag){
	if(!tip){
		tip = "确认删除该条数据吗？";
	}
	url+="&id="+id;
	$.dialog.setting.zIndex = getzIndex(true);
	layer.open({
		title:'删除确认',
		content:tip,
		icon:7,
		shade: 0,
		yes:function(index){
			$.ajax({
				async : false,
				cache : false,
				type : 'GET',
				url : url,// 请求的action路径
				error : function() {// 请求失败处理函数
				},
				success : function(data) {
					var d = $.parseJSON(data);
					if (d.success) {
						topWinTip(d.msg);
						reloadTable();
						if(flag){
							refreshSubTable();//刷新子表
						}
					}
				}
			});
			layer.close(index);
		},
		btn:['确定','取消'],
		btn2:function(index){
			layer.close(index);
		}
	});
}
/**
 * 多记录刪除請求
 * @param title
 * @param url
 * @param gname
 * @return
 */
function deleteALLSelectPms(confirm,url,gname,flag) {
    var ids = [];
    var rows = $("#"+gname).datagrid('getSelections');
   // var rows = $("#"+gname).datagrid('getChecked');
    if (rows.length > 0) {
    	$.dialog.setting.zIndex = getzIndex(true);
    	if(!confirm){
    		confirm = '你确定永久删除选中数据吗?';
    	}
    	$.dialog.confirm(confirm, function(r) {
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
							topWinTip(msg);
							reloadTable();
							$("#"+gname).datagrid('unselectAll');
							ids='';
							if(flag){
								refreshSubTable();//刷新子表
							}
						}
					}
				});
			}
		});
	} else {
		topWinTip("请选择需要删除的数据!");
	}
}

/**
 * dataGrid 操作菜单 切换显示
 * @param data
 * @returns
 */
function optsMenuToggleBydg(dgPanel){
/*	 var tr = dgPanel.find('div.datagrid-body tr');
	 tr.each(function(){   
	     var td = $(this).children('td[field="opt"]'); 
	     td.hover(function(){
				$(this).find(".opts-menus-parent").show();
			},function(){
				$(this).find(".opts-menus-parent").hide();
			});
	 }); */
	
 	 var tr = dgPanel.find('div.datagrid-body tr');
 	  tr.each(function(){   
 	     var td = tr.children('td[field="opt"]'); 
 	     td.hover(function(){
 			},function(){
 				$(this).children(".datagrid-cell").removeClass("opt-menus");
 			});
 		 var bbtn = tr.find(".opts_menu_btn");
 		 bbtn.hover(function(){
 				$(this).closest(".datagrid-cell").addClass("opt-menus");
 			},function(){
 			});
 	 }); 
}

/**
 * 添加小图标
 */
function addEditRowOptBtn(gname,index){
	//cancel-row-div
	var state = $.data($("#"+gname)[0], 'datagrid');
	var tableBody = state.dc.view2.find('div.datagrid-body').children('table').children('tbody');
	var btn = "<div class='opts_menu_container' style='left:30%'><a href='####' class='cancel-row-btn btn-menu' onclick='cancelAddingRow(\""+gname+"\","+index+")' title='删除该行'><i class='fa fa-minus'></i></a></div>";
	tableBody.children("tr:eq("+index+")").find("td[field='opt']").find("div").html(btn);
}
/**
 * 删除行编辑新增行
 */
function cancelAddingRow(gname,index){
	try{
		$("#"+gname).datagrid('cancelEdit',index);
		$("#"+gname).datagrid('deleteRow',index);
	}catch(error){
		console.log("cancelAddingRow exception occurred:"+error);
		$("#"+gname).datagrid('reload');
	}
}
/**
 * 日期框初始化去掉时分秒
 */
 function initDateboxformat(){
	var a = $(this).datebox('getText');
	if(a.length>10){
		$(this).datebox('setText', a.substr(0,10));
	}
 }
 
/**
 * 行编辑保存数据
 * @param title
 * @param addurl
 * @param gname
 * @returns
 */
function saveData(addurl,gname){
	if(!endEdit(gname))
		return false;
	var rows=$('#'+gname).datagrid("getChanges","inserted");
	var uprows=$('#'+gname).datagrid("getChanges","updated");
	rows=rows.concat(uprows);
	if(rows.length<=0){
		topWinTip("没有需要保存的数据！")
		return false;
	}
	var result={};
	for(var i=0;i<rows.length;i++){
		for(var d in rows[i]){
			//TODO 列表名和page中list属性名要对应上
			result[gname+"["+i+"]."+d]=rows[i][d];
		}
	}
	//<%=basePath%>/"
	var mainInput = $("#"+gname+"MainId");
	if(!!mainInput){
		addurl+="&mainId="+mainInput.val();
	}
	$.ajax({
		url:addurl,
		type:"post",
		data:result,
		dataType:"json",
		//contentType: "application/json",
		success:function(data){
			topWinTip(data.msg);
			if(data.success){
				$('#'+gname).datagrid('reload');    
				//reloadTable();
			}
		}
	})
}
//结束编辑
function endEdit(gname){
	var  editIndex = $('#'+gname).datagrid('getRows').length-1;
	for(var i=0;i<=editIndex;i++){
		if($('#'+gname).datagrid('validateRow', i)){
			$('#'+gname).datagrid('endEdit', i);
		}else{

			topWinTip("请输入有效的内容!");

			return false;
		}
	}
	return true;
}

/*-------------------------------文件图片formatter---------------------------------------*/
function formatterImg(value,rec,index){
	return  listFileImgFormat(value,"image");
  }
  
  function formatterFile(value,rec,index){
	  return listFileImgFormat(value);
  }
//列表文件图片 列格式化方法
  function listFileImgFormat(value,type){
  	var href='';
  	if(value==null || value.length==0){
  		return href;
  	}
  	var value1 = "systemController/showOrDownByurl.do?dbPath="+value;
  	if("image"==type){
   		href+="<img src='"+value1+"' width=30 height=30  onmouseover='tipImg(this)' onmouseout='moveTipImg()' style='vertical-align:middle'/>";
  	}else{
   		if(value.indexOf(".jpg")>-1 || value.indexOf(".gif")>-1 || value.indexOf(".png")>-1){
   			href+="<img src='"+value1+"' onmouseover='tipImg(this)' onmouseout='moveTipImg()' width=30 height=30 style='vertical-align:middle'/>";
   		}else{
   			var value2 = "systemController/showOrDownByurl.do?down=1&dbPath="+value;
   			href+="<a href='"+value2+"' class='ace_button' style='text-decoration:none;' target=_blank><u><i class='fa fa-download'></i>点击下载</u></a>";
   		}
  	}
  	return href;
  }
 /*-----------------------------------------------------------------------------*/
  
 /*---------------------------------自定义验证--------------------------------------------*/
 $.extend($.fn.validatebox.defaults.rules,{
	 phoneRex: {
	   validator: function(value){
		   var rex=/^13[0-9]{9}$|14[0-9]{9}|15[0-9]{9}$|17[0-9]{9}$|18[0-9]{9}$/;
		   var rex2=/^((0\d{2,3})-)(\d{7,8})(-(\d{3,}))?$/;
		   if(rex.test(value)||rex2.test(value)){
		     return true;
		   }else{
		      return false;
		   }
	   },
	   message: '请输入正确电话或手机格式'
	 }
  },{
	decimalFour:{
	  validator: function(value){
		  var rex=/^0\.\d{1,4}$/;
		  if(rex.test(value)){
			 return true;
		  }else{
		     return false;
		  }
	  },
	  message: '请输入0-1之间至多四位的小数'
  	}  
  },{
    decimalTwo:{
	  validator: function(value){
		  var rex= /^([0-9]\d{0,16})(\.\d{1,2})?$/;
		  if(rex.test(value)){
			 return true;
		  }else{
		     return false;
		  }
	  },
	  message: '最多保留两位小数'
  	}  
  },{
	decimalSix:{
		  validator: function(value){
			  var rex=/^0\.\d{1,6}$/;
			  if(rex.test(value)){
				 return true;
			  }else{
			     return false;
			  }
		  },
		  message: '请输入0-1之间至多6位的小数'
	  	}  
	  });
/*---------------------------------自定义验证--------------------------------------------*/


/**
 * tip以浏览器窗口为基准
 * @param msg
 * @returns
 */
function topWinTip(msg,w,h){
	if(!w)w = 290;
	if(!h)h = 130;
	var wid = $(top.window).width()-w;
	var hei = $(top.window).height()-h;
	var icon = 7;
	if(msg.indexOf("成功") > -1){
		icon = 1;
	}else if(msg.indexOf("失败") > -1){
		icon = 2;
	}
	top.layer.open({
		title:'提示信息',
		offset: [hei+'px', wid+'px'],
		area: [(w-8)+'px', (h-8)+'px'],
		content:msg,
		time:3000,
		btn:false,
		shade:false,
		icon:icon,
		shift:2
	});
	
}
function topWinTip2(msg){
	var wid = $(window).width()-290;
	var hei = $(top.window).height()-130;
	
	var icon = 7;
	if(msg.indexOf("成功") > -1){
		icon = 1;
	}else if(msg.indexOf("失败") > -1){
		icon = 2;
	}
	parent.layer.open({
		title:'提示信息',
		//offset:'rb',
		offset: [hei+'px', wid+'px'],
		area: ['273px', '130px'],
		content:msg,
		time:300000,
		btn:false,
		shade:false,
		icon:icon,
		shift:2,
	    success: function(layero, index){
	    	console.log($("#layui-layer"+index).css("top")+"--"+$("#layui-layer"+index).css("left"));
		}
	});
}


/* 扩展窗口外部方法 */
$.dialog.notice = function( options )
{
    var opts = options || {},
        api, aConfig, hide, wrap, top,
        duration = opts.duration || 800;
        
    var config = {
        id: 'Notice',
        left: '100%',
        top: '100%',
        fixed: true,
        drag: false,
        resize: false,
        init: function(here){
            api = this;
            aConfig = api.config;
            wrap = api.DOM.wrap;
            top = parseInt(wrap[0].style.top);
            hide = top + wrap[0].offsetHeight;
                        
            wrap.css('top', hide + 'px')
            .animate({top: top + 'px'}, duration, function(){
                opts.init && opts.init.call(api, here);
            });
        },
        close: function(here){
            wrap.animate({top: hide + 'px'}, duration, function(){
                opts.close && opts.close.call(this, here);
                aConfig.close = $.noop;
                api.close();
            });
                        
            return false;
        }
    };
        
    for(var i in opts)
    {
        if( config[i] === undefined ) config[i] = opts[i];
    }
        
    return $.dialog( config );
};
function topWinTip3(msg){
	/* 调用示例 */
	$.dialog.notice({
	    title: '提示信息',
	    width: 220,  /*必须指定一个像素宽度值或者百分比，否则浏览器窗口改变可能导致lhgDialog收缩 */
	    content:msg,
	    time: 5
	});
}

function showHeaderMenus(obj){
	 var field = $(obj).closest("td").attr("field");
	 headerMenu("",field);
}
//初始化下标
function resetTrXh(tableId) {
	var lastIndex = 1;
	$("#"+tableId+"").find('>tr').each(function(i){
		var ixh = $(this).find(">td.xh").find("input").val();
		if(!!ixh && ixh>lastIndex){
			lastIndex = ixh;
		}
	});
	$("#"+tableId+"").children("tr").last().children("td.xh").children("input").val(parseInt(lastIndex)+1);
}