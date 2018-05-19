<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>测试多文件上传</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="multiUploadController.do?doAdd" callback="jeecgFormFileCallBack@Override">
					<input id="cgFormId" name="id" type="hidden" value="${multiUploadPage.id }"/>
					<input id="cgFormName" name="cgFormName" type="hidden" value="jeecg_multi_upload">
					<input id="cgFormField_testFile1" type="hidden" value="TEST_FILE_1">
					<input id="cgFormField_testFile2" type="hidden" value="TEST_FILE_2">
					<input id="cgFormField_testFile3" type="hidden" value="TEST_FILE_3">
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							测试文件1:
						</label>
					</td>
					<td class="value">
								<table></table>
								<div class="form jeecgDetail">
									<t:upload name="testFile1" id="testFile1" queueID="filediv_testFile1" uploader="cgUploadController.do?saveFiles" extend="" formData="cgFormId,cgFormName,cgFormField_testFile1" outhtml="false"></t:upload> 
								</div> 
								<div class="form" id="filediv_testFile1"></div>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">测试文件1</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							测试文件2:
						</label>
					</td>
					<td class="value">
								<table></table>
								<div class="form jeecgDetail"> 
									<t:upload name="testFile2" id="testFile2" queueID="filediv_testFile2" uploader="cgUploadController.do?saveFiles" extend="" formData="cgFormId,cgFormName,cgFormField_testFile2" outhtml="false"></t:upload> 
								</div> 
								<div class="form" id="filediv_testFile2"></div>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">测试文件2</label>
						</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							测试文件3:
						</label>
					</td>
					<td class="value">
								<table></table>
								<div class="form jeecgDetail"> 
									<t:upload name="testFile3" id="testFile3" queueID="filediv_testFile3" uploader="cgUploadController.do?saveFiles" extend="" formData="cgFormId,cgFormName,cgFormField_testFile3" outhtml="true"></t:upload> 
								</div> 
								<div class="form" id="filediv_testFile3"></div>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">测试文件3</label>
						</td>
				</tr>
				
				<tr>
					<td align="right">
						<label class="Validform_label">
							使用说明:
						</label>
					</td>
					<td class="value">
						页面当中使用多个"&lt;t:upload"的时候，需要设置参数outhtml的值，
						<span style="color:red;">最后一个标签当中的outhtml的值设置为true，其余标签当中的outhtml设置为false;</span>
						页面当中有且仅有一个"&lt;t:upload"的时候，可以省略outhtml="true"
					</td>
				</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/com/jeecg/demo/multiUpload.js"></script>		
	  	<script type="text/javascript">
	  		function jeecgFormFileCallBack(data){
	  			if (data.success == true) {
					uploadFile(data);
				} else {
					if (data.responseText == '' || data.responseText == undefined) {
						$.messager.alert('错误', data.msg);
						$.Hidemsg();
					} else {
						try {
							var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
							$.messager.alert('错误', emsg);
							$.Hidemsg();
						} catch(ex) {
							$.messager.alert('错误', data.responseText + '');
						}
					}
					return false;
				}
				if (!neibuClickFlag) {
					var win = frameElement.api.opener;
					win.reloadTable();
				}
	  		}
	  		
			
			var neibuClickFlag = false;
			function neibuClick() {
				neibuClickFlag = true; 
				$('#btn_sub').trigger('click');
			}
			
			function uploadFile(data){
				if(!$("input[name='id']").val()){
					if(data.obj!=null && data.obj!='undefined'){
						$("input[name='id']").val(data.obj.id);
					}
				}
				if($(".uploadify-queue-item").length>0){
					upload();
				}else{
					if (neibuClickFlag){
						alert(data.msg);
						neibuClickFlag = false;
					}else {
						var win = frameElement.api.opener;
						win.reloadTable();
						win.tip(data.msg);
						frameElement.api.close();
					}
				}
			}
	  	</script>
