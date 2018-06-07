<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>

<!DOCTYPE html>
<html>
<head>
<title>form_nature</title>
<meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE"/>
<t:base type="jquery,tools"></t:base>
<!-- 文件上传 -->
<link rel="stylesheet" type="text/css" href="plug-in/webuploader/custom.css"></link>
<script type="text/javascript" src="plug-in/webuploader/webuploader.min.js" ></script>
<style>
.upbtn:focus{background-color:#51c3e5 !imporatnt;}
.webuploader-pick{background: none !important; top: 5px;}
.testbtn{margin-left: 20px; margin-top: 8px;display: inline-block;position: absolute;}
.infoc{padding-left:20px;}
.infoc input{margin:10px;width:200px}
.info-bottom{width:100%;height:10px;border-bottom: 1px solid #C4E1FF;}
#wrapper{width:99% !important;}
#steps form legend,#steps{width:100% !important;}
.uploader-info{display:none;}
.operate-area{
    font-size: 18px;
    display: inline-block;
    font-weight: 800;
    position: relative;
    margin-left: 10px;
    top: 3px;
    cursor: pointer;
}
.state .down{display:none;}
.state.upload-ok .down{display:inline-block;}
</style>
</head>
<body>
<t:formvalid layout="div" formid="dd" dialog="" >
 <fieldset>
 <legend>文件上传</legend>
	<div id="uploader" class="wu-example">
	    <!--用来存放文件信息-->
	    <div id="uploaderThelist" class="uploader-list">
	    </div>
	    <div class="btns" style="margin-top:20px">
	        <div id="uploaderPicker" class="btn-M btn-blue mb20">选择文件</div>
	        <div id="uploaderCtlBtn" class="upbtn btn-M btn-blue testbtn" >开始上传</div>
	    </div>
	</div>
 </fieldset>
 
<input id = "fileName" type = "text" style="width:100%"/><br>
<input id = "filePath" type = "text" style="width:100%" /><br>
<input type="button" value="编辑页面模拟" onclick="uploaderInitInfo()">
</t:formvalid>
<script type="text/javascript">
var uploaderArrays = [];
function uploaderAddWebFile(id,attributes){
	 var webuploaderInfo = {id:"",filename:"",filepath:"",filetype:"",filesize:""};
	 webuploaderInfo.id = id;
	 webuploaderInfo.filename = attributes.filename;
	 webuploaderInfo.filepath = attributes.filepath;
	 webuploaderInfo.filetype = attributes.filetype;
	 webuploaderInfo.filesize = attributes.filesize;
	 uploaderArrays.push(webuploaderInfo);
	 uploaderShowInfo();
}
function uploaderRemoveWebFile(id,name){
	uploaderArrays = $.grep(uploaderArrays, function(cur,i){
	   if(!id){
		   return cur.filename!=name;
	   }else{
		   return cur.id!=id;
	   }
    });
	uploaderShowInfo();
}
function uploaderGetWebFileInfo(id){
	//console.log(uploaderArrays);
	for(var a = 0;a<uploaderArrays.length;a++){
		if(uploaderArrays[a].id ==id){
			return uploaderArrays[a];
		}
	}
}
function uploaderInitInfo(){
	var name = $("#fileName").val();
	var path = $("#filePath").val();
	var name_arr = name.split(",");
	var path_arr = path.split(",");
	if(!!name && !!path){
		for(var a = 0;a<name_arr.length;a++){
			var f_id = 'H_WU_FILE_'+a+"-uploader";
			var attributes = {filename:name_arr[a],filepath:path_arr[a]};
			uploaderAddWebFile(f_id,attributes);
			var ext = path_arr[a].substring(path_arr[a].indexOf("."));
			var tempHtml ='<div id="'+f_id+'" class="item webuploader-file"><div class="state upload-ok">'+
			'<span class="tip-conent">'+name_arr[a]+ext+'---历史文件</span>'+
			'<span title="删除" class="operate-area del">×</span>'+
			'<span title="下载" class="operate-area down">ㅗ</span></div></div>';
			$("#uploaderThelist").append(tempHtml);
		}
	}
}
function uploaderShowInfo(){
	var name  = "",path="";
	for(var a = 0;a<uploaderArrays.length;a++){
		name+=uploaderArrays[a].filename;
		path+=uploaderArrays[a].filepath;
		if(a<uploaderArrays.length-1){
			name+=",";path+=",";
		}
	}
	$("#fileName").val(name);
	$("#filePath").val(path);
}
$(function() {
	/*-------------------------------------------文件上传----------------------------------------------*/
	var BASE_URL="<%=basePath%>";
	var urlc= BASE_URL+'/jeecgFormDemoController/filedeal.do';
	var uploader = WebUploader.create({
	    // swf文件路径
	    swf: BASE_URL+'/plug-in/webuploader/Uploader.swf',
	    // 文件接收服务端。
		server: urlc,
	    // 选择文件的按钮。可选。
	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	    pick: '#uploaderPicker',
	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	    resize: false,
	    //指明参数名称，后台也用这个参数接收文件
	    duplicate: false,
	    auto: false,
	    fileVal: 'file',
        fileNumLimit: 3,
	 
	});
	uploader.on( 'fileQueued', function( file ) {
		$("#uploaderThelist").append( '<div id="' + file.id + '-uploader" class="item webuploader-file">' +
	        '<div class="state"><span class="tip-conent">'+file.name+'---等待上传...</span>' +
	   		'<span title="删除" class="operate-area del">×</span>'+
	   		'<span title="下载" class="operate-area down">ㅗ</span>'+
	   		'</div></div>' );
	}); 
	
	uploader.on( 'uploadSuccess', function(file,response) {
		var f_id =file.id+ "-uploader";
	    if (response.success) {
	    	$('#'+f_id).find('div.state>.tip-conent').html(file.name+'---上传成功!');
	    	$('#'+f_id).find(".state").addClass("upload-ok");
	    	uploaderAddWebFile(f_id,response.attributes);
        } else {
        	$( '#'+f_id).find('div.state>.tip-conent').html(file.name+'---上传出错!');
        }
	});
	uploader.on( 'uploadError', function( file) {
	    $( '#'+file.id+'-uploader').find('div.state>.tip-conent').html(file.name+'---上传出错');
	});
	uploader.on( 'uploadComplete', function( file ) {
	   $( '#'+file.id+'-uploader').find('.progress').fadeOut('slow');
	});
	$("#uploaderCtlBtn").on('click',
	    function() {
			 uploader.upload();
	    });
	
	$("#uploaderThelist").on('click','span.operate-area',function(){
		var item = $(this).closest(".webuploader-file");
		var fileId = item.attr("id");
		//alert(fileId);
		//console.log(uploaderGetWebFileInfo(fileId));
		if($(this).hasClass("del")){
			if(item.children("div.state").hasClass("upload-ok")){
				$.ajax({
		            type: "POST",
		            url: BASE_URL+'/jeecgFormDemoController/filedelete.do',
		            data: uploaderGetWebFileInfo(fileId),
		            dataType: "json",
		            success: function(data){
		            	if(data.success){
		            		item.remove();
		            		uploaderRemoveWebFile(fileId);
		            		if(fileId.indexOf('H_')!=0){
		            			uploader.removeFile(fileId.substring(0,fileId.indexOf('-')));
		            		}
		            	}
	                 }
		         });
			}else{
				uploaderRemoveWebFile(fileId);
				item.remove();
				uploader.removeFile(fileId.substring(0,fileId.indexOf('-')));
			}
		}else if($(this).hasClass("down")){
			var info = uploaderGetWebFileInfo(fileId);
			var filepath = info.filepath;
			var filename = info.filename;
			var downsrc = BASE_URL+'/jeecgFormDemoController/filedown.do?filepath='+filepath+'&filename='+filename;
			location.href=downsrc;
		}
	});
});
</script>
</body>
</html>