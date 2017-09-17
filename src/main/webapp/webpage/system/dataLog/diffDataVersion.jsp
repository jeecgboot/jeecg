<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<% 
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path;
%>
<html>
<title></title>
<!-- update-begin--Author:LiShaoQing  Date:20170817 for：[TASK #2282]IE下箭头被遮挡了 -->
<script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.min.js"></script>
<!-- update-end--Author:LiShaoQing  Date:20170817 for：[TASK #2282]IE下箭头被遮挡了 -->
<link rel="stylesheet" href="<%=basePath %>/plug-in/easyui/themes/icon.css" />
<style type="text/css">
    body, table {
        font-size:12px;
    }
    table {
        table-layout:fixed;
        empty-cells:show;
        border-collapse: collapse;
        margin:0 auto;
    }
    td {
        height:30px;
    }
    h1, h2, h3 {
        font-size:12px;
        margin:0;
        padding:0;
    }
    .table {
        border:1px solid #cad9ea;
        color:#666;
    }
    .table th {
        background-repeat:repeat-x;
        height:30px;
    }
    .table td, .table th {
        border:1px solid #cad9ea;
        padding:0 1em 0;
    }
    .table tr.alter {
        background-color:#f5fafe;
    }
</style>
<body style="overflow：scroll">
	<table width="90%" class="table" style="table-layout:fixed;word-break:break-all">
	    <tbody>
		    <tr>
		        <th style="width:80px; white-space:nowrap">字段名</th>
		        <th style="white-space:nowrap">版本号[${versionNumber1}]</th>
		        <!-- update-begin--Author:LiShaoQing  Date:20170817 for：[TASK #2282]IE下箭头被遮挡了 -->
		        <th class="tdClass" style="white-space:nowrap"></th>
		        <!-- update-end--Author:LiShaoQing  Date:20170817 for：[TASK #2282]IE下箭头被遮挡了 -->
		        <th style="white-space:nowrap">版本号[${versionNumber2}]</th>
		    </tr>
		    <!-- update-begin--Author:taoyan  Date:20170321 for:TASK #1674 【样式美化】数据对比功能样式修改  -->
		    <c:forEach items="${dataLogDiffs }" varStatus="itemStatus" var="item">
		    	<tr <c:if test="${itemStatus.index%2==0}">class="alter"</c:if> <c:if test="${item.diff=='Y'}">style="background-color: rgba(255, 192, 203, 0.31);color:red;"</c:if>>
					<td>${item.name }</td>
					<td>${item.value1 }</td>
					<td><c:if test="${item.diff=='Y'}"><span class="icon-goright" style="display:inline-block;height:15px;width:15px"></span></c:if></td>
					<td>${item.value2 }</td>
				</tr>
	        </c:forEach>
	         <!-- update-end--Author:taoyan  Date:20170321 for:TASK #1674 【样式美化】数据对比功能样式修改  -->
	        
		</tbody>
	</table>
	<!-- update-begin--Author:LiShaoQing  Date:20170817 for：[TASK #2282]IE下箭头被遮挡了 -->
	<script>
	$(function(){
		if(navigator.appName == "Microsoft Internet Explorer" && navigator.appVersion .split(";")[1].replace(/[ ]/g,"")=="MSIE8.0") 
		{
			$(".tdClass").css("width","35px");
		} else {
			$(".tdClass").css("width","15px");
		}
	});
	</script>
	<!-- update-end--Author:LiShaoQing  Date:20170817 for：[TASK #2282]IE下箭头被遮挡了 -->
</body>