<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
 <head>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
        function uploadCallback(callback,inputId){
        	var a='';
        	$("#uploader").find("input[name='okpath']").each(function(){
        		a+=$(this).val()+",";
        	});
        	return a;
        }
</script>
</head>
 <body>
 	<t:webUploader name="okpath" buttonStyle="div" fileNumLimit="1" url="jeecgFormDemoController/filedeal.do"></t:webUploader>
 	<div id="tempdiv"></div>
 </body>
 </html>
