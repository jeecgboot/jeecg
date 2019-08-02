<#setting number_format="0.#####################">
<!DOCTYPE html>
<html>
 <head>
 <base href="${basePath}/"/>
  <title>订单信息</title>
  <style type="text/css">
   	.Button{ 
		display: inline-block;
		outline: none;
		cursor: pointer;
		text-align: center;
		text-decoration: none;
		font: 14px/100% Arial, Helvetica, sans-serif;
		padding: .5em 2em .55em;
		-webkit-border-radius: .5em; 
		-moz-border-radius: .5em;
		border-radius: .5em;
		-webkit-box-shadow: 0 1px 2px rgba(0,0,0,.2);
		-moz-box-shadow: 0 1px 2px rgba(0,0,0,.2);
		box-shadow: 0 1px 2px rgba(0,0,0,.2);
		color: #fef4e9;
		border: solid 1px #1D73F7;
		background: #1D73F7;
		background: -webkit-gradient(linear, left top, left bottom, from(#1D73F7), to(#1D51F7));
	}

  </style>
  ${config_iframe}
 </head>
 <script type="text/javascript">
 $(document).ready(function(){
	$('#tt').tabs({
	   onSelect:function(title){
	       $('#tt .panel-body').css('width','auto');
		}
	});
	$(".tabs-wrap").css('width','100%');
  });
  //初始化下标
	<#-- update-begin-Author:LiShaoQing date:20180829 for:TASK #3127 删除时没有添加 validtype_str校验-->
	function resetTrNum(tableId) {
		$tbody = $("#"+tableId+"");
		<#-- update-begin-Author:LiShaoQing date:20181023 for:Online EASY默认表单样式不显示序号问题 -->
		$tbody.find('tr').each(function(i){
		<#-- update-end-Author:LiShaoQing date:20181023 for:Online EASY默认表单样式不显示序号问题 -->
			$(':input, select,button,a', this).each(function(){
				var $this = $(this),validtype_str = $this.attr('validType'), name = $this.attr('name'),id=$this.attr('id'),onclick_str=$this.attr('onclick'), val = $this.val();
				if(name!=null){
					if (name.indexOf("#index#") >= 0){
						$this.attr("name",name.replace('#index#',i));
					}else{
						var s = name.indexOf("[");
						var e = name.indexOf("]");
						var new_name = name.substring(s+1,e);
						$this.attr("name",name.replace(new_name,i));
					}
				}
				if(id!=null){
					if (id.indexOf("#index#") >= 0){
						$this.attr("id",id.replace('#index#',i));
					}else{
						var s = id.indexOf("[");
						var e = id.indexOf("]");
						var new_id = id.substring(s+1,e);
						$this.attr("id",id.replace(new_id,i));
					}
				}
				if(onclick_str!=null){
					if (onclick_str.indexOf("#index#") >= 0){
						$this.attr("onclick",onclick_str.replace(/#index#/g,i));
					}else{
					    var s = onclick_str.indexOf("[");
						var e = onclick_str.indexOf("]");
						var new_onclick_str = onclick_str.substring(s+1,e);
						<#-- update--begin--author:zhoujf date:20180827 for：TASK #3064 popup控件实现 -->
						if(new_onclick_str!=''){
							$this.attr("onclick",onclick_str.replace(new_onclick_str,i));
						}
						<#-- update--end--author:jiaqiankun date:20180710 for：TASK #3064 popup控件实现 -->
					}
				}
				if(validtype_str!=null){
					if(validtype_str.indexOf("#index#") >= 0){
						$this.attr("validType",validtype_str.replace('#index#',i));
					}else{
						var s = id.indexOf("[");
						var e = id.indexOf("]");
						var new_id = id.substring(s+1,e);
						$this.attr("id",id.replace(new_id,i));
					}
				}
				var class_str = $this.attr("class");
				if(!!class_str && class_str.indexOf("i-checks-tpl")>=0){
					$this.attr("class",class_str.replace(/i-checks-tpl/,"i-checks"));
				}
			});
			<#-- update-begin-Author:LiShaoQing date:20181023 for:Online EASY默认表单样式不显示序号问题 -->
			$(this).find('div[name=\'xh\']').html(i+1);
			<#-- update-end-Author:LiShaoQing date:20181023 for:Online EASY默认表单样式不显示序号问题 -->
		});
	}
	<#-- update-end-Author:LiShaoQing date:20180829 for:TASK #3127 删除时没有添加 validtype_str校验-->
 </script>
 <body>
  <form id="formobj" action="${basePath}/cgFormBuildController.do?saveOrUpdateMore" name="formobj" method="post"><input type="hidden" id="btn_sub" class="btn_sub"/>
	<#include "online/template/default/html/jformhead.ftl">
			
			
<script type="text/javascript">
   $(function(){
    //查看模式情况下,删除和上传附件功能禁止使用
	if(location.href.indexOf("goDetail.do")!=-1){
		$(".jeecgDetail").hide();
	}
	
	if(location.href.indexOf("goDetail.do")!=-1){
		//查看模式控件禁用
		$("#formobj").find(":input").attr("disabled","disabled");
	}
	if(location.href.indexOf("goAddButton.do")!=-1||location.href.indexOf("goUpdateButton.do")!=-1){
		//其他模式显示提交按钮
		$("#sub_tr").show();
	}
   });
   function upload() {
   <#-- update--begin--author:zhangjiaqiang date:20170607 for:增加对于图片的支持 -->
  	<#list columns as po>
  		<#if po.show_type=='file' || po.show_type == 'image'>
  		$('#${po.field_name}').uploadify('upload', '*');		
  		</#if>
  	</#list>
  	<#-- update--end--author:zhangjiaqiang date:20170607 for:增加对于图片的支持 -->
  }
  var neibuClickFlag = false;
  function neibuClick() {
	  neibuClickFlag = true; 
	  $('#btn_sub').trigger('click');
  }
  function cancel() {
  <#-- update--begin--author:zhangjiaqiang date:20170607 for:增加对于图片的支持 -->
  	<#list columns as po>
  		<#if po.show_type=='file' || po.show_type == 'image'>
 	 $('#${po.field_name}').uploadify('cancel', '*');
 	 	</#if>
  	</#list>
  	<#-- update--end--author:zhangjiaqiang date:20170607 for:增加对于图片的支持 -->
  }
  function uploadFile(data){
  		if(!$("input[name='id']").val()){
  			<#--update-start--Author:luobaoli  Date:20150614 for：需要判断data.obj存在，才能取id值-->
  			if(data.obj!=null && data.obj!='undefined'){
  				$("input[name='id']").val(data.obj.id);
  			}
  			<#--update-end--Author:luobaoli  Date:20150614 for：需要判断data.obj存在，才能取id值-->
  		}
  		if($(".uploadify-queue-item").length>0){
  			upload();
  		}else{
  			if (neibuClickFlag){
  				alert(data.msg);
  				neibuClickFlag = false;
  			}else {
	  			var win = frameElement.api.opener;
				win.reloadTable();
				win.tip(data.msg);
				frameElement.api.close();
  			}
  		}
  	}
	//update-begin-author：taoYan date:20180519 for:弹出层z-index不足被遮住--
	function del(url,obj){
		$.dialog.setting.zIndex = getzIndex();
	//update-end-author：taoYan date:20180519 for:弹出层z-index不足被遮住--
		$.dialog.confirm("确认删除该条记录?", function(){
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
						var msg = d.msg;
						tip(msg);
						$(obj).closest("tr").hide("slow");
					}
				}
			});  
		}, function(){
	});
}

