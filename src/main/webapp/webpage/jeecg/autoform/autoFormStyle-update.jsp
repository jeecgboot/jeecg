<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>表单样式表</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="autoFormStyleController.do?doUpdate" tiptype="1">
			<input id="id" name="id" type="hidden" value="${autoFormStylePage.id }">
			<input id="createName" name="createName" type="hidden" value="${autoFormStylePage.createName }">
			<input id="createBy" name="createBy" type="hidden" value="${autoFormStylePage.createBy }">
			<input id="createDate" name="createDate" type="hidden" value="${autoFormStylePage.createDate }">
			<input id="updateName" name="updateName" type="hidden" value="${autoFormStylePage.updateName }">
			<input id="updateBy" name="updateBy" type="hidden" value="${autoFormStylePage.updateBy }">
			<input id="updateDate" name="updateDate" type="hidden" value="${autoFormStylePage.updateDate }">
			<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${autoFormStylePage.sysOrgCode }">
			<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${autoFormStylePage.sysCompanyCode }">
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right" style="width:15%;">
						<label class="Validform_label">
							表单名称:
						</label>
					</td>
					<td class="value" style="width:85%;">
					     	 <input id="styleDesc" name="styleDesc" type="text" style="width: 25%;" class="inputxt" datatype="*" ajaxurl="autoFormStyleController.do?checkStyleNm&id=${autoFormStylePage.id}"
									       value='${autoFormStylePage.styleDesc}'>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">表单名称</label>
					</td>
				</tr>
				<tr >
					 <td align="right">
						<label class="Validform_label">
							表单内容:
						</label>
					</td>
					<td class="value">
				     <textarea id="styleContent" name="styleContent" rows="30" cols="245" datatype="*">${autoFormStylePage.styleContent}</textarea>
					</td>
				</tr>
		</table>
		</t:formvalid>
 </body>
 </html>	