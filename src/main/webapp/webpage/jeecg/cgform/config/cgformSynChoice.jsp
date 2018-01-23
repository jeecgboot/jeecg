<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<SCRIPT type=text/javascript src="plug-in/clipboard/ZeroClipboard.js"></SCRIPT>
<t:base type="jquery,easyui,jqueryui-sortable,tools"></t:base>
<style>
<!--
body{
	overflow: hidden;
}
-->
</style>
<div>
<div><input type='radio' name='synMethod' value='normal' checked><t:mutiLang langKey="normal.sync"/></div>
<div><input type='radio' name='synMethod' value='force'><t:mutiLang langKey="force.sync"/></div>
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