</script>
			<div style="width: auto;height: 200px;">
				<div style="width:690px;height:1px;"></div>
				<div id="tt" tabPosition="top" border=flase style="margin:0px;padding:0px;overflow:hidden;width:auto;" class="easyui-tabs" fit="false">
				<#assign subTableStr>${head.subTableStr?if_exists?html}</#assign>
				<#assign subtablelist=subTableStr?split(",")>
				<#list subtablelist as sub >
				    <#if field['${sub}']?exists >
				    	<#if field['${sub}'].head.relationType==1 >
					    <#include "online/template/default/html/jformonetoone.ftl">
					    <#else>
					    <#include "online/template/default/html/jformonetomany.ftl">
					    </#if>
					</#if>
				</#list>
				</div>
			</div>
		<div align="center"  id = "sub_tr" style="display: none;" > <input type="button" value="提交" onclick="$('#btn_sub').trigger('click');" class="Button"></div>
		<#--update--begin--author:scott Date:20170304 for:替换layer风格提示框-->
		<#if brower_type?? && brower_type == 'Microsoft%20Internet%20Explorer'>
		<script type="text/javascript">$(function(){$("#formobj").Validform({tiptype:1,btnSubmit:"#btn_sub",btnReset:"#btn_reset",ajaxPost:true,usePlugin:{passwordstrength:{minLen:6,maxLen:18,trigger:function(obj,error){if(error){obj.parent().next().find(".Validform_checktip").show();obj.find(".passwordStrength").hide();}else{$(".passwordStrength").show();obj.parent().next().find(".Validform_checktip").hide();}}}},callback:function(data){if(data.success==true){uploadFile(data);}else{if(data.responseText==''||data.responseText==undefined){$.messager.alert('错误', data.msg);$.Hidemsg();}else{try{var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'),data.responseText.indexOf('错误信息')); $.messager.alert('错误',emsg);$.Hidemsg();}catch(ex){$.messager.alert('错误',data.responseText+'');}} return false;}if(!neibuClickFlag){var win = frameElement.api.opener; win.reloadTable();}}});});</script></form>
		<#else>
		<script type="text/javascript">$(function(){$("#formobj").Validform({tiptype:function(msg,o,cssctl){if(o.type == 3){layer.open({title:'提示信息',content:msg,icon:5,shift:6,btn:false,shade:false,time:5000,cancel:function(index){o.obj.focus();layer.close(index);},yes:function(index){o.obj.focus();layer.close(index);},})}},btnSubmit:"#btn_sub",btnReset:"#btn_reset",ajaxPost:true,usePlugin:{passwordstrength:{minLen:6,maxLen:18,trigger:function(obj,error){if(error){obj.parent().next().find(".Validform_checktip").show();obj.find(".passwordStrength").hide();}else{$(".passwordStrength").show();obj.parent().next().find(".Validform_checktip").hide();}}}},callback:function(data){if(data.success==true){uploadFile(data);}else{if(data.responseText==''||data.responseText==undefined){$.messager.alert('错误', data.msg);$.Hidemsg();}else{try{var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'),data.responseText.indexOf('错误信息')); $.messager.alert('错误',emsg);$.Hidemsg();}catch(ex){$.messager.alert('错误',data.responseText+'');}} return false;}if(!neibuClickFlag){var win = frameElement.api.opener; win.reloadTable();}}});});</script></form>
		</#if>
		<#--update--end--author:scott Date:20170304 for:替换layer风格提示框-->
		<!-- 添加 产品明细 模版 -->
		<table style="display:none">
		<#assign subTableStr>${head.subTableStr?if_exists?html}</#assign>
		<#assign subtablelist=subTableStr?split(",")>
		<#list subtablelist as sub >
		    <#if field['${sub}']?exists >
				<#if field['${sub}'].head.relationType!=1 >
			    <#include "online/template/default/html/jformonetomanytpl.ftl">
			    </#if>
			</#if>
		</#list>
		</table>
	<script type="text/javascript">${js_plug_in?if_exists}</script>	
	<#-- update--begin--author:zhangjiaqiang date:20170607 for:增加对于图片的支持 -->
	<script>
		
//通用弹出式文件上传
function commonUpload(callback,inputId){
    $.dialog({
           content: "url:systemController.do?commonUpload",
           lock : true,
           title:"文件上传",
           <#-- update--begin--author:zhangjiaqiang date:20170601 for:修订弹出框对应的index -->
           zIndex:getzIndex(),
            <#-- update--end--author:zhangjiaqiang date:20170601 for:修订弹出框对应的index -->
           width:700,
           height: 200,
           parent:windowapi,
           cache:false,
       ok: function(){
               var iframe = this.iframe.contentWindow;
               iframe.uploadCallback(callback,inputId);
               return true;
       },
       cancelVal: '关闭',
       cancel: function(){
       } 
   });
}
//通用弹出式文件上传-回调
function commonUploadDefaultCallBack(url,name,inputId){
	var linkElement = document.getElementById(inputId+"_href");
	var inputElement = document.getElementById(inputId);
	linkElement.setAttribute("href",url);
	linkElement.innerHTML="下载";
	inputElement.setAttribute("value",url);
	//$("#"+inputId+"_href").attr('href',url).html('下载');
	//$("#"+inputId).val(url);
}
	</script>
	<#-- update--begin--author:zhangjiaqiang date:20170607 for:增加对于图片的支持 -->
 </body>
 </html>