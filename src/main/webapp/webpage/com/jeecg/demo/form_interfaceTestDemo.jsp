<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="jquery,easyui,tools"></t:base>
<script>
//重置
function gReload(){
	$("#serverUrl").val('');
	$("#requestBody").val('');
	$("#json-field").val('');
	//$("#S_TYPE_S").val('');
	//$("input.i-checks:first").iCheck('check');
}
// $('input.i-checks:radio').on('ifChecked', function(event){
// 	  $("#S_TYPE").val($(this).attr("value"));
// 	});
	
//发送请求 ajax
function sendSever(){
	if($("#serverUrl").val()=="" ){
		 tip("请输入请求的地址",1);
		$("#serverUrl").focus();
		return false;
	}
	$.ajax({
		type: "POST",
		url: "${webRoot}/jeecgFormDemoController.do?interfaceTest",
    	data: {serverUrl:$("#serverUrl").val(),requestBody:$("#requestBody").val(),requestMethod:$('input[name="requestMethod"]:checked').val()},
		dataType:'json',
		cache: false,
		success: function(data){
			 if(data.success){
				 tip("服务器请求成功！",0);
			 	 $("#json-field").val(data.obj);
			 }else{
				 tip(data.obj,1);
			 }
		}
	});
}
 </script>
 <style type="text/css">
 h1 {
    display: block;
    font-size: 2em;
    -webkit-margin-before: 0.67em;
    -webkit-margin-after: 0.67em;
    -webkit-margin-start: 0px;
    -webkit-margin-end: 0px;
    font-weight: bold;
}
 </style>
  </head>
<body style="overflow-y: hidden" scroll="no">
  <h1 align="center">接口测试</h1>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table">
			<table cellpadding="0" cellspacing="1" class="formtable">
				<tr>
				<td align="right">
						<label class="Validform_label" style="font-size: 14px">
							  请求类型：
						</label>
					</td>
					<td style="height: 40px;padding-left: 15px">
						<input name="requestMethod"  class="form-control i-checks" type="radio" value="GET" checked="checked" >GET
						<input name="requestMethod"  class="form-control i-checks" type="radio" value="POST"  >POST 
						&nbsp;&nbsp;<span><font color="gray">默认GET请求方式</font></span> 
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label" style="font-size: 14px">
							 请求的URL：
						</label>
					</td>
					<td class="value" style="padding-left: 15px">
						<input type="text" id="serverUrl" placeholder="输入请求地址" value=""  style="width:600px;height: 40px" datatype="url">
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label" style="font-size: 14px">
							 请求参数：
						</label>
					</td>
					<td class="value" style="padding-left: 15px">
						  <input type="text" id="requestBody" placeholder="输入请求参数" value="" style="width:600px;height: 40px" >
                           <span><font color="gray">格式:  name1=value1&name2=value2, 如果是get请求请留空。</font></span>

					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label" style="font-size: 14px">
							返回结果:
						</label>
					</td>
					<td class="value" style="padding-left: 15px">
						 <textarea id="json-field" title="返回结果" style="width:600px;height: 100px"></textarea>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label" style="font-size: 14px">
							操作：
						</label>
					</td>
					<td class="value" style="padding-left: 15px">
						 <button class="ace_button" style="width: 10%;height:30px;font-size: 12px" onclick="sendSever();">确定</button>&nbsp;
				 		 <button class="ace_button" style="width: 10%;height:30px;font-size: 12px" onclick="gReload();">重置</button>
					</td>
				</tr>
			</table>
		</t:formvalid>
 </body>
</html>
