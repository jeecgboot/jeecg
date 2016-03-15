<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>图片表</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script src="webpage/jeecg/image/ajaxfileupload.js"></script>
  <script type="text/javascript">
	  $(function(){
	
			//触发click方法
			$('#defaultImage').on('click',function(){
				$('#fileInput').click();
			});
			//触发click方法
	  		$('#imageUploadLink').on('click',function(){
	  			$('#fileInput').click();
	  		});
		});
		
		function uploadHead(){
			$.ajaxFileUpload({
				url:"imagesController.do?ajaxUpload",//需要链接到服务器地址 
				secureuri:false,
				fileElementId:"fileInput",//文件选择框的id属性
				dataType: 'json',   //json
				success: function (data) {
					var path = jQuery.parseJSON(data).imagePath;
					var oldName = jQuery.parseJSON(data).oldName;
					$("#defaultImage").attr("src","imagesController.do?readImage&imagePath="+path);
					$('#imageAddress').val(path);
					$('#oldName').val(oldName);
				},
				error:function(XMLHttpRequest, textStatus, errorThrown){
					alert('上传失败！');
				}
			});
		};
  </script>
 </head>
 <body>
	<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="imagesController.do?doUpdate" tiptype="1">
		<input id="id" name="id" type="hidden" value="${imagesPage.id }">
		<input id="createName" name="createName" type="hidden" value="${imagesPage.createName }">
		<input id="createBy" name="createBy" type="hidden" value="${imagesPage.createBy }">
		<input id="createDate" name="createDate" type="hidden" value="${imagesPage.createDate }">
		<input id="updateName" name="updateName" type="hidden" value="${imagesPage.updateName }">
		<input id="updateBy" name="updateBy" type="hidden" value="${imagesPage.updateBy }">
		<input id="updateDate" name="updateDate" type="hidden" value="${imagesPage.updateDate }">
		<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${imagesPage.sysOrgCode }">
		<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${imagesPage.sysCompanyCode }">
		<input id="extensions" name="extensions" type="hidden" value="${imagesPage.extensions }">
		<input id="oldName" name="oldName" type="hidden" value="${imagesPage.oldName }">
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
			<tr>
				<td align="right">
					<label class="Validform_label">
						标题:
					</label>
				</td>
				<td class="value">
				     	 <input id="name" name="name" type="text" style="width: 150px" class="inputxt"  value='${imagesPage.name}'>
					<span class="Validform_checktip"></span>
					<label class="Validform_label" style="display: none;">标题</label>
				</td>
			<tr>
				<td align="right">
					<label class="Validform_label">
						图片:
					</label>
				</td>
				<td class="value">
					<input type="hidden" id="imageAddress" name="imageAddress" value='${imagesPage.imageAddress}'/>
					<div >
						<a href="javascript:void(0);" id="imageUploadLink">[图片上载]</a>
						<a href="${imagesPage.imageAddress}"  target="_blank" id="imageAddress_href" href="${imagesPage.imageAddress}">[下载]</a>
					</div>
					<div>
						<img id="defaultImage" src="${imagesPage.imageAddress}" alt="图片上载" width="250" height="188">
					</div>
					<script type="text/javascript">
						function imageAddressCallback(url,name){
							$("#imageAddress_href").attr('href',url).html('下载');
							$("#imageAddress").val(url);
						}
					</script>
					<input type="file" onchange="uploadHead();" id="fileInput" style="display:none;" name="fileInput" />
				</td>
			</tr>
		</table>
	</t:formvalid>
 </body>
  <script src = "webpage/jeecg/image/images.js"></script>		