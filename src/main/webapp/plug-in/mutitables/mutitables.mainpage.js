//新增弹框
function iframeGoAdd(mm){
	if(mm==1){
		$("#mainList")[0].contentWindow.curd.addForm();
	}else{
		var listname = $("#mainPageFrameActived").val();
		$("#"+listname+"Iframe")[0].contentWindow.curd.addForm();
	}
}
//修改弹框
function iframeGoUpdate(mm){
	if(mm==1){
		$("#mainList")[0].contentWindow.curd.update();
	}else{
		var listname = $("#mainPageFrameActived").val();
		$("#"+listname+"Iframe")[0].contentWindow.curd.update();
	}
}
//查看弹框
function iframeGoDetail(mm){
	if(mm==1){
		$("#mainList")[0].contentWindow.curd.detail();
	}else{
		var listname = $("#mainPageFrameActived").val();
		$("#"+listname+"Iframe")[0].contentWindow.curd.detail();
	}
}
//批量删除
function iframeDeleteAll(mm){
	if(mm==1){
		$("#mainList")[0].contentWindow.curd.batchDel();
	}else{
		var listname = $("#mainPageFrameActived").val();
		$("#"+listname+"Iframe")[0].contentWindow.curd.batchDel();
		//$("#"+listname+"Iframe")[0].contentWindow.deleteALLSelectPms('批量删除',listname+'Controller.do?doBatchDel',listname+"List");
	}
}
//行编辑新增
function iframeAddRow(mm){
	if(mm==1){
		$("#mainList")[0].contentWindow.curd.addRow();
	}else{
		var listname = $("#mainPageFrameActived").val();
		$("#"+listname+"Iframe")[0].contentWindow.curd.addRow();
	}
}
//行编辑保存
function iframeGoSaveRow(mm){
	if(mm==1){
		$("#mainList")[0].contentWindow.curd.saveRows();
	}else{
		var listname = $("#mainPageFrameActived").val();
		$("#"+listname+"Iframe")[0].contentWindow.curd.saveRows();
		//$("#"+listname+"Iframe")[0].contentWindow.saveData('提交修改',listname+'Controller.do?saveRows',listname+"List",null,null)
	}
}
//行编辑取消
function iframeRejectUpdate(mm){
	if(mm==1){
		$("#mainList")[0].contentWindow.curd.rejectUpdate();
	}else{
		var listname = $("#mainPageFrameActived").val();
		$("#"+listname+"Iframe")[0].contentWindow.curd.rejectUpdate();
		//$("#"+listname+"Iframe")[0].contentWindow.rejectUpdate(listname+"List");
	}
}

function iframeImportExcel(mm){
	if(mm==1){
		$("#mainList")[0].contentWindow.curd.excelImport();
	}else{
		var listname = $("#mainPageFrameActived").val();
		$("#"+listname+"Iframe")[0].contentWindow.curd.excelImport();
		//$("#"+listname+"Iframe")[0].contentWindow.myImportExcel(listname);
		//	openuploadwin('Excel导入', "pmsContractController.do?commonUpload&listname="+listname+"&mainId="+mainId, listname+"List");
	}
}
function iframeExportXlsByT(mm){
	if(mm==1){
		$("#mainList")[0].contentWindow.ExportXlsByT();
	}else{
		var listname = $("#mainPageFrameActived").val();
		$("#"+listname+"Iframe")[0].contentWindow.exportExcelTemplate();
	}
}
//数据导出
function iframeExportXls(mm){
	if(mm==1){
		$("#mainList")[0].contentWindow.ExportXls();
	}else{
		var listname = $("#mainPageFrameActived").val();
		$("#"+listname+"Iframe")[0].contentWindow.ExportXls();
	}
}

function iframeFilter(mm){
	if(mm==1){
		$("#mainList")[0].contentWindow.curd.doFilterit();
	}else{
		var listname = $("#mainPageFrameActived").val();
		$("#"+listname+"Iframe")[0].contentWindow.curd.doFilterit();
	}
}
//新增弹框
function tempNoDo(){
	topWinTip("版本升级中...");
}
//初始化子表list/刷新子表数据
function initSubList(id){
	id = iframeMainPageid(id);
	if(!id){
		console.log("主表无选中");
	}else{
		var listname = $("#mainPageFrameActived").val();
		$("#"+listname+"Iframe")[0].contentWindow.curd.initListByMain(id);
	}
}
//设置/获取隐藏域主表id
function iframeMainPageid(id){
	if(!id){
		return $("#mainPageHiddenId").val();
	}else{
		$("#mainPageHiddenId").val(id);
		return id;
	}
}
//删除主表数据后刷新子表
function freshSubList(){
	var id = iframeMainPageid(0);
	var listname = $("#mainPageFrameActived").val();
	$("#"+listname+"Iframe")[0].contentWindow.curd.initListByMain(id,1);
}
//切换子表的时候切换对应菜单的激活状态
function toggleMenus(index){
	$("#tab-menus-attached").find("div."+$('#mainPageFrameActived').val()+"-ul").removeClass("active");
	//console.log($("#mainPageFrameActived").val());
	$("#mainPageFrameActived").find("option:eq("+index+")").attr("selected","selected");
	//console.log($("#mainPageFrameActived").val());
	$("#tab-menus-attached").find("div."+$('#mainPageFrameActived').val()+"-ul").addClass("active");
}

