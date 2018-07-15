  <%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
 <head>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">
        function uploadCallback(){
        	var a='';
        	$("#onetomanyuploader").find("input[name='onetomany']").each(function(){
        		a=$(this).val();
        	});
        	return a;
        }
</script>
</head>
 <body style="overflow-x:hidden">
  <t:webUploader auto="true" name="onetomany" outJs="false" fileNumLimit="1"></t:webUploader>
 </body>
 </html>
