<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0" />
<link rel="stylesheet" href="plug-in/easyui/themes/metrole/easyui.css" type="text/css"></link>
<link rel="stylesheet" href="plug-in/easyui/themes/metrole/icon.css" type="text/css"></link>
<link rel="stylesheet" href="plug-in/ace/css/font-awesome.css" type="text/css"></link>
<link rel="stylesheet" href="plug-in/mutitables/mutitables.mainpage.css" type="text/css"></link>
<t:base type="jquery"></t:base>
<script type="text/javascript" src="plug-in/themes/fineui/jquery/jquery.easyui.min.js"></script>
<script type="text/javascript" src="plug-in/layer/layer.js"></script>
<script type="text/javascript" src="plug-in/mutitables/mutitables.mainpage.js" ></script>
</head>
<body>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:1px;overflow-x:hidden;">
	<div class="tab-opts-menu" id="tab-menus-main" style="font-size:14px">
		<div class="opts-menu-box">
			<div class="menus active table-menu-1" style="top:30px">
				<!-- 主表菜单 -->
				<t:menuButtons codes="addgroup,editgroup,batchDel" name="jformOrderMain2" mm="true"></t:menuButtons>
			</div>
			<div class="menus table-menu-0" style="top:-1px">
				<a title="重置" onclick="mainPageQueryReset()" href="####" class="btn-menu fa fa-refresh menu-more" ></a>
				<a title="查询" onclick="associatedQuery('jformOrderMain2','jformOrderMain2List')" href="####" class="btn-menu fa fa-search menu-more"></a>
			</div>
		</div>
	</div> 

  	<!-- 上方 -->
	<div  id="accDiv" class="easyui-accordion" data-options="multiple:true" style="padding-right:0px;overflow-x:hidden;box-sizing: border-box;">
		<div title="订单信息查询" data-options="iconCls:'icon-ok'" style="height:100px;padding:10px 0px;overflow:hidden;box-sizing: border-box;">
		  <!-- 查询DIV 主表必须配置有高级查询才可用 -->
		  <div id="associated_query" style="">
			  <form class = "page-query">
			  	<span style="max-width: 83%;display: inline-block;display:-moz-inline-box;">
					<span style="display:-moz-inline-box;display:inline-block;margin-bottom:2px;text-align:justify;">
						<span style="vertical-align:middle;display:-moz-inline-box;display:inline-block;width: 90px;text-align:right;text-overflow:ellipsis;-o-text-overflow:ellipsis; overflow: hidden;white-space:nowrap;" >
							订单号：
						</span>
						<input type="text" name="jform_order_main.order_code" style="width: 120px" class="inuptxt">
					</span>
				</span>
			  </form>
		  </div>
		</div>
		
		<!-- 主表 --> 
		<div title="订单信息" data-options="iconCls:'icon-ok',selected:true"  >
			<div id="easyui_mainList" class="easyui-resizable"  style="height:275px;padding-bottom:6px;margin-bottom:6px;border-bottom:2px solid rgb(0, 116, 101)">
				<iframe id="mainList" height="99%" width="100%" frameborder="0" 
					src="${webRoot}/jformOrderMain2Controller.do?list"></iframe>
			</div>
		</div>
	</div>
	<!-- 上方end -->
		
	<!-- 从表菜单 -->
	<div class="tab-opts-menu" id="tab-menus-attached" style="font-size:14px">
		<div class="opts-menu-box">
			<div class="menus testContractItem-ul active">
				<t:menuButtons codes="ALL" name="jformOrderCustomer2"></t:menuButtons>
			</div>
			
			<div class="menus testContractPart-ul">
				<t:menuButtons codes="ALL" name="jformOrderTicket2"></t:menuButtons>
			</div>
		</div>
	 </div>
	 
	 <!-- 从表 -->
	 <div id="tabsok" style="height:500px">
	     <div title="订单客户" data-options="closable:false" style="overflow:hidden;box-sizing: border-box;">
			<iframe id="jformOrderCustomer2Iframe" scrolling="yes" frameborder="0" height="100%" width="100%"
				src="${webRoot}/jformOrderCustomer2Controller.do?list">
			</iframe>
		 </div>
		 <div title="订单机票" data-options="closable:false" style="overflow:hidden;box-sizing: border-box;">
			<iframe id="jformOrderTicket2Iframe" scrolling="yes" frameborder="0" height="100%" width="100%"
				src="${webRoot}/jformOrderTicket2Controller.do?list">
			</iframe>
		 </div>
	  </div>
	  <!-- 从表end -->

   </div>
   <!-- center end -->
</div>

<div style="display:none">
	<!-- 激活选项卡再刷新页面需要该隐藏域 -->
	<input type="hidden" id="mainPageHiddenId">
	<select id="mainPageFrameActived" style="display:none">
		<option value="jformOrderCustomer2" selected="selected"></option>
		<option value="jformOrderTicket2"></option>
	</select>
</div>
<script type="text/javascript">
$(function(){
 	initdivwidth();
	var menu_top1 = "78px",menu_top2 = '30px';
	$('#accDiv').children(".panel:first-child").children('.panel-header').click(function(){
		toggleMainMenusTop(menu_top1,menu_top2);
	});
	$('#accDiv').children(".panel:first-child").find('.panel-tool a').click(function(){
		toggleMainMenusTop(menu_top1,menu_top2);
	});
	$(window).resize(function(){
		initdivwidth();
	}); 
	var tabsok = $('#tabsok').tabs({
		narrow: true,
		tabPosition:'top',
		noheader:true,
		tools:[{iconCls:'accordion-collapse',handler:function(){diyAccordianForTabs(this,'tabsok',500)}}],
		onSelect:function(title,index){
			toggleMenus(index);
			initSubList(0);
	    }
	});
	
	$("#tabsok").find(".tabs-header .tabs-wrap").click(function(event){
		//event.stopPropagation();
		var tagname = event.target.tagName.toLowerCase();
		if(tagname=='ul'){
			$("#tabsok").find(".tabs-header .tabs-tool").find("a.l-btn").trigger("click");
			//event.stopPropagation();
		}else{
			if($("#tabsok").find(".tabs-tool").find('span.l-btn-icon').hasClass("accordion-expand")){
				return false;
			}
		}
	});
	
 	$('#accDiv').accordion({
		onSelect:function(title,index){
			$('#tab-menus-main').find('.table-menu-'+index).addClass("active");
	 	},
		onUnselect:function(title,index){
	 		$('#tab-menus-main').find('.table-menu-'+index).removeClass("active");
		}
	}); 
});

</script>
<!-- 需要改变的是每个iframe的src;子表iframe的id ;mainPageFrameActived中的option的value -->
</body>