/**
 * 自定义tab展开折叠
 * @param obj 捕获事件对象-tool上的a标签
 * @param outer tab最外层的DIV的id
 * @param maxH  tab最外层的高度
 * @returns
 */
function diyAccordianForTabs(obj,outer,maxH){
//TODO 当子表展开的时候判断主表是否被折叠 若是折叠则子表自动撑开整个页面而不是设置固定高度
	var claszz = $(obj).find('span.l-btn-icon').attr('class');
	if(claszz.indexOf('accordion-expand')>0){
		//accordianExpandit(obj,outer,maxH);
		//展开设置右上角样式
		$(obj).find('span.l-btn-icon').removeClass('accordion-expand');
		//展开直接调用show
		$("#"+outer).children('div.tabs-panels').show();
		//设置最外部div高度
		$("#"+outer).css('height',maxH);
		//展开后让tab移除disabled
		$("#"+outer).find(".tabs-header").find("li a").removeAttr("disabled");
		//展开后tab-header底部border移除
		$("#"+outer).find(".tabs-header").css("border-bottom",0);
		//展开后设置主表高度
		$("#easyui_mainList").css("height",320);
		$("#contractmenus").show();
		$("#tab-menus-attached").show();
		scrollToEndit();
	}
	else{
		$(obj).find('span.l-btn-icon').addClass('accordion-expand');
		//折叠
		$("#contractmenus").hide();
		$("#tab-menus-attached").hide();
		$("#"+outer).children('div.tabs-panels').hide();
		//.fadeOut('slow');
		//animate({'display':'none'},1000);
		$("#"+outer).css('height','45');
		$("#"+outer).find(".tabs-header").find("li a").attr('disabled',"true");
		$("#"+outer).find(".tabs-header").css("border-bottom","1px solid #ddd")
		$("#easyui_mainList").css("height",$(window).height()-($("#easyui_mainList").closest(".panel").prev().height()+30));
	}
}
//展开
function accordianExpandit(obj,outer,maxH){
	$(obj).find('span.l-btn-icon').removeClass('accordion-expand');
	//展开
	$("#"+outer).children('div.tabs-panels').show();
	//.animate({'display':'block'},1000);
	$("#"+outer).css('height',maxH);
	$("#"+outer).find(".tabs-header").find("li a").removeAttr("disabled");
	$("#"+outer).find(".tabs-header").css("border-bottom",0);
	scrollToEndit();
}
//滚动到底部
function scrollToEndit(){
   // var h = $(document).height()-$(window).height();
    //alert($(document).height()+"--"+$(window).height())
    //$(".body-iframe").scrollTop(1800); 
	//console.log($("#mainpage_contract_easyui").outerHeight(true)+"--"+$("#mainpage_contract_easyui").scrollTop()+"--"+$(document).height());
	//$('#mainpage_contract_easyui').scrollTop(500);
	$(".panel-body").animate({'scrollTop':450},400);
}

//宽度适应当前窗口
function initdivwidth(){
	var allw = document.body.clientWidth;
	var abc = parseInt(allw)-17;
	$("#accDiv").css("width", abc);
	$("#tabsok").css("width", abc);
	$("#tab-menus-attached").css("width", abc);
	$("#tab-menus-main").css("width", abc);
	
 	var singleWidth = 225;
 	var rowLen = Math.floor((allw-15)/singleWidth);
 	var alllen = $("#associated_query").find("span.query-item").length;
 	var lenOffset = Math.floor(alllen/rowLen);
 	$("#accDiv").accordion('getPanel',0).panel('resize',{height:lenOffset*30+100});
	var menu_top1 = (78+lenOffset*30)+"px",menu_top2 = '30px';
	$('#accDiv').children(".panel:first-child").children('.panel-header').click(function(){
		toggleMainMenusTop(menu_top1,menu_top2);
	});
	$('#accDiv').children(".panel:first-child").find('.panel-tool a').click(function(){
		toggleMainMenusTop(menu_top1,menu_top2);
	});
}

