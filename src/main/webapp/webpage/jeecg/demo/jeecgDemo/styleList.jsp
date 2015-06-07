<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01//EN"
   "http://www.w3.org/TR/html4/strict.dtd">

<html lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=9" > </meta>
<title>自定义表单样式示例</title>
<style type="text/css">
body{
	margin:0px;
	font-family:Arial,"宋体",Verdana,sans-serif;
	font-size:12px;
}
html,body {padding: 0;margin: 0; overflow-x:hidden; overflow-y:auto;}
dl,dd{margin:0px}
ul{
	list-style-type:none;
	margin:0px;
	padding:0px;
}
</style>
<t:base type="jquery,easyui,tools"></t:base>
<link rel="stylesheet" href="plug-in/easyui/themes/main.css" />

</head>
<body>
 
<script language="javascript"> 
$.fn.dialog.defaults.top=100;
//$.fn.combo.defaults.height=308;
/* $.fn.combo.defaults=$.extend({},$.fn.combo.defaults,{heihgt:28} } */


//时间公共getFormatDateByLong(value, "yyyy-MM-dd")
    Date.prototype.format = function (format) {  
        var o = {  
            "M+": this.getMonth() + 1,  
            "d+": this.getDate(),  
            "h+": this.getHours(),  
            "m+": this.getMinutes(),  
            "s+": this.getSeconds(),  
            "q+": Math.floor((this.getMonth() + 3) / 3),  
            "S": this.getMilliseconds()  
        };  
        if (/(y+)/.test(format)) {  
            format = format.replace(RegExp.$1, (this.getFullYear() + "").substr(4 - RegExp.$1.length));  
        }  
        for (var k in o) {  
            if (new RegExp("(" + k + ")").test(format)) {  
                format = format.replace(RegExp.$1, RegExp.$1.length == 1 ? o[k] : ("00" + o[k]).substr(("" + o[k]).length));  
            }  
        }  
        return format;  
    };  
    function getFormatDateByLong(l, pattern) {  
        return getFormatDate(new Date(l*1000), pattern);  
    }     
    
    function getFormatDate(date, pattern) {  
        if (date == undefined) {  
            date = new Date();  
        }  
        if (pattern == undefined) {  
            pattern = "yyyy-MM-dd hh:mm:ss";  
        }  
        return date.format(pattern);  
    }
    
    function newTab(title,url){
    	parent.addTab1(title,url);
    }
    
    $.extend($.fn.validatebox.defaults.rules, {
        mobile: {
            validator: function (value, param) {
            	if(value==""){
            		return false;
            	}
                return /^0?(13[0-9]|15[012356789]|18[0236789]|14[57]|170)[0-9]{8}$/.test(value);
            },
            message: '手机号码不正确'
        },
        tel: {
            validator: function (value, param) {
                return /^((\+86)?|\(\+86\)|\+86\s)0?([1-9]\d-?\d{6,8}|[3-9][13579]\d-?\d{6,7}|[3-9][24680]\d{2}-?\d{6})(-\d{3})?$/.test(value);
            },
            message: '固定电话号码不正确'
        },
        money:{
        	validator: function (value, param) {
                return /^(([1-9]\d*)|\d)(\.\d{1,2})?$/.test(value);
            },
            message: '只能为浮点数并且不能为空'
        }
    });
    
    
	var isScroll = function (el) {  
	    // test targets  
	    var elems = el ? [el] : [document.documentElement, document.body];  
	    var scrollX = false, scrollY = false;  
	    for (var i = 0; i < elems.length; i++) {  
	        var o = elems[i];  
	        // test horizontal  
	        var sl = o.scrollLeft;  
	        o.scrollLeft += (sl > 0) ? -1 : 1;  
	        o.scrollLeft !== sl && (scrollX = scrollX || true);  
	        o.scrollLeft = sl;  
	        // test vertical  
	        var st = o.scrollTop;  
	        o.scrollTop += (st > 0) ? -1 : 1;  
	        o.scrollTop !== st && (scrollY = scrollY || true);  
	        o.scrollTop = st;  
	    }  
	    // ret  
	    return {  
	        scrollX: scrollX,   
	        scrollY: scrollY  
	    };  
	};  
	$(function(){
		resetBtn();
	}); 
	
	$(window).resize(function() {
		resetBtn();
	})
	
	function resetBtn(){
		 if(isScroll().scrollY){
		    	$(".buttonWrap").addClass("fixed");
		    }else{
		    	$(".buttonWrap").removeClass("fixed");
		    }
	}

