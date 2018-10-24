<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>plupload-plugin</title>
 <script src="plug-in/jquery/jquery-1.9.1.js"></script>   
 <script src="plug-in/plupload/plupload.full.min.js"></script>
 <style type="text/css">
     a{cursor:pointer;}
     body{background: #fff none repeat scroll 0 0; color: #333; font: 12px/1.5 "Microsoft YaHei","Helvetica Neue",Helvetica,STHeiTi,sans-serif; background-position: left top; background-repeat: repeat; background-attachment: scroll;}
     .clearfix:after{visibility:hidden; display:block; font-size:0; content:" "; clear:both; height:0}
     *:first-child+html .clearfix{zoom:1}
     ul,li{list-style: none;padding:0;margin:0}
     .emot_photo_video{margin:14px 0 0;width:350px;float:left}
     .icon_emot_photo_video{display: inline-block;margin:0 4px 0 0}
     .icon_photo{background:url("plug-in/plupload/jquery.ui.plupload/img/icon_photo.png") no-repeat scroll 0 0;width:20px;height: 15px;}
     .emot_photo_video .item{vertical-align: top;display: inline-block;margin:0 10px 0 0}
     .emot_photo_video .item i,.emot_photo_video .item span{vertical-align: middle;}

     .photo_upload_box_outside{position: absolute;left:0;top:0;z-index: 800;display: none}
     .photo_upload_box{padding: 16px 0 10px 16px; width: 268px;background-color: #FFF; border: 1px solid #ccc; border-radius: 3px; box-shadow: 0 4px 20px 1px rgba(0, 0, 0, 0.2); position: relative}
     .photo_upload_box h1{font-size: 14px;font-weight: 700;}
     .photo_upload_box .upload_num{margin:10px 0}
     .photo_upload_box .arrow_layer .arrow_top_area{left:20px}
     .ul_pics li{float:left;width:80px;height:80px;margin:0 8px 8px 0;position: relative}
     .ul_pics li img{width:100%;height: 100%}
     .ul_pics li:hover .picbg{background: #4A4A4A; opacity: 0.6; filter:alpha(opacity=60); display: block; height: 100%; position: absolute; top: 0; width: 100%;}
   
     .progress{position:relative;padding: 1px; border-radius:3px; margin:30px 0 0 0;}
     .bar{background-color: green; display:block; width:0%; height:20px; border-radius:3px;}
     .percent{position:absolute; height:20px; display:inline-block;top:3px; left:2%; color:#fff}
     .pic_close{background:url("plug-in/plupload/jquery.ui.plupload/img/ico_layer.png") no-repeat scroll -25px -25px; display: none; height: 20px; width: 20px; position: absolute;right:0;top:0;z-index: 990}
     .ul_pics li:hover .pic_close{display: block}
     .photo_upload_close{background:url("plug-in/plupload/jquery.ui.plupload/img/local_upload_close.png") no-repeat scroll 0 0; display: block; height: 11px; width: 11px; position: absolute;right:7px;top:8px}
     .arrow_top_area{right: 20px; top: -15px; display: block; overflow: hidden; position: absolute;}
     .arrow_top_area i, .arrow_top_area em{border-style: solid; border-width: 7px; display: inline-block; font-size: 0; height: 0; line-height: 0; overflow: hidden; vertical-align: top; width: 0; border-left-color: transparent; border-right-color: transparent; border-top-color: transparent;}
     .arrow_top_area em{margin: 1px 0 0 -14px;}
     .arrow_top_bg{border-color: #cccccc;}
     .arrow_top{border-color: #fff; color: #fff;}
     .uploadify-button{
	     background-color: rgb(80, 80, 80);
	    background-image: -webkit-gradient(linear, 0% 100%, 0% 0%, from(rgb(80, 80, 80)), to(rgb(112, 112, 112)));
	    color: rgb(255, 255, 255);
	    text-align: center;
	    text-shadow: rgba(0, 0, 0, 0.25) 0px -1px 0px;
	    width: 100%;
	    background-position: center top;
	    background-repeat: no-repeat;
	    border-radius: 30px;
	    border-width: 2px;
	    border-style: solid;
	    border-color: rgb(128, 128, 128);
	    border-image: initial;
	    font: bold 12px Arial, Helvetica, sans-serif;
    }
         
 </style>
</head>
<body>
<h3>第一种：带悬浮框的</h3>
<div class="demo clearfix" style="padding-bottom:200px">
   <div class="emot_photo_video" style="position: relative;">
       <div id="btn" class="uploadify-button" style="position: relative;cursor:pointer;height: 18px; line-height: 18px; width: 80px;">
       		<span class="uploadify-button-text">选择图片</span>
       	</div>
       
   		<div id="container" class="moxie-shim moxie-shim-html5" style="position: absolute; top: 0px; left: 0px; width: 48px; height: 18px; overflow: hidden; z-index: 0;">
   			<input id="html5fileupload" type="file" style="font-size: 999px; opacity: 0; position: absolute; top: 0px; left: 0px; width: 100%; height: 100%;" multiple="" accept="image/jpeg,image/png,image/gif">
   		</div>
   </div>
</div>
       
<div class="photo_upload_box_outside blur_area" id="photo_upload_box_outside" tabindex="2000"> 
    <div class="photo_upload_box"> 
        <a class="photo_upload_close"href="javascript:void(0);"onclick="photo_upload_close()"></a> 
        <h1>本地上传</h1>
        <p class="upload_num">共<span id="uploaded_length">0</span>张，还能上传<span id="upload_other">9</span>张</p> 
        <ul id="ul_pics" class="ul_pics clearfix"> 
            <li id="local_upload"><img src="plug-in/plupload/jquery.ui.plupload/img/local_upload.png" id="btn2"/></li> 
        </ul> 
        <div class="arrow_layer"> 
            <span class="arrow_top_area"><i class="arrow_top_bg"></i><em class="arrow_top"></em></span> 
        </div> 
    </div> 
</div>
<script>
var upload_total = 9;//最多上传数量
var uploader = new plupload.Uploader({//创建实例的构造方法
    runtimes: 'gears,html5,flash,silverlight,html4', //上传插件初始化选用那种方式的优先级顺序
    browse_button: ['btn', 'btn2'], // 上传按钮
    url: "systemController/filedeal.do", //远程上传地址
    flash_swf_url: 'plug-in/plupload/Moxie.swf', //flash文件地址
    silverlight_xap_url: 'plug-in/plupload/Moxie.xap', //silverlight文件地址
    filters: {
        max_file_size: '10mb', //最大上传文件大小（格式100b, 10kb, 10mb, 1gb）
        mime_types: [//允许文件上传类型
            {title: "files", extensions: "jpg,png,gif,jpeg"}
        ]
    },
    multipart_params:{isup:"1"},
    multi_selection: true, //true:ctrl多文件上传, false 单文件上传
    init: {
        FilesAdded: function(up, files) { //文件上传前
            var length_has_upload = $("#ul_pics").children("li").length;
            if (files.length >= upload_total) { //超过上传总数量则隐藏
                $("#local_upload").hide();
            }
            var li = '';
            plupload.each(files, function(file) { //遍历文件
                if (length_has_upload <= upload_total) {
                    li += "<li class='li_upload' id='" + file['id'] + "'><div class='progress'><span class='bar'></span><span class='percent'>0%</span></div></li>";
                }
                length_has_upload++;
            });
            $("#ul_pics").prepend(li);
            uploader.start();
        },
        UploadProgress: function(up, file) { //上传中，显示进度条
            var percent = file.percent;
            $("#" + file.id).find('.bar').css({"width": percent + "%"});
            $("#" + file.id).find(".percent").text(percent + "%");
        },
        FileUploaded: function(up, file, info) { //文件上传成功的时候触发
            showPhotoUploadBox($('#btn'));
            var uploaded_length = $(".img_common").length;
            if (uploaded_length <= upload_total) {
                var data = eval("(" + info.response + ")");//解析返回的json数据
                var picpath = data.obj;
                while(picpath.indexOf('\\')>=0){
                	picpath = picpath.replace("\\","/");
                }
                //<input type='hidden'name='pic_name[]' value='" + data.name + "'/>
                $("#" + file.id).html("<input type='hidden'name='pic[]' value='" + picpath + "'/>\n\
			<img class='img_common' src='img/server/" + picpath + "'/><span class='picbg'></span><a class='pic_close' onclick=delPic('" + picpath + "','" + file.id + "')></a>");
            }
            showUploadBtn();
        },
        Error: function(up, err) { //上传出错的时候触发
            alert(err.message);
        }
    }
});
uploader.init();

function delPic(path, file_id) { //删除图片 参数1图片路径  参数2 随机数
    $.post("systemController/filedeal.do", {path: path,isdel:"1"}, function(data) {
        $("#" + file_id).remove();
        showUploadBtn();
    })
}

function delPic2(path, file_id) {
    $.post("systemController/filedeal.do", {path: path,isdel:"1"}, function(data) {
        $("#" + file_id).remove();
    })
}
function showUploadBtn() { //是否显示上传按钮
    var uploaded_length = $(".img_common").length;
    $("#uploaded_length").text(uploaded_length);
    var other_length = (upload_total - uploaded_length) > 0 ? upload_total - uploaded_length : 0;
    $("#upload_other").text(other_length);
    var uploaded_length = $(".img_common").length;
    if (uploaded_length >= upload_total) {
        $("#local_upload").hide();
    } else {
        $("#local_upload").show();
    }
}
function showPhotoUploadBox(obj) { //显示上传弹出层
    var left = obj.offset().left;
    var top = obj.offset().top + 26;
    $("#photo_upload_box_outside").css({"left": left, "top": top}).show()
}
function photo_upload_close() {
    $("#photo_upload_box_outside").fadeOut(500, function() {
        $("#ul_pics").find(".li_upload").remove();
    })
}
$(function() { 
    $(".blur_area").hover(function() { 
        $("body").attr('is_hover', 1); 
    }, function() { 
        $("body").attr('is_hover', 0); 
    }); 
    $(".blur_area").blur(function() { 
        if ($("body").attr("is_hover") == 0) { 
            photo_upload_close(); 
        } 
    }) 
})
</script>


<h3>第二种：直接选取</h3>
<div style="cursor:pointer">
 <ul id="picsUl" class="ul_pics clearfix"> 
     <li id="local_upload1">
     	<img src="plug-in/plupload/jquery.ui.plupload/img/local_upload.png" id="picsPicker"/>
     </li> 
 </ul> 
</div>

<script>
var uploader2 = new plupload.Uploader({//创建实例的构造方法
    runtimes: 'gears,html5,html4,silverlight,flash', //上传插件初始化选用那种方式的优先级顺序
    browse_button: 'picsPicker', // 上传按钮
    url: "systemController/filedeal.do", //远程上传地址
    flash_swf_url: 'plug-in/plupload/Moxie.swf', //flash文件地址
    silverlight_xap_url: 'plug-in/plupload/Moxie.xap', //silverlight文件地址
    filters: {
        max_file_size: '10mb', //最大上传文件大小（格式100b, 10kb, 10mb, 1gb）
        mime_types: [//允许文件上传类型
            {title: "files", extensions: "jpg,png,gif,jpeg"}
        ]
    },
    multipart_params:{isup:"1"},
    multi_selection: true, //true:ctrl多文件上传, false 单文件上传
    init: {
        FilesAdded: function(up, files) { //文件上传前
            var li = '';
            plupload.each(files, function(file) { //遍历文件
            	li += "<li class='li_upload' id='" + file['id'] + "'><div class='progress'><span class='bar'></span><span class='percent'>0%</span></div></li>";
            });
            $("#picsUl").prepend(li);
            uploader2.start();
        },
        UploadProgress: function(up, file) { //上传中，显示进度条
            var percent = file.percent;
            $("#" + file.id).find('.bar').css({"width": percent + "%"});
            $("#" + file.id).find(".percent").text(percent + "%");
        },
        FileUploaded: function(up, file, info) { //文件上传成功的时候触发
             var data = eval("(" + info.response + ")");//解析返回的json数据
             var picpath = data.obj;
             while(picpath.indexOf('\\')>=0){
             	picpath = picpath.replace("\\","/");
             }
             var html = "<input type='hidden'name='pic[]' value='" + picpath + "'/>\n\<img class='img_common' src='img/server/" + picpath + "'/><span class='picbg'></span><a class='pic_close' onclick=delPic2('" + picpath + "','" + file.id + "')></a>";
             $("#" + file.id).html(html);
        },
        Error: function(up, err) { //上传出错的时候触发
            alert(err.message);
        }
    }
});
uploader2.init();
</script>
</body>
</html>
