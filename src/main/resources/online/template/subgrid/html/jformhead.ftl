			<#--update-start--Author:luobaoli  Date:20150614 for：表单（主表/单表）属性中增加了扩展参数 ${po.extend_json?if_exists}-->
			<input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
			<input type="hidden" name="id" value="${id?if_exists?html}" >
			<#list columnhidden as po>
			  	<input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
			</#list>
			<table  cellpadding="0" cellspacing="1" class="formtable">
				<#list columns as po>
				<#if po_index%2==0>
				<tr>
				</#if>
					<td align="right">
						<label class="Validform_label">
							<@mutiLang langKey="${po.content?if_exists?html}"/>:
						</label>
					</td>
					<td class="value">
						<#if po.show_type=='text'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							       style="width: 150px" class="inputxt" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
							      <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							        <#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
					               <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.type == 'int'>
					               datatype="n" 
					               <#elseif po.type=='double'>
					               datatype="/^(-?\d+)(\.\d+)?$/" 
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if></#if>>
						
						<#elseif po.show_type=='password'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  type="password"
							       style="width: 150px" class="inputxt" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
					                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
					               <#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
					               <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>>
						
						<#elseif po.show_type=='radio'>
					        <@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
								<#list dataList as dictdata> 
								<input value="${dictdata.typecode?if_exists?html}" ${po.extend_json?if_exists} name="${po.field_name}" type="radio"
								 <#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
							  	<#if dictdata_index == 0>
							  	 <#if po.field_valid_type?if_exists?html != ''>
				               	 datatype="${po.field_valid_type?if_exists?html}"
				                <#elseif po.is_null != 'Y'>
				                 datatype="*"
				                </#if>
				                <#if po.field_must_input?if_exists?html != ''><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
							  	</#if>
				                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
								<#if po.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
								<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}"> checked="true" </#if>>
									${dictdata.typename?if_exists?html}
								</#list> 
							</@DictData>
					               
						<#elseif po.show_type=='checkbox'>
							<#assign checkboxstr>${data['${tableName}']['${po.field_name}']?if_exists?html}</#assign>
							<#assign checkboxlist=checkboxstr?split(",")>
							<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
								<#list dataList as dictdata> 
								<input value="${dictdata.typecode?if_exists?html}" ${po.extend_json?if_exists} name="${po.field_name}" type="checkbox"
								 <#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
							   <#if dictdata_index == 0>
								   <#if po.field_valid_type?if_exists?html != ''>
					               	 datatype="${po.field_valid_type?if_exists?html}"
					                <#elseif po.is_null != 'Y'>
					                 datatype="*"
					                </#if>
					                <#if po.field_must_input?if_exists?html != ''><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
							   </#if>
				                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
								<#if po.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
								<#list checkboxlist as x >
								<#if dictdata.typecode?if_exists?html=="${x?if_exists?html}"> checked="true" </#if></#list>>
									${dictdata.typename?if_exists?html}
								</#list> 
							</@DictData>
					               
						<#elseif po.show_type=='list'>
							<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
								<select id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" <#if po.operationCodesReadOnly?if_exists>onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;"</#if> 
								 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								 <#-- update--begin--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
							   <#if po.field_valid_type?if_exists?html != ''>
				               	 datatype="${po.field_valid_type?if_exists?html}"
				                <#elseif po.is_null != 'Y'>
				                 datatype="*"
				                </#if>>
				                <#-- update--end--author:zhangjiaqiang Date:20170512 for:TASK #1910 【Online 校验】radio\checkbox\select 存在问题，没有根据选择校验规则校验 -->
									<#list dataList as dictdata> 
									<option value="${dictdata.typecode?if_exists?html}" 
									<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}"> selected="selected" </#if>>
										${dictdata.typename?if_exists?html}
									</option> 
									</#list> 
								</select>
							</@DictData>
							
						<#elseif po.show_type=='date'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							       style="width: 150px"  value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
							       class="Wdate" onClick="WdatePicker({<#if po.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
							        <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							       <#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
					               <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>>
						
						<#elseif po.show_type=='datetime'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							       style="width: 150px"  value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
							       class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'<#if po.operationCodesReadOnly?if_exists> ,readonly = true</#if>})"
					                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
					               <#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
					               <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if> 
					               </#if>>
						
						<#elseif po.show_type=='popup'>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  type="text"
							       style="width: 150px" class="searchbox-inputtext" 
							       value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
							        <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							       <#if po.operationCodesReadOnly?if_exists> 
							       readonly = "readonly"
							       <#else>
							       onClick="popupClick(this,'${po.dict_text?if_exists?html}','${po.dict_field?if_exists?html}','${po.dict_table?if_exists?html}');" 
							       </#if>
					               <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>>
						
						<#elseif po.show_type=='file'>
							 <table>
									<#list filesList as fileB>
										<#-- update--begin--author:zhangjiaqiang date:20170608 for:修订字段为小写 -->
										<#if fileB['field']?lower_case == po.field_name>
										<#-- update--end--author:zhangjiaqiang date:20170608 for:修订字段为小写 -->
										<tr style="height:34px;">
										<td>${fileB['title']}</td>
										<td><a href="${basePath}/commonController.do?viewFile&fileid=${fileB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity" title="下载">下载</a></td>
										<td><a href="javascript:void(0);" onclick="openwindow('预览','${basePath}/commonController.do?openViewFile&fileid=${fileB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)">预览</a></td>
										<td><a href="javascript:void(0)" class="jeecgDetail" onclick="del('${basePath}/cgUploadController.do?delFile&id=${fileB['fileKey']}',this)">删除</a></td>
										</tr>
										</#if>
									</#list>
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
						<#-- update--begin--author:zhangjiaqiang date:20170607 for:增加图片格式的上传 -->
						<#elseif po.show_type=='image'>
								<table>
									<#-- update--begin--author:zhangjiaqiang date:20170519 for:修订资源预览关联错误 -->
									<#list imageList as imageB>
									<#-- update--begin--author:zhangjiaqiang date:20170608 for:修订字段为小写 -->
										<#if imageB['field']?lower_case == po.field_name>
										<#-- update--end--author:zhangjiaqiang date:20170608 for:修订字段为小写 -->
										<tr style="height:34px;">
										<td>${imageB['title']}</td>
										<td><a href="${basePath}/commonController.do?viewFile&fileid=${imageB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity" title="下载">下载</a></td>
										<td><a href="javascript:void(0);" onclick="openwindow('预览','${basePath}/commonController.do?openViewFile&fileid=${imageB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)">预览</a></td>
										<td><a href="javascript:void(0)" class="jeecgDetail" onclick="del('${basePath}/cgUploadController.do?delFile&id=${imageB['fileKey']}',this)">删除</a></td>
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
							<#-- update--end--author:zhangjiaqiang date:20170607 for:增加图片格式的上传 -->
							<#-- update--begin--author:zhangjiaqiang date:20170815 for:TASK #2274 【online】Online 表单支持树控件 -->
							<#elseif po.show_type=='tree'>
								<input id="${po.field_name}" ${po.extend_json?if_exists}  type="text"
							       style="width: 150px" class="inputxt" 
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
					                 <#if po.field_valid_type?if_exists?html != ''>
						               datatype="${po.field_valid_type?if_exists?html}"
						               <#else>
						               <#if po.type == 'int'>
						               datatype="n" 
						               <#elseif po.type=='double'>
						               datatype="/^(-?\d+)(\.\d+)?$/" 
						               <#else>
						               <#if po.is_null != 'Y'>datatype="*"</#if>
						               </#if>
					               </#if>
					               onclick="show${po.field_name?cap_first }Tree();" readonly="readonly" >
					               <input type="hidden" id="${po.field_name}Id" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" class="show${po.field_name?cap_first}">  
									<div id="show${po.field_name?cap_first }TreeContent" class="menuContent" style="display: none; position: absolute; border: 1px #CCC solid; background-color: #F0F6E4;z-index:9999;">  
									    <ul id="show${po.field_name?cap_first }Tree" class="ztree" style="margin-top:0;"></ul>  
									</div>
								<script>
									$(function(){
										if(!$.fn.zTree){
											$("head").append('<link rel="stylesheet" href="${basePath}/plug-in/ztree/css/zTreeStyle.css"/>');
											$("head").append('<script type=\"text/javascript\" src=\"${basePath}/plug-in/ztree/js/jquery.ztree.core-3.5.min.js\"><\/script>');
											$("head").append('<script type=\"text/javascript\" src=\"${basePath}/plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js\"><\/script>');
										}
										var defaultVal = $("#${po.field_name}Id").val();
										if(defaultVal != null && defaultVal != ''){
											if(defaultVal.indexOf(",") > -1){
												var defaultValArray = defaultVal.split(",");
												var resultValue = "";
												for(var i = 0; i < defaultValArray.length; i++){
													var result = $.ajax({
														url:'${basePath}/categoryController.do?tree',
														type:'POST',
														dataType:'JSON',
														data:{
															selfCode:defaultValArray[i]
														},
														async:false
													});
													var responseText = result.responseText;
													if(typeof responseText == 'string'){
														responseText = JSON.parse(responseText);
													}
													if(resultValue != ''){
														  resultValue = resultValue + "," + responseText[0].text;
													}else{
														resultValue = responseText[0].text;
													}
												}
												$("#${po.field_name}").val(resultValue);
											}else{
												$.ajax({
													url:'${basePath}/categoryController.do?tree',
													type:'POST',
													dataType:'JSON',
													data:{
														selfCode:defaultVal
													},
													success:function(res){
														if(typeof res == 'object'){
															var value = res[0].text;
															$("#${po.field_name}").val(value);
														}
													}
												});
											}
											
										}
										$("body").bind("mousedown", onBodyDownBy${po.field_name?cap_first });
									});
									
									var ${po.field_name}Setting = {  
											check: {  
								                enable: true
									        }, 
										    view: {  
										        dblClickExpand: false  
										    },  
										    data: {  
										        simpleData: {  
										            enable: true  
										        },
										        key:{
										        	name:'text'
										        }
										    },  
										    callback: {  
										        onClick: ${po.field_name}OnClick,
										        onCheck: ${po.field_name}OnCheck
										    }  
										}; 
										function ${po.field_name}OnCheck(e, treeId, treeNode) { 
										    var idVal = $("#${po.field_name}Id").val();
										    var textVal = $("#${po.field_name}").val();
										    if(treeNode.checked){
										    	//选中
										    	if(idVal != null && idVal != ''){
										    		$("#${po.field_name}Id").val(idVal + ',' +treeNode.id);  
											    }else{
												    $("#${po.field_name}Id").val(treeNode.id);  
											    }
											    if(textVal != null && textVal != ''){
											    	 $("#${po.field_name}").val(textVal + ',' + treeNode.text);  
											    }else{
												    $("#${po.field_name}").val(treeNode.text);  
											    }
										    }else{
										    	idVal = idVal.replace(treeNode.id,"");
										    	if(idVal.indexOf(",") == 0){
										    		idVal = idVal.substring(1);
										    	}else if(idVal.indexOf(",,") > -1){
										    		idVal = idVal.replace(",,",",");
										    	}else if(idVal.indexOf(",") == idVal.length -1){
										    		idVal = idVal.substring(0,idVal.length - 1);
										    	}
										    	textVal = textVal.replace(treeNode.text,"");
										    	if(textVal.indexOf(",") == 0){
										    		textVal = textVal.substring(1);
										    	}else if(textVal.indexOf(",,") > -1){
										    		textVal = textVal.replace(",,",",");
										    	}else if(textVal.indexOf(",") == textVal.length -1){
										    		textVal = textVal.substring(0,textVal.length - 1);
										    	}
										    	$("#${po.field_name}").val(textVal);
										    	 $("#${po.field_name}Id").val(idVal);
										    }
										    e.stopPropagation();
										}  
									function ${po.field_name}OnClick(e, treeId, treeNode) {  
										    var zTree = $.fn.zTree.getZTreeObj("show${po.field_name?cap_first }Tree");  
										  	zTree.checkNode(treeNode, !treeNode.checked, true,true);
										  	e.stopPropagation();
										}  
									function show${po.field_name?cap_first }Tree(){
										 if($("#show${po.field_name?cap_first }TreeContent").is(":hidden")){
										 	 $.ajax({  
										        url:'${basePath}/categoryController.do?tree',  
										        type:'POST',  
										        dataType:'JSON',
										        async:false,  
										        success:function(res){
										            var obj = res; 
										            $.fn.zTree.init($("#show${po.field_name?cap_first }Tree"), ${po.field_name}Setting, obj);  
										            var deptObj = $("#${po.field_name}");  
										            var deptOffset = $("#${po.field_name}").offset();  
										            $("#show${po.field_name?cap_first }TreeContent").css({left:deptOffset.left + "px", top:deptOffset.top + deptObj.outerHeight() + "px"}).slideDown("fast");  
										            $('#show${po.field_name?cap_first }Tree').css({width:deptObj.outerWidth() - 12 + "px"});  
										            var zTree = $.fn.zTree.getZTreeObj("show${po.field_name?cap_first }Tree"); 
										            var idVal =  $("#${po.field_name}Id").val();
										            if(idVal != null && idVal != ''){
											             if(idVal.indexOf(",") > -1){
											            	var idArray = idVal.split(",");
											            	for(var i = 0; i < idArray.length; i++){
											            		var node = zTree.getNodeByParam("id", idArray[i], null);
											            		zTree.checkNode(node, true, true);
											            	}
											            }else{
											            	var node = zTree.getNodeByParam("id", idVal, null);
											            		zTree.checkNode(node, true, true);
											            } 
										            }
										            //$("#show${po.field_name?cap_first }TreeContent").bind("mousedown",${po.field_name?cap_first }TreeContentClick);  
										        } 
										      }); 
										 }
										 }
									   
									    function onBodyDownBy${po.field_name?cap_first }(event){
									    	if(event.target.id == '' || (event.target.id.indexOf('switch') == -1 
										    	&& event.target.id.indexOf('check') == -1 
										    	&& event.target.id.indexOf('span') == -1
										    	&& event.target.id.indexOf('ico') == -1)){  
										    	$("#show${po.field_name?cap_first }TreeContent").fadeOut("fast");  
	   											//$("body").unbind("mousedown", onBodyDownBy${po.field_name?cap_first });
   											 }
									    }
									    function ${po.field_name?cap_first }TreeContentClick(event){
									    	 event=event||window.event;
       										 event.stopPropagation();
									    }
								</script>
								<#-- update--begin--author:zhangjiaqiang date:20170815 for:TASK #2274 【online】Online 表单支持树控件 -->
						<#else>
							<input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
							       style="width: 150px" class="inputxt" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
					                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
					               <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.type == 'int'>
					               datatype="n" 
					               <#elseif po.type=='double'>
					               datatype="/^(-?\d+)(\.\d+)?$/" 
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if></#if>>
						</#if>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;"><@mutiLang langKey="${po.content?if_exists?html}"/></label>
					</td>
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
			  </#list>
			  
			  <#list columnsarea as po>
			  <tr>
					<td align="right">
						<label class="Validform_label">
							<@mutiLang langKey="${po.content?if_exists?html}"/>:
						</label>
					</td>
					<td class="value" colspan="3">
						<textarea id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  style="width:${po.field_length}px;
						       <#if po.show_type!='umeditor'>class="inputxt"</#if> rows="6"
				                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != 'Y'> ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
				               <#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
				               <#if po.field_valid_type?if_exists?html != ''>
				               datatype="${po.field_valid_type?if_exists?html}"
				               <#else>
				               <#if po.is_null != 'Y'>datatype="*"</#if>
				               </#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;"><@mutiLang langKey="${po.content?if_exists?html}"/></label>
						<#if po.show_type=='umeditor'>
						<script type="text/javascript">
					    //实例化编辑器
					    var ${po.field_name}_ue = UE.getEditor('${po.field_name}',{initialFrameWidth:${po.field_length}}).setHeight(260);
					    </script>
					    </#if>
					</td>
				</tr>
			  </#list>
			</table>
			<#--update-end--Author:luobaoli  Date:20150614 for：表单（主表/单表）属性中增加了扩展参数 ${po.extend_json?if_exists}-->