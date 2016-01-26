<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>表单数据源</title>
  <t:base type="jquery,easyui,tools"></t:base>
  	<script type="text/javascript" src="plug-in/jquery-plugs/form/jquery.form.js"></script>
  	<LINK rel="stylesheet" href="plug-in/Validform/plugin/jqtransform/jqtransform.css" type="text/css"></LINK>
  	<script type="text/javascript">
  		$(function(){
  			$("#viewSubmit").click(function () {
  				//document.formobj.target="mywin";
  				var url = "autoFormController.do?viewContent";
  				var param = $("#formobj").serialize();
  				url = url +"&"+param;
                window.open(url,'mywin',"menubar=0,toolbar=0,status=0,resizable=1,left=0,top=0,scrollbars=1,width=" +(screen.availWidth-10) + ",height=" + (screen.availHeight-50) + "\"");
                //document.formobj.action= "autoFormController.do?viewContent";
                //document.formobj.submit();
                frameElement.api.opener.winclose();
  			});
  		});
  	</script>
  	<link href="plug-in/lhgDialog/skins/default.css" rel="stylesheet" id="lhgdialoglink">
 </head>
 <body style="overflow-x: hidden;">
	<%-- 数据源参数展示 --%>
	<fieldset style="border: 1px solid #E6E6E6">
 	<legend><t:mutiLang langKey="form.db.param.input"/></legend>
 	<t:formvalid formid="formobj" dialog="false" layout="table" action="autoFormController.do?viewContent" tiptype="1">
		<input id="formName" name="formName" type="hidden" value="${autoFormPage.formName }">
						
		<table cellpadding="0" cellspacing="1" class="formtable" style="width: 100%">
		
				<c:forEach items="${paramList}" var="poVal" varStatus="status">
				<tr height="30px">
				   <td align="center"><label class="Validform_label"><b>${poVal}：</b></label></td>
				   <!-- 属性名称增加"#"为了避免和autoFormDb重复 -->
				   <td class="value"><input type="text" name="${poVal}" class="inputxt"/><span class="Validform_checktip"></span></td>
				</tr>
				</c:forEach>
			<tr height="30px">
				<td align="center" >
				<label class="Validform_label"><b>操作模式：</b></label> 
				</td>
				<td class="value">
					<select name="op">
						<option value="">--请选择--</option>
						<option value="view" selected>查看模式</option>
						<option value="add">添加模式</option>
						<option value="update">编辑模式</option>
						<!-- <option value="addorupdate">智能提交模式</option> -->
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="4" align="center" class="value" >
					<input id="viewSubmit" type="button" value=" 预 览 " class="ui_state_highlight" style="font-size:14px;"/>
				</td>
			</tr>
		</table>
	   </t:formvalid>
    </fieldset>
 </body>