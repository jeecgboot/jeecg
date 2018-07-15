<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>form_topjui</title>
<meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE"/>
<t:base type="jquery,easyui,tools"></t:base>
<style>
	/*下拉框样式开始*/
	.selectBox{
		width: 400px;
		height: 28px;
		line-height: 36px;
	}
	input::-ms-clear, input::-ms-reveal{
		/*clear去掉叉  reveal去掉眼睛;但是只能去掉ie10及以上，ie9及以下去不掉*/
	    display: none;  
	}
	
	.inputCase{
		position: relative;
		width: 100%;
		height: 100%;
		box-sizing: border-box;
	}
	.inputCase input.imitationSelect{
		width: 100%;
		height: 100%;
		box-sizing: border-box;
		border: 1px solid #ccc;
		display: block;
		text-indent: 20px;
		cursor: default;
	}
	.inputCase i.fa{
		position: absolute;
		right: 10px;
		top: 5px;
		font-size: 20px;
		z-index: 99999;
	}
	.inputCase .fa{
		cursor: pointer;
	}
	.inputCase .fa {
	    display: inline-block;
	    font: normal normal normal 14px/1 FontAwesome;
	    font-size: inherit;
	    text-rendering: auto;
	    -webkit-font-smoothing: antialiased;
	    -moz-osx-font-smoothing: grayscale;
	}
	.fa-caret-down:before {
	    content: "\f0d7";
	}
	.fa-caret-up:before {
	    content: "\f0d8";
	}
	.selectUl{
		display: none;
		padding: 0;
		margin: 0;
		border-bottom: 1px solid  #ccc;
		border-left: 1px solid  #ccc;
		border-right: 1px solid  #ccc;
	    max-height: 222px;
		overflow: auto;
		list-style-type: disc;
	    position: relative;
	    z-index: 10000;
	    background: white;
	}
	.selectUl::-webkit-scrollbar {
	    width: 10px;
	    height: 10px;
	    background-color: #F5F5F5;
	}
	.selectUl::-webkit-scrollbar-thumb {
	    background: #555;
	}
	.selectUl::-webkit-scrollbar-track {
	    background: #F5F5F5;
	}
	.selectUl li{
		height: 36px;
		line-height: 36px;
		list-style: none;
		text-indent: 20px;
		border-bottom: 1px dashed #ccc;
	}
	.selectUl li:hover{
		background: #ddd;
	}
	.selectUl li:last-child{
		border-bottom: 0 none;
	}
	/*下拉框样式结束*/
	/*文件框样式开始*/
	.form-label {
	    position: relative;
	    float: left;
	    display: block;
	    padding: 5px;
	    width: 120px;
	    font-weight: 400;
	    line-height: 20px;
	    text-align: right;
	    color: #666;
	}
	.textbox {
	    position: relative;
	    border: 1px solid #D3D3D3;
	    background-color: #fff;
	    vertical-align: middle;
	    display: inline-block;
	    overflow: hidden;
	    white-space: nowrap;
	    margin: 0;
	    padding: 0;
	    -moz-border-radius: 2px;
	    -webkit-border-radius: 2px;
	    border-radius: 2px;
	}
	.textbox .textbox-text {
	    border: 0;
	    margin: 0;
	    padding: 4px;
	    white-space: normal;
	    vertical-align: top;
	    outline-style: none;
	    resize: none;
	    -moz-border-radius: 2px;
	    -webkit-border-radius: 2px;
	    border-radius: 2px;
	}
	
	.textbox .textbox-button-right{
		position: absolute;
	    top: 0;
	    padding: 0;
	    vertical-align: top;
	    -moz-border-radius: 0;
	    -webkit-border-radius: 0;
	    border-radius: 0;
	    right: 0;
	    border-width: 0 0 0 1px;
	}
	.fa-folder:before {
	    content: "\f07b";
	}
	.l-btn {
	    margin: 0;
	  		overflow: hidden;
		cursor: pointer;
	    outline: 0;
	    text-align: center;
	    vertical-align: middle;
	    line-height: normal;
	    color: #444;
	    border: 1px solid #bbb;
	    background: -webkit-linear-gradient(top,#fff 0,#eee 100%);
	    background: -moz-linear-gradient(top,#fff 0,#eee 100%);
	    background: -o-linear-gradient(top,#fff 0,#eee 100%);
	    background: linear-gradient(to bottom,#fff 0,#eee 100%);
	    background-repeat: repeat-x;
	    filter: progid:DXImageTransform.Microsoft.gradient(startColorstr=#ffffff, endColorstr=#eeeeee, GradientType=0);
	    /* -moz-border-radius: 2px;
	    -webkit-border-radius: 2px;
	    border-radius: 2px; */
	    padding: 0;
	}
	.l-btn-left {
		color: #444;
		position: relative;
	    margin: 0;
	    margin-top: 2px !important;
	    padding: 0;
	    vertical-align: top;
	    display: inline-block;
	    overflow: hidden;
	}
	.filebox-label {
	    width: 100%;
	    height: 100%;
	    cursor: pointer;
	    left: 0;
	    z-index: 10;
	}
	.filebox-label{
	    display: inline-block;
	       top: 0;
	    position: absolute;
	}
	.filebox .textbox-value {
	    vertical-align: top;
	    left: -5000px;
	}
	.filebox .textbox-value{
	    top: 0;
	    position: absolute;
	}
	
	.button, a.l-btn span.l-btn-left {
	    height: 24px;
	    cursor: pointer;
	    line-height: 20px;
	    display: inline-block;
	    color: rgb(68, 68, 68);
	    white-space: nowrap;
	    border-width: 0px;
	    border-left: 1px;
	    border-color: rgb(204, 204, 204);
	    border-image: initial;
	    border-radius: 0px;
	    background: -webkit-gradient(linear, 0 0, 0 100%, from(rgb(255, 255, 255)), to(rgb(242, 242, 242)));
	    padding: 3px 3px;
	}
	
	.button:hover, a.l-btn:hover span.l-btn-left {
	    border: 0px solid #76B4AC;
	    border-radius: 0px;
	    border-left: 1px;
	    background-color: #f7f5f5;
	    background: -webkit-gradient(linear, 0 0, 0 100%, from(#ffffff),
	 to(#f2f2f2));
	    background: -moz-gradient(linear, 0 0, 0 100%, from(#f7f7f7),
	 to(#f2f2f2));
	    background: -o-gradient(linear, 0 0, 0 100%, from(#e9e9e9), to(#f2f2f2));
	    background: -ms-gradient(linear, 0 0, 0 100%, from(#e9e9e9), to(#f2f2f2));
	    filter: progid:DXImageTransform.Microsoft.gradient(startcolorstr=#f7f7f7,
	 endcolorstr=#f2f2f2, gradientType=0);
	    color: #007465;
	    cursor: pointer;
	}
	/*文件框样式结束*/
</style>
</head>
<body>
<t:formvalid layout="div" formid="dd" dialog="" >

 <fieldset>
	 <legend>select</legend>
	  <table>
		<tr>
			<td style="width:90px;text-align: right;">省份：</td>
			<td>
				<div class="selectBox">
		        	<div class="inputCase">
						<input id="imitationSelect" class="imitationSelect" type="text" oulName="" oulId="" value=""/>
						<i class="fa fa-caret-down"></i>
					</div>
					<ul id="selectUl" class="selectUl"></ul>
		        </div>
			</td>
		</tr>
	 </table>
 </fieldset>

 <fieldset>
	<legend>文件上传</legend>
	<table>
		<tr>
			<td style="width:90px;text-align: right;">文件：</td>
			<td>
				<div id="uploader" class="wu-example">
				    <div class="btns">
				        <div class="file">
				            <div>
				                <span class="textbox easyui-fluid filebox" style="width: 400px; height: 28px;">
					                <a href="javascript:;" class="textbox-button textbox-button-right l-btn l-btn-small" style="height: 30px;position: absolute;top: -2px;">
						                <span class="l-btn-left l-btn-icon-left">
						                <span class="l-btn-text" style="float:right;font: 12px/normal 'microsoft yahei','Times New Roman',Times,serif;">选择</span>
						                <span class="l-btn-icon fa fa-folder">&nbsp;</span></span>
						                <label class="filebox-label" for="filebox_file_id_1"></label>
					                </a>
					                <input id="_easyui_textbox_input1" type="text" class="textbox-text validatebox-text textbox-prompt" autocomplete="off" readonly="readonly" style="margin: 0px 55px 0px 0px; padding-top: 0px; padding-bottom: 0px; height: 28px; line-height: 28px; width: 945px;">
					                <input type="file" class="textbox-value" id="filebox_file_id_1" name="filebox1">
				                </span>
				            </div>
				        </div>
				    </div>
				</div>
			</td>
		</tr>
	 </table>
	
 </fieldset>
 
</t:formvalid>

<script type="text/javascript">
	$(function(){
		//点击右边箭头icon时候
		$(".selectBox .fa").on("click",function(event){
			$(this).parent().next().toggle();//ul弹窗展开
			if($(this).hasClass("fa-caret-down")){
				$(this).removeClass("fa-caret-down").addClass("fa-caret-up")//点击input选择适合，小图标动态切换
			}else{
				$(this).addClass("fa-caret-down").removeClass("fa-caret-up")//点击input选择适合，小图标动态切换
			}
			if (event.stopPropagation) {   
	        	// 针对 Mozilla 和 Opera   
	        	event.stopPropagation();   
	        }else if (window.event) {   
	        	// 针对 IE   
	        	window.event.cancelBubble = true;   
	        }  
		});
		
		//注意async属性的使用，此处只能为false，否则无法为li添加事件
		$.ajax({
			url:'jeecgFormDemoController.do?regionSelect&pid=1',
			type:'GET',
			dataType:'JSON',
			async:false,
			delay: 250,
			cache: true,
			success: function(data){
				var cnt = "";
				for(var i = 0; i < data.length; i++){
					cnt+="<li oliName='"+data[i].name+"' oliId='"+data[i].id+"' style='z-index:10000;'>"+data[i].name+"</li>";
				}
				$("#selectUl").html(cnt);
			}
		});
		
		$(".selectUl li").on("click",function(event){
			event=event||window.event; 
			$(this).addClass("actived_li").siblings().removeClass("actived_li");//点击当前的添加。actived_li这个类；其他的移除这个类名
			var oliName = $(this).attr("oliName");//定义一个name属性，获取点击的元素属性赋值到当前，方便动态化传值
			var oliId = $(this).attr("oliId");//定义一个id属性，获取点击的元素属性赋值到当前，方便数据交互传值
			$(this).parent().prev().children().val(oliName); //把当前点击的name赋值到显示的input的val里面
			$(this).parent().prev().children().attr("oliName",oliName);//把当前点击的oliName赋值到显示的input的oliName里面
			$(this).parent().prev().children().attr("oliId",oliId);//把当前点击的oliId赋值到显示的input的oliId里面
		});
		
		//点击任意地方隐藏下拉
		$(document).click(function(event){
			event=event||window.event; 
			$(".inputCase .fa").removeClass("fa-caret-up").addClass("fa-caret-down")//当点隐藏ul弹窗时候，把小图标恢复原状
			$(".selectUl").hide();//当点击空白处，隐藏ul弹窗
		});
		
		$("#filebox_file_id_1").change(function(){
	   		var vl = $("#filebox_file_id_1").val();
	   		var valArr = vl.split("\\");
	   		$("#_easyui_textbox_input1").val(valArr[valArr.length-1]);
	   	});
	})
	
	
</script>
</body>
</html>
