<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <t:base type="jquery,easyui,tools"></t:base>
		<link rel="stylesheet" href="plug-in/Validform/css/style.css" type="text/css"/>
		<link rel="stylesheet" href="plug-in/Validform/css/tablefrom.css" type="text/css"/>
	    <link rel="stylesheet" href="plug-in/Formdesign/js/ueditor/formdesign/bootstrap/css/bootstrap.css">
	    <!--[if lte IE 6]>
	    <link rel="stylesheet" type="text/css" href="plug-in/Formdesign/js/ueditor/formdesign/bootstrap/css/bootstrap-ie6.css">
	    <![endif]-->
	    <!--[if lte IE 7]>
	    <link rel="stylesheet" type="text/css" href="plug-in/Formdesign/js/ueditor/formdesign/bootstrap/css/ie.css">
	    <![endif]-->
	    <link rel="stylesheet" href="plug-in/Formdesign/js/ueditor/formdesign/leipi.style.css">
         <style>
            html,body{
                height:100%;
                width:100%;
                padding:0;
                margin:0;
            }
            #preview{
                width:100%;
                height:100%;
                padding:0;
                margin:0;
            }
            #preview *{font-family:sans-serif;font-size:16px;}
        </style>
        <script type="text/javascript">
        $(function(){
        	$(":input").attr("disabled","true");
        });
        </script>
    </head>
    <body class="view">
      <div class="container">
		<%-- <div class="page-header">
		  <h1>预览表单 <small>如无问题请保存你的设计</small></h1>
		</div> --%>
		<div id="preview" style="margin:8px">
			${formContent}
        </div>
	  </div>
        
    </body>
</html>