<#-- 文件上传的通用处理 -->
<#macro uploadtag po height = "18" width = "80">
<div class="iuploader uploadify">
	<div id = "${po.field_name}thelist" class="uploader-list">
		<table class="temptable">
		<tbody>
		<#list filesList as fileB>
		<#if fileB['field']?lower_case == po.field_name>
			<tr class="upload_generate history" style="">
				<td title="${fileB['title']}">
				<#if fileB['title']?length gt 20>
					${fileB['title']?substring(0,15)}...
				<#else>
					${fileB['title']}
				</#if>
				</td>
				<td>
					<a title="删除" href="javascript:void(0)" class="jeecgDetail" onclick="del('${basePath}/cgUploadController.do?delFile&id=${fileB['fileKey']}',this)" style="margin:0 8px;">删除</a>
				</td>
				<td>
					<a title="预览" href="javascript:void(0);" onclick="openwindow('预览','${basePath}/commonController.do?openViewFile&fileid=${fileB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)" style="margin:0 8px;">预览</a>
				</td>
				<td>
					<a title="下载" href="${basePath}/commonController.do?viewFile&fileid=${fileB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity" style="margin:0 8px;">下载</a>
				</td>
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
			<#if po.show_type=='file'>
				添加文件
			<#else>
				添加图片
			</#if>
			</span>
		</div>
		<input type="button" id = "${po.field_name}" style="display:none"/>
	</div>
	</#if>
	<#if po.show_type=='file'>
		<div class="form" id="filediv_${po.field_name}"> </div>
	<#else>
		<div class="form" id="imagediv_${po.field_name}"> </div>
	</#if>
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
var uploader = new plupload.Uploader({
	runtimes: 'gears,html5,flash,silverlight,html4', <#-- 上传插件初始化选用那种方式的优先级顺序  -->
	browse_button: '${po.field_name}Upselector', <#--  上传按钮  -->
	url: '${basePath}/cgUploadController.do?saveFiles&jsessionid='+$("#sessionUID").val()+'',
	flash_swf_url: '${basePath}/plug-in/plupload/Moxie.swf', <#-- flash文件地址  -->
    silverlight_xap_url: '${basePath}/plug-in/plupload/Moxie.xap', <#-- silverlight文件地址  -->
    filters: {
        max_file_size: "100mb", <#-- 最大上传文件大小（格式100b, 10kb, 10mb, 1gb）  -->
        mime_types: [
         <#if po.show_type=='file'>
            {title: "Common files", extensions:"txt,doc,docx,xls,xlsx,ppt,pdf"}
         <#else>
            {title : "Image files", extensions : "jpg,jpeg,png,gif"}
         </#if>
        ],
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
    		for(var a = 0;a<files.length;a++){
    			addtrFile(files[a]);
		    }
    	},
    	UploadProgress: function(up, file) {
        	//上传中，显示进度条
            var percent = file.percent;
            $("#" + file.id).find('.uploadify-progress-bar').css({"width": percent + "%"});
        },
    	BeforeUpload: function(up, file) {
    		var params = up.getOption('multipart_params');
    		var cgFormId=$("input[name='id']").val();
    		params['cgFormId'] = cgFormId;
    		up.setOption('multipart_params',params);
		},
		FileUploaded: function(up, file, info) {
        	var response = jQuery.parseJSON(info.response);
	        if (response.success) {
	        	serverMsg = response.msg;
	        	$("#"+file.id).find(".sdata").text(' - Complete');
	        	setTimeout(function(){$("#"+file.id).fadeOut("slow");},500);
	        }
        },
		UploadComplete: function(up, files) {
			if(files.length>0){
				 var win = frameElement.api.opener;
				 win.reloadTable();
				 win.tip(serverMsg);
				 frameElement.api.close();
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
<#if po.show_type=='file'>$("#filediv_${po.field_name}")<#else>$("#imagediv_${po.field_name}")</#if>
.on("click",".iqueueDel",function(eve){
	var itemObj = $(eve.target).closest(".uploadify-queue-item");
	uploader.removeFile(uploader.getFile(itemObj.attr("id")));
	itemObj.find(".sdata").text(' - 已取消');
	setTimeout(function(){itemObj.fadeOut("slow");},500);
});
});
</script>
</#if>	
</#macro>