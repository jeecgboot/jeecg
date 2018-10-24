<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <title>文件上传</title>
    <link rel="stylesheet" href="plug-in/plupload/jquery.plupload.queue/css/jquery.plupload.queue.css" type="text/css"></link>
    <script type="text/javascript" src="plug-in/jquery/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="plug-in/plupload/plupload.full.min.js"></script>
    <script type="text/javascript" src="plug-in/plupload/jquery.plupload.queue/jquery.plupload.queue.min.js"></script>
    <script type="text/javascript" src="plug-in/plupload/i18n/zh_CN.js"></script>
</head>
<body style="padding: 0;margin: 0;">
    <div id="iuploader">&nbsp;</div>
<script type="text/javascript">
var files = [];
var errors = [];
var info = "";
$('#iuploader').pluploadQueue({
	url : 'systemController/filedeal.do',
	filters : [
		{title : "Image files", extensions : "jpg,gif,png"},
		{title : "common files", extensions : "xls,doc,xlsx"}
	],
	multipart_params:{isup:"1"},
	rename: true,
	runtimes: 'gears,html5,flash,silverlight,html4', //上传插件初始化选用那种方式的优先级顺序
	flash_swf_url: 'plug-in/plupload/Moxie.swf', //flash文件地址
    silverlight_xap_url: 'plug-in/plupload/Moxie.xap', //silverlight文件地址
	init:{
		FileUploaded:function(uploader,file,info){
			 var data = eval("(" + info.response + ")");//解析返回的json数据
             var picpath = data.obj;
             while(picpath.indexOf('\\')>=0){
             	picpath = picpath.replace("\\","/");
             }
             if(data.success){
				files.push(picpath);
			 }else{
			 	errors.push(file.name);
			 }
		},
		UploadComplete:function(uploader,fs){
			var e= errors.length ? ",失败"+errors.length+"个("+errors.join("、")+")。" : "。";
			info = "上传完成！共"+fs.length+"个。成功"+files.length+e;
		}
	}
});
</script>
  </body>
</html>

