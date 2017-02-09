<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
    <head>
        <title></title>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
        <t:base type="jquery,easyui,tools"></t:base>
        <script type="text/javascript" src="plug-in/jquery-plugs/form/jquery.form.js"></script>
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
    </head>
    <body class="view">
    <form action="autoFormController.do?addorupdateForm" method="post">
      <input type="hidden" name="formName" value="${formName}">
      <c:forEach items="${param}" var="item">
        <input type="hidden" name="param.${item.key}" value="${item.value}">
	  </c:forEach>
      <div class="container">
		<%-- <div class="page-header">
		  <h1>预览表单 <small>如无问题请保存你的设计</small></h1>
		</div> --%>
		<div id="preview" style="margin:8px">
			${formContent}
        </div>
	  </div>
     </form>   
     
     <br><br>
     <nav class="navbar navbar-default navbar-fixed-bottom" role="navigation">
         <div class="navbar-inner">
		    <div class="container">
		      <div class="nav-collapse collapse">
		        <ul class="nav" style="float: right;">
		            <li><button type="button" class="btn btn-primary  navbar-button" onclick="formSubmit();"> 提 交 </button></li>
		        </ul>
		      </div>
		    </div>
		    <hr>
		  </div>
     </nav>
    </body>
</html>