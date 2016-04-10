<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="plug-in/lhgDialog/skins/default.css">
    <script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script>
    <script type=text/javascript src="plug-in/clipboard/ZeroClipboard.js"></script>
    <script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js"></script>
    <script>
        $(function(){
            var clip = new ZeroClipboard.Client();
            clip.setHandCursor( true );
            clip.addEventListener('complete', function(client, text){
                alert("复制成功");
                frameElement.api.close();
            });
          	//update-begin--Author:luobaoli  Date:20150705 for：修改"配置地址"生成的URL为REST风格
          	//update-begin--Author: jg_huangxg  Date:20150806 for：修改"配置地址"生成的URL为 .do风格
			var url = "${url}&id=${title}";
            clip.setText(url);
            $("#menuLink").val(url);
            //update-end--Author: jg_huangxg  Date:20150806 for：修改"配置地址"生成的URL为 .do风格
          	//update-end--Author:luobaoli  Date:20150705 for：修改"配置地址"生成的URL为REST风格
            clip.glue('copyBtn');
            $("#closeBtn").click(function(){
                frameElement.api.close();
            });
        });
    </script>
</head>
<body>
    <div>
        <input id='menuLink'  type='text' style="width:380px;" disabled="disabled"/>
    </div>
    <div class="ui_buttons" style="padding-left: 240px;">
        <input type="button" id="copyBtn" value="复制" class="ui_state_highlight">
        <input type="button" id="closeBtn" value="关闭" onclick='close();'>
    </div>
</body>
</html>