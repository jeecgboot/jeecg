<#-- 图片上传 -->
<#macro uploadImg po height = "18" width = "80">
<div class="iuploader">
	<div style="cursor:pointer">
	 <ul id="${po.field_name}thelist" class="ul_pics clearfix"> 
	    <#list filesList as fileB>
		<#if fileB['field']?lower_case == po.field_name>
			<li class="li_upload uploadify-queue-item history" id="${fileB['fileKey']}">
				<input type="hidden" name="${po.field_name}" value="${fileB['path']}"/>
				<img class="img_common" src="${basePath}/${fileB['path']}"/>
				<span class="picbg"></span>
				<a class="pic_close" href="javascript:void(0)"></a>
			</li>
	    </#if>
	    </#list>
	    <#if !(po.operationCodesReadOnly ??)>
	    <li class="plupload-btns li_upload">
     		<img src="plug-in/plupload/jquery.ui.plupload/img/local_upload.png" id="${po.field_name}Upselector"/>
     	</li> 
     	</#if>
	</ul>
	</div>
</div>
<#if !(po.operationCodesReadOnly ??)>
<#-- ----------非readOnly模式------------ -->
<script type="text/javascript">
$(function(){
if(location.href.indexOf('load=detail')!=-1){$(".plupload-btns").hide();$(".pic_close").hide();}
var serverMsg = "";
var addLiFile = function(file) {
	var path = file['url'],fileid = file['fileid'];
	var html = '<li class="li_upload uploadify-queue-item" id="'+fileid+'">';
	html+='<input type="hidden" name="${po.field_name}" value="'+path+'"/>';
	html+='<img class="img_common" src="${basePath}/'+path+'"/>';
	html+='<span class="picbg"></span>';
	html+='<a class="pic_close" href="javascript:void(0)"></a>';
	html+='</li>';
	$("#${po.field_name}thelist").prepend(html);
}
var uploader = new plupload.Uploader({
	runtimes: 'gears,html5,flash,silverlight,html4', <#-- 上传插件初始化选用那种方式的优先级顺序  -->
	browse_button: '${po.field_name}Upselector', <#--  上传按钮  -->
	url: '${basePath}/cgUploadController.do?ajaxSaveFile&jsessionid='+$("#sessionUID").val()+'',
	flash_swf_url: '${basePath}/plug-in/plupload/Moxie.swf', <#-- flash文件地址  -->
    silverlight_xap_url: '${basePath}/plug-in/plupload/Moxie.xap', <#-- silverlight文件地址  -->
    filters: {
        max_file_size: "100mb", <#-- 最大上传文件大小（格式100b, 10kb, 10mb, 1gb）  -->
        mime_types: [{title : "Image files", extensions : "jpg,jpeg,png,gif"}],
        prevent_duplicates:false
    },
    multipart_params:{
		'cgFormName':'${tableName?if_exists?html}',
    	'cgFormField':'${po.field_name}'
    },
    multi_selection: true, <#-- true:ctrl多文件上传, false 单文件上传  -->
    init: {
    	PostInit: function() {
    		$.iplupload("${po.field_name}",uploader);
		},
    	FilesAdded: function(up, files) {
    		up.start();
    	},
    	UploadProgress: function(up, file) {
        	//上传中，显示进度条
            //var percent = file.percent;
            //$("#" + file.id).find('.uploadify-progress-bar').css({"width": percent + "%"});
        },
    	BeforeUpload: function(up, file) {
    		//var params = up.getOption('multipart_params');
    		//var cgFormId=$("input[name='id']").val();
    		//params['cgFormId'] = cgFormId;
    		//up.setOption('multipart_params',params);
		},
		FileUploaded: function(up, file, info) {
        	var response = jQuery.parseJSON(info.response);
	        if (response.success) {
	        	addLiFile(response.attributes);
	        }
        },
		UploadComplete: function(up, files) {
			if(files.length>0){
				if(!$("#icgformUploadfile")){
					//$("#${po.field_name}thelist").append("<div id='icgformUploadfile'><input type='hidden' name = 'icgformUploadfile' value = '1'/><input type='hidden' name='icgFormName' value='${tableName?if_exists?html}'/><input type='hidden' name='icgFormField' value='${po.field_name}'/></div>");
				}
			}
		},
		Error: function(up, err) {
	   		<#-- 上传出错的时候触发 -->
	        if(err.code == plupload.FILE_EXTENSION_ERROR){
	        	tip("文件类型不识别！");
	        }else if(plupload.FILE_SIZE_ERROR = err.code){
	        	tip("文件大小超标！");
	        }
	        console.log(err);
    	}
    }
});
uploader.init();
$("#${po.field_name}thelist").on("click",".pic_close",function(eve){
	var itemObj = $(eve.target).closest(".uploadify-queue-item");
	var id = itemObj.attr("id");
	$.dialog.setting.zIndex = getzIndex();
	$.dialog.confirm("确认删除该条记录?", function(){
	  	$.ajax({
			async : false,
			cache : false,
			url:"cgUploadController.do?delAttachment",
			data:{id:id},
			type:"POST",
			dataType:"JSON",
			error : function() {// 请求失败处理函数
			},
			success : function(data) {
				if (data.success) {
					var obj = data.obj;
					if(obj==1){
						<#-- 成功删除附件  -->
						itemObj.find("input").val('');
						itemObj.remove();
					}else{
						<#-- 页面小作欺骗  -->
						itemObj.find("input").remove();
						itemObj.hide();
					}
				}else{
					tip(data.msg);
				}
			}
		});  
	}, function(){});
});
});
</script>
</#if>	
</#macro>
<#-- #####################################上为图片,下为文件############################################# -->
<#-- 文件上传 -->
<#macro uploadFile po height = "18" width = "80">
<div class="iuploader">
	<div id = "${po.field_name}thelist" class="uploader-list">
		<table class="temptable">
		<tbody>
		<#list filesList as fileB>
		<#if fileB['field']?lower_case == po.field_name>
			<tr class="upload_generate history uploadify-queue-item" id="${fileB['fileKey']}">
				<td title="${fileB['title']}">
				<#if fileB['title']?length gt 20>
					${fileB['title']?substring(0,15)}...
				<#else>
					${fileB['title']}
				</#if>
				</td>
				<td>
					<a title="删除" href="javascript:void(0)" class="jeecgDetail file_close" style="margin:0 8px;text-decoration: none;">删除</a>
				</td>
				<td>
					<a title="预览" href="javascript:void(0);" onclick="openwindow('预览','${basePath}/commonController.do?openViewFile&fileid=${fileB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)" style="margin:0 8px;text-decoration: none;">预览</a>
				</td>
				<td>
					<a title="下载" href="${basePath}/commonController.do?viewFile&fileid=${fileB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity" style="margin:0 8px;text-decoration: none;">下载</a>
				</td>
				<td style="display:none"><input type="hidden" name="${po.field_name}" value="${fileB['path']}"/></td>
			</tr>
		</#if>
		</#list>
		</tbody>
		</table>
	</div>
	<#if !(po.operationCodesReadOnly ??)>
	<div class="plupload-btns">
		<div id="${po.field_name}Upselector" class="uploadify-button " style="cursor:pointer;height:${height}px; line-height:${height}px; width:${width}px; position: relative; z-index: 1;">
			<span class="uploadify-button-text">
				添加文件
			</span>
		</div>
		<input type="button" id = "${po.field_name}" style="display:none"/>
	</div>
	</#if>
	<div class="form" id="filediv_${po.field_name}"> </div>
