<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>业务SQL表</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="tSSmsSqlController.do?doAdd" tiptype="1">
					<input id="id" name="id" type="hidden" value="${tSSmsSqlPage.id }">
					<input id="createName" name="createName" type="hidden" value="${tSSmsSqlPage.createName }">
					<input id="createBy" name="createBy" type="hidden" value="${tSSmsSqlPage.createBy }">
					<input id="createDate" name="createDate" type="hidden" value="${tSSmsSqlPage.createDate }">
					<input id="updateName" name="updateName" type="hidden" value="${tSSmsSqlPage.updateName }">
					<input id="updateBy" name="updateBy" type="hidden" value="${tSSmsSqlPage.updateBy }">
					<input id="updateDate" name="updateDate" type="hidden" value="${tSSmsSqlPage.updateDate }">
		<table style="width: 100%" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							SQL名称:
						</label>
					</td>
					<td class="value">
					     	 <input id="sqlName" name="sqlName" type="text" style="width: 150px" class="inputxt"  
								               datatype="*"
>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">SQL名称</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							SQL内容:
						</label>
					</td>
					<td class="value">
						  	 <textarea style="width:600px;" class="inputxt" rows="6" id="sqlContent" name="sqlContent"></textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">SQL内容</label>
						</td>
				</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/system/sms/tSSmsSql.js"></script>		