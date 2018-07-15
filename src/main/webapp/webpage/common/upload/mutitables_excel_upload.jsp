<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>Excel导入</title>
<t:base type="jquery,tools"></t:base>
<style>
    .uploadlog{color:red;}
</style>
</head>
<body style="overflow-y: hidden" scroll="no">
<t:formvalid formid="formobj" layout="div" dialog="true">
	<fieldset class="step">
		<div class="form">
			<t:upload name="fiels" buttonText="选择要导入的文件" 
				uploader="${controller_name}.do?${empty method_name?'importExcel':method_name }&mainId=${mainId}" 
				extend="*.xls;*.xlsx" id="file_upload" formData="documentTitle"></t:upload>
		</div>
		<!-- '+getdbname2()+' -->
		<div class="form" id="filediv" style="height: 50px"></div>
	</fieldset>
</t:formvalid>
<script type="text/javascript">
window.onload = function(){
	var myCloseFlag  = 0;
	$('#file_upload').uploadify('settings','onUploadSuccess',function(file, data, response) {
		var d = $.parseJSON(data);
		if (d.success) {
			serverMsg = d.msg;
			myCloseFlag= 0;
		}else{
			if(d.obj == '1'){
				myCloseFlag= 1;
				$("#filediv").fadeOut('slow',function(){
					var html = '<div class="form uploadlog" id="tipdiv" style="height: 20px">'+d.msg+'，详情请<a download="上传excel错误日志.txt" href=\'${webRoot}/'+d.attributes.log1+'\'><<下载日志>></a>查看!</div>';
					$("#filediv").after(html);
				});
			}else{
				myCloseFlag= 0;
				serverMsg = d.msg;
			}
		}
	},true);
 	$('#file_upload').uploadify('settings','onQueueComplete',function(queueData) {
 		var win = frameElement.api.opener;
        if (subDlgIndex && $('#infoTable-loading')) {
            $('#infoTable-loading').hide();
            if (!subDlgIndex.closed) subDlgIndex.close();
        }
        if(myCloseFlag==0){
        	 frameElement.api.close();
        	 win.reloadTable();
             win.topWinTip(serverMsg);
        }
   	    },true); 
 	
 	$('#file_upload').uploadify('settings','onSelect',function(file) {
 		$("#filediv").fadeIn('slow',function(){
 			if($("#tipdiv").length>0){
 				$("#tipdiv").remove();
 			}
		});
   	    },true); 
}
</script>
</body>
</html>

