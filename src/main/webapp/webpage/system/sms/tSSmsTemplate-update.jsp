<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>消息模本表</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="tSSmsTemplateController.do?doUpdate" tiptype="1">
					<input id="id" name="id" type="hidden" value="${tSSmsTemplatePage.id }">
					<input id="createName" name="createName" type="hidden" value="${tSSmsTemplatePage.createName }">
					<input id="createBy" name="createBy" type="hidden" value="${tSSmsTemplatePage.createBy }">
					<input id="createDate" name="createDate" type="hidden" value="${tSSmsTemplatePage.createDate }">
					<input id="updateName" name="updateName" type="hidden" value="${tSSmsTemplatePage.updateName }">
					<input id="updateBy" name="updateBy" type="hidden" value="${tSSmsTemplatePage.updateBy }">
					<input id="updateDate" name="updateDate" type="hidden" value="${tSSmsTemplatePage.updateDate }">
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right">
							<label class="Validform_label">
								模板类型:
							</label>
						</td>
						<td class="value">
									<t:dictSelect field="templateType" type="list"
										typeGroupCode="msgTplType" 
										defaultVal="${tSSmsTemplatePage.templateType}" 
										hasLabel="false"  title="模板类型"
										extendJson="{\"datatype\":\"*\"}" ></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">模板类型</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								模板名称:
							</label>
						</td>
						<td class="value">
						     	 <input id="templateName" name="templateName" type="text" style="width: 150px" class="inputxt"  
									               datatype="*"
  value='${tSSmsTemplatePage.templateName}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">模板名称</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								模板内容:
							</label>
						</td>
						<td class="value">
						  	 	<textarea id="templateContent" style="width:600px;" class="inputxt" rows="6" name="templateContent">${tSSmsTemplatePage.templateContent}</textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">模板内容</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/system/sms/tSSmsTemplate.js"></script>		