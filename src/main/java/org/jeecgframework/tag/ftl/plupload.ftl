<#if style?? && style=="uploadify">
<#-- 参照uploadify风格,内部实现用的是plupload插件  -->
<#if obj.outhtml == true>
<link rel="stylesheet" href="plug-in/uploadify/css/uploadify.css" type="text/css"></link>
<script type="text/javascript" src="plug-in/plupload/plupload.full.min.js"></script>
<script type="text/javascript" src="plug-in/tools/Map.js"></script>
</#if>
<div class="iuploader uploadify">
	<div id = "${obj.name}thelist" class="uploader-list"></div>
	<div id="${obj.name}Upselector" class="uploadify-button " style="cursor:pointer;height:${obj.height}px; line-height:${obj.height}px; width:${obj.width}px;">
		<span class="uploadify-button-text">
			${obj.buttonText}
		</span>
	</div>
	<input type="button" id= "${obj.id}" style="display:none"/>
</div>
<script type="text/javascript">
$(function(){
var $list = $("#${obj.name}thelist");
var serverMsg = "";
var fileKey = "";
var m = new Map();
var addOneFile = function(file){
	var fileName = file.name;
	var fileSize = Math.ceil(file.size/1024);
	var html = '<div id="'+file.id+'" class="uploadify-queue-item">';
	<#-- 删除  -->
	html+='<div class="cancel"><a class="delthisfile" href="javascript:void(0)">X</a></div>';
	<#-- 文件信息  -->
	html+='<span class="fileName">'+fileName+'('+fileSize+'KB)</span><span class="sdata"></span>';
	<#-- 进度条 -->
	html+='<div class="uploadify-progress"><div class="uploadify-progress-bar"></div></div>';
	html+='</div>';
	$("#${obj.queueID}").append(html);
}
<#if obj.view == true>
var addViewHtml = function(d){
	var fileitem ="<span id='" + d.attributes.id + "'>";
	fileitem +="<a href='#' onclick=openwindow('文件查看','" + d.attributes.viewhref + "','70%','80%') title='查看'>";
	fileitem += d.attributes.name;
	fileitem += "</a><img border='0' onclick=confuploadify('" + d.attributes.delurl + "','" + d.attributes.id + "') title='删除' src='plug-in/uploadify/img/uploadify-cancel.png' widht='15' height='15'>&nbsp;&nbsp;</span>";
    m = new Map();
    m.put(d.attributes.id, fileitem);
    fileKey = d.attributes.fileKey;       
}
</#if>
var uploader = new plupload.Uploader({
	<#-- 创建实例的构造方法  -->
    runtimes: 'gears,html5,flash,silverlight,html4', <#-- 上传插件初始化选用那种方式的优先级顺序  -->
    browse_button: '${obj.name}Upselector', <#--  上传按钮  -->
    url: "${obj.getUploader()}", //远程上传地址
    flash_swf_url: 'plug-in/plupload/Moxie.swf', <#-- flash文件地址  -->
    silverlight_xap_url: 'plug-in/plupload/Moxie.xap', <#-- silverlight文件地址  -->
    filters: {
        max_file_size: '${obj.fileSizeLimit}', <#-- 最大上传文件大小（格式100b, 10kb, 10mb, 1gb）  -->
        mime_types: [
        	<#-- 允许文件上传类型  -->
            {title: "files", extensions:"${obj.getAllowedFilesExt()}"}
        ],
        prevent_duplicates:false//允许重复文件?
    },
    multipart_params:{
    },
    multi_selection: <#if obj.multi?? && obj.multi==true>true<#else>false</#if>, <#-- true:ctrl多文件上传, false 单文件上传  -->
    init: {
        PostInit: function() {
        	$.iplupload("${obj.id}",uploader);
			<#if obj.outhtml == true>
			document.getElementById('${obj.id}').onclick = function() {
				uploader.stop();
				uploader.destroy();
			};
			</#if>
		},
        FilesAdded: function(up, files) { 
        <#if obj.multi == false>
        	<#-- 单选  -->
        	var item = $("#${obj.queueID}").find('.uploadify-queue-item');
        	if(item && item.length>=1){
        		up.removeFile(files[a]);
        		tip('不支持多文件上传!');
        	}else{
        		addOneFile(files[0]);
        	}
        <#else>
        	<#-- 多选无限制  -->
        	for(var a = 0;a<files.length;a++){
        		addOneFile(files[a]);
		    }
        </#if>
        <#if (obj.auto == true)>
			uploader.start();
	    </#if>
	    <#if obj.onFileAdded?? && obj.onFileAdded !="">
			${obj.onFileAdded}(up,files);
	    </#if>
        },
        FilesRemoved: function(up, files) {
        	<#if obj.onFilesRemoved?? && obj.onFilesRemoved !="">
			${obj.onFilesRemoved}(up,files);
	    	</#if>
        },
		UploadFile: function(up,file){
		},
        UploadProgress: function(up, file) {
        	//上传中，显示进度条
            var percent = file.percent;
            $("#" + file.id).find('.uploadify-progress-bar').css({"width": percent + "%"});
           // $("#" + file.id).find(".percent").text(percent + "%");
        },
        BeforeUpload: function(up, file) {
        var waitup = up.files;
        if(!waitup || waitup.length<=0){
        	return false;
        }
    	<#if obj.onUploadStart?? && obj.onUploadStart !="">
    		${obj.onUploadStart}(file);
    	<#else>
    		<#if obj.formData?? && obj.formData!="">
    		var o = up.getOption('multipart_params');
    		<#list obj.formData?split(",") as id>
    		<#assign _index = id?index_of('_')>
    		<#if _index gt 0>
    		o['${id?substring(0,_index)}'] = ${'$'}("#${id}").val();
    		<#else>
    		o['${id}'] = ${'$'}("#${id}").val();
    		</#if>
    		</#list>
    		up.setOption('multipart_params',o);
    		<#elseif obj.formId?? && obj.formId!="">
    		var o = {};
    		var _array = $('#${obj.formId}').serializeArray();
    		$.each(_array, function() {
    			if (o[this.name]) {
    				if (!o[this.name].push) {
    					o[this.name] = [ o[this.name] ];
    				}
    				o[this.name].push(this.value || '');
    			} else {
    				o[this.name] = this.value || '';
    			}
    		});
    		up.setOption('multipart_params',o);
    		</#if>
    	</#if>
		},
        FileUploaded: function(up, file, info) {
       		var response = jQuery.parseJSON(info.response);
	        if (response.success) {
	        <#if obj.view == true>
			 	addViewHtml(response);
	    	</#if>
	    	<#if obj.onUploadSuccess?? && obj.onUploadSuccess!="">
				${obj.onUploadSuccess}(response,file);
			</#if>
				serverMsg = response.msg;
				$("#"+file.id).find(".sdata").text(' - Complete');
	        }
        },
        UploadComplete: function(up, files){
         if(files.length>0){
            <#if obj.dialog == true>
    		var win = frameElement.api.opener;
    		win.reloadTable();
            win.tip(serverMsg);
            if (subDlgIndex && $('#infoTable-loading')) {
                $('#infoTable-loading').hide();
                if (!subDlgIndex.closed) subDlgIndex.close();
            }
            frameElement.api.close();
         <#elseif obj.callback?? && obj.callback!="">
         	${obj.callback}();
    	 </#if>
    	 <#if obj.view == true>
    	 	$("#viewmsg").html(m.toString());
    	 	$("#fileKey").val(fileKey);
    	 </#if>
         }
        },
        Error: function(up, err) {
       		<#-- 上传出错的时候触发 -->
            if(err.code == plupload.FILE_EXTENSION_ERROR){
            	tip("文件类型不识别！");
            }else if(plupload.FILE_SIZE_ERROR = err.code){
            	tip("文件大小超标！");
            }
        }
    }
});
uploader.init();
$("#${obj.queueID}").on("click", ".delthisfile",
	function(){
		var itemObj = $(this).closest(".uploadify-queue-item");//获取tr
		uploader.removeFile(uploader.getFile(itemObj.attr("id")));
		itemObj.find(".sdata").text(' - 已取消');
		setTimeout(function(){itemObj.fadeOut("slow");},500);
	});
});
<#if obj.outhtml == true>
function upload(){
<#if idList?? && (idList?size>0)>
<#list idList as tempid>
$.iplupload("${tempid}").start();
</#list>
<#else>
$.iplupload("${obj.id}").start();
</#if>
return false;
}
function cancel(){
<#if idList?? && (idList?size>0)>
<#list idList as tempid>
$("#${tempid}").click();
</#list>
<#else>
$("#${obj.id}").click();
</#if>
}
</#if>
</script>
<#rt/>
<#rt/>
<#rt/>
<#rt/>
<#else>
<#-- 以下参照webuploader风格,内部实现用的是plupload插件  -->
<#if obj.outJs == false>
<link rel="stylesheet" type="text/css" href="plug-in/webuploader/custom.css"></link>
<script src="plug-in/plupload/plupload.full.min.js"></script>
</#if>

