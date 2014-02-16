<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<SCRIPT type=text/javascript src="plug-in/clipboard/ZeroClipboard.js"></SCRIPT>
<t:base type="jquery,easyui,jqueryui-sortable,tools"></t:base>
<div>
<div><input type='radio' name='synMethod' value='normal' checked>普通同步(保留表数据)</div>
<div><input type='radio' name='synMethod' value='force'>强制同步(删除表,重新生成)</div>
</div>
<SCRIPT type="text/javascript">
 function getSynChoice(){
	var synchoice;
	$("[name='synMethod']").each(function(){
		if($(this).attr("checked")){
			synchoice = $(this).val();
		}
	});
	return synchoice;
 }
 </SCRIPT>