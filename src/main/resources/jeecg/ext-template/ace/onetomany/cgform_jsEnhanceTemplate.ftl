${cgformConfig.formJs.cgJsStr?if_exists}

//初始化下标
function resetTrNum(tableId) {
	$tbody = $("#"+tableId+"");
	$tbody.find('>tr').each(function(i){
		$(':input, select,button,a', this).each(function(){
			var $this = $(this), validtype_str = $this.attr('validType'), name = $this.attr('name'),id=$this.attr('id'),onclick_str=$this.attr('onclick'), val = $this.val();
			if(name!=null){
				if (name.indexOf("#index#") >= 0){
					$this.attr("name",name.replace('#index#',i));
				}else{
					var s = name.indexOf("[");
					var e = name.indexOf("]");
					var new_name = name.substring(s+1,e);
					<#-- update--begin--author:jiaqiankun date:20180710 for：TASK #2934 【bug - 少谦】老版代码生成器都存在的问题，明细页面上传附件的问题 -->
					$this.attr("name",name.replace("["+new_name+"]","["+i+"]"));
					<#-- update--end--author:jiaqiankun date:20180710 for：TASK #2934 【bug - 少谦】老版代码生成器都存在的问题，明细页面上传附件的问题 -->
				}
			}
			if(id!=null){
				if (id.indexOf("#index#") >= 0){
					$this.attr("id",id.replace('#index#',i));
				}else{
					var s = id.indexOf("[");
					var e = id.indexOf("]");
					var new_id = id.substring(s+1,e);
					<#-- update--begin--author:jiaqiankun date:20180710 for：TASK #2934 【bug - 少谦】老版代码生成器都存在的问题，明细页面上传附件的问题 -->
					$this.attr("id",id.replace("["+new_id+"]","["+i+"]"));
					<#-- update--end--author:jiaqiankun date:20180710 for：TASK #2934 【bug - 少谦】老版代码生成器都存在的问题，明细页面上传附件的问题 -->
				}
			}
			if(onclick_str!=null){
				if (onclick_str.indexOf("#index#") >= 0){
					$this.attr("onclick",onclick_str.replace(/#index#/g,i));
				}else{
					<#-- update--begin--author:jiaqiankun date:20180710 for：TASK #2934 【bug - 少谦】老版代码生成器都存在的问题，明细页面上传附件的问题 -->
					if(name!=null && name.indexOf("imgBtn")>=0){
						var s = onclick_str.indexOf("[");
						var e = onclick_str.indexOf("]");
						var new_onclick_str = onclick_str.substring(s+1,e);
						$this.attr("onclick",onclick_str.replace(new_onclick_str,i+"\\"+"\\"));
					}
					<#-- update--end--author:jiaqiankun date:20180710 for：TASK #2934 【bug - 少谦】老版代码生成器都存在的问题，明细页面上传附件的问题 -->
				}
			}
			<#-- update--begin--author:Yandong Date:20180226 for:TASK #2513 【bug】代码生成器，新添加的online唯一校验生成代码问题-->
			if(validtype_str!=null){
				if(validtype_str.indexOf("#index#") >= 0){
					$this.attr("validType",validtype_str.replace('#index#',i));
				}
			}
			<#-- update--end--author:Yandong Date:20180226 for:TASK #2513 【bug】代码生成器，新添加的online唯一校验生成代码问题-->
		});
		$(this).find('div[name=\'xh\']').html(i+1);
	});
}
//通用弹出式文件上传
function commonUpload(callback,inputId){
    $.dialog({
           content: "url:systemController.do?commonUpload",
           lock : true,
           title:"文件上传",
           <#-- update--begin--author:zhangjiaqiang date:20170601 for:修订弹出框对应的index -->
           zIndex:getzIndex(),
            <#-- update--end--author:zhangjiaqiang date:20170601 for:修订弹出框对应的index -->
           width:700,
           height: 200,
           parent:windowapi,
           cache:false,
       ok: function(){
               var iframe = this.iframe.contentWindow;
               iframe.uploadCallback(callback,inputId);
               return true;
       },
       cancelVal: '关闭',
       cancel: function(){
       } 
   });
}
//通用弹出式文件上传-回调
function commonUploadDefaultCallBack(url,name,inputId){
	$("#"+inputId+"_href").attr('href',url).html('下载');
	$("#"+inputId).val(url);
}
function decode(value, id) {//value传入值,id接受值
	var last = value.lastIndexOf("/");
	var filename = value.substring(last + 1, value.length);
	$("#" + id).text(decodeURIComponent(filename));
}