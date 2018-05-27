<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>

<html>
 <head>
  <title>黑名单</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="tsBlackListController.do?doAdd" >
		<input id="id" name="id" type="hidden" value="${tsBlackListPage.id }"/>
		<input id="createName" name="createName" type="hidden" value="${tsBlackListPage.createName }"/>
		<input id="createBy" name="createBy" type="hidden" value="${tsBlackListPage.createBy }"/>
		<input id="createDate" name="createDate" type="hidden" value="${tsBlackListPage.createDate }"/>
		<input id="updateName" name="updateName" type="hidden" value="${tsBlackListPage.updateName }"/>
		<input id="updateBy" name="updateBy" type="hidden" value="${tsBlackListPage.updateBy }"/>
		<input id="updateDate" name="updateDate" type="hidden" value="${tsBlackListPage.updateDate }"/>
		<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${tsBlackListPage.sysOrgCode }"/>
		<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${tsBlackListPage.sysCompanyCode }"/>
		<input id="bpmStatus" name="bpmStatus" type="hidden" value="${tsBlackListPage.bpmStatus }"/>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							ip地址:
						</label>
					</td>
					<td class="value">
					     	 <input id="ip" name="ip" type="text" style="width: 150px" class="inputxt" datatype="*"/>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">ip地址</label>
						</td>
				</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/com/jeecg/black/tsBlackList.js"></script>		
