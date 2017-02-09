<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>下拉树菜单Demo</title>
<t:base type="jquery,easyui"></t:base>
</head>
<body>
	<!-- <div class="con-wrapper" id="con-wrapper1" style="display: none;">
		<div style="margin: 0 15px; background-color: white;"> -->
			<table id="crmInfoId" class="table table-bordered table-hover" style="margin-bottom: 0;">
				<tbody id="addCrminfo">
					<tr>
						<td class="text-center" ><b>选择分类</b></td>
						<td >
							<t:selectZTree id="citySel" url="jeecgDemoController.do?getTree"></t:selectZTree>
						</td>
						<td class="text-center" ><b>名称</b></td>
						<td >
							<input id="name" type="text" name="name" value="" style="width: 200px"/>
						</td>
					</tr>
				</tbody>
			</table>
	<!-- 	</div>
	</div> -->
</body>
</html>