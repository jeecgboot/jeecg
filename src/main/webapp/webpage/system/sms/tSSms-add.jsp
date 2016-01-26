<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>消息发送记录表</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="tSSmsController.do?doAdd" tiptype="1">
					<input id="id" name="id" type="hidden" value="${tSSmsPage.id }">
					<input id="createName" name="createName" type="hidden" value="${tSSmsPage.createName }">
					<input id="createBy" name="createBy" type="hidden" value="${tSSmsPage.createBy }">
					<input id="createDate" name="createDate" type="hidden" value="${tSSmsPage.createDate }">
					<input id="updateName" name="updateName" type="hidden" value="${tSSmsPage.updateName }">
					<input id="updateBy" name="updateBy" type="hidden" value="${tSSmsPage.updateBy }">
					<input id="updateDate" name="updateDate" type="hidden" value="${tSSmsPage.updateDate }">
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							消息标题:
						</label>
					</td>
					<td class="value">
					     	 <input id="esTitle" name="esTitle" type="text" style="width: 150px" class="inputxt"  
								               
								               >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">消息标题</label>
						</td>
				<tr>
					<td align="right">
						<label class="Validform_label">
							消息类型:
						</label>
					</td>
					<td class="value">
					     	 <input id="esType" name="esType" type="text" style="width: 150px" class="inputxt"  
								               
								               >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">消息类型</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							发送人:
						</label>
					</td>
					<td class="value">
					     	 <input id="esSender" name="esSender" type="text" style="width: 150px" class="inputxt"  
								               
								               >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">发送人</label>
						</td>
				<tr>
					<td align="right">
						<label class="Validform_label">
							接收人:
						</label>
					</td>
					<td class="value">
					     	 <input id="esReceiver" name="esReceiver" type="text" style="width: 150px" class="inputxt"  
								               
								               >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">接收人</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							内容:
						</label>
					</td>
					<td class="value">
					     	 <input id="esContent" name="esContent" type="text" style="width: 150px" class="inputxt">
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">内容</label>
						</td>
				<tr>
					<td align="right">
						<label class="Validform_label">
							发送时间:
						</label>
					</td>
					<td class="value">
					     	 <input id="esSendtime" name="esSendtime" type="text" style="width: 150px" class="inputxt"  
								               
								               >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">发送时间</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							发送状态:
						</label>
					</td>
					<td class="value">
					     	 <input id="esStatus" name="esStatus" type="text" style="width: 150px" class="inputxt"  
								               
								               >
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">发送状态</label>
						</td>
				<td align="right">
					<label class="Validform_label">
					</label>
				</td>
				<td class="value">
				</td>
					</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/system/sms/tSSms.js"></script>		