<#if obj.type=='file' >
<div class="iuploader">
	<div id = "${obj.name}thelist" class="uploader-list">
		<table class="temptable">
		<tbody>
		<#if obj.pathValues?? && obj.pathValues!="">
		<#--如果当前有设置默认值则  -->
		<#list obj.pathValues?split(",") as item>
			<tr class="item" id="id${obj.randomSix()}">
			<#if item?? && item!="">
				<#assign curFileName = obj.getFilename("${item}")>
				<#if curFileName?? && curFileName!="">
				<td title="${curFileName}">
					<#if curFileName?length gt 15>
					${curFileName?substring(0,15)}...
					<#else>
					${curFileName}
					</#if>
					<input type="hidden" name= "${obj.name}" value = "${item}"/>
				</td>
				<td class="state">--历史上传文件--</td>
				<#if obj.readOnly == 'false'>
				<td title="删除" class="icontd">
					<span class="del icon-cha" style="overflow:hidden;">1</span>
				</td>
				</#if>
				<td title="预览" class="icontd">
					<span class="view icon-view">
					<#--判断文件是否支持预览  -->
					<#assign supportView = obj.supportView("${item}")>
					${supportView}
					</span>
				</td>
				<td title="下载" class="icontd">
					<span class="down icon-down">1</span>
				</td>
			</#if>
			</#if>
			</tr>
		</#list>
		</#if>
		</tbody>
		</table>
	</div>
