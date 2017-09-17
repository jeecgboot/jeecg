<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@include file="/context/mytags.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>通用上传</title>
<t:base type="jquery,easyui,tools"></t:base>
<link rel="stylesheet" href="plug-in/bootstrap/css/bootstrap.min.css">
</head>
<body>
<t:formvalid formid="formobj" layout="div" dialog="true" action="jeecgFormDemoController.do?saveUploadFile">
	<fieldset class="step">
	<div class="form">
		<label class="Validform_label"> 文件标题: </label> 
		<input name="documentTitle" id="documentTitle" datatype="s3-50" value="${doc.documentTitle}" type="text"> 
		<span class="Validform_checktip">标题名称在3~50位字符,且不为空</span>
	</div>
	<div class="form">
		<input type="hidden" id="file-name" name="filename" />
		<input type="hidden" id="file-name-swfpath" name="swfpath">
		<a  target="_blank" id="file-name-href">未上传</a>
		<br>
	   <input class="btn btn-success btn-sm" type="button" value="上传附件" onclick="commonUpload(commonUploadDefaultCallBack,'file-name')"/> 
	</div>
	</fieldset>
</t:formvalid>
<script type="text/javascript">
//通用弹出式文件上传
function commonUpload(callback,inputId){
    $.dialog({
           content: "url:systemController.do?commonUpload",
           lock : true,
           title:"文件上传",
           zIndex:getzIndex(),
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
function commonUploadDefaultCallBack(url,name,inputId,swfpath){
	if(url.indexOf(".png") != -1 || url.indexOf(".jpg") != -1|| url.indexOf(".jpeg") != -1||url.indexOf(".gif")!=-1){
		var imgHtml = '<img src="'+url+'" width="100">';
		$("#"+inputId+"-href").attr('href',url).html(imgHtml);
	}else{
		$("#"+inputId+"-href").attr('href',url).html('下载');
	}
	$("#"+inputId).val(url);
	$("#"+inputId+"-swfpath").val(swfpath)
}
</script>
</body>
</html>