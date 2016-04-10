<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
	<head>
		<title>文档目录</title>
		<t:base type="jquery,easyui,tools,DatePicker"></t:base>
		<script src="webpage/jeecg/onlinedoc/ajaxfileupload.js"></script>
		<script type="text/javascript">
		 	$(function(){
		
		 		//触发click方法
		 		$('#uploadLink').on('click',function(){
		 			$('#fileInput').click();
		 		});
		 		
		 		$('#onlineDocSortTree').combotree({
					url : 'onlineDocSortController.do?tree',
					panelHeight : 200,
					width : 157,
					value : '${onlineDocPage.treeNode}',
					onClick : function(node) {
						$("#treeNode").val(node.id);
					}
				});
		 		
		 		//触发click方法
		 		$('#redoLink').on('click',function(){
		 			$("#fileNameInput").val("");
		 			$("#path").val("");
					$("#oldName").val("");
					$("#newName").val("");
		 		});
		 		
		 		$("#fileNameInput").css("color","green");
	 			$("#fileNameInput").val("${onlineDocPage.oldName }");
		 	});
			
			function uploadHead(){
				$.ajaxFileUpload({
					url:"onlineDocController.do?ajaxUpload",//需要链接到服务器地址 
					secureuri:false,
					fileElementId:"fileInput",//文件选择框的id属性
					dataType: 'json',   //json
					success: function (data) {
						var path = jQuery.parseJSON(data).path;
						var oldName = jQuery.parseJSON(data).oldName;
						var newName = jQuery.parseJSON(data).newName;
						
						$("#path").val(path);
						$("#oldName").val(oldName);
						$("#newName").val(newName);

						$("#fileNameInput").val(oldName);
					},
					error:function(XMLHttpRequest, textStatus, errorThrown){
						alert('上传失败！');
					}
				});
			};
		</script>
	</head>
	<body>
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="onlineDocController.do?doUpdate" tiptype="1">
			<input id="id" name="id" type="hidden" value="${onlineDocPage.id }">
			<input id="createName" name="createName" type="hidden" value="${onlineDocPage.createName }">
			<input id="createBy" name="createBy" type="hidden" value="${onlineDocPage.createBy }">
			<input id="createDate" name="createDate" type="hidden" value="${onlineDocPage.createDate }">
			<input id="updateName" name="updateName" type="hidden" value="${onlineDocPage.updateName }">
			<input id="updateBy" name="updateBy" type="hidden" value="${onlineDocPage.updateBy }">
			<input id="updateDate" name="updateDate" type="hidden" value="${onlineDocPage.updateDate }">
			<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${onlineDocPage.sysOrgCode }">
			<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${onlineDocPage.sysCompanyCode }">
			<input id="bpmStatus" name="bpmStatus" type="hidden" value="${onlineDocPage.bpmStatus }">
			<input id="oldName" name="oldName" type="hidden" value="${onlineDocPage.oldName }">
			<input id="newName" name="newName" type="hidden" value="${onlineDocPage.newName }">
			<input id="path" name="path" type="hidden" value="${onlineDocPage.path }">
			<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label">
							文件:
						</label>
					</td>
					<td class="value">
						<input type="text" width="120" disabled="disabled" style="background:#cccccc" id="fileNameInput"/>
						<img alt="文件上载" src="webpage/jeecg/onlinedoc/add.gif" id="uploadLink"/>
						<img alt="取消上载" src="webpage/jeecg/onlinedoc/redo.png" id="redoLink"/>
						
						<input type="file" onchange="uploadHead();" id="fileInput" style="display:none;" name="fileInput" />
						
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">文件</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							文档目录:
						</label>
					</td>
					<td class="value">
						<input id="onlineDocSortTree" />
						<input id="treeNode" name="treeNode" style="display: none;" value="${onlineDocPage.treeNode}">
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">文档目录</label>
					</td>
				</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							描述:
						</label>
					</td>
					<td class="value">
						<textarea rows="10" cols="50" id="description" name="description">${onlineDocPage.description }</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">描述</label>
					</td>
				</tr>
			</table>
		</t:formvalid>
	</body>
<script src = "webpage/jeecg/onlinedoc/onlineDoc.js"></script>