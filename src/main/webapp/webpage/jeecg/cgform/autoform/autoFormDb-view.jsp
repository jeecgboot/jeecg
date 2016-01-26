<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>表单数据源</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  	<script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  	<script type="text/javascript" src="plug-in/jquery-plugs/form/jquery.form.js"></script>
  	<LINK rel="stylesheet" href="plug-in/Validform/plugin/jqtransform/jqtransform.css" type="text/css"></LINK>
  	<script type="text/javascript">
  		$(function(){
  			$("#viewSubmit").click(function () {
	  			 $("#formobj").ajaxSubmit({
	  				 type:'post',
	  				success:function(data){
	  					var jsonObj = $.parseJSON(data);
	  					if(jsonObj.success){
	  						$("#viewData").val(JSON.stringify(jsonObj.obj,null,4));
	  					}else{
	  						tip(jsonObj.msg);
	  					}
	  				}
	  			 });
  			});
  		});
  	</script>
  	<link href="plug-in/lhgDialog/skins/default.css" rel="stylesheet" id="lhgdialoglink">
 </head>
 <body style="overflow-x: hidden;">
	 <fieldset style="border: 1px solid #E6E6E6">
	 	<legend><t:mutiLang langKey="form.db.param.input"/></legend>
	 	<form action="autoFormDbController.do?view" id="formobj">
			<input id="id" name="id" type="hidden" value="${autoFormDbEntity.id }">
			<input id="autoFormId" name="autoFormId" type="hidden" value="${autoFormDbEntity.autoFormId }">
			<input id="autoFormDbKey" name="dbKey" type="hidden" value="${autoFormDbEntity.dbKey }">
			<input id="autoFormDbDynSql" name="dbDynSql" type="hidden" value="${autoFormDbEntity.dbDynSql }">
			<input id="autoFormDbTableName" name="dbTableName" type="hidden" value="${autoFormDbEntity.dbTableName }">
			<input id="autoFormDbType" name="dbType" type="hidden" value="${autoFormDbEntity.dbType }">
			<input id="autoFormDbName" name="dbName" type="hidden" value="${autoFormDbEntity.dbName }">
							
			<table cellpadding="0" cellspacing="1" class="formtable" style="width: 100%">
				<c:if test="${fn:length(autoFormParamList)  > 0 }">
					<c:forEach items="${autoFormParamList}" var="poVal" varStatus="status">
						<c:if test="${status.count%2 == 1}">
							<tr height="30px">
						</c:if>
								<td align="center"><label class="Validform_label"><b>${poVal.paramName}：</b></label></td>
								<!-- 属性名称增加"#"为了避免和autoFormDb重复 -->
								<td class="value"><input type="text" name="#${poVal.paramName}" class="inputxt"/><span class="Validform_checktip"></span></td>
						<c:if test="${status.count%2 == 0}">
							</tr>
						</c:if>
						<c:set var="v_count" value="${status.count} "/>
					</c:forEach>
					<c:if test="${fn:length(autoFormParamList)%2==1}">
						<td colspan="2"></td>
						</tr>
					</c:if>
				</c:if>
				
				<tr>
					<td colspan="4" align="right">
						<input id="viewSubmit" type="button" value="<t:mutiLang langKey='form.db.data.query'/>" class="ui_state_highlight"/>
					</td>
				</tr>
			</table>
		</form>
	</fieldset>
	<fieldset style="border: 1px solid #E6E6E6;">
		<legend><t:mutiLang langKey="form.db.data.view"/></legend>
		<textarea type="textarea" style="margin-top: 20px;border: 1px inset #E6E6E6;width: 100%;height:300px;word-wrap:break-word;word-break:break-all;resize:none" id="viewData" class="formdbdiv">
				
		</textarea>
	</fieldset>
 </body>