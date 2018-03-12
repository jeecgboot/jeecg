<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>二维码生成页面</title>
	<t:base type="jquery,easyui"></t:base>
	<script type="text/javascript"  charset="utf-8" src="plug-in/qrcode/jquery.min.js"></script>
	<script type="text/javascript"  charset="utf-8" src="plug-in/qrcode/qrcode.min.js"></script>
	<SCRIPT type="text/javascript">
        function make2DCode() {
            $("#qrcode").html("");//清空二维码
            var qrcode;
            var codesize = document.getElementById("codesize").value;
            console.log(codesize);
            qrcode = new QRCode(document.getElementById("qrcode"), {
                width : codesize,
                height : codesize
            });
            qrcode.makeCode(document.getElementById("content").value);
        };
        window.onload=function(){
            make2DCode();
        };
        function downloadqrcode() {
            // 获取base64的图片节点
            var img = document.getElementById('qrcode').getElementsByTagName('img')[0];
            // 构建画布
            var canvas = document.createElement('canvas');
            canvas.width = img.width;
            canvas.height = img.height;
            canvas.getContext('2d').drawImage(img, 0, 0);
            // 构造url
            url = canvas.toDataURL('image/png');
            // 构造a标签并模拟点击
            var downloadLink = document.getElementById('downloadLink');
            downloadLink.setAttribute('href', url);
            downloadLink.setAttribute('download', '二维码.png');
            downloadLink.click();
        };
  </SCRIPT>
  </head>
  <body style="overflow-x: hidden" scroll="no">
        <div >
            <label class="Validform_label"> 二维码大小： </label>
            <input type="text" style="width: 200px" name="codesize" id="codesize" value="220" onkeyup="value=value.replace(/[^\d]/g,'')">px
            <span class="Validform_checktip"></span>

        </div>

		<div >
			<label class="Validform_label"> 二维码内容： </label>
			<input type="text" name="content" id="content" style="width: 200px" value="http://www.jeecg.org" />
			<input type="button" class="blueButton" value="生成二维码" id="genqrcode" onclick="make2DCode()" />
            <a id="downloadLink"></a>
            <input type="button"  class="blueButton"  value="下载二维码" id="btn_print"  onclick="downloadqrcode()" >

        </div>
		
		<div>
			<label class="Validform_label"> 二维码图片： </label>
            <span class="help-block">&nbsp;&nbsp;&nbsp;&nbsp;请使用微信扫一扫</span>
            <div id="qrcode" style="width:220px; height:220px;margin-top: 10px;margin-left: 10px"></div>
		</div>
</body>
</html>