<div id='${obj.name}_progress_bar' class='progress-bar-ty '>
	<div class='progress-ty'>
		<span class='upload-label-ty' style='display:none;'>
			正在加载...<b class='value'></b>
		</span>
	</div>
</div>
<div class="plupload-btns" style="display:inline-block">
<#if obj.readOnly == 'false'>
<#-- plupload_button plupload_add  -->
	<a href="javascript:void(0)" class="plupload-btn-default plupload-green" id="${obj.name}Upselector" style="position:relative;z-index: 1;">
		<#if obj.buttonText??>
			${obj.buttonText}
		<#else>
			<#if obj.type == 'file'>
 				选择文件
			<#else>
 				选择图片
 			</#if>
		</#if>
	</a>
	
	<#if (obj.auto == false)>
	<a class="plupload-btn-uploader plupload_disabled" id="${obj.name}Uploader" href="javascript:void(0)">
		开始上传
	</a>
	</#if>
</#if>
</div>
<#if obj.datatype??>
<div class="datatypeInparea" style="display:inline-block">
	<input id="${obj.name}dataTypeInp" type="hidden" datatype="*"<#rt/>
	<#if obj.nullMsg??>
 nullmsg="${obj.nullMsg}"<#rt/>
	<#else>
		<#if obj.type == 'file'>
 nullmsg="请选择文件!"<#rt/>
		<#else>
 nullmsg="请选择图片!"<#rt/>
 		</#if>
	</#if>
 value = />
 </div>
</#if>
</div>

