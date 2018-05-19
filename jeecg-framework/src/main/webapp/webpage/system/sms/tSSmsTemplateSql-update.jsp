<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>消息模板_业务SQL配置表</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="tSSmsTemplateSqlController.do?doUpdate" tiptype="1">
					<input id="id" name="id" type="hidden" value="${tSSmsTemplateSqlPage.id }">
					<input id="createName" name="createName" type="hidden" value="${tSSmsTemplateSqlPage.createName }">
					<input id="createBy" name="createBy" type="hidden" value="${tSSmsTemplateSqlPage.createBy }">
					<input id="createDate" name="createDate" type="hidden" value="${tSSmsTemplateSqlPage.createDate }">
					<input id="updateName" name="updateName" type="hidden" value="${tSSmsTemplateSqlPage.updateName }">
					<input id="updateBy" name="updateBy" type="hidden" value="${tSSmsTemplateSqlPage.updateBy }">
					<input id="updateDate" name="updateDate" type="hidden" value="${tSSmsTemplateSqlPage.updateDate }">
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right">
							<label class="Validform_label">
								配置CODE:
							</label>
						</td>
						<td class="value">
						     	 <input id="code" name="code" type="text" style="width: 150px" class="inputxt"  datatype="*"  value='${tSSmsTemplateSqlPage.code}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">配置CODE</label>
						</td>
					<tr>
						<td align="right">
							<label class="Validform_label">
								配置名称:
							</label>
						</td>
						<td class="value">
						     	 <input id="name" name="name" type="text" style="width: 150px" class="inputxt"  datatype="*"  value='${tSSmsTemplateSqlPage.name}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">配置名称</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								业务SQLID:
							</label>
						</td>
						<td class="value">
									<t:dictSelect field="sqlId" type="list" dictTable="t_s_sms_sql" dictField="id" dictText="sql_name" 
										defaultVal="${tSSmsTemplateSqlPage.sqlId}" hasLabel="false"  title="业务SQLID" extendJson="{\"datatype\":\"*\"}"></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">业务SQLID</label>
						</td>
					<tr>
						<td align="right">
							<label class="Validform_label">
								消息模本ID:
							</label>
						</td>
						<td class="value">
									<t:dictSelect field="templateId" type="list" dictTable="t_s_sms_template" dictField="id" dictText="template_name" 
										defaultVal="${tSSmsTemplateSqlPage.templateId}" hasLabel="false"  title="消息模本ID" extendJson="{\"datatype\":\"*\"}"></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">消息模本ID</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
 </body>