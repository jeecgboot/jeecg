<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>form_nature</title>
<meta http-equiv="X-UA-Compatible" content="IE=9; IE=8; IE=7; IE=EDGE"/>
<t:base type="jquery,easyui,tools"></t:base>

<!-- ztree -->
<link rel="stylesheet" type="text/css" href="plug-in/ztree/css/zTreeStyle.css"></link>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js" ></script>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js"></script>

<!-- 文件上传 -->
<link rel="stylesheet" type="text/css" href="plug-in/webuploader/webuploader.css"></link>
<script type="text/javascript" src="plug-in/webuploader/webuploader.min.js" ></script>

<!-- 自动补全 -->
<link rel="stylesheet" href="plug-in/jquery/jquery-autocomplete/jquery.autocomplete.css" type="text/css"></link>
<script type="text/javascript" src="plug-in/jquery/jquery-autocomplete/jquery.autocomplete.min.js"></script>

<!-- 联动 -->
<script src="plug-in/jquery/jquery.regionselect.js" type="text/javascript"></script>
</head>
<body>
<t:formvalid layout="div" formid="dd" dialog="" >

<!-- update-begin--Author:yugwu  Date:20170626 for：[TASK #2135]【浏览器兼容问题】IE8下样式乱了-------------------- -->
 <fieldset>
 <legend>文件上传</legend>
	<div id="uploader" class="wu-example">
	    <!--用来存放文件信息-->
	    <div id="thelist" class="uploader-list"></div>
	    <div class="btns">
	        <div id="picker">选择文件</div>
	    </div>
	</div>
 </fieldset>
 
 <fieldset>
 <legend>autocomplete</legend>
  <table>
	<tr>
		<td style="width:90px;text-align: right;">用户名自动补全:</td>
		<td>
			<input type="text" id="userNameAuto" name="userName" class="ac_input">
		</td>
	</tr>
 </table>
 </fieldset>
  
 <fieldset>
 <legend>联动下拉省市区</legend>
	<!-- update-begin_author:taoYan date:20170803 for:修复ie下样式变乱   -->
 	<div style="width:80%;margin:5px 0 0 10px;">
	  <input type="text" id="province" style="width:32%;" value=""/> 
	  <input type="text" id="city" style="width:32%;" value=""/> 
	  <input type="text" id="area" style="width:32%;" value=""/> 
 	</div>
 </fieldset>
 
 <fieldset>
 <legend>ztree</legend>
 	<div style="clear:both"></div>
 	<div class="zTreeDemoBackground left">
		<ul id="treeDemo" class="ztree"></ul>
	</div>
 </fieldset>
 <!-- update-end-author:taoYan date:20170803 for:修复ie下样式变乱  -->
 
 <fieldset>
 <legend>ueditor</legend>
 	 	<table>
	<tr>
		<!-- <td align="right"><label class="Validform_label">demo:</label> -->
		<td>
			<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
			<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
	    	<textarea name="ueditorContent" id="ueditorContent" style="width: 650px;"></textarea>
		    <script type="text/javascript">
		        var editor = UE.getEditor('ueditorContent');
		    </script>
		    <span class="Validform_checktip"></span>
		</td>
	</tr>
 	</table>
 </fieldset>
</t:formvalid>
<!-- update-end--Author:yugwu  Date:20170626 for：[TASK #2135]【浏览器兼容问题】IE8下样式乱了-------------------- -->

<!-- update-begin--Author:taoYan  Date:20170803 for：代码格式修改 -->
<script type="text/javascript">
function printobj(obj){
	var str='[';
	for(var a in obj){
		str+=a+':'+obj[a]+",";
	}
	str+=0+':0]';
	return str;
}
function getTremValueuserName() {
	return $("#userNameAuto").val();
}
$(function() {
	//ztree
	var setting = {
		check: {
			enable: true
		},
		view: {
			dblClickExpand: true
		},
		data: {
			simpleData: {
				enable: true
			}
		}
	};
	var zNodes=jQuery.parseJSON('${regions}');
	$.fn.zTree.init($("#treeDemo"), setting, zNodes);
	
	//省市区下拉
	$("#province").regionselect({
			url:'<%=basePath%>/jeecgFormDemoController.do?regionSelect'
	});
	
	/*-------------------------------------------文件上传----------------------------------------------*/
	var urlc= '<%=basePath%>/systemController/filedeal.do';
	var BASE_URL="<%=basePath%>";
	var uploader = WebUploader.create({
	    // swf文件路径
	    swf: BASE_URL+'/plug-in/webuploader/Uploader.swf',
	    // 文件接收服务端。
		server: urlc,
	    // 选择文件的按钮。可选。
	    // 内部根据当前运行是创建，可能是input元素，也可能是flash.
	    pick: '#picker',
	    // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
	    resize: false,
	    //指明参数名称，后台也用这个参数接收文件
	    duplicate: false,
	    auto: true,
	    //每次上传附带参数
	    formData:{"uparg":"ggfile"}
	 
	});
	uploader.on( 'fileQueued', function( file ) {
		$("#thelist").append( '<div id="' + file.id + '" class="item">' +
	        '<div class="state">'+file.name+'---等待上传...</div>' +
	    '</div>' );
	}); 
	
	//文件上传过程中创建进度条实时显示.
	 uploader.on( 'uploadProgress', function( file, percentage ) {
	    var $li = $( '#'+file.id ),
	        $percent = $li.find('.progress .progress-bar');
	    // 避免重复创建
	    if ( !$percent.length ) {
	        $percent = $('<div class="progress progress-striped active">' +
	          '<div class="progress-bar" role="progressbar" style="width: 0%">' +
	          '</div>' +
	        '</div>').appendTo( $li ).find('.progress-bar');
	    }
	    $li.find('div.state').html(file.name+'---上传中');
	    $percent.css( 'width', percentage * 100 + '%' );
	});
	uploader.on( 'uploadSuccess', function(file) {
	    $( '#'+file.id ).find('div.state').html(file.name+'---上传成功!');
	});
	uploader.on( 'uploadError', function( file) {
	    $( '#'+file.id ).find('div.state').html(file.name+'---上传出错');
	});
	uploader.on( 'uploadComplete', function( file ) {
	   $( '#'+file.id ).find('.progress').fadeOut('slow');
	}); 
	/*-------------------------------------------文件上传----------------------------------------------*/
	
	/*-------------------------------------------自动补全----------------------------------------------*/
	$("#userNameAuto").autocomplete("jeecgFormDemoController.do?getAutocompleteData", {
        max: 5,
        minChars: 1,
        width: 200,
        scrollHeight: 100,
        matchContains: true,
        autoFill: false,
        extraParams: {
            featureClass: "P",
            style: "full",
            maxRows: 10,
            labelField: "userName",
            valueField: "userName",
            searchField: "userName",
            entityName: "TSUser",
            trem: getTremValueuserName
        },
        parse: function(data) {
            return jeecgAutoParse.call(this, data);
        },
        formatItem: function(row, i, max) {
            return row['userName'];
        }
    }).result(function(event, row, formatted) {
        $("#userNameAuto").val(row['userName']);
    });
	/*-------------------------------------------自动补全----------------------------------------------*/

	$("div.webuploader-container").css("width","78px");

});
</script>
</body>
</html>
<!-- update-end--Author:taoYan  Date:20170803 for：代码格式修改 -->