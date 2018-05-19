<#setting number_format="0.#####################">
<!DOCTYPE html>
<html>
 <head>
  <title>订单信息</title>
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
	function resetTrNum(tableId) {
		$tbody = $("#"+tableId+"");
		$tbody.find('>tr').each(function(i){
			$(':input, select', this).each(function(){
				var $this = $(this), name = $this.attr('name'), val = $this.val();
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
			});
			$(this).find('div[name=\'xh\']').html(i+1);
		});
	}
 </script>
 <body>
  <form id="formobj" action="cgFormBuildController.do?saveOrUpdateMore" name="formobj" method="post"><input type="hidden" id="btn_sub" class="btn_sub"/>
	<#include "org/jeecgframework/web/cgform/engine/jformhead.ftl">
			
			
<script type="text/javascript">
   $(function(){
    //查看模式情况下,删除和上传附件功能禁止使用
	if(location.href.indexOf("load=detail")!=-1){
		$(".jeecgDetail").hide();
	}
	if(location.href.indexOf("mode=read")!=-1){
		//查看模式控件禁用
		$("#formobj").find(":input").attr("disabled","disabled");
	}
	if(location.href.indexOf("mode=onbutton")!=-1){
		//其他模式显示提交按钮
		$("#sub_tr").show();
	}
   });
   function upload() {
  	<#list columns as po>
  		<#if po.show_type=='file'>
  		$('#${po.field_name}').uploadify('upload', '*');		
  		</#if>
  	</#list>
  }
  var neibuClickFlag = false;
  function neibuClick() {
	  neibuClickFlag = true; 
	  $('#btn_sub').trigger('click');
  }
  function cancel() {
  	<#list columns as po>
  		<#if po.show_type=='file'>
 	 $('#${po.field_name}').uploadify('cancel', '*');
 	 	</#if>
  	</#list>
  }
  function uploadFile(data){
  		if(!$("input[name='id']").val()){
  			<!--update-start--Author:luobaoli  Date:20150614 for：需要判断data.obj存在，才能取id值-->
  			if(data.obj!=null && data.obj!='undefined'){
  				$("input[name='id']").val(data.obj.id);
  			}
  			<!--update-end--Author:luobaoli  Date:20150614 for：需要判断data.obj存在，才能取id值-->
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
	$.dialog.setting.zIndex =1990;
	function del(url,obj){
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
					    <#include "org/jeecgframework/web/cgform/engine/jformonetoone.ftl">
					    <#else>
					    <#include "org/jeecgframework/web/cgform/engine/jformonetomany.ftl">
					    </#if>
					</#if>
				</#list>
				</div>
			</div>
		<div align="center"  id = "sub_tr" style="display: none;" > <input type="button" value="提交" onclick="$('#btn_sub').trigger('click');" class="ui_state_highlight"></div>
		<script type="text/javascript">$(function(){$("#formobj").Validform({tiptype:1,btnSubmit:"#btn_sub",btnReset:"#btn_reset",ajaxPost:true,usePlugin:{passwordstrength:{minLen:6,maxLen:18,trigger:function(obj,error){if(error){obj.parent().next().find(".Validform_checktip").show();obj.find(".passwordStrength").hide();}else{$(".passwordStrength").show();obj.parent().next().find(".Validform_checktip").hide();}}}},callback:function(data){if(data.success==true){uploadFile(data);}else{if(data.responseText==''||data.responseText==undefined){$.messager.alert('错误', data.msg);$.Hidemsg();}else{try{var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'),data.responseText.indexOf('错误信息')); $.messager.alert('错误',emsg);$.Hidemsg();}catch(ex){$.messager.alert('错误',data.responseText+'');}} return false;}if(!neibuClickFlag){var win = frameElement.api.opener; win.reloadTable();}}});});</script></form>
		<!-- 添加 产品明细 模版 -->
		<table style="display:none">
		<#assign subTableStr>${head.subTableStr?if_exists?html}</#assign>
		<#assign subtablelist=subTableStr?split(",")>
		<#list subtablelist as sub >
		    <#if field['${sub}']?exists >
				<#if field['${sub}'].head.relationType!=1 >
			    <#include "org/jeecgframework/web/cgform/engine/jformonetomanytpl.ftl">
			    </#if>
			</#if>
		</#list>
		</table>
	<script type="text/javascript">${js_plug_in?if_exists}</script>	
 </body>
 </html>