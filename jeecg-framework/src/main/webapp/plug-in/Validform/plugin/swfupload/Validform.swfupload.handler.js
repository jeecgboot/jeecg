/*set handlers here*/
var swfuploadhandler={
	init:function(settings,index){
		settings=$.extend(true,{},swfuploadefaults,settings);
		swfuploadhandler["SWFUPLOAD_"+settings.custom_settings.form.attr("id")+"_"+index]=new SWFUpload(settings);
	},
	
	swfUploadLoaded:function(){
			
	},
	
	uploadStart:function(){
		//this.customSettings.form.find(".fsUploadProgress").show();
	},
	
	uploadDone:function(){
		//this.customSettings.form.find(".fsUploadProgress").hide();
		this.customSettings.showmsg("已成功上传文件！",2);
		//this.customSettings.form.submit();
	},
	
	fileDialogStart:function(){
		this.customSettings.form.find("input[plugin='swfupload']").val("");
		this.cancelUpload();
	},
	
	fileQueueError:function(file, errorCode, message){
		try {
			// Handle this error separately because we don't want to create a FileProgress element for it.
			switch (errorCode) {
			case SWFUpload.QUEUE_ERROR.QUEUE_LIMIT_EXCEEDED:
				this.customSettings.showmsg("You have attempted to queue too many files.\n" + (message === 0 ? "You have reached the upload limit." : "You may select " + (message > 1 ? "up to " + message + " files." : "one file.")),3);
				return;
			case SWFUpload.QUEUE_ERROR.FILE_EXCEEDS_SIZE_LIMIT:
				this.customSettings.showmsg("The file you selected is too big.",3);
				this.debug("Error Code: File too big, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
				return;
			case SWFUpload.QUEUE_ERROR.ZERO_BYTE_FILE:
				this.customSettings.showmsg("The file you selected is empty.  Please select another file.",3);
				this.debug("Error Code: Zero byte file, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
				return;
			case SWFUpload.QUEUE_ERROR.INVALID_FILETYPE:
				this.customSettings.showmsg("The file you choose is not an allowed file type.",3);
				this.debug("Error Code: Invalid File Type, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
				return;
			default:
				swfu.customSettings.showmsg("An error occurred in the upload. Try again later.",3);
				this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
				return;
			}
		} catch (e) {}	
	},
	
	fileQueued:function(file){
		try {
			this.customSettings.form.find("input[plugin='swfupload']").val(file.name);
		} catch (e) {}
	},
	
	fileDialogComplete:function(numFilesSelected, numFilesQueued){
		this.startUpload();
	},
	
	uploadProgress:function(file, bytesLoaded, bytesTotal){
		try {
			var percent = Math.ceil((bytesLoaded / bytesTotal) * 100);
			this.customSettings.showmsg("已上传："+percent+"%",1);
			//this.customSettings.form.find(".fsUploadProgress").text("已上传："+percent+"%");
		} catch (e) {}
	},
	
	uploadSuccess:function(file, serverData){
		try {
			if (serverData === " ") {
				this.customSettings.upload_successful = false;
			} else {
				this.customSettings.upload_successful = true;
				this.customSettings.form.find("input[pluginhidden='swfupload']").val(serverData);
			}
		} catch (e) {}
	},
	
	uploadComplete:function(file){
		try {
			if (this.customSettings.upload_successful) {
				//this.setButtonDisabled(true);
				swfuploadhandler.uploadDone.call(this);
			} else {
				this.customSettings.form.find("input[plugin='swfupload']").val("");
				this.customSettings.showmsg("There was a problem with the upload.\nThe server did not accept it.",3);
			}
		} catch (e) {}	
	},
	
	uploadError:function(file, errorCode, message){
		try {
			if (errorCode === SWFUpload.UPLOAD_ERROR.FILE_CANCELLED) {
				// Don't show cancelled error boxes
				return;
			}
			this.customSettings.form.find("input[plugin='swfupload']").val("");
	
			// Handle this error separately because we don't want to create a FileProgress element for it.
			switch (errorCode) {
			case SWFUpload.UPLOAD_ERROR.MISSING_UPLOAD_URL:
				this.customSettings.showmsg("There was a configuration error.  You will not be able to upload a resume at this time.",3);
				this.debug("Error Code: No backend file, File name: " + file.name + ", Message: " + message);
				return;
			case SWFUpload.UPLOAD_ERROR.UPLOAD_LIMIT_EXCEEDED:
				this.customSettings.showmsg("You may only upload 1 file.",3);
				this.debug("Error Code: Upload Limit Exceeded, File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
				return;

			case SWFUpload.UPLOAD_ERROR.FILE_CANCELLED:
			case SWFUpload.UPLOAD_ERROR.UPLOAD_STOPPED:
				break;
			default:
				this.customSettings.showmsg("An error occurred in the upload. Try again later.",3);
				this.debug("Error Code: " + errorCode + ", File name: " + file.name + ", File size: " + file.size + ", Message: " + message);
				return;
			}
		} catch (ex) {}
	}
	
}

var swfuploadefaults={
	file_size_limit : "10 MB",
	file_types : "*.*",
	file_types_description : "All Files",
	file_upload_limit : "0",
	file_queue_limit : "10",
	button_placeholder_id : "spanButtonPlaceholder",
	
	file_post_name: "resume_file",
	upload_url: "demo/plugin/swfupload/upload.php",
	button_image_url: "demo/plugin/swfupload/XPButtonUploadText_61x22.png",
	button_width: 61,
	button_height: 22,
	flash_url: "demo/plugin/swfupload/swfupload.swf",
	
	swfupload_loaded_handler : swfuploadhandler.swfUploadLoaded,
	file_dialog_start_handler: swfuploadhandler.fileDialogStart,
	file_queued_handler : swfuploadhandler.fileQueued,
	file_queue_error_handler : swfuploadhandler.fileQueueError,
	file_dialog_complete_handler : swfuploadhandler.fileDialogComplete,
	upload_start_handler : swfuploadhandler.uploadStart,
	upload_progress_handler : swfuploadhandler.uploadProgress,
	upload_error_handler : swfuploadhandler.uploadError,
	upload_success_handler : swfuploadhandler.uploadSuccess,
	upload_complete_handler : swfuploadhandler.uploadComplete,

	custom_settings:{},
	debug: false
}

//$(function(){
	//独立触发事件;
	//var custom={
	//	custom_settings:{
	//		form:$this,
	//		showmsg:function(msg){
	//			alert(msg);	
	//		}	
	//	}	
	//}
	//swfuploadhandler.init(custom);	
//})
