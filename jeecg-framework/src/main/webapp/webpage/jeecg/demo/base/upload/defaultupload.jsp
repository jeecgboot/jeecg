<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<t:base type="jquery,easyui,tools"></t:base>
<SCRIPT type="text/javascript">
 function openrcon() {
  tip('上传完毕,我是回调函数');
 }
</SCRIPT>
</head>
<body>

<t:formvalid formid="formobj" dialog="false" layout="table" beforeSubmit="upload">
	<table cellpadding="0" width="100%" cellspacing="1" class="formtable">
		<tr>
			<td align="right" height="40" width="10%"><label class="Validform_label">文件标题：</label></td>
			<td class="value" width="30%" colspan="2"><input name="documentTitle" id="documentTitle" datatype="s3-50" errormsg="范围在3~50位字符!"> <span class="Validform_checktip">标题名称在3~50位字符,且不为空</span>
			</td>
		</tr>
		<tr>
			<td align="right" height="40"><label class="Validform_label">选择文件：</label></td>
			<td class="value" width="30%"><t:upload name="fiels" buttonText="上传文件" dialog="false" callback="openrcon" uploader="systemController.do?saveFiles" extend="office" id="default"
				formData="documentTitle"></t:upload></td>
			<td class="value" id="test"></td>
		</tr>
		<tr height="40">
			<td class="upload" colspan="6"><a href="#" class="easyui-linkbutton" id="btn_sub" iconCls="icon-ok">上传</a> <a href="#" class="easyui-linkbutton" id="btn_reset" iconCls="icon-back">重置</a> <a
				href="systemController.do?downloadFiles&path=plug-in/login/images/toplogo-main.png" class="easyui-linkbutton" id="btn_sub" iconCls="icon-ok" callback="openrcon">下载</a></td>
		</tr>
	</table>
</t:formvalid>

</body>
</html>

