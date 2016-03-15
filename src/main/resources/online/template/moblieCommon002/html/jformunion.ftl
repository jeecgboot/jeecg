<#setting number_format="0.#####################">
﻿<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<meta name="keywords" content="Jeecg 移动表单" />
		<meta name="description" content="Jeecg 移动表单" />
		<title>Jeecg 移动表单</title>
		<link type="text/css" rel="stylesheet" href="online/template/${this_olstylecode}/css/formviewm.css" />
		<link type="text/css" rel="stylesheet" href="online/template/${this_olstylecode}/css/default.css" />
		<link type="text/css" rel="stylesheet" href="online/template/${this_olstylecode}/css/bootstrap.min.css" />
		<script type="text/javascript" src="online/template/${this_olstylecode}/js/head.load.min.js"></script>
		<script type="text/javascript" src="online/template/${this_olstylecode}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="online/template/${this_olstylecode}/js/lang-cn.js"></script>
		<script type="text/javascript" src="online/template/${this_olstylecode}/js/ajaxfileupload.js"></script>
		<script type="text/javascript" src="online/template/${this_olstylecode}/js/address-cn.js"></script>
		<script type="text/javascript" src="online/template/${this_olstylecode}/js/utils.js"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="plug-in/tools/dataformat.js"></script>
		<style id="__wechat_default_css">
			::-webkit-scrollbar{
				width: 10px;
				height: 10px;
				background-color: #FFF;
			}
			::-webkit-scrollbar-button:start:decrement,::-webkit-scrollbar-button:end:increment{
				display: block;
			}
			::-webkit-scrollbar-button:vertical:start:increment,::-webkit-scrollbar-button:vertical:end:decrement{
				display: none;
			}
			::-webkit-scrollbar-button:end:increment{
				background-color: transparent;
			}
			::-webkit-scrollbar-button:start:decrement{
				background-color: transparent;
			}
			::-webkit-scrollbar-track-piece:vertical:start{
				background-color: transparent;
			}
			::-webkit-scrollbar-track-piece:vertical:end{
				background-color: transparent;
			}
			::-webkit-scrollbar-thumb:vertical{
				background: rgb(191, 191, 191);
			}
		</style>
	</head>
	<body class="wallpaper wallpaperm">
	
 <script type="text/javascript">	
	$(function() {
		$("#btnSubmit").click(function(){
			if(validateForm()){
				$.post(
				   'cgFormBuildController.do?saveOrUpdate',
				   $("#form1").serialize(),
				   function(data){
				   	  var d = $.parseJSON(data);
				   	  if(data.success){
	            		alert(d.msg);
	            	  }else{
	            		alert(d.msg);
	            	  }
				   }
				);
			}
		});
	 });
	 
	 function validateForm(){
	 	
	 	var flag = true;
	 	$("#form1 input[datatype]").each(function(){
	 	  var value = $(this).val(),$this = $(this);
	 	  if(value == ''){
	 		$this.focus();
	 		var html = $this.parent().prev().html();
	 		var s = html.indexOf(":");
	 		var new_html = html.substring(0,s);
	 		alert($.trim(new_html)+'不能为空!');
	 		flag = false;
	 		return false;
	 	  }
	 	});
	 	return flag;
	 }
	
 </script>
 <body class="wallpaper wallpaperm">
 <div id="container" class="container" mobile="1">
 
 	<div>
		<h1 id="logo" class="logo"><a></a></h1>
	</div>
	
	<div class="ui-content">
		<form id="form1" class="form" action="cgFormBuildController.do?saveOrUpdateMore" name="form1" method="post">
			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<ul id="fields" class="fields">
				<input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
				<input type="hidden" name="id" value="${id?if_exists?html}" >
				<#list columnhidden as po>
				  <input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
				</#list>
				<!-- 引入主表内容 -->
				<#include "online/template/moblieCommon002/html/jformhead.ftl">
				
				<!--引入子表 -->
				<#assign subTableStr>${head.subTableStr?if_exists?html}</#assign>
				<#assign subtablelist=subTableStr?split(",")>
				<#list subtablelist as sub >
					<#if field['${sub}']?exists >
						<#include "online/template/moblieCommon002/html/jformonetomany.ftl">
					</#if>
				</#list>
				
				<#-- 提交按钮 -->
				<li>
					<input id="btnSubmit" type="button" class="btn-submit" value="提交" />
				</li>
				<div style="display:block !important;" class="powerby">由<a href="#">JEECG</a>提供技术支持</div>
			</ul>
		</form>
	</div>
	
	<div id="status" class="mobile hide"></div>
	
	<!-- 添加 产品明细 模版 -->
	<div style="display:none">
	<#assign subTableStr>${head.subTableStr?if_exists?html}</#assign>
	<#assign subtablelist=subTableStr?split(",")>
	<#list subtablelist as sub >
	    <#if field['${sub}']?exists >
		    <#include "online/template/moblieCommon002/html/jformonetomanytpl.ftl">
		</#if>
	</#list>
	</div>
			
</div>
 </body>
 </html>