/**
 * 主表菜单top值改变
 * @returns
 */
function toggleMainMenusTop(menu_top1,menu_top2){
	var obj = $('#tab-menus-main').find('.table-menu-1');
	if(obj.hasClass("expty")){
		obj.removeClass("expty").animate({top:menu_top2},'500');
	}else{
		obj.addClass("expty").animate({top:menu_top1},'500');
	}
}
/**
 * 自定义可拖动改变高度
 * @returns
 */
function diyrResizeableForDIV(obj){
	var obj_style = obj.style;
	var x = 0,y = 0;
	$(obj).mousedown(function(e){
		y = e.clientY - obj.offsetHeight;
		obj.setCapture ? (obj.setCapture(),
				obj.onmousemove = function(ev) {
					diyMounseMoveForDIV(ev || event)
				},	
				obj.onmouseup = diyMounseUpForDIV
			): (
				$(obj).bind("mousemove",diyMounseMoveForDIV).bind("mouseup", diyMounseUpForDIV)
			)
            //防止默认事件发生 
            e.preventDefault();
		});
	function diyMounseMoveForDIV(e){
		var cursor = getCursorDiy(e);
		console.log(cursor);
		if(cursor==""){
			$(e.target).css("cursor","");
		}else{
			$(e.target).css("cursor",cursor+"-resize");
		}
		obj_style.height = e.clientY - y + 'px';
		console.log(e.clientY - y);
	}
	function diyMounseUpForDIV(){
		alert(12);
	obj.releaseCapture ? (obj.releaseCapture(),
				obj.onmousemove = obj.onmouseup = null
		) : (
				$(obj).unbind("mousemove", diyMounseMoveForDIV).unbind("mouseup", diyMounseUpForDIV)
        )
	}
	
	function getCursorDiy(e){
		var tt=$(e.target);
		var dir="";
		var _13=tt.offset();
		var _14=tt.outerWidth();
		var _15=tt.outerHeight();
		var _16=0;
		if(e.pageY>_13.top&&e.pageY<_13.top+_16){
		dir+="n";
		}else{
		if(e.pageY<_13.top+_15&&e.pageY>_13.top+_15-_16){
		dir+="s";
		}
		}
		if(e.pageX>_13.left&&e.pageX<_13.left+_16){
		dir+="w";
		}else{
		if(e.pageX<_13.left+_14&&e.pageX>_13.left+_14-_16){
		dir+="e";
		}
		}
		var _17='n, e, s, w, ne, se, sw, nw, all'.split(",");
		for(var i=0;i<_17.length;i++){
		var _18=_17[i].replace(/(^\s*)|(\s*$)/g,"");
		if(_18=="all"||_18==dir){
		return dir;
		}
		}
		return "";
	}; 
}
//重置查询
function mainPageQueryReset(){
	$("#associated_query").find(":input").val("");
	$("#mainList")[0].contentWindow.queryResetit();
}
//联合查询
function associatedQuery(queryCode,dgname){
	$.ajax({
		url:"commonController.do?superQueryExist&superQueryCode="+queryCode,
		type:"GET",
		dataType:"text",
		success:function(data){
			if(data=='yes'){
				doAssociatedQuery(queryCode,dgname);
			}else{
				$("#mainList")[0].contentWindow.topWinTip('请先去【在线开发->Online组合查询配置】配置相应的查询规则','',145);
			}
			
		}
	});
}
function doAssociatedQuery(queryCode,dgname){
	var sqlbuildArr = [];
	var sqlbuildObj = {};
	sqlbuildObj.queryCode = queryCode;
	sqlbuildObj.relation = "and";
	var childArr = [];
	$("#associated_query").find(":input").each(function(){
		if(!$(this).val()){
			return true;
		}
		var obj = {};
		var name = $(this).attr("name");
		var nameArr = name.split(".");
		obj.table = nameArr[0];
		obj.field = nameArr[1];
		if(this.tagName.toLowerCase()=='select'){
			obj.condition = "=";
			obj.value = $(this).val();
		}else{
			obj.condition = "like";
			obj.value = "%"+$(this).val()+"%";
		}
		childArr.push(obj);
	});
	sqlbuildObj.children = childArr;
	sqlbuildArr.push(sqlbuildObj);
	//console.log(JSON.stringify(sqlbuildArr)+"---"+dgname);
	$("#mainList").contents().find("#_complexSqlbuilder").val(JSON.stringify(sqlbuildArr));
	$("#mainList")[0].contentWindow[dgname+'search'].call(this);
}

function superQuery(){
	$("#mainList")[0].contentWindow.curd.superQuery();
}