</div>
<#if !(po.operationCodesReadOnly ??)>
<#-- ----------非readOnly模式------------ -->
<script type="text/javascript">
$(function(){
if(location.href.indexOf('load=detail')!=-1){$(".plupload-btns").hide();}
var serverMsg = "";
var addtrFile = function(file) {
    var fileName = file.name;
    if (fileName.length > 20) {
        fileName = fileName.substring(0, 15) + '...';
    }
	var fileSize = Math.ceil(file.size/1024);
	var html = '<div id="'+file.id+'" class="uploadify-queue-item">';
	<#-- 删除  -->
	html+='<div class="cancel"><a class="iqueueDel" href="javascript:void(0)">X</a></div>';
	<#-- 文件信息  -->
	html+='<span class="fileName" title="'+file.name+'">'+fileName+'('+fileSize+'KB)</span><span class="sdata"></span>';
	<#-- 进度条 -->
	html+='<div class="uploadify-progress"><div class="uploadify-progress-bar"></div></div>';
	html+='</div>';
	<#if po.show_type=='file'>
		$("#filediv_${po.field_name}").append(html);
	<#else>
		$("#imagediv_${po.field_name}").append(html);
	</#if>
}

var addSuccessFile = function(file) {
    var path = file['url'],fileid = file['fileid'],title = file['name'];
	var html = '<tr class="uploadify-queue-item upload_generate" id="'+fileid+'"><td title="'+title+'">';
	if(title.length>20){
		html+=title.substring(0,15)+'...';
	}else{
		html+=title;
	}
	html+='</td>';
	html+='<td><a title="删除" class="jeecgDetail file_close" href="javascript:void(0)" style="margin:0 8px;text-decoration: none;">删除</a></td>';
	//html+='<td><a title="预览" href="javascript:void(0);" onclick="openwindow(\'预览\',\'${basePath}/commonController.do?openViewFile&fileid='+fileid+'&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity\',\'fList\',700,500)" style="margin:0 8px;text-decoration: none;">预览</a></td>';
	//html+='<td><a title="下载" href="${basePath}/commonController.do?viewFile&fileid='+fileid+'&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity" style="margin:0 8px;text-decoration: none;">下载</a></td>';
	html+='<td style="display:none"><input type="hidden" name="${po.field_name}" value="'+path+'"/></td></tr>';
	$("#${po.field_name}thelist").children('table').append(html);
}
var uploader = new plupload.Uploader({
	runtimes: 'gears,html5,flash,silverlight,html4', <#-- 上传插件初始化选用那种方式的优先级顺序  -->
	browse_button: '${po.field_name}Upselector', <#--  上传按钮  -->
	url: '${basePath}/cgUploadController.do?ajaxSaveFile&jsessionid='+$("#sessionUID").val()+'',
	flash_swf_url: '${basePath}/plug-in/plupload/Moxie.swf', <#-- flash文件地址  -->
    silverlight_xap_url: '${basePath}/plug-in/plupload/Moxie.xap', <#-- silverlight文件地址  -->
    filters: {
        max_file_size: "100mb", <#-- 最大上传文件大小（格式100b, 10kb, 10mb, 1gb）  -->
        mime_types: [{title: "Common files", extensions:"txt,doc,docx,xls,xlsx,ppt,pdf,jpg,jpeg,png,gif"}],
        prevent_duplicates:false
    },
    multi_selection: true, <#-- true:ctrl多文件上传, false 单文件上传  -->
    init: {
    	PostInit: function() {
    		$.iplupload("${po.field_name}",uploader);
		},
    	FilesAdded: function(up, files) {
    		for(var a = 0;a<files.length;a++){
    			addtrFile(files[a]);
		    }
		    up.start();
    	},
    	UploadProgress: function(up, file) {
        	//上传中，显示进度条
            var percent = file.percent;
            $("#" + file.id).find('.uploadify-progress-bar').css({"width": percent + "%"});
        },
		FileUploaded: function(up, file, info) {
        	var response = jQuery.parseJSON(info.response);
	        if (response.success) {
	        	serverMsg = response.msg;
	        	$("#"+file.id).find(".sdata").text(' - Complete');
	        	setTimeout(function(){
	        		$("#"+file.id).fadeOut("slow",function(){
	        			addSuccessFile(response.attributes);
	        		});
	        	},500);
	        }
        },
		UploadComplete: function(up, files) {
			if(files.length>0){
				// var win = frameElement.api.opener;
				// win.reloadTable();
				// win.tip(serverMsg);
				// frameElement.api.close();
			}
		},
		Error: function(up, err) {
	   		<#-- 上传出错的时候触发 -->
	        if(err.code == plupload.FILE_EXTENSION_ERROR){
	        	tip("文件类型不识别！");
	        }else if(plupload.FILE_SIZE_ERROR = err.code){
	        	tip("文件大小超标！");
	        }
	        console.log(err);
    	}
    }
});
uploader.init();
$("#${po.field_name}thelist").on("click",".file_close",function(eve){
	var itemObj = $(eve.target).closest(".uploadify-queue-item");
	var id = itemObj.attr("id");
	$.dialog.setting.zIndex = getzIndex();
	$.dialog.confirm("确认删除该条记录?", function(){
	  	$.ajax({
			async : false,
			cache : false,
			url:"cgUploadController.do?delAttachment",
			data:{id:id},
			type:"POST",
			dataType:"JSON",
			error : function() {// 请求失败处理函数
			},
			success : function(data) {
				if (data.success) {
					var obj = data.obj;
					if(obj==1){
						<#-- 成功删除附件  -->
						itemObj.find("input").val('');
						itemObj.remove();
					}else{
						<#-- 页面小作欺骗  -->
						itemObj.find("input").remove();
						itemObj.hide();
					}
				}else{
					tip(data.msg);
				}
			}
		});  
	}, function(){});
});
});
</script>
</#if>	
</#macro>