<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.jeecgframework.core.util.SysThemesUtil,org.jeecgframework.core.enums.SysThemesEnum"%> 
<%@include file="/context/mytags.jsp"%>
<%
SysThemesEnum sysTheme = SysThemesUtil.getSysTheme(request);
String style = sysTheme.getStyle();
%>
<!DOCTYPE html>
<html>
 <head>
  <title>内部邮件</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="plug-in/ckeditor_new/ckeditor.js"></script>
  <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  <script>UEDITOR_HOME_URL='<%=path%>/plug-in/Formdesign/js/ueditor/';</script>
  <script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/ueditor.config.js"></script>
  <script type="text/javascript" charset="utf-8" src="plug-in/Formdesign/js/ueditor/ueditor.all.js"> </script>
  <script type="text/javascript">
  $(function() {  
	  if('${jformInnerMailPage.status }'=='01'){
		 // alertTip("本邮件已经发送,请刷新草稿箱","提示");
		  $.dialog({
				title:"提示",
				icon:'tips.gif',
				lock:true,
				content: "本邮件已经发送,请刷新草稿箱",
				ok: function(){
					window.top.$('#maintabs').tabs('close',"写信");
				}
			}).zindex();
		 

		  /*$.dialog.confirm('本邮件已经发送不可再次编辑,查看邮件?',
					function(r) {
	            		createdetailwindow("写信","jformInnerMailController.do?goDetail&id=${jformInnerMailPage.id }") ;
						window.top.$('#maintabs').tabs('close',"写信");},
			  		function(r){
						window.top.$('#maintabs').tabs('close',"写信");
					}
			);*/
	  }
	  init();
   }); 
  //页面初始化
  function init(){
  	$("#realName").val('${jformInnerMailPage.receiverNames}')
  	$("#pageReceiverIds").val('${jformInnerMailPage.receiverIds}')
  	
  	editor.addListener("ready",function(){
  		editor.setContent('${jformInnerMailPage.content}', false);
  		});//防止在按钮按下的时候，编辑器还没初始化
  }
  //编写自定义JS代码
  //初始化：
  //receiverName pageReceiverIds
   //编写自定义JS代码
   function setContent(){
	    $("#receiverIds").val($("#pageReceiverIds").val());
	    if(editor.queryCommandState( 'source' ))
	    	editor.execCommand('source');//切换到编辑模式才提交，否则有bug
	            
	    if(editor.hasContents()){
	    	editor.sync();
		    $("#content").val(editor.getContent());
		}
	}
   //发送
    function save(status){
    	$("#status").val(status);
    	setContent();
    	//当状态是发送时，要验证   收件人不可为空、主题不可为空
    	if(status=='01'){
    		if(!$("#receiverIds").val()){
    			tip("收件人不可为空");
    			return ;
    		}
    		if(!$("#title").val()){
    			tip("主题不可为空");
    			return ;
    		}
    	}
    	
    	$('#btn_sub').click();
    	/*
    	$.ajax({
			url : 'jformInnerMailController.do?doSave',
			type : 'post',
			data:{
				id:$("#id").val(),
				receiverIds:$("#receiverIds").val(),
				receiverNames:$("#realName").val(),
				attachment:$("#attachment").val(),
				createName:$("#createName").val(),
				title:$("#title").val(),
				content:$("#content").val(),
				status:status
			},
			cache : false,
			success : function(data) {
				var d = $.parseJSON(data);
				tip(d.msg)
			}
		});*/
    }
   
	function uploadFile(data){
  		$("#mailId").val(data.obj.id);
  		if($(".uploadify-queue-item").length>0){
  			upload();
  		}
  		else{
  			onUploadSuccess();
  		}
  	}
	function onUploadSuccess(data){
		$.dialog.confirm('再写一封?',
				function(r) {
		  			self.location="jformInnerMailController.do?goAddOrUpdate";},
		  		function(r){
		  			var style="<%=style%>";	
		  			if(style=="ace"||style=="acele"){
		  				try{
		  					window.top.closeTab("tab_${clickFunctionId }");
		  				}catch(e){
		  				}
		  			}else{
		  				try{
		  					window.top.$('#maintabs').tabs('close',"写信");
		  				}catch(e){
		  				}
		  			}
				}
		);
	}
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table"  action="jformInnerMailController.do?doSave" callback="@Override uploadFile"  tiptype="1" >
					<input id="id" name="id" type="hidden" value="${jformInnerMailPage.id }">
					<input id="createName" name="createName" type="hidden" value="${jformInnerMailPage.createName }">
					<input id="createBy" name="createBy" type="hidden" value="${jformInnerMailPage.createBy }">
					<input id="createDate" name="createDate" type="hidden" value="${jformInnerMailPage.createDate }">
					<input id="status" name="status" type="hidden" value="${jformInnerMailPage.status }">
					<input id="receiverIds" name="receiverIds" type="hidden" value="${jformInnerMailPage.receiverIds }">
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td height="50px" align="left" colspan="2">
							<a style="margin-left:80px" href="#" class="easyui-linkbutton l-btn"  plain="true" iconcls="icon-save" onclick="save('00')" id="">存草稿</a>
							<a href="#" class="easyui-linkbutton l-btn"  plain="true" iconcls="icon-redo" onclick="save('01')" id="">发送</a>
						</td>
					</tr>
					<tr>
						<td align="right" width="80px">
							<label class="Validform_label">
								收件人:
							</label>
						</td>
						<td class="value">
								 <input name="pageReceiverIds" type="hidden" value="${id}" id="pageReceiverIds">
						     	 <input name="receiverNames" class="inputxt" value="${realName }" id="realName" readonly="readonly" datatype="*" />
							<t:choose hiddenName="pageReceiverIds" hiddenid="id" url="jformInnerMailController.do?receivers" name="userList"
				                          icon="icon-search" title="选择收件人" textname="realName" isclear="true" isInit="true" width="800px"></t:choose>
							
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">收件人列表</label>
						</td>
					</tr>
				
					<tr>
						<td align="right">
							<label class="Validform_label">
								主题:
							</label>
						</td>
						<td class="value">
						     	 <input id="title" name="title" type="text" style="width: 150px" class="inputxt"  value='${jformInnerMailPage.title}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">主题</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label"> 附件
							</label>
						</td>
						<td>
							<table>
							    <tr style="height: 34px;">
								<c:forEach items="${documents}" var="vdocument">
										<td><a href="commonController.do?viewFile&fileid=${vdocument.id}&subclassname=org.jeecgframework.web.system.pojo.base.JformInnerMailAttach" title="下载">${vdocument.attachmenttitle}.${vdocument.extend}</a>(<a href="javascript:void(0)" class="jeecgDetail" onclick="del('jformInnerMailController.do?delFile&id=${vdocument.id}',this)">删除</a>)</td>
								</c:forEach>
								</tr>
								<tr>
								 	<td colspan="3">
								 	<div class="form" id="filediv"></div>
									<div class="form jeecgDetail">
									<t:upload name="fiels" id="file_upload" 
									   extend="*.doc;*.docx;*.txt;*.ppt;*.xls;*.xlsx;*.html;*.htm;*.pdf;" 
									   buttonText="添加文件" formId="uploadForm"  onUploadSuccess="onUploadSuccess"
									   uploader="jformInnerMailController.do?saveFile" ></t:upload></div></td></tr>
					        </table>
						</td>
					</tr>
					
					<tr>
						<td align="right">
							<label class="Validform_label">
								内容:
							</label>
						</td>
						<td class="value">
					    		 <div style="display: none;"><input id="content" name="content" type="hidden"></div>
							  	 <script id="mailcontent" type="text/plain" style="width:100%;" ></script>
							  	 <script type="text/javascript">
							        	var editor = UE.getEditor('mailcontent',{
							        	    toolleipi:true,//是否显示，设计器的 toolbars
							        	    textarea: 'design_content',   
							        	    //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个/*
							        	    wordCount:false,
							        	    elementPathEnabled:false,
							        	    initialFrameHeight:300
							        	});
								 </script>
								<span class="Validform_checktip"></span>
								<label class="Validform_label" style="display: none;">邮件内容</label>
					    </td>
					</tr>
					<tr>
						<td height="50px" align="left" colspan="2">
							<a style="margin-left:80px" href="#" class="easyui-linkbutton l-btn"  plain="true" iconcls="icon-save" onclick="save('00')" id="">存草稿</a>
							<a href="#" class="easyui-linkbutton l-btn"  plain="true" iconcls="icon-redo" onclick="save('01')" id="">发送</a>
						</td>
					</tr>
			</table>
		</t:formvalid>
		<form id="uploadForm">
		  <input id="mailId" name="mailId" type="hidden" value="${jformInnerMailPage.id }">
		</form>
 </body>
 <script type="text/javascript">
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
						$(obj).closest("td").hide("slow");
					}
				}
			});  
		}, function(){
		});
	}
</script>
