

//通用弹出式文件上传
function commonUpload(callback){
    $.dialog({
           content: "url:systemController.do?commonUpload",
           lock : true,
           title:"文件上传",
           zIndex:2100,
           width:700,
           height: 200,
           parent:windowapi,
           cache:false,
       ok: function(){
               var iframe = this.iframe.contentWindow;
               iframe.uploadCallback(callback);
                   return true;
       },
       cancelVal: '关闭',
       cancel: function(){
       } 
   });
}
function decode(value, id) {//value传入值,id接受值
	var last = value.lastIndexOf("/");
	var filename = value.substring(last + 1, value.length);
	$("#" + id).text(decodeURIComponent(filename));
}

function checkPic(){
	if($.trim( $("#templatePic").val()).length<=0){
		$.messager.alert('错误', "请上传预览图！");
		return false;
	}
	return true;
}

function checkZip(){
	if(hasZipFile<=0){
		$.messager.alert('错误', "请上传模板压缩文件！");
		return false;
	}
	return true;
}

//上传图片
function uploadPic(){
	$('#templatePic_u').uploadify("upload","*");
}
//风格类型改变后 模板名称默认值要改变
function changeTemplate(selectObj){
	var val=selectObj.value;
	if(val==1){
		$("#templateListName").val("autolist.ftl");
		$("#templateAddName").val("jform.ftl");
		$("#templateUpdateName").val("jform.ftl");
		$("#templateDetailName").val("jform.ftl");
	}else{
		$("#templateListName").val("autolist.ftl");
		$("#templateAddName").val("jformunion.ftl");
		$("#templateUpdateName").val("jformunion.ftl");
		$("#templateDetailName").val("jformunion.ftl");
	}

}
