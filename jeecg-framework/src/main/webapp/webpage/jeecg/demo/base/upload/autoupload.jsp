<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<t:base type="jquery,easyui,tools"></t:base>
<script type="text/javascript">

	function submitproject(r) {
		if (r.success) {
			window.top.$.messager.progress('close');
		}
	}

	function showzj(type, no) {
		openwindow('查看', 'attachmentController.do?archivedocList&id=${tbCorpArchive.id}&type=' + type);
	}
</script>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid layout="table" dialog="false" formid="formobj" beforeSubmit="show" callback="submitproject" action="systemController.do?saveFiles">
	<input type="hidden" name="id" value="${demo.id }">
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tbody>
			<tr>
				<td align="right" height="40" width="10%"><label class="Validform_label">文件标题：</label></td>
				<td class="value" width="30%" colspan="2"><input name="documentTitle" id="documentTitle" datatype="s3-50" errormsg="范围在3~50位字符!"> <span class="Validform_checktip">标题名称在3~50位字符,且不为空</span>
				</td>
			</tr>
			<tr>
				<td align="right"><label class="Validform_label">上传文件:</label></td>
				<td class="value"><t:upload name="instruction" dialog="false" queueID="instructionfile" view="true" auto="true" uploader="systemController.do?saveFiles" extend="pic" id="instruction"
					formData="documentTitle"></t:upload></td>
			</tr>
			<tr>
				<td colspan="2" id="instructionfile" class="value"></td>
			</tr>
		</tbody>
	</table>
</t:formvalid>
</body>
</html>

