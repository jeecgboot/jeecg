<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Pluplaod插件的上传演示</title>
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript" src="plug-in/hplus/js/plugins/layer/layer.min.js"></script>
<style>
.layui-layer-iframe .layui-layer-btn, .layui-layer-page .layui-layer-btn {
    padding-top: 8px;
}
</style>
</head>
<body>
<script type="text/javascript">
$(function(){
	$("#layerUploader").on("click",function(){
	    layer.open({
	      title: '文件上传',
	      type: 2,
		  shadeClose: true,
		  closeBtn:1,
		  shade: 0.5,
		  area: ['700px', '352px'],
		  content: '${webRoot}/jeecgFormDemoController.do?goPlupload',
	      cancel: function(index) {
	      	layer.close(index);
	      },
	      btn: ['确认'],
	      yes: function(index,layero) {
	    	  var frameId=layero[0].getElementsByTagName("iframe")[0].id;
	    	  var files = $('#'+frameId)[0].contentWindow.files;
	    	  if(files && files.length>0){
	 			 var html = "文件地址：<br>";
	 			 for(var a = 0;a<files.length;a++){
	 				html+=files[a]+"<br>";
	 			 }
	 			$("#res").html(html);
	 		  }
	    	  $("#info").html($('#'+frameId)[0].contentWindow.info);
	    	  layer.close(index);
	      },
	    })
	});
});

</script>
</head>
<body style="width: 100%;height: 100%;overflow:hidden;margin: 0;padding: 0;">
	<h2 style="padding-left:10px">Pluplaod插件的上传演示</h2>
	<hr/>
	&nbsp;&nbsp;&nbsp;<button class="ace_button" style="width: 10%;height:30px;font-size: 12px" id = "layerUploader" >文件上传</button>
	<hr/>
	<div style="padding-left:10px">
	<div id="info"></div>
	<div id="res"></div>
	</div>
</body>
</html>