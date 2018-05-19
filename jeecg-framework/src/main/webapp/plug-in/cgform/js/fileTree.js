 /**
 ** 打开文件夹选择器
 	@param id 选择文件夹后回填的控件id
 */
 function openFolder(id){
 	$.dialog({
		content: 'url:generateController.do?goFileTree',
		lock : true,
		width:500,
		zIndex:2100,
		parent:frameElement.api,
		height:300,
		title:'文件夹选择',
		opacity : 0.3,
		cache:false,
	    ok: function(){
	    	iframe = this.iframe.contentWindow;
			iframe.fillPath(id);
			return true;
	    },
	    cancelVal: '关闭',
	    cancel: true /*为true等价于function(){}*/
	});
 }
 
 function selectCallback(id,path){
 	$("#"+id).val(path);
 }