<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<SCRIPT type=text/javascript src="plug-in/clipboard/ZeroClipboard.js"></SCRIPT>
<t:base type="jquery,easyui,jqueryui-sortable,tools"></t:base>
<!-- update--begin--author:zhangjiaqiang date:20170526 for:TASK #2008 【样式改进】同步数据库下面这个去掉 -->
<style>
<!--
body{
	overflow: hidden;
}
-->
</style>
<!-- update--end--author:zhangjiaqiang date:20170526 for:TASK #2008 【样式改进】同步数据库下面这个去掉 -->
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