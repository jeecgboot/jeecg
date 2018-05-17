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
            if(codesize>220){
            	var size=parseInt(codesize)+30;
            	console.log(size);
            	$(".text-center").css('width',size+"px");
            	$(".text-center").css('height',size+"px");
            	$("#text-he").css('height','');
            }else{
            	$(".text-center").css('width',"250px");
            	$(".text-center").css('height',"250px");
            	$("#text-he").css('height','');
            }
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
  <style>	
.form-control-lg {
    min-height: 3.5rem;
}
.form-control {
    padding: .375rem .75rem;
    line-height: 1.5;
    color: #55595c;
    background-color: #fff;
    background-image: none;
    border: .0625rem solid #ccc;
    border-radius: .25rem;
    margin-top: 50px;
}

.qrcode {
    position: relative;
    border-radius: 3px;
    width: 280px;
    margin: 0 auto 8px;
    
}
.qrimage-wrap {
    width: 250px;
    height: 250px;
    padding: 10px 0;
    margin: auto;
}

.white {
    background-color: #fff;
}
.text-center {
    text-align: center;
}
table {
    border-spacing: 0;
    border-collapse: collapse;
}
#qrfun-box {
    width: 33.33%;
    margin-left: 0!important;
    padding-right: 10%;
    padding-top: 3%;
}

#qrfun-left {
    width: 50%;
    margin-left: 0!important;
    padding-top: 10px;
    padding-left: 50px;
}
.wrapper {
    width: 100%;
    position: relative;
}

.btn {
    padding: .5rem 1rem;
    line-height: 1.4;
}
.green {
    background-color: #4caf50;
    color: rgba(255,255,255,.87);
}
.btn {
    font-weight: 500;
    outline: 0!important;
    border-width: 0;
    padding: .4375rem 1rem;
}
.btn {
    display: inline-block;
    padding: .375rem 1rem;
    font-size: 1.2rem;
    font-weight: 400;
    line-height: 1.5;
    text-align: center;
    white-space: nowrap;
    vertical-align: middle;
    -ms-touch-action: manipulation;
    touch-action: manipulation;
    cursor: pointer;
    user-select: none;
    border: .0625rem solid transparent;
    border-radius: .25rem;
}

.text-center {
    text-align: center;
    margin: auto;
    }

a, a:focus, a:hover {
    text-decoration: none;
   	color: #fff;
}
  </style>
  <body style="overflow-x: hidden" scroll="no">
  <div>
  <div id="qrfun-left">
       
		<div >
			<label class="Validform_label" style="font-size: 1.1rem;"> 二维码内容： </label>
			<input type="text" name="content" class="form-control form-control-lg"  style="width:80%;font-size: 1.1rem;" id="content" value="http://www.jeecg.org" />
      		 <a id="downloadLink"></a>
        </div>
         <div>
      
            <label class="m-b" style="font-size: 1.1rem;"> 二维码大小： </label>
            <input type="text" class="form-control form-control-lg" style="font-size: 1.1rem;" name="codesize" id="codesize" value="220" onkeyup="value=value.replace(/[^\d]/g,'')">
       		<span style="font-size: 1.1rem;">px</span>
       		<a class="btn green"  href="javascript:make2DCode();" style="position: absolute;left: 26%;top: 173px;"> 生成二维码 </a>
          
            
         
        </div>
    </div>
	<div  id="qrfun-box">
		<div class="qrcode">
       		<table class="qrimage-wrap white b-a text-center" id="click-create">
        	<tbody>
         	<tr>
          		<td style="width:220px; height:220px;">
          			<div style="margin:auto;">
            			<div id="qrcode" align="center"></div>
					</div>
				</td>
         	</tr>
        	</tbody>
       		</table>
       		<div id="text-he" class="text-center" style="padding-top:10px;">
      		<a class="btn green btn-block" href="javascript:downloadqrcode();" style="width:220px;"> 下载二维码 </a>
        </div>
      	</div>
      	
 	</div>
</div>
</body>
</html>
