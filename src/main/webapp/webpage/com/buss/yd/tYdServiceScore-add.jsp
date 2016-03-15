<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>艺都餐厅客户服务评价</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="plug-in/ckeditor_new/ckeditor.js"></script>
  <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
  <t:authFilter></t:authFilter>
  
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="tYdServiceScoreController.do?doAdd" tiptype="1">
					<input id="id" name="id" type="hidden" value="${tYdServiceScorePage.id }">
					<input id="createName" name="createName" type="hidden" value="${tYdServiceScorePage.createName }">
					<input id="createBy" name="createBy" type="hidden" value="${tYdServiceScorePage.createBy }">
					<input id="createDate" name="createDate" type="hidden" value="${tYdServiceScorePage.createDate }">
					<input id="updateName" name="updateName" type="hidden" value="${tYdServiceScorePage.updateName }">
					<input id="updateBy" name="updateBy" type="hidden" value="${tYdServiceScorePage.updateBy }">
					<input id="updateDate" name="updateDate" type="hidden" value="${tYdServiceScorePage.updateDate }">
					<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${tYdServiceScorePage.sysOrgCode }">
					<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${tYdServiceScorePage.sysCompanyCode }">
		<table style="width: 700px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							饭菜口味:
						</label>
					</td>
					<td class="value">
							  <t:dictSelect field="foodScore" type="radio"
									typeGroupCode="five_score" defaultVal="${tYdServiceScorePage.foodScore}" hasLabel="false"  title="饭菜口味"></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">饭菜口味</label>
						</td>
				<tr id="c_speedScore">
					<td align="right">
						<label class="Validform_label">
							送餐速度:
						</label>
					</td>
					<td class="value">
							  <t:dictSelect field="speedScore" type="radio"
									typeGroupCode="five_score" defaultVal="${tYdServiceScorePage.speedScore}" hasLabel="false"  title="送餐速度"></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">送餐速度</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							评价详情:
						</label>
					</td>
					<td class="value">
						  	 <textarea style="width:600px;" class="inputxt" rows="6" id="detail" name="detail"></textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">评价详情</label>
						</td>
				<tr id="c_response">
					<td align="right">
						<label class="Validform_label">
							餐厅反馈:
						</label>
					</td>
					<td class="value">
						  	 <textarea style="width:600px;" class="inputxt" rows="6" id="response" name="response"></textarea>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">餐厅反馈</label>
						</td>
					</tr>
				<tr id="c_isValid">
					<td align="right">
						<label class="Validform_label">
							是否有效:
						</label>
					</td>
					<td class="value">
							  <t:dictSelect field="isValid" type="list"
									typeGroupCode="is_valid" defaultVal="${tYdServiceScorePage.isValid}" hasLabel="false"  title="是否有效"></t:dictSelect>     
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">是否有效</label>
						</td>
						</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/com/buss/yd/tYdServiceScore.js"></script>		