</script> 

<div id="goodsSelectDiv"></div>
<div id="photoDiv"></div><style>
.input_text{
	width: 150px;
}
</style>
<div id="loading"></div>
<div class="main">
	<form id="mutiLangListtb">
		<div class='buttonArea'>
			<div style="float:left;">
			<!-- <a href="javascript:void(0)" class="easyui-linkbutton"
				data-options="plain:true" onclick="append()">添加</a> -->
			<a href="javascript:void(0)" class="button " data-options="plain:true" onclick="doSubmit('mutiLangController.do?refreshCach','mutiLangList',null,null)" >刷新</a>
			</div>
			 <span style="float: right;height:28px;"> 
			 	<a href="javascript:void(0)" class="button b_fr" data-options="plain:true" id="aAdvanced" >高级搜索</a>
			 	<a href="javascript:void(0)" class="button b_fr" id="search" data-options="plain:true" onclick="mutiLangListsearch()">搜索</a>
				<input id="langContext" name="langContext" class="input_text b_fr mr5" type="text" value="" size="30" placeholder="请输入搜索内容"  />
			</span>
		</div>

		<div  style="display: block;" class="searchAdvanced">
			<input id="Advanced" name="Advanced" type="hidden" value="0" />
			<table width="98%" border="0" cellspacing="0" cellpadding="8">
				<tr>
					<td width="70" align="right">语言Key</td>
					<td><input type="text" value="" id="langKey" name="langKey" class="input_text">
					</td>

					<td width="70" align="right"></td>
					<td>  </td>

					<td width="70" align="right">语言</td>
					<td><select name="langCode" id="langCode" class="inputSelect valid">
							<option value="">---所有---</option> 
								<option value="zh-cn">中文</option>
								<option value="en">英文</option>
					</select></td>

					<td width="70" align="right"></td>
					<td></td>
				</tr>
				<tr>
					<td width="70" align="right"></td>
					<td colspan="7" align="center"><a id="searchAdvance"
						class="button blueButton" onclick="mutiLangListsearch()"
						href="javascript:;">开始搜索</a></td>
				</tr>
			</table>
		</div>

		<div class="clear height10"></div>
		<!-- 
		<div class="shadowBoxWhite tableDiv">
			<table class="easyui-datagrid"
				data-options="url:'json.json',pageList: [5,10,15,20],pageSize:10,fitColumns:'true',queryParams:{'complete':''}"
				pagination="true" width="width" id="orderdata" sortName="order_id" sortOrder="desc">
				<thead>
					<tr>
						<th data-options="field:'order_id',checkbox:true,width:100"></th>
						<th data-options="field:'sn',width:150" formatter="forsn">订单号</th>
						<th data-options="field:'create_time',width:100,sortable:'true'" formatter="formatDate" >下单日期</th>
						<th data-options="field:'sale_cmpl_time',width:100,sortable:'true'" formatter="formatDate">发货日期</th>		
						<th data-options="field:'need_pay_money',width:100,sortable:'true'" formatter="forMoney">订单总额</th>
						<th data-options="field:'paymoney',width:100,sortable:'true'" formatter="forMoney">实付金额</th>
						<th data-options="field:'ship_name',width:100">收货人</th>
						<th data-options="field:'status',width:100,sortable:'true'" formatter="forStruts">订单状态</th>
						<th data-options="field:'pay_status',width:100,sortable:'true'" formatter="forpay" >付款状态</th>
						<th data-options="field:'ship_status',width:100,sortable:'true'" formatter="forship">发货状态</th>
						<th data-options="field:'shipping_type',width:100,sortable:'true'">配送方式</th>
						<th data-options="field:'payment_name',width:100,sortable:'true'">支付方式</th>
						<th data-options="field:'action',width:100" formatter="formatAction">操作</th>
					</tr>
				</thead>
			</table>
		</div> -->
		<div class="shadowBoxWhite tableDiv">
			<table class="easyui-datagrid"
				data-options="striped:true,url:'mutiLangController.do?datagrid&field=id,langKey,langContext,langCode',pageList: [5,10,15,20],pageSize:10,fitColumns:'true',queryParams:{'complete':''}"
				pagination="true" width="width" id="mutiLangList" sortName="id" sortOrder="desc">
				<thead>
					<tr>
						<th data-options="field:'id',checkbox:true,width:100"></th>
						<th data-options="field:'langKey',width:150" formatter="forsn" >语言Key</th>
						<th data-options="field:'langContext',width:100,sortable:'true'"   >内容</th>
						<th data-options="field:'langCode',width:100,sortable:'true'" formatter="forlang" >语言</th>		
						<th data-options="field:'opt',width:100" formatter="formatAction" >操作</th>
					</tr>
				</thead>
			</table>
		</div>
	</form>