<script type='text/javascript'>
$(function(){
<#-- 
 * 备注:
 * 1|新增文件 del down view 均为0
 * 2|文件状态值plupload.QUEUED=1,plupload.FAILED=4, plupload.DONE=5
 * 3|历史文件 del down 均为1  view可为-1(不可预览)/1(支持预览)
 * 4|TODO 可将外部按钮直接设置为 【选择/上传】按钮，这样避免的页面风格不一致还需要增设css的问题
 * 具备功能：
 * 1|支持查看文件列表
 * 2|支持删除、预览、下载
 * 3|支持编辑页面设置默认值
 * 4|支持非空校验
 * 5|支持readOnly (此模式只能v不能+/-)
 -->
var $list = $("#${obj.name}thelist");
var nameLength = "${obj.name}".length;
/**
 * 添加文件到列表
 * id: obj.name+文件id
 * name: 文件名
 * text: 状态
 * downsrc: 下载地址
 * delflag:
 */
var addtrFile = function(id, name, text, downsrc, delflag) {
    var namet = name;
    if (name.length > 15) {
        name = name.substring(0, 15) + '...';
    }
    var trhtml = '<tr class="item" id="' + id + '"><td title = ' + namet + '>' + name + '</td><td class="state">' + text + '</td>';
    <#-- 删除td readOnly模式不生成 -->
    trhtml += '<td title="删除" class="icontd"><span class="del icon-cha" style="overflow:hidden;">'+ delflag + '</span></td>';
     <#-- 预览td  -->
    trhtml += '<td title="预览" class="viewtd"><span class="view"></span></td>';
    <#-- 下载td  -->
   // trhtml += '<td title="下载" class="icontd"><span '+(downsrc == 0 ? 'style="display:none;" ': '')+'class="down icon-down">' + downsrc + '</span></td>';
    trhtml += '<td style="display:none"></td></tr>';
    $list.children('table').append(trhtml);
}
/**
 * 修改文件列表显示状态
 * fileId: 文件ID
 * content: 状态
 */
var updatetdState = function(fileId, content) {
    $('#${obj.name}' + fileId).find('.state').text('--' + content + '--');
}

/**
 * 删除文件ajax请求
 * path: 文件路劲
 */
var delFile = function(path){
	var dtd = $.Deferred();
	$.post('systemController/filedeal.do', {
		path: path,
		swfTransform: '${obj.swfTransform}',
		isdel: "1"
	},function(aj){
		var data = JSON.parse(aj);
		if (data.success) {
			dtd.resolve();
		}else{
			dtd.reject();
		}
	});
	return dtd.promise();
}

/**
 * 获取文件ID
 * itemObj: tr的jquery对象
 */
var getFileID = function(itemObj){
	var id = itemObj.attr("id").substring(nameLength);<#-- 获取文件ID  -->
	return id;
}
/**
 * 重置datatype验证
 * isDel: 1是删除 0是新增
 */
var resetDatatype = function(isDel){
	var obj = $("#${obj.name}dataTypeInp");
	if (obj.length > 0) {
		var objval = obj.val() || '';
		if(isDel == 0){
			//新增操作
			if (objval == '') {
                obj.val('1');
            } else {
                obj.val(objval.toString() + (parseInt(objval.length) + 1));
            }
		}else{
			//删除操作
			if (objval.length <= 1) {
                obj.val('');
            } else {
                obj.val(objval.substr(0, objval.length - 1));
            }
		}
		obj.blur();
	}
}
/**
 * 跑进度条
 */
var showUploadProgress = function(progress, mycallback, obj) {
    if (!obj) {
        obj = $('#${obj.name}_progress_bar').find('.progress-ty');
    }
    if (!$('#${obj.name}_progress_bar').hasClass('active')) {
        $('#${obj.name}_progress_bar').addClass('active');
    }
    obj.animate({
        width: progress + '%'
    },
    {
        duration: 100,
        easing: 'swing',
        complete: function(scope, i, elem) {
            if ( !! mycallback) {
                mycallback();
            }
        }
    })
};
/**
 * 显示进度条
 */
var uploadStartProgress = function(){
	$('#${obj.name}_progress_bar').find('.progress-ty').css('width', '1%');
        var temprd = Math.floor(Math.random() * 7 + 1);
        if (temprd < 4) {
            temprd = Number(temprd) + 3
        }
        temprd = Number(temprd) * 10;
        showUploadProgress(temprd,
        function() {
            showUploadProgress(Number(temprd) + 15);
        })
}
/**
 * 校验输入框编辑页面复制
 */
var initDatatypeVal = function(){
	var abc = "";
	$list.find("table>tbody>tr").each(function(i){
		if(!!$(this).html()){
			abc+= ""+(Number(i)+1);
		}
	});
	$("#${obj.name}dataTypeInp").val(abc);
}
<#if obj.fileNumLimit ==1>
<#-- 替换第一个文件  -->
var delFirstTr = function(){
	var alltr = $list.find("table>tbody>tr");
	if(alltr.length>1){
		var tr = $list.find("table>tbody>tr:first");
		tr.find(".del").click();
		tr.remove();
	}
}
</#if>
var uploader = new plupload.Uploader({
	<#-- 创建实例的构造方法  -->
    runtimes: 'gears,html5,flash,silverlight,html4', <#-- 上传插件初始化选用那种方式的优先级顺序  -->
    browse_button: ['${obj.name}Upselector'], <#--  上传按钮  -->
    url: "${obj.url}", //远程上传地址
    flash_swf_url: 'plug-in/plupload/Moxie.swf', <#-- flash文件地址  -->
    silverlight_xap_url: 'plug-in/plupload/Moxie.xap', <#-- silverlight文件地址  -->
    filters: {
        max_file_size: '${obj.fileSingleSizeLimit}kb', <#-- 最大上传文件大小（格式100b, 10kb, 10mb, 1gb）  -->
        mime_types: [
        	<#-- 允许文件上传类型  -->
            {title: "files", extensions:"${obj.getAllowedFilesExt()}"}
        ],
        prevent_duplicates:false//允许重复文件?
    },
    multipart_params:{
    	isup:"1",
    	swfTransform:"${obj.swfTransform}",
    	bizType:"${obj.bizType}"
    },
    multi_selection: true, <#-- true:ctrl多文件上传, false 单文件上传  -->
    init: {
        PostInit: function() {
			// Called after initialization is finished and internal event handlers bound
			<#if (obj.auto == false)>
			document.getElementById('${obj.name}Uploader').onclick = function() {
				uploader.start();
				return false;
			};
			</#if>
		},
        FilesAdded: function(up, files) { 
        <#-- 文件被过滤并添加到队列后触发。 -->
        <#if obj.fileNumLimit ==1>
        	$list.find("table>tbody>tr").hide();
        	if(files.length>1){
        		tip('文件数量超标!');
        	}
        	for(var a = 0;a<files.length;a++){
        		if(a==0){
	        		var id = '${obj.name}' + files[a].id;
		       	    var name = files[a].name;
		            var text = '--等待上传--';
		            addtrFile(id, name, text, 0, 0);
		            <#if (obj.auto == true)>
					uploader.start();
					<#else>
					$("#${obj.name}Uploader").removeClass("plupload_disabled");
				    </#if>
        		}else{
        			up.removeFile(files[a]);
        		}
		    }
        <#else>
        	for(var a = 0;a<files.length;a++){
        		var alreadyNum = $list.find(".item").length;
        		if(alreadyNum>=${obj.fileNumLimit}){
        			//如果超标清除文件
        			up.removeFile(files[a]);
        			tip('文件数量超标!');
        		}else{
        			var id = '${obj.name}' + files[a].id;
		       	    var name = files[a].name;
		            var text = '--等待上传--';
		            addtrFile(id, name, text, 0, 0);
		            <#if (obj.auto == true)>
					uploader.start();
					<#else>
					$("#${obj.name}Uploader").removeClass("plupload_disabled");
				    </#if>
		        }
		    }
        </#if>
        },
        FilesRemoved: function(up, files) {
        	// Called when files are removed from queue
        	var restFiles = uploader.files;
			if(!restFiles || restFiles.length<=0){
				$("#${obj.name}Uploader").addClass("plupload_disabled");
			}
        },
		UploadFile: function(up,file){
			uploadStartProgress();
		},
        UploadProgress: function(up, file) {
        	//上传中，显示进度条
        	updatetdState(file.id, '上传中');
            var percent = file.percent;
            //console.log(percent);
          //  $("#" + file.id).find('.bar').css({"width": percent + "%"});
           // $("#" + file.id).find(".percent").text(percent + "%");
        },
        FileUploaded: function(up, file, info) {
        	<#-- 文件上传成功的时候触发 -->
        	showUploadProgress(100,
       		function() {
       			var response = jQuery.parseJSON(info.response);
	        	if (response.success) {
	        		$('#${obj.name}_progress_bar').removeClass('active');<#-- 上传文件成功进度条消失 -->
	                resetDatatype(0);<#-- 上传文件成功触发校验 -->
	                updatetdState(file.id, '上传成功');
	                var filepath = response['${obj.name}'] || response.obj;
	                <#-- 上传完成增加一个input存储文件路径 -->
	                $('#${obj.name}' + file.id + ' td:first').append('<input type="hidden" name="${obj.name}" value="' + filepath + '" />');
	                <#-- 上传完成增加预览效果 -->
	                $('#${obj.name}' + file.id + ' td.viewtd').removeClass('viewtd').addClass('icontd').find('span').addClass('icon-view');
	                <#-- 替换第一个文件  -->
	                <#if obj.fileNumLimit ==1>
	                delFirstTr();
					</#if>
	            } else {
	            	$('#${obj.name}_progress_bar').removeClass('active');<#-- TODO 失败改变进度条颜色 -->
	            	console.log(file.name+'上传出错:' + response.msg);
	            }
       		});
        },
        Error: function(up, err) {
       		<#-- 上传出错的时候触发 -->
            if(err.code == plupload.FILE_EXTENSION_ERROR){
            	tip("文件类型不识别！");
            }else if(plupload.FILE_SIZE_ERROR = err.code){
            	tip("文件大小超标！");
            }
        }
    }
});
uploader.init();
initDatatypeVal();
//删除图标点击事件
$list.on("click", ".del",
	function(){
		var delspantext = $(this).text();
		var itemObj = $(this).closest(".item");//获取tr
		if(delspantext==0){
			//处理新增页面的
			var id = getFileID(itemObj);//获取文件ID
			var curFile = uploader.getFile(id);
			if(curFile.status==plupload.QUEUED){
				//选中而已,未上传
				itemObj.remove();
				uploader.removeFile(curFile);
				
			}else if(curFile.status==plupload.DONE){
				//已经上传完成了
				var delpath = itemObj.find("input[name='${obj.name}']").val();
				if(!!delpath){
					$.when(delFile(delpath))
					　　.done(function(){
							itemObj.remove();
							uploader.removeFile(curFile);
							resetDatatype(1);<#-- 删除文件时触发校验 -->
					}).fail(function(){
						console.log('删除文件'+curFile.name+'失败');
					});
				}
			}else{
				//其他状态 可能是上传失败的
				itemObj.remove();
				uploader.removeFile(curFile);
				
			}
		}else{
			//编辑页面
			var delpath = itemObj.find("input[name='${obj.name}']").val();
			if(!!delpath){
				$.when(delFile(delpath))
				　　.done(function(){
						itemObj.remove();
						resetDatatype(1);<#-- 编辑页面删除文件时触发校验 -->
				}).fail(function(){
					console.log('删除文件'+curFile.name+'失败');
				});
			}
		}
	});
//下载图标点击事件
$list.on("click", ".down",
	function(){
		var itemObj = $(this).closest(".item");//获取tr
		var optpath = itemObj.find("input[name='${obj.name}']").val();
        if (!!optpath) {
            var downsrc = "${obj.showAndDownUrl}" + optpath + '?down=true';
            location.href = downsrc;
        }
	});
//预览图标点击事件
$list.on("click", ".view",
	function(){
		var viewspantext = $(this).text();
		var itemObj = $(this).closest(".item");//获取tr
		var filepath = itemObj.find("input[name='${obj.name}']").val();
		var viewUrl = "systemController.do?openViewFile&path="+filepath;
		if(viewspantext==0){
			//新增页面
			var id = getFileID(itemObj);//获取文件ID
			var curFile = uploader.getFile(id);
			if(!!curFile){
				var fileType = curFile.type;
				if(fileType.indexOf('image')>=0){
					openwindow('预览',viewUrl,'tempty',700,500);
				}else{
					<#-- 如果支持swf转换那么文件也支持预览 否则只支持图片预览  -->
					<#if (obj.swfTransform == true || obj.swfTransform == 'true')>
					openwindow('预览',viewUrl,'tempty',700,500);
					<#else>
					tip('该文件类型不支持预览!');
					</#if>
				}
			}
		}else if(viewspantext == 1){
			openwindow('预览',viewUrl,'tempty',700,500);
		}else if(viewspantext == -1){
			tip('code:-1-该文件类型不支持预览!');
		}else{
			console.log("what happened??");
		}
	});
	
	//查看页面 控件不允许上传/删除文件
	if (location.href.indexOf('load=detail') != -1) {
	    $('.plupload-btns').hide();
	    $('.datatypeInparea').addClass('virtual-hidden');
	    //addClass('virtual-hidden').css('visibility', 'hidden');
	    $list.find('span.del').css('display', 'none');
	    $('.iuploader').find('.del').closest('td').css('display', 'none');
	}
});
</script>
<#elseif obj.type=='image'>
<#rt/>
<#rt/>
<#-- **************************************新增缩略图模式**************************************** -->
<#rt/>
<#rt/>
<div style="cursor:pointer" class="iuploader">
<#-- 文件上传 -->
<div id = "${obj.name}thelist" class="uploader-list">
	<table class="temptable">
		<tbody>
		<#if obj.pathValues?? && obj.pathValues!="">
		<#--如果当前有设置默认值则  -->
		<#list obj.pathValues?split(",") as item>
			<tr class="item" id="id${obj.randomSix()}">
			<#if item?? && item!="">
				<#assign curFileName = obj.getFilename("${item}")>
				<#if curFileName?? && curFileName!="">
				<td title="${curFileName}">
					<#if curFileName?length gt 15>
					${curFileName?substring(0,15)}...
					<#else>
					${curFileName}
					</#if>
					<input type="hidden" name= "${obj.name}" value = "${item}"/>
				</td>
				<td class="state">--历史上传文件--</td>
				<#if obj.readOnly == 'false'>
				<td title="删除" class="icontd">
					<span class="del icon-cha" style="overflow:hidden;">1</span>
				</td>
				</#if>
				<td title="预览" class="icontd">
					<span class="view icon-view">
					<#--判断文件是否支持预览  -->
					<#assign supportView = obj.supportView("${item}")>
					${supportView}
					</span>
				</td>
				<td title="下载" class="icontd">
					<span class="down icon-down">1</span>
				</td>
			</#if>
			</#if>
			</tr>
		</#list>
		</#if>
		</tbody>
	</table>
