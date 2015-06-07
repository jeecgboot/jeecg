<#setting number_format="0.#####################">
<!DOCTYPE html>
<html>
 <head>
  <title></title>
  ${config_iframe}
 </head>
 <body style="overflow-y: hidden; overflow-x: hidden;" scroll="no">
  <form id="formobj" action="cgFormBuildController.do?saveOrUpdate" name="formobj" method="post">
			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
			<input type="hidden" name="id" value="${id?if_exists?html}" >
			<#list columnhidden as po>
			  <input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
			</#list>
			<table cellpadding="0" cellspacing="1" class="formtable">
			   <#list columns as po>
			    <#if (columns?size>10)>
					<#if po_index%2==0>
					<tr>
					</#if>
				<#else>
					<tr>
				</#if>
					<td align="right" >
						<label class="Validform_label">
							${po.content}:
						</label>
					</td>
					<td class="value">
						<#if po.show_type=='text'>
							<input id="${po.field_name}" name="${po.field_name}" type="text"
							       style="width: 150px" class="inputxt" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
					               <#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.type == 'int'>
					               datatype="n"  <#if po.is_null == 'Y'>ignore="ignore" </#if>
					               <#elseif po.type=='double'>
					               datatype="/^(-?\d+)(\.\d+)?$/" <#if po.is_null == 'Y'>ignore="ignore" </#if>
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>
					               </#if>>
						<#elseif po.show_type=='password'>
							<input id="${po.field_name}" name="${po.field_name}"  type="password"
							       style="width: 150px" class="inputxt" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
					               <#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>>
						
						<#elseif po.show_type=='radio'>
					        <@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
								<#list dataList as dictdata> 
								<input value="${dictdata.typecode?if_exists?html}"  name="${po.field_name}" type="radio"
					            <#if dictdata_index==0&&po.is_null != 'Y'>datatype="*"</#if> 
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
								<input value="${dictdata.typecode?if_exists?html}" name="${po.field_name}" type="checkbox"
								<#if po.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
					            <#if dictdata_index==0&&po.is_null != 'Y'>datatype="*"</#if> 
								<#list checkboxlist as x >
								<#if dictdata.typecode?if_exists?html=="${x?if_exists?html}"> checked="true" </#if></#list>>
									${dictdata.typename?if_exists?html}
								</#list> 
							</@DictData>
					               
						<#elseif po.show_type=='list'>
							<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
								<select id="${po.field_name}" name="${po.field_name}" <#if po.operationCodesReadOnly?if_exists>onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;"</#if><#if po.is_null != 'Y'>datatype="*"</#if> >
									<#list dataList as dictdata> 
									<option value="${dictdata.typecode?if_exists?html}" 
									<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}"> selected="selected" </#if>>
										${dictdata.typename?if_exists?html}
									</option> 
									</#list> 
								</select>
							</@DictData>
							
						<#elseif po.show_type=='date'>
							<input id="${po.field_name}" name="${po.field_name}" type="text"
							       style="width: 150px"  value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
							       class="Wdate" onClick="WdatePicker({<#if po.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
					              <#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if> 
					               </#if>>
						
						<#elseif po.show_type=='datetime'>
							<input id="${po.field_name}" name="${po.field_name}" type="text"
							       style="width: 150px"  value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
							       class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'<#if po.operationCodesReadOnly?if_exists> ,readonly = true</#if>})"
						         <#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if> 
					               </#if>>
						
						<#elseif po.show_type=='popup'>
							<input id="${po.field_name}" name="${po.field_name}"  type="text"
							       style="width: 150px" class="searchbox-inputtext" 
							       onClick="inputClick(this,'${po.dict_text?if_exists?html}','${po.dict_table?if_exists?html}');" 
							       value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
					               <#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
						       <#if po.field_valid_type?if_exists?html != ''>
					               datatype="${po.field_valid_type?if_exists?html}"
					               <#else>
					               <#if po.is_null != 'Y'>datatype="*"</#if>
					               </#if>>
						
						<#elseif po.show_type=='file'>
								<table>
									<#list filesList as fileB>
										<#if fileB['field'] == po.field_name>
										<tr style="height:34px;">
										<td>${fileB['title']}</td>
										<td><a href="commonController.do?viewFile&fileid=${fileB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity" title="下载">下载</a></td>
										<td><a href="javascript:void(0);" onclick="openwindow('预览','commonController.do?openViewFile&fileid=${fileB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)">预览</a></td>
										<td><a href="javascript:void(0)" class="jeecgDetail" onclick="del('cgUploadController.do?delFile&id=${fileB['fileKey']}',this)">删除</a></td>
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
										fileTypeExts:'*.rar;*.zip;*.doc;*.docx;*.txt;*.ppt;*.xls;*.xlsx;*.html;*.htm;*.pdf;*.jpg;*.gif;*.png',
										fileSizeLimit:'15MB',swf:'plug-in/uploadify/uploadify.swf',	
										uploader:'cgUploadController.do?saveFiles&jsessionid='+$("#sessionUID").val()+'',
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
						<#else>
							<input id="${po.field_name}" name="${po.field_name}" type="text"
							       style="width: 150px" class="inputxt" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
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
					               </#if>>

						</#if>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
					</td>
				<#if (columns?size>10)>
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
			  
			  <#list columnsarea as po>
			  <#if (columns?size>10)>
			  	<tr>
					<td align="right">
						<label class="Validform_label">
							${po.content}:
						</label>
					</td>
					<td class="value" colspan="3">
						<textarea id="${po.field_name}" name="${po.field_name}" 
						       style="width: 600px" class="inputxt" rows="6"
						<#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
				               <#if po.field_valid_type?if_exists?html != ''>
				               datatype="${po.field_valid_type?if_exists?html}"
				               <#else>
				               <#if po.is_null != 'Y'>datatype="*"</#if> 
				               </#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
					</td>
				</tr>
				<#else>
					<tr>
					<td align="right">
						<label class="Validform_label">
							${po.content}:
						</label>
					</td>
					<td class="value">
						<textarea id="${po.field_name}" name="${po.field_name}" 
						       style="width: 300px" class="inputxt" rows="6"
						<#if po.operationCodesReadOnly?if_exists> readonly = "readonly"</#if>
				               <#if po.field_valid_type?if_exists?html != ''>
				               datatype="${po.field_valid_type?if_exists?html}"
				               <#else>
				               <#if po.is_null != 'Y'>datatype="*"</#if> 
				               </#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}</textarea>
						<span class="Validform_checktip"></span>
						<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
					</td>
				</tr>
				</#if>
			  </#list>
			  <tr id = "sub_tr" style="display: none;">
				  <td colspan="2" align="center">
				  <input type="button" value="提交" onclick="neibuClick();" class="ui_state_highlight">
				  </td>
			  </tr>
			</table>
			<script type="text/javascript">$(function(){$("#formobj").Validform({tiptype:1,btnSubmit:"#btn_sub",btnReset:"#btn_reset",ajaxPost:true,usePlugin:{passwordstrength:{minLen:6,maxLen:18,trigger:function(obj,error){if(error){obj.parent().next().find(".Validform_checktip").show();obj.find(".passwordStrength").hide();}else{$(".passwordStrength").show();obj.parent().next().find(".Validform_checktip").hide();}}}},callback:function(data){if(data.success==true){uploadFile(data);}else{if(data.responseText==''||data.responseText==undefined){$.messager.alert('错误', data.msg);$.Hidemsg();}else{try{var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'),data.responseText.indexOf('错误信息')); $.messager.alert('错误',emsg);$.Hidemsg();}catch(ex){$.messager.alert('错误',data.responseText+'');}} return false;}if(!neibuClickFlag){var win = frameElement.api.opener; win.reloadTable();}}});});</script>
	</form>
<script type="text/javascript">
   $(function(){
    //查看模式情况下,删除和上传附件功能禁止使用
	if(location.href.indexOf("load=detail")!=-1){
		$(".jeecgDetail").hide();
	}
	
	if(location.href.indexOf("mode=read")!=-1){
		//查看模式控件禁用
		$("#formobj").find(":input").attr("disabled","disabled");
	}
	if(location.href.indexOf("mode=onbutton")!=-1){
		//其他模式显示提交按钮
		$("#sub_tr").show();
	}
   });
  function upload() {
  	<#list columns as po>
  		<#if po.show_type=='file'>
  		$('#${po.field_name}').uploadify('upload', '*');		
  		</#if>
  	</#list>
  }
  var neibuClickFlag = false;
  function neibuClick() {
	  neibuClickFlag = true; 
	  $('#btn_sub').trigger('click');
  }
  function cancel() {
  	<#list columns as po>
  		<#if po.show_type=='file'>
 	 $('#${po.field_name}').uploadify('cancel', '*');
 	 	</#if>
  	</#list>
  }
  function uploadFile(data){
  		if(!$("input[name='id']").val()){
  			$("input[name='id']").val(data.obj.id);
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
	$.dialog.setting.zIndex =1990;
	function del(url,obj){
		$.dialog.confirm("确认删除该条记录?", function(){
		  	$.ajax({
				async : false,
				cache : false,
				type : 'POST',
				url : url,// 请求的action路径
				error : function() {// 请求失败处理函数
				},
				success : function(data) {
					var d = $.parseJSON(data);
					if (d.success) {
						var msg = d.msg;
						tip(msg);
						$(obj).closest("tr").hide("slow");
					}
				}
			});  
		}, function(){
	});
}
</script>
	<script type="text/javascript">${js_plug_in?if_exists}</script>		
 </body>
</html>