</div>
<script type="text/javascript">
	function forsn(value,row,index){
		var val="<a href='#' onclick=\"add('语言编辑','mutiLangController.do?addorupdate&load=detail&id="+row.id+"','mutiLangList',null,null)\">"+row.langKey+"</a>"
		return val;
	}
	function forMoney(value, row, index) {
		var val = "￥" + value;
		return val;
	}
	function formatDate(value,row,index){
		if(value==null||value==0){
			return "";
		}
		else{
			return getFormatDateByLong(value, "yyyy-MM-dd");
		}
		
	}
	
	
	//语言翻译
	function forlang(value,row,index){
		var val;
		val = getType({"zh-cn":"中文","en":"英文","jp":"日文"},value);
		return val;
	}
	
	
	
	function getType(exMap,value){
		var val;
		$.each(exMap,function(key,values){ 
		    if(value==key){
		    	val=values;
		    }
		});
		return val;
	}
	
	
	
	var buttons = $.extend([], $.fn.datebox.defaults.buttons);
	buttons.splice(1, 0, {
	text: '清空',
	handler: function(target){
		 $('#start_time').datebox('setValue',"");
	}
	});
	
	var e_buttons = $.extend([], $.fn.datebox.defaults.buttons);
	e_buttons.splice(1, 0, {
	text: '清空',
	handler: function(target){
		 $('#end_time').datebox('setValue',"");
	}
	});
    
    
function formatAction(value,row,index){
	var val="<a class='edit' title='查看' href='#' onclick=\"add('查看','mutiLangController.do?addorupdate&id="+row.id+"','mutiLangList',null,null)\" ></a>";
	return val;
		
	}
	
	$(function(){
		$(".searchAdvanced").hide();
		//高级查询按钮
	    $("#aAdvanced").click(function () {
	        if ($("#Advanced").val() == "0") {
	            $("#Advanced").val(1);
	            $("#simpleSearch").hide();
	            //$("#aAdvanced").text("简单搜索")
	            $("#aAdvanced").addClass("searchAdvancedS");
	        } else {
	            $("#Advanced").val(0);
	            $("#simpleSearch").show();
	            //$("#aAdvanced").text("高级搜索");
	            $("#aAdvanced").removeClass("searchAdvancedS");
	        }
	        $(".searchAdvanced").slideToggle("slow");
	    });
	})
	function mutiLangListsearch(){
		//var queryParams=$('#mutiLangList').datagrid('options').queryParams;
		$('#mutiLangListtb').find('*').each(function(){
			//queryParams[$(this).attr('name')]=$(this).val();
			});
		var langCode = $("#langCode").val();
		var langContext = $("#langContext").val();
		
		var langKey = $('#langKey').val();
		//$('#mutiLangList').datagrid({url:'mutiLangController.do?datagrid&field=id,langKey,langContext,langCode,',pageNumber:1});
		$("#mutiLangList").datagrid('load', {
			langKey:langKey,
			langContext:langContext,
			langCode:langCode,
			 page:1
	    });
	}
	

	function formatTime(value,row,index){
		var val = getFormatDateByLong(value, "yyyy-MM-dd");
		return val;
	}
</script>

</body>
</html>