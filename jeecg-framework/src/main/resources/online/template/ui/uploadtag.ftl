<#-- 文件上传的通用处理 -->
<#macro uploadtag po>
 <#if po.show_type=='file'>
	<table>
		<#-- update--begin--author:zhangjiaqiang date:20170519 for:修订资源预览关联错误 -->
		<#list filesList as fileB>
			<#if fileB['field']?lower_case == po.field_name>
			<tr style="height:34px;">
			<td title="${fileB['title']}">
			<#if fileB['title']?length gt 20>${fileB['title']?substring(0,15)}...<#else>${fileB['title']}</#if></td>
			<#-- update--begin--author:zhangjiaqiang date:20170608 for:增加下载、预览、删除按钮之间的间隔 -->
			<td><a style="margin-left:8px;" href="${basePath}/commonController.do?viewFile&fileid=${fileB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity" title="下载">下载</a></td>
			<td><a style="margin-left:8px;"  href="javascript:void(0);" onclick="openwindow('预览','${basePath}/commonController.do?openViewFile&fileid=${fileB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)">预览</a></td>
			<td><a style="margin-left:8px;"  href="javascript:void(0)" class="jeecgDetail" onclick="del('${basePath}/cgUploadController.do?delFile&id=${fileB['fileKey']}',this)">删除</a></td>
			<#-- update--end--author:zhangjiaqiang date:20170608 for:增加下载、预览、删除按钮之间的间隔 -->
			</tr>
			</#if>
		</#list>
		<#-- update--end--author:zhangjiaqiang date:20170519 for:修订资源预览关联错误 -->
	</table>
	<#if !(po.operationCodesReadOnly ??)>						
	    <div class="form jeecgDetail">
			<script type="text/javascript">
			var serverMsg="";
			var m = new Map();
			$(function(){$('#${po.field_name}').uploadify(
				{buttonText:'添加文件',
				auto:false,
				progressData:'speed',
				multi:true,
				height:25,
				overrideEvents:['onDialogClose'],
				fileTypeDesc:'文件格式:',
				queueID:'filediv_${po.field_name}',
				<#-- fileTypeExts:'*.rar;*.zip;*.doc;*.docx;*.txt;*.ppt;*.xls;*.xlsx;*.html;*.htm;*.pdf;*.jpg;*.gif;*.png',   页面弹出很慢解决 20170317 scott -->
				fileSizeLimit:'15MB',swf:'${basePath}/plug-in/uploadify/uploadify.swf',	
				uploader:'${basePath}/cgUploadController.do?saveFiles&jsessionid='+$("#sessionUID").val()+'',
				onUploadStart : function(file) { 
					var cgFormId=$("input[name='id']").val();
					$('#${po.field_name}').uploadify("settings", "formData", {'cgFormId':cgFormId,'cgFormName':'${tableName?if_exists?html}','cgFormField':'${po.field_name}'});} ,
				onQueueComplete : function(queueData) {
					 var win = frameElement.api.opener;
					 win.reloadTable();
					 win.tip(serverMsg);
					 frameElement.api.close();},
				onUploadSuccess : function(file, data, response) {var d=$.parseJSON(data);if(d.success){var win = frameElement.api.opener;serverMsg = d.msg;}},onFallback : function(){tip("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试")},onSelectError : function(file, errorCode, errorMsg){switch(errorCode) {case -100:tip("上传的文件数量已经超出系统限制的"+$('#${po.field_name}').uploadify('settings','queueSizeLimit')+"个文件！");break;case -110:tip("文件 ["+file.name+"] 大小超出系统限制的"+$('#${po.field_name}').uploadify('settings','fileSizeLimit')+"大小！");break;case -120:tip("文件 ["+file.name+"] 大小异常！");break;case -130:tip("文件 ["+file.name+"] 类型不正确！");break;}},
				onUploadProgress : function(file, bytesUploaded, bytesTotal, totalBytesUploaded, totalBytesTotal) { }});});
			
				</script><span id="file_uploadspan"><input type="file" name="${po.field_name}" id="${po.field_name}" /></span>
		</div>
		<div class="form" id="filediv_${po.field_name}"> </div>
	</#if>
	<#--update-start--Author: jg_huangxg  Date:20160113 for：TASK #824 【online开发】控件类型扩展增加一个图片类型 image -->
	<#elseif po.show_type=='image'>
		<table>
		    <#-- update--begin--author:zhangjiaqiang date:20170519 for:修订资源预览关联错误 -->
			<#list imageList as imageB>
				<#if imageB['field']?lower_case == po.field_name>
				<tr style="height:34px;">
				<td>${imageB['title']}</td>
				<#-- update--begin--author:zhangjiaqiang date:20170608 for:增加下载、预览、删除按钮之间的间隔 -->
				<td><a style="margin-left:8px;"  href="${basePath}/commonController.do?viewFile&fileid=${imageB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity" title="下载">下载</a></td>
				<td><a style="margin-left:8px;"  href="javascript:void(0);" onclick="openwindow('预览','${basePath}/commonController.do?openViewFile&fileid=${imageB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)">预览</a></td>
				<td><a style="margin-left:8px;"  href="javascript:void(0)" class="jeecgDetail" onclick="del('${basePath}/cgUploadController.do?delFile&id=${imageB['fileKey']}',this)">删除</a></td>
				<#-- update--end--author:zhangjiaqiang date:20170608 for:增加下载、预览、删除按钮之间的间隔 -->
				</tr>
				</#if>
			</#list>
			<#-- update--end--author:zhangjiaqiang date:20170519 for:修订资源预览关联错误 -->
		</table>
		<#if !(po.operationCodesReadOnly ??)>
	    <div class="form jeecgDetail">
			<script type="text/javascript">
			var serverMsg="";
			var m = new Map();
			$(function(){$('#${po.field_name}').uploadify(
				{buttonText:'添加图片',
				auto:false,
				progressData:'speed',
				multi:true,
				height:25,
				overrideEvents:['onDialogClose'],
				fileTypeDesc:'图片格式:',
				queueID:'imagediv_${po.field_name}',
				fileTypeExts:'*.jpg;*.jpeg;*.gif;*.png;*.bmp',
				fileSizeLimit:'15MB',swf:'${basePath}/plug-in/uploadify/uploadify.swf',	
				uploader:'${basePath}/cgUploadController.do?saveFiles&jsessionid='+$("#sessionUID").val()+'',
				onUploadStart : function(file) { 
					var cgFormId=$("input[name='id']").val();
					$('#${po.field_name}').uploadify("settings", "formData", {'cgFormId':cgFormId,'cgFormName':'${tableName?if_exists?html}','cgFormField':'${po.field_name}'});} ,
				onQueueComplete : function(queueData) {
					 var win = frameElement.api.opener;
					 win.reloadTable();
					 win.tip(serverMsg);
					 frameElement.api.close();},
				onUploadSuccess : function(file, data, response) {var d=$.parseJSON(data);if(d.success){var win = frameElement.api.opener;serverMsg = d.msg;}},onFallback : function(){tip("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试")},onSelectError : function(file, errorCode, errorMsg){switch(errorCode) {case -100:tip("上传的文件数量已经超出系统限制的"+$('#${po.field_name}').uploadify('settings','queueSizeLimit')+"个文件！");break;case -110:tip("文件 ["+file.name+"] 大小超出系统限制的"+$('#${po.field_name}').uploadify('settings','fileSizeLimit')+"大小！");break;case -120:tip("文件 ["+file.name+"] 大小异常！");break;case -130:tip("文件 ["+file.name+"] 类型不正确！");break;}},
				onUploadProgress : function(file, bytesUploaded, bytesTotal, totalBytesUploaded, totalBytesTotal) { }});});
			
				</script><span id="image_uploadspan"><input type="file" name="${po.field_name}" id="${po.field_name}" /></span>
		</div>
		<div class="form" id="imagediv_${po.field_name}"> </div>
	</#if>
  </#if>
</#macro>