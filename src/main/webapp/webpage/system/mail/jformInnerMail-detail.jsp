<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
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
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table"  tiptype="1" >
					<input id="id" name="id" type="hidden" value="${jformInnerMailPage.id }">
					<input id="createName" name="createName" type="hidden" value="${jformInnerMailPage.createName }">
					<input id="createBy" name="createBy" type="hidden" value="${jformInnerMailPage.createBy }">
					<input id="createDate" name="createDate" type="hidden" value="${jformInnerMailPage.createDate }">
					<input id="status" name="status" type="hidden" value="${jformInnerMailPage.status }">
					<input id="receiverIds" name="receiverIds" type="hidden" value="${jformInnerMailPage.receiverIds }">
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right">
							<label class="Validform_label">
								收件人:
							</label>
						</td>
						<td class="value">
								 <input name="pageReceiverIds" type="hidden" value="${id}" id="pageReceiverIds">
						     	 <input name="receiverNames" class="inputxt" value="${realName }" id="realName" readonly="readonly" datatype="*" />
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
						     	 <input id="title" name="title" type="text" style="width: 150px" class="inputxt"  readonly="readonly" value='${jformInnerMailPage.title}'>
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
											<td><a href="commonController.do?viewFile&fileid=${vdocument.id}&subclassname=org.jeecgframework.web.system.pojo.base.JformInnerMailAttach" title="下载">${vdocument.attachmenttitle}.${vdocument.extend}</a></td>
									</c:forEach>
								</tr>
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
							  	 <script id="mailcontent" type="text/plain" style="width:100%;" ></script>
							  	 <script type="text/javascript">
							        	var editor = UE.getEditor('mailcontent',{
							        	    toolleipi:true,//是否显示，设计器的 toolbars
							        	    toolbars:[['FullScreen', 'Source', 'Undo', 'Redo','bold','test']],
							        	    textarea: 'design_content',   
							        	    //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个/*
							        	    wordCount:false,
							        	    elementPathEnabled:false,
							        	    initialFrameHeight:300,
							        	    readonly:true
							        	});
								 </script>
								<span class="Validform_checktip"></span>
								<label class="Validform_label" style="display: none;">邮件内容</label>
					    </td>
					</tr>
			</table>
		</t:formvalid>
 </body>
