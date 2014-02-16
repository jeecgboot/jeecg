<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<t:base type="ckeditor,jquery,easyui,tools"></t:base>
<script type="text/javascript">
	 function goForm() {
		 $('#myCkeditorForm').form('submit', {
				url : "jeecgDemoController.do?saveCkeditor",
				dataType:"json",
				success : function(data) {
					var mydata = eval("("+data+")");
					alert(mydata.msg);
				}
		});
     }
	</script>
</head>

<form action="jeecgDemoController.do?saveCkeditor" method="post" id="myCkeditorForm"><input type="hidden" value="${cKEditorEntity.id}" name="id" /> <t:ckeditor name="contents" isfinder="false"
	type="width:1100,height:570" value="${contents}"></t:ckeditor>
<p><input type="button" value="更新" onclick="goForm();"></p>
</form>
</html>