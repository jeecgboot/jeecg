<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
	<head>
<t:base type="jquery-webos,easyui,tools,DatePicker,autocomplete"></t:base>
		<link href="plug-in/sliding/css/main.css" rel="stylesheet" type="text/css" />

        <script>
        //update-end--Author:gaofeng  Date:20140620 for：修改云桌面的搜索功能中的系统中应用内搜索
            $(function(){
            	$(".menuSearch_Info").live("click",function(){
            		//$(this).blur();
            			var url=$(this).attr("url");
            			var icon=$(this).attr("icon");
            			var id=$(this).attr("id");
            			var title=$(this).attr("title");
            			//window.parent.close();
            			createwindow(title,url,1000,500);
            		})
            });
        //update-end--Author:gaofeng  Date:20140620 for：修改云桌面的搜索功能中的系统中应用内搜索
        </script>
	</head>
	<body>
	${menuListMap }
	</body>
</html>