<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<#assign callbackFlag = false />
<#assign fileName = "" />
<#list pageColumns as callBackTestPo>
	<#if callBackTestPo.showType=='file'>
		<#assign callbackFlag = true />
	</#if>
</#list>
<html>
 <head>
  <title>${ftl_description}</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <#if callbackFlag == true>
		<link rel="stylesheet" href="plug-in/uploadify/css/uploadify.css" type="text/css" />
		<script type="text/javascript" src="plug-in/uploadify/jquery.uploadify-3.1.js"></script>
  </#if>
  <script src="plug-in/layer/layer.js"></script>
 <script>
	function btn_ok(){
		$("#btnsub").click();
	}
	function callback(data){
		
		<#if callbackFlag == true>
	  	jeecgFormFileCallBack(data);
  	</#if>
		
		if(data.success){
			layer.alert(data.msg, function(index){
				window.location.href="${entityName?uncap_first}Controller.do?list"
				layer.close(index);
			});       
		}
		else{
			layer.alert(data.msg);
		}
	}
</script>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="false" usePlugin="password" layout="table" action="${entityName?uncap_first}Controller.do?doAdd" tiptype="1" callback="callback">
			<#list columns as po>
				<#if po.isShow == 'N'>
					<input id="${po.fieldName}" name="${po.fieldName}" type="hidden" value="${'$'}{${entityName?uncap_first}Page.${po.fieldName} }">
				</#if>
			</#list>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
			<#list pageColumns as po>
			<#if (pageColumns?size>20)>
			<#if po_index%2==0>
				<tr>
				</#if>
			<#else>
				<tr>
			</#if>
					<td align="right">
						<label class="Validform_label">
							${po.content}:
						</label>
					</td>
					<td class="value">
						 <#if po.showType=='text'>
					     	 <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" 
					     	 <#-- update--begin--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
									<#if po.fieldMustInput??><#if po.fieldMustInput == 'Y' || po.isNull != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
					     	 class="inputxt" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#elseif po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#elseif po.isNull != 'Y'> datatype="*"</#if>>
						<#elseif po.showType=='popup'>
						<input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" class="searchbox-inputtext" <#if po.fieldValidType?if_exists?html != ''>
							datatype="${po.fieldValidType?if_exists?html}"
						<#elseif po.type == 'int'>
								datatype="n" 
							<#elseif po.type=='double'>
								     datatype="/^(-?\d+)(\.\d+)?$/" 
							<#elseif po.isNull != 'Y'>datatype="*"
						</#if>
						<#-- update--begin--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
						<#if po.fieldMustInput??><#if po.fieldMustInput == 'Y' || po.isNull != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
						<#-- update--end--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
						<#if po.dictTable?if_exists?html!=""> onclick="inputClick(this,'${po.dictField}','${po.dictTable}')"</#if>>
						  <#elseif po.showType=='textarea'>
						  	 <textarea style="width:600px;" class="inputxt" rows="6" id="${po.fieldName}" 
						  	 <#-- update--begin--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
									<#if po.fieldMustInput??><#if po.fieldMustInput == 'Y' || po.isNull != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
						  	 name="${po.fieldName}"></textarea>
					      <#elseif po.showType=='password'>
					      	<input id="${po.fieldName}" name="${po.fieldName}" type="password" style="width: 150px" class="inputxt"  
					      					<#-- update--begin--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
									<#if po.fieldMustInput??><#if po.fieldMustInput == 'Y' || po.isNull != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
					      							<#if po.fieldValidType?if_exists?html != ''>
								               datatype="${po.fieldValidType?if_exists?html}"
								               <#elseif po.type == 'int'>
								               datatype="n" 
								               <#elseif po.type=='double'>
								               datatype="/^(-?\d+)(\.\d+)?$/" 
								               <#elseif po.isNull != 'Y'>datatype="*"
								               </#if>
						       >
							<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>	 
							  <t:dictSelect field="${po.fieldName}" type="${po.showType?if_exists?html}"
									<#if po.dictTable?if_exists?html != ''>dictTable="${po.dictTable?if_exists?html}" dictField="${po.dictField?if_exists?html}" dictText="${po.dictText?if_exists?html}"<#else>typeGroupCode="${po.dictField}"</#if> defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
							<#elseif po.showType=='date'>
							   <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" 
					      						class="Wdate" onClick="WdatePicker()"
					      						<#-- update--begin--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
									<#if po.fieldMustInput??><#if po.fieldMustInput == 'Y' || po.isNull != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
					      						<#if po.fieldValidType?if_exists?html != ''>
								               datatype="${po.fieldValidType?if_exists?html}"
								               <#elseif po.isNull != 'Y'>datatype="*"
								               </#if>>    
					      	<#elseif po.showType=='datetime'>
							   <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" 
					      						 class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
					      						<#-- update--begin--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
									<#if po.fieldMustInput??><#if po.fieldMustInput == 'Y' || po.isNull != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
					      						<#if po.fieldValidType?if_exists?html != ''>
								               datatype="${po.fieldValidType?if_exists?html}"
								               <#elseif po.isNull != 'Y'>datatype="*"
								               </#if>>
							<#elseif po.showType=='file'>
								<#assign fileName = "${po.fieldName}" />
								<table></table>
								<div class="form jeecgDetail"> 
									<script type="text/javascript">
										var serverMsg="";
										$(function(){
											$('#${po.fieldName}').uploadify({
												buttonText:'添加文件',
												auto:false,
												progressData:'speed',
												multi:true,
												height:25,
												overrideEvents:['onDialogClose'],
												fileTypeDesc:'文件格式:',
												queueID:'filediv_file',
												<#-- fileTypeExts:'*.rar;*.zip;*.doc;*.docx;*.txt;*.ppt;*.xls;*.xlsx;*.html;*.htm;*.pdf;*.jpg;*.gif;*.png',   页面弹出很慢解决 20170317 scott -->
												fileSizeLimit:'15MB',
												swf:'plug-in/uploadify/uploadify.swf',	
												uploader:'cgUploadController.do?saveFiles&jsessionid='+$("#sessionUID").val()+'',
												onUploadStart : function(file) { 
													var cgFormId=$("input[name='id']").val();
													$('#${po.fieldName}').uploadify("settings", "formData", {
														'cgFormId':cgFormId,
														'cgFormName':'${tableName}',
														'cgFormField':'${fieldMeta[po.fieldName]}'
													});
												} ,
												onQueueComplete : function(queueData) {
													 var win = frameElement.api.opener;
													 win.reloadTable();
													 win.tip(serverMsg);
													 frameElement.api.close();
												},
												onUploadSuccess : function(file, data, response) {
													var d=$.parseJSON(data);
													if(d.success){
														var win = frameElement.api.opener;
														serverMsg = d.msg;
													}
												},
												onFallback: function() {
								                    tip("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试")
								                },
								                onSelectError: function(file, errorCode, errorMsg) {
								                    switch (errorCode) {
								                    case - 100 : tip("上传的文件数量已经超出系统限制的" + $('#file').uploadify('settings', 'queueSizeLimit') + "个文件！");
								                        break;
								                    case - 110 : tip("文件 [" + file.name + "] 大小超出系统限制的" + $('#file').uploadify('settings', 'fileSizeLimit') + "大小！");
								                        break;
								                    case - 120 : tip("文件 [" + file.name + "] 大小异常！");
								                        break;
								                    case - 130 : tip("文件 [" + file.name + "] 类型不正确！");
								                        break;
								                    }
								                },
								                onUploadProgress: function(file, bytesUploaded, bytesTotal, totalBytesUploaded, totalBytesTotal) {}
											});
										});
									</script>
									<span id="file_uploadspan"><input type="file" name="${po.fieldName}" id="${po.fieldName}" /></span> 
								</div> 
								<div class="form" id="filediv_file"></div>
							<#--update-start--Author: jg_huangxg  Date:20160421 for：TASK #1027 【online】代码生成器模板不支持UE编辑器 -->
							<#elseif po.showType='umeditor'>
								<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
								<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
						    	<textarea name="${po.fieldName}" id="${po.fieldName}" style="width: 650px;height:300px"></textarea>
							    <script type="text/javascript">
							        var editor = UE.getEditor('${po.fieldName}');
							    </script>
							<#--update-end--Author: jg_huangxg  Date:20160421 for：TASK #1027 【online】代码生成器模板不支持UE编辑器 -->
					      	<#else>
					      		<input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" class="inputxt"  
					      					<#-- update--begin--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
									<#if po.fieldMustInput??><#if po.fieldMustInput == 'Y' || po.isNull != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170414 for:增加校验必填项 -->
					      							<#if po.fieldValidType?if_exists?html != ''>
								               datatype="${po.fieldValidType?if_exists?html}"
								               <#elseif po.type == 'int'>
								               datatype="n" 
								               <#elseif po.type=='double'>
								               datatype="/^(-?\d+)(\.\d+)?$/" 
								               <#elseif po.isNull != 'Y'>datatype="*"
								               </#if>>
							</#if>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
						</td>
			<#if (columns?size>20)>
				<#if (po_index%2==0)&&(!po_has_next)>
				<td align="right">
					<label class="Validform_label">
					</label>
				</td>
				<td class="value">
				</td>
				</#if>
				<#if (po_index%2!=0)||(!po_has_next)>
					</tr>
				</#if>
				<#else>
				</tr>
			</#if>
				</#list>
				<tr>
					<td height="50px" align="center" colspan="2">
						<a style="margin-left:80px" href="#" class="easyui-linkbutton l-btn"  plain="true" iconcls="icon-le-back" onclick="history.go(-1)">返回</a>
						<div style="display:none"><input type="submit" id ="btnsub" value=""/></div>
						<a  href="#" class="easyui-linkbutton l-btn"  iconcls="icon-le-ok" onclick="btn_ok()">提交</a>
					</td>
				</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/${bussiPackage?replace('.','/')}/${entityPackage}/${entityName?uncap_first}.js"></script>		
  <#if callbackFlag == true>
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
	  		function upload() {
				$('#${fileName}').uploadify('upload', '*');		
			}
			
			var neibuClickFlag = false;
			function neibuClick() {
				neibuClickFlag = true; 
				$('#btn_sub').trigger('click');
			}
			function cancel() {
				$('#${fileName}').uploadify('cancel', '*');
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
  	</#if>