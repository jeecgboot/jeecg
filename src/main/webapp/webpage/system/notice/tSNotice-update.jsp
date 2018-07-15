<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>common.notice</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
  <script type="text/javascript" charset="utf-8" src="plug-in/ueditor/ueditor.all.js"> </script>
  <script type="text/javascript">
  //编写自定义JS代码
    function setContent(){
	    if(editor.queryCommandState( 'source' ))
	    	editor.execCommand('source');//切换到编辑模式才提交，否则有bug
	            
	    if(editor.hasContents()){
	    	editor.sync();
		    $("#noticeContent").val(editor.getContent());
		}
	}
  
  function dataytpeSelect(name) {
        $("#roleName").removeAttr('datatype');
        $("#roleName_span").hide()
        $("#userName").removeAttr('datatype');
        $("#userName_span").hide()
        if (name){
            $("#"+name).attr('datatype','*');
            $("#"+name+"_span").show()
		}
    }

  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="noticeController.do?doUpdate" tiptype="1" beforeSubmit="setContent()">
					<input id="id" name="id" type="hidden" value="${tSNoticePage.id }">
		<table style="width: 100%;" cellpadding="0" cellspacing="1" class="formtable">
					<tr>
						<td align="right">
							<label class="Validform_label" >
								标题:
							</label>
						</td>
						<td class="value">
						     	 <input id="noticeTitle" name="noticeTitle" type="text" style="width: 95%" class="inputxt"    value='${tSNoticePage.noticeTitle}'>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">通知标题</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label">
								内容:
							</label>
						</td>
						<td class="value">
								<input id="noticeContent" name="noticeContent" type="hidden" value='${tSNoticePage.noticeContent}'>
								<script id="content" type="text/plain" style="width:95%" value='${tSNoticePage.noticeContent}'></script>
						  	 	<script type="text/javascript">
						  	 	var editor = UE.getEditor('content',{
					        	    toolleipi:true,//是否显示，设计器的 toolbars
					        	    textarea: 'design_content',   
					        	    //这里可以选择自己需要的工具按钮名称,此处仅选择如下五个/*
					        	    toolbars: [[
					        	    'fullscreen', 'source', '|', 'undo', 'redo', '|',
					        	    'fontfamily', 'fontsize', '|', 'indent', '|',
					        	    'justifyleft', 'justifycenter', 'justifyright', 'justifyjustify', '|', 
					        	    'inserttable', 'deletetable', 'insertparagraphbeforetable', 'insertrow', 'deleterow', '|',
					        	    ]],
					        	    wordCount:false,
					        	    elementPathEnabled:false,
					        	    initialFrameHeight:400
					        	});
						  	 	editor.ready(function() {
						  	 		editor.setContent($('#noticeContent').val());
						  	    });
							 </script>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">通知公告内容</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label" >
								类型:
							</label>
						</td>
						<td class="value">
						     	<%--  <input type="radio" name="noticeType" value="1" datatype="*"  <c:if test="${tSNoticePage.noticeType=='1'}">checked="checked"</c:if> 
						     	 <c:if test="${empty tSNoticePage.noticeType}">checked="checked"</c:if> />通知 --%>
         				    <input type="radio" name="noticeType" value="2" checked="checked" />公告
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">类型</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label" style="white-space:nowrap;">
								授权级别:
							</label>
						</td>
						<td class="value">
						     	 <input type="radio" onclick="dataytpeSelect()" id="noticeLevel" name="noticeLevel" value="1" datatype="*"  <c:if test="${tSNoticePage.noticeLevel=='1'}">checked="checked"</c:if>
						     	 <c:if test="${empty tSNoticePage.noticeLevel}">checked="checked"</c:if> />全员
         				&nbsp;&nbsp;<br/><input type="radio" onclick="dataytpeSelect('roleName')" name="noticeLevel" value="2" <c:if test="${tSNoticePage.noticeLevel=='2'}">checked="checked"</c:if> />角色授权

							<span id="roleName_span" <c:if test="${tSNoticePage.noticeLevel!='2'}">style="display: none"</c:if>>
							<input name="roleid" name="roleid" type="hidden" value="${rolesid}" id="roleid">
							<input name="roleName" class="inputxt" value="${rolesName }" id="roleName" readonly="readonly" />
							<t:choose hiddenName="roleid" hiddenid="id" url="userController.do?roles" name="roleList"
									  icon="icon-search" title="common.role.list" textname="roleName" isclear="true" isInit="true"></t:choose>
         				&nbsp;&nbsp;
							</span>
								<br/><input type="radio" onclick="dataytpeSelect('userName')" name="noticeLevel" value="3" <c:if test="${tSNoticePage.noticeLevel=='3'}">checked="checked"</c:if> />用户授权
							<span id="userName_span" <c:if test="${tSNoticePage.noticeLevel!='3'}">style="display: none"</c:if>>
							<input name="userid" name="userid" type="hidden" value="${usersid}" id="userid">
							<input name="userName" class="inputxt" value="${usersName }" id="userName" readonly="readonly" />
							<t:choose hiddenName="userid" hiddenid="id" url="noticeAuthorityUserController.do?selectUser" name="userList"
									  icon="icon-search" title="common.user.list" textname="userName" isclear="true" isInit="true"></t:choose>
						</span>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">授权级别</label>
						</td>
					</tr>
					<tr>
						<td align="right">
							<label class="Validform_label" style="white-space:nowrap;">
								阅读期限:
							</label>
						</td>
						<td class="value">
						     <input type="text" class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})"  style="width: 150px" id="noticeTerm" 
						     name="noticeTerm" ignore="ignore" value="<fmt:formatDate value='${tSNoticePage.noticeTerm}' type="date" pattern="yyyy-MM-dd"/>"> 		  
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">阅读期限</label>
						</td>
					</tr>
			</table>
		</t:formvalid>
 </body>
	