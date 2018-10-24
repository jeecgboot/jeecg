<#setting number_format="0.#####################">
<#include "online/template/ui/tag.ftl"/>
﻿<html>
	<head>
		<base href="${basePath}/"/>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<meta name="keywords" content="Jeecg 移动表单" />
		<meta name="description" content="Jeecg 移动表单" />
		<title>Jeecg 移动表单</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/online/template/${this_olstylecode}/css/formviewm.css" />
		<link type="text/css" rel="stylesheet" href="${basePath}/online/template/${this_olstylecode}/css/default.css" />
		<link type="text/css" rel="stylesheet" href="${basePath}/online/template/${this_olstylecode}/css/bootstrap.min.css" />
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/head.load.min.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/lang-cn.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/ajaxfileupload.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/address-cn.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/utils.js"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/My97DatePicker/WdatePicker.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/tools/dataformat.js"></script>
		<#--update-begin--Author:liushaoqian  Date:20180710 for：TASK #2930 【online样式】通用移动模板一对多，支持上传图片和附件-->
		<link rel="stylesheet" href="${basePath}/plug-in/uploadify/css/uploadify.css" type="text/css"></link>
		<#--update-begin--Author:taoYan  Date:20180821 for： Online上传改造 -->
  		<#--<script type="text/javascript" src="${basePath}/plug-in/uploadify/jquery.uploadify-3.1.js"></script-->
  		<script type="text/javascript" src="${basePath}/plug-in/plupload/plupload.full.min.js"></script>
  		<script type="text/javascript" src="${basePath}/plug-in/tools/Map.js"></script>
  		<link rel="stylesheet" href="${basePath}/plug-in/webuploader/custom.css" type="text/css"></link>
  		<#--update-end--Author:taoYan  Date:20180821 for： Online上传改造 -->
		<script type="text/javascript" src="${basePath}/plug-in/lhgDialog/lhgdialog.min.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/jquery-plugs/i18n/jquery.i18n.properties.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/tools/curdtools.js"></script>
		<#--update-end--Author:liushaoqian  Date:20180710 for：TASK #2930 【online样式】通用移动模板一对多，支持上传图片和附件-->
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
			.upload_generate {
				font-size:13px;
			}
			.li_upload{
				padding:0 !important;
				clear:none !important;
				float:left;
			}
		</style>
	</head>
	<body class="wallpaper wallpaperm">
	
 <script type="text/javascript">	
	$(function() {
		$("#btnSubmit").click(function(){
			if(validateForm()){
				$.post(
				 	<#--//update-begin--Author:Yandong  Date:20171227 for：TASK #2375 【online模板】通用移动模板002，有很多问题-->
				   '${basePath}/cgFormBuildController.do?saveOrUpdateMore',
				    <#--//update-end--Author:Yandong  Date:20171227 for：TASK #2375 【online模板】通用移动模板002，有很多问题-->
				   $("#form1").serialize(),
				   function(data){
				   	  var d = $.parseJSON(data);
				   	  alert(d.msg);
				   	  if(d.success){
				   	  	  uploadFile(d);
	            		//var win = frameElement.api.opener;
						//win.reloadTable();
						//frameElement.api.close();
	            	  }
				   }
				);
			}
		});
		   <#--update-begin--Author:liushaoqian  Date:20180710 for：TASK #2930 【online样式】通用移动模板一对多，支持上传图片和附件-->
		 function uploadFile(data){
			        if(!$("input[name='id']").val()){
			            if(data.obj!=null && data.obj!='undefined'){
			                $("input[name='id']").val(data.obj.id);
			            }
			        }
			        if($(".uploadify-queue-item").length>0){
			            upload();
			        }else{
		                var win = frameElement.api.opener;
					    win.reloadTable();
					    frameElement.api.close();
			        }
			    }
			<#--update-end--Author:liushaoqian  Date:20180710 for：TASK #2930 【online样式】通用移动模板一对多，支持上传图片和附件-->    
		 <#--//update-begin--Author:Yandong  Date:20171227 for：TASK #2375 【online模板】通用移动模板002，有很多问题-->
        //查看模式情况下,删除和上传附件功能禁止使用
    	if(location.href.indexOf("goDetail.do")!=-1){
    		$(".jeecgDetail").hide();
    		$("#form1").find("input,select,textarea").attr("disabled","disabled");
    	}
    	 <#--//update-end--Author:Yandong  Date:20171227 for：TASK #2375 【online模板】通用移动模板002，有很多问题-->
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
	 
	<#-- update-begin-author:taoYan date:20180903 for:移动模板文件上传改造 -->
    function upload() {
    	var iattachment = getFileIDArray();
	    var icgFormId = $("input[name='id']").val();
		$.ajax({
			async : false,
			cache : false,
			url:"cgUploadController.do?updateCgformFile",
			data:{
				'cgFormName':'${tableName?if_exists?html}',
				'cgFormId':icgFormId,
				'attachment': iattachment
			},
			type:"POST",
			dataType:"JSON",
			error : function() {// 请求失败处理函数
			},
			success : function(data) {
				if (data.success) {
					 var win = frameElement.api.opener;
					 win.reloadTable();
					 win.tip("操作成功！");
					 frameElement.api.close();
				}else{
					tip(data.msg);
				}
			}
		});
    }
   	function getFileIDArray(){
    	var arr = [];
     	<#list columns as po>
	       <#if po.show_type=='file' || po.show_type=='image'>
	             var ${po.field_name}_attachment = [];
	    		 $("#${po.field_name}thelist").find('.uploadify-queue-item').each(function(){
	    		 	var temp = $(this).attr("id");
	    		 	if(!!temp){
	    		 		if($(this).is(":hidden")){
	    		 			temp = temp+"_D";//删除文件
	    		 		}else if($(this).hasClass('history')){
	    		 			temp = temp+"_O";//老文件
	    		 		}
	    		 		${po.field_name}_attachment.push(temp);
	    		 	}
		         });
		         if(${po.field_name}_attachment.length>0){
		        	arr.push({cgFormField:'${po.field_name}',attachment: ${po.field_name}_attachment.join(',')});
		         }
	        </#if>
	    </#list>
        return JSON.stringify(arr);
	}
    <#-- update-end-author:taoYan date:20180903 for:移动模板文件上传改造 -->
 </script>
 <body class="wallpaper wallpaperm">
 <div id="container" class="container" mobile="1">
 
 	<div>
		<h1 id="logo" class="logo"><a></a></h1>
	</div>
	
	<div class="ui-content">
		<form id="form1" class="form" action="${basePath}/cgFormBuildController.do?saveOrUpdateMore" name="form1" method="post">
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
					 <#--//update-begin--Author:Yandong  Date:20171227 for：TASK #2375 【online模板】通用移动模板002，有很多问题-->
					<input id="btnSubmit" type="button" class="btn-submit jeecgDetail" value="提交" />
					 <#--//update-end--Author:Yandong  Date:20171227 for：TASK #2375 【online模板】通用移动模板002，有很多问题-->
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