</div>
 <ul id="${obj.name}picsUl" class="ul_pics clearfix"> 
     <li class = "selectorli">
     	<img src="plug-in/plupload/jquery.ui.plupload/img/local_upload.png" id="${obj.name}Upselector"/>
     </li> 
 </ul> 
</div>
<script type='text/javascript'>
$(function(){
var $list = $("#${obj.name}thelist");
var nameLength = "${obj.name}".length;
var addtrFile = function(id, name, text, downsrc, delflag) {
    var namet = name;
    if (name.length > 15) {
        name = name.substring(0, 15) + '...';
    }
    var trhtml = '<tr class="item" id="' + id + '"><td title = ' + namet + '>' + name + '<input type="hidden" name="${obj.name}" value="' + downsrc + '" /></td><td class="state">' + text + '</td>';
    <#-- 删除td readOnly模式不生成 -->
    trhtml += '<td title="删除" class="icontd"><span class="del icon-cha" style="overflow:hidden;">'+ delflag + '</span></td>';
    <#-- 预览td  -->
    trhtml += '<td title="预览" class="icontd"><span class="view icon-view"></span></td>';
    trhtml += '<td style="display:none"></td></tr>';
    $list.children('table').append(trhtml);
}
var getFileID = function(itemObj){
	var id = itemObj.attr("id").substring(nameLength);<#-- 获取文件ID  -->
	return id;
}

var removeImg = function(id,curFile){
	$("#" + id).remove();
	$("#${obj.name}"+id).remove();
	if(!!curFile){
		uploader.removeFile(curFile);
	}
}
/**
 * 删除文件ajax请求
 * path: 文件路劲
 */
var delFile = function(path){
	var dtd = $.Deferred();
	$.post('systemController/filedeal.do', {
		path: path,
		swfTransform: '${obj.swfTransform}',
		isdel: "1"
	},function(aj){
		var data = JSON.parse(aj);
		if (data.success) {
			dtd.resolve();
		}else{
			dtd.reject();
		}
	});
	return dtd.promise();
}
var removeFirstFile = function(isdel){
	if(isdel==0){
		$list.find("table>tbody>tr").hide();
    	$("#${obj.name}picsUl").children("li").not('.selectorli').hide();
	}else{
		var tr = $list.find("table>tbody>tr:first");
		tr.find(".del").click();
		tr.remove();
	}
}
var uploader = new plupload.Uploader({
	<#-- 创建实例的构造方法  -->
    runtimes: 'gears,html5,flash,silverlight,html4', <#-- 上传插件初始化选用那种方式的优先级顺序  -->
    browse_button: ['${obj.name}Upselector'], <#--  上传按钮  -->
    url: "${obj.url}", //远程上传地址
    flash_swf_url: 'plug-in/plupload/Moxie.swf', <#-- flash文件地址  -->
    silverlight_xap_url: 'plug-in/plupload/Moxie.xap', <#-- silverlight文件地址  -->
    filters: {
        max_file_size: '${obj.fileSingleSizeLimit}kb', <#-- 最大上传文件大小（格式100b, 10kb, 10mb, 1gb）  -->
        mime_types: [<#-- 允许文件上传类型  -->
            {title: "image files", extensions:"${obj.getAllowedIMG()}"}
        ],
        prevent_duplicates:false//允许重复文件?
    },
    multipart_params:{
    	isup:"1",
    	bizType:"${obj.bizType}"
    },
    multi_selection: true, <#-- true:ctrl多文件上传, false 单文件上传  -->
    init: {
        PostInit: function() {
		},
        FilesAdded: function(up, files) { 
        	//文件被过滤并添加到队列后触发。
        <#if obj.fileNumLimit ==1>
       	    removeFirstFile(0);
        	if(files.length>1){
        		tip('图片数量超标!');
        	}
        	for(var a = 0;a<files.length;a++){
        		if(a==0){
	        		var li = "<li class='li_upload' id='" + files[a]['id'] + "'><div class='progress'><span class='bar'></span><span class='percent'>0%</span></div></li>";
	        		$("#${obj.name}picsUl").prepend(li);
        			uploader.start();
        		}else{
        			up.removeFile(files[a]);
        		}
		    }
        <#else>
        	for(var a = 0;a<files.length;a++){
        		var alreadyNum = $list.find(".item").length;
        		if(alreadyNum>=${obj.fileNumLimit}){
        			//如果超标清除文件
        			up.removeFile(files[a]);
        			tip('图片数量超标!');
        		}else{
        			var li = "<li class='li_upload' id='" + files[a]['id'] + "'><div class='progress'><span class='bar'></span><span class='percent'>0%</span></div></li>";
	        		$("#${obj.name}picsUl").prepend(li);
        			uploader.start();
		        }
		    }
        </#if>
        },
        FilesRemoved: function(up, files) {
        },
		UploadFile: function(up,file){
		},
        UploadProgress: function(up, file) {
         	var percent = file.percent;
            $("#" + file.id).find('.bar').css({"width": percent + "%"});
            $("#" + file.id).find(".percent").text(percent + "%");
        },
        FileUploaded: function(up, file, info) {
        	<#-- 文件上传成功的时候触发 -->
        	var response = jQuery.parseJSON(info.response);
        	if (response.success) {
        		<#if obj.fileNumLimit ==1>
       	    	removeFirstFile(1);
       	    	</#if>
	        	var picpath = response.obj;
	        	while(picpath.indexOf('\\')>=0){
             		picpath = picpath.replace("\\","/");
             	}
             	var html = "<img class='img_common' src='${obj.showAndDownUrl}" + picpath + "'/><span class='picbg'></span><a href='javascript:void(0)' class='pic_close'></a>";
             	$("#" + file.id).html(html);
             	var id = '${obj.name}' + file.id;
	       	    var name = file.name;
	            var text = '--上传成功--';
	            addtrFile(id, name,text ,picpath, 0);
            } else {
            	console.log(file.name+'上传出错:' + response.msg);
            }
        },
        Error: function(up, err) {
       		<#-- 上传出错的时候触发 -->
            if(err.code == plupload.FILE_EXTENSION_ERROR){
            	tip("文件类型不识别！");
            }else if(plupload.FILE_SIZE_ERROR = err.code){
            	tip("文件大小超标！");
            }
        }
    }
});
uploader.init();
//删除图标点击事件
$('#${obj.name}picsUl').on("click", ".pic_close",
	function(){
		try{
			var singleLi =  $(this).closest("li");
			var file_id = singleLi.attr("id");
			var itemObj = $("#${obj.name}"+file_id);
			var path = itemObj.find("input[name='${obj.name}']").val();
			if(!!path){
				$.when(delFile(path))
					　　.done(function(){
							removeImg(file_id);
					}).fail(function(){
						console.log('删除文件'+curFile.name+'失败');
					});
			}
		}catch(err){
			console.log('删除出错!'+err);
		}
	});
//删除图标点击事件
$list.on("click", ".del",
	function(){
		var delspantext = $(this).text();
		var itemObj = $(this).closest(".item");//获取tr
		if(delspantext==0){
			//处理新增页面的
			var id = getFileID(itemObj);//获取文件ID
			var curFile = uploader.getFile(id);
			if(curFile.status==plupload.QUEUED){
				//选中而已,未上传
				removeImg(id,curFile);
			}else if(curFile.status==plupload.DONE){
				//已经上传完成了
				var delpath = itemObj.find("input[name='${obj.name}']").val();
				if(!!delpath){
					$.when(delFile(delpath))
					　　.done(function(){
							removeImg(id,curFile);
					}).fail(function(){
						console.log('删除文件'+curFile.name+'失败');
					});
				}
			}else{
				//其他状态 可能是上传失败的
				removeImg(id,curFile);
			}
		}else{
			//编辑页面
			var delpath = itemObj.find("input[name='${obj.name}']").val();
			if(!!delpath){
				$.when(delFile(delpath))
				　　.done(function(){
						itemObj.remove();
						
				}).fail(function(){
					console.log('删除文件'+curFile.name+'失败');
				});
			}
		}
	});
//下载图标点击事件
$list.on("click", ".down",
	function(){
		var itemObj = $(this).closest(".item");//获取tr
		var optpath = itemObj.find("input[name='${obj.name}']").val();
        if (!!optpath) {
            var downsrc = "${obj.showAndDownUrl}" + optpath + '?down=true';
            location.href = downsrc;
        }
	});
//预览图标点击事件
$list.on("click", ".view",
	function(){
		var viewspantext = $(this).text();
		var itemObj = $(this).closest(".item");//获取tr
		var filepath = itemObj.find("input[name='${obj.name}']").val();
		if(!!filepath){
			var viewUrl = "systemController.do?openViewFile&path="+filepath;
			openwindow('预览',viewUrl,'tempty',700,500);
		}else{
			tip("文件地址无效");
		}
	});
	
	//查看页面 控件不允许上传/删除文件
	if (location.href.indexOf('load=detail') != -1) {
	    $('#${obj.name}picsUl').hide();
	    $list.find('span.del').css('display', 'none');
	    $('.iuploader').find('.del').closest('td').css('display', 'none');
	}
});
</script>
</#if>
</#if>