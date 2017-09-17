<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>测试多文件上传</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
		<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="multiUploadController.do?doUpdate" callback="jeecgFormFileCallBack@Override">
					<input id="cgFormId" name="id" type="hidden" value="${multiUploadPage.id }"/>
					<input id="cgFormName" name="cgFormName" type="hidden" value="jeecg_multi_upload">
					<input id="cgFormField_testFile1" type="hidden" value="TEST_FILE_1">
					<input id="cgFormField_testFile2" type="hidden" value="TEST_FILE_2">
					<input id="cgFormField_testFile3" type="hidden" value="TEST_FILE_3">
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right">
							<label class="Validform_label">
								测试文件1:
							</label>
						</td>
						<td class="value">
									<table id="test_file_1_fileTable"></table>
										<table></table>
										<div class="form jeecgDetail">
									<t:upload name="testFile1" id="testFile1" queueID="filediv_testFile1" uploader="cgUploadController.do?saveFiles" extend="" formData="cgFormId,cgFormName,cgFormField_testFile1" outhtml="false"></t:upload> 
								</div> 
										<div class="form" id="filediv_testFile1"></div>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">测试文件1</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								测试文件2:
							</label>
						</td>
						<td class="value">
									<table id="test_file_2_fileTable"></table>
										<table></table>
											<div class="form jeecgDetail">
									<t:upload name="testFile2" id="testFile2" queueID="filediv_testFile2" uploader="cgUploadController.do?saveFiles" extend="" formData="cgFormId,cgFormName,cgFormField_testFile2" outhtml="false"></t:upload> 
								</div> 
										<div class="form" id="filediv_testFile2"></div>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">测试文件2</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								测试文件3:
							</label>
						</td>
						<td class="value">
									<table id="test_file_3_fileTable"></table>
										<table></table>
										<div class="form jeecgDetail">
									<t:upload name="testFile3" id="testFile3" queueID="filediv_testFile3" uploader="cgUploadController.do?saveFiles" extend="" formData="cgFormId,cgFormName,cgFormField_testFile3" outhtml="true"></t:upload> 
								</div> 
										<div class="form" id="filediv_testFile3"></div>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">测试文件3</label>
						</td>
					</tr>
				<tr>
					<td align="right">
						<label class="Validform_label">
							使用说明:
						</label>
					</td>
					<td class="value">
						页面当中使用多个"&lt;t:upload"的时候，需要设置参数outhtml的值，
						<span style="color:red;">最后一个标签当中的outhtml的值设置为true，其余标签当中的outhtml设置为false;</span>
						页面当中有且仅有一个"&lt;t:upload"的时候，可以省略outhtml="true"
					</td>
				</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/com/jeecg/demo/multiUpload.js"></script>		
	  	<script type="text/javascript">
		  	//加载 已存在的 文件
		  	$(function(){
		  		var cgFormId=$("input[name='id']").val();
		  		$.ajax({
		  		   type: "post",
		  		   url: "multiUploadController.do?getFiles&id=" +  cgFormId,
		  		   success: function(data){
		  			 var arrayFileObj = jQuery.parseJSON(data).obj;
		  			 
		  			$.each(arrayFileObj,function(n,file){
		  				var fieldName = file.field.toLowerCase();
		  				var table = $("#"+fieldName+"_fileTable");
		  				var tr = $("<tr style=\"height:34px;\"></tr>");
		  				var title = file.title;
		  				if(title.length > 15){
		  					title = title.substring(0,12) + "...";
		  				}
		  				var td_title = $("<td>" + title + "</td>");
		  		  		var td_download = $("<td><a style=\"margin-left:10px;\" href=\"commonController.do?viewFile&fileid=" + file.fileKey + "&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity\" title=\"下载\">下载</a></td>")
		  		  		var td_view = $("<td><a style=\"margin-left:10px;\" href=\"javascript:void(0);\" onclick=\"openwindow('预览','commonController.do?openViewFile&fileid=" + file.fileKey + "&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)\">预览</a></td>");
		  		  		var td_del = $("<td><a style=\"margin-left:10px;\" href=\"javascript:void(0)\" class=\"jeecgDetail\" onclick=\"del('cgUploadController.do?delFile&id=" + file.fileKey + "',this)\">删除</a></td>");
		  		  		tr.appendTo(table);
		  		  		td_title.appendTo(tr);
		  		  		td_download.appendTo(tr);
		  		  		td_view.appendTo(tr);
		  		  		td_del.appendTo(tr);
		  			 });
		  		   }
		  		});
		  	});
		  	
		  	/**
		 	 * 删除图片数据资源
		 	 */
		  	function del(url,obj){
		  		var content = "请问是否要删除该资源";
		  		var navigatorName = "Microsoft Internet Explorer"; 
		  		if( navigator.appName == navigatorName ){ 
		  			$.dialog.confirm(content, function(){
		  				submit(url,obj);
		  			}, function(){
		  			});
		  		}else{
		  			layer.open({
						title:"提示",
						content:content,
						icon:7,
						yes:function(index){
							submit(url,obj);
						},
						btn:['确定','取消'],
						btn2:function(index){
							layer.close(index);
						}
					});
		  		}
		  	}
		  	
		  	function submit(url,obj){
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
		  					obj.parentNode.parentNode.parentNode.deleteRow(obj.parentNode.parentNode);
		  				} else {
		  					tip(d.msg);
		  				}
		  			}
		  		});
		  	}
		  	
	  		function jeecgFormFileCallBack(data){
	  			if (data.success == true) {
					uploadFile(data);
				} else {
					if (data.responseText == '' || data.responseText == undefined) {
						$.messager.alert('错误', data.msg);
						$.Hidemsg();
					} else {
						try {
							var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
							$.messager.alert('错误', emsg);
							$.Hidemsg();
						} catch(ex) {
							$.messager.alert('错误', data.responseText + '');
						}
					}
					return false;
				}
				if (!neibuClickFlag) {
					var win = frameElement.api.opener;
					win.reloadTable();
				}
	  		}
			
			var neibuClickFlag = false;
			function neibuClick() {
				neibuClickFlag = true; 
				$('#btn_sub').trigger('click');
			}
			function uploadFile(data){
				if(!$("input[name='id']").val()){
					if(data.obj!=null && data.obj!='undefined'){
						$("input[name='id']").val(data.obj.id);
					}
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
	  	</script>
