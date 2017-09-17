<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>可排序多选</title>
<t:base type="jquery,easyui,tools"></t:base>

</head>
<body>
<t:formvalid formid="formobj" dialog="false" layout="div" callback="test" action="jeecgFormDemoController.do?testsubmit" beforeSubmit="setContentc">
	<fieldset>
	<legend>可排序多选 | input</legend>
	<table>
		<tr>
			<td align="center" width="100px"><label class="Validform_label">用户名称 :</label></td>
			<td class="value">
				
				<input id="id" name="id" type="hidden" value="" /> 
				<input name="realName" class="inputxt" value="" id="realName" readonly="readonly" datatype="*" /> 
				<%-- <t:choose hiddenName="roleid" hiddenid="id" url="userController.do?roles" name="roleList" icon="icon-search" title="选择操作标签" textname="roleName" isclear="true" isInit="true"></t:choose> --%>
				<a href="#" class="easyui-linkbutton l-btn l-btn-plain" plain="true" id="departSearch" onclick="openSelectSort()">
					<span class="l-btn-text icon-search l-btn-icon-left">选择</span>
				</a>
				<a href="#" class="easyui-linkbutton l-btn l-btn-plain" plain="true" id="departRedo" onclick="callbackClean()">
					<span class="l-btn-text icon-redo l-btn-icon-left">清空</span>
				</a>
			 	<!-- <span class="Validform_checktip"></span> -->
			 </td>
		</tr>
	</table>
	</fieldset>
</t:formvalid>
<script type="text/javascript">
function openSelectSort() {
	$.dialog.setting.zIndex = getzIndex(); 
	$.dialog({content: 'url:jeecgFormDemoController.do?gridSelectdemo', zIndex: getzIndex(), title: '用户选择列表', lock: true, width: '700px', height: '400px', opacity: 0.4, button: [
		{name: '<t:mutiLang langKey="common.confirm"/>', callback: callbackRealNameSelect, focus: true},
		{name: '<t:mutiLang langKey="common.cancel"/>', callback: function (){}}
	]}).zindex();
}
function callbackRealNameSelect() {
	var iframe = this.iframe.contentWindow;
	var table = iframe.$("#table1");
	var id='',userName='';
	//$("#table1 tr :first-child").remove();
	$(table).find("tbody tr").each(function() {
		id += $(this).find("input").val()+",";
		userName += $(this).find("span").text()+",";
	})
	$("#realName").val(userName);
	$("#realName").blur();
	$("#id").val(id);
}
function callbackClean(){
	$('#realName').val('');
	$('#id').val('');	
}
</script>
</body>
</html>
