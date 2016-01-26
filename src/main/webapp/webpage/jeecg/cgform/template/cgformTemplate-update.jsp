<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>Online表单风格</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="cgformTemplateController.do?doUpdate" tiptype="1">
				<input id="id" name="id" type="hidden" value="${cgformTemplatePage.id }">
				<input id="createName" name="createName" type="hidden" value="${cgformTemplatePage.createName }">
				<input id="createBy" name="createBy" type="hidden" value="${cgformTemplatePage.createBy }">
				<input id="createDate" name="createDate" type="hidden" value="${cgformTemplatePage.createDate }">
				<input id="updateName" name="updateName" type="hidden" value="${cgformTemplatePage.updateName }">
				<input id="updateBy" name="updateBy" type="hidden" value="${cgformTemplatePage.updateBy }">
				<input id="updateDate" name="updateDate" type="hidden" value="${cgformTemplatePage.updateDate }">
				<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${cgformTemplatePage.sysOrgCode }">
				<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${cgformTemplatePage.sysCompanyCode }">
	  <div style="float: left;height: 99%;width: 30%;margin-top: 20px">
		  <img id="prePic" src="" alt="预览图" width="99%" height="200px" />
		  <a class="easyui-linkbutton" href="javascript:void(0)" onclick="uploadPic()">上传</a>

	  </div>
	  <div style="float: right;height: 99%;width:70%">
		  <table style="width: 100%;height: 100%" cellpadding="0" cellspacing="1" class="formtable">

			  <tr>
				  <td align="right">
					  <label class="Validform_label">
						  表单风格编码:
					  </label>
				  </td>
				  <td class="value">
					  <input disabled id="templateCode" name="templateCode" type="text" style="width: 300px" class="inputxt"
							 datatype="/\w{1,20}/i" errormsg="编码只能为字母！" value='${cgformTemplatePage.templateCode}'>
					  <span class="Validform_checktip"></span>
					  <label class="Validform_label" style="display: none;">表单风格编码</label>
				  </td>
			  </tr>
			  <tr>
				  <td align="right">
					  <label class="Validform_label" style="width: 100px">
						  表单风格名称:
					  </label>
				  </td>
				  <td class="value">
					  <input id="templateName" name="templateName" type="text" style="width: 300px" class="inputxt"
							 datatype="*" value='${cgformTemplatePage.templateName}'
							  >
					  <span class="Validform_checktip"></span>
					  <label class="Validform_label" style="display: none;">表单风格名称</label>
				  </td>
			  </tr>
			  <tr>
				  <td align="right" >
					  <label class="Validform_label">
						  类型:
					  </label>
				  </td>
				  <td class="value"  >
					  <select id="templateType" name="templateType"  onclick="changeTemplate(this)">
						  <option value="1" <c:if test="${cgformTemplatePage.templateType eq '1'}"> selected='selected'</c:if>>单表</option>
						  <option value="2" <c:if test="${cgformTemplatePage.templateType eq '2'}"> selected="selected"</c:if>>主子表</option>
					  </select>
					  <span class="Validform_checktip"></span>
					  <label class="Validform_label" style="display: none;">类型</label>
				  </td>
			  </tr>
			 <%-- <tr>
				  <td align="right"  style="display: none">
					  <label class="Validform_label">
						  模板类型:
					  </label>
				  </td>
				  <td class="value"  style="display: none">
					  <t:dictSelect field="templateType" type="list"
									typeGroupCode="smsTplType" defaultVal="${cgformTemplatePage.templateType}"
									hasLabel="false" title="模板类型"></t:dictSelect>
					  <span class="Validform_checktip"></span>
					  <label class="Validform_label" style="display: none;">模板类型</label>
				  </td>
			  </tr>
			  <tr>
				  <td align="right"  style="display: none">
					  <label class="Validform_label">
						  是否共享:
					  </label>
				  </td>
				  <td class="value" style="display: none" >
					  <t:dictSelect field="templateShare" type="radio"
									typeGroupCode="sf_yn" defaultVal="${cgformTemplatePage.templateShare}"
									hasLabel="false" title="是否共享"></t:dictSelect>
					  <span class="Validform_checktip"></span>
					  <label class="Validform_label" style="display: none;">是否共享</label>
				  </td>
			  </tr>--%>
			  <tr>
				  <td align="right">
					  <label class="Validform_label">
						  预览图：
					  </label>
				  </td>
				  <td class="value" >
					  <span id="templatePicspan"><input type="file" name="templatePic_u" id="templatePic_u" /></span>
					  <input type="hidden" id="templatePic" name="templatePic" value="${cgformTemplatePage.templatePic}" />
					  <div class="form" id="picDiv" ></div>
					  <span class="Validform_checktip"></span>
					  <label class="Validform_label" style="display: none;">预览图</label>
				  </td>
			  </tr>

			  <tr>
				  <td align="right">
					  <label class="Validform_label">
						  上传风格模板:
					  </label>
				  </td>
				  <td class="value" >
					  <t:upload id="templateZip"   buttonText="浏览文件" multi="false" name="templateZip" uploader="cgformTemplateController.do?uploadZip" onUploadSuccess="uploadZipSuccess" extend="*.zip;*.rar"></t:upload>
					  <div class="form" id="filediv" ></div>
					  <span class="Validform_checktip"></span>
					  <label class="Validform_label" style="display: none;">表单风格模板</label>
					  <input type="hidden" id="templateZipName" name="templateZipName" />
				  </td>

			  </tr>
			  <tr>
				  <td align="right">
					  <label class="Validform_label">
						  风格描述:
					  </label>
				  </td>
				  <td class="value">
                    <textarea style="width:400px;" class="inputxt" rows="6" id="templateComment"
							  name="templateComment">${cgformTemplatePage.templateComment}</textarea>
					  <span class="Validform_checktip"></span>
					  <label class="Validform_label" style="display: none;">表单风格描述</label>
				  </td>
			  </tr>
			  <tr>
				  <td align="right">
					  <label class="Validform_label" style="width: 100px">
						  自定义OL模板 - 列表页面:
					  </label>
				  </td>
				  <td class="value">
					  <input id="templateListName" name="templateListName" value="${cgformTemplatePage.templateListName}" type="text" style="width: 400px" class="inputxt"
							 datatype="*" errormsg="自定义OL模板 -  列表页面不能为空！" nullmsg="自定义OL模板 -  列表页面不能为空!">
					  <span class="Validform_checktip"></span>
					  <label class="Validform_label" style="display: none;">列表页面文件名</label>
				  </td>
			  </tr>
			  <tr>
				  <td align="right">
					  <label class="Validform_label" style="width: 100px">
						    自定义OL模板 -  添加页面:
					  </label>
				  </td>
				  <td class="value">
					  <input id="templateAddName" name="templateAddName" value="${cgformTemplatePage.templateAddName}" type="text" style="width: 400px" class="inputxt"
							 datatype="*" errormsg="自定义OL模板 -  添加页面不能为空！" nullmsg="自定义OL模板 -  添加页面不能为空!"
							  >
					  <span class="Validform_checktip"></span>
					  <label class="Validform_label" style="display: none;">自定义OL模板 -  添加页面</label>
				  </td>
			  </tr>
			  <tr>
				  <td align="right">
					  <label class="Validform_label" style="width: 100px">
						  自定义OL模板 -  编辑页面:
					  </label>
				  </td>
				  <td class="value">
					  <input id="templateUpdateName" name="templateUpdateName" value="${cgformTemplatePage.templateUpdateName}" type="text" style="width: 400px" class="inputxt"
							 datatype="*" errormsg="自定义OL模板 -  编辑页面不能为空！" nullmsg="自定义OL模板 -  编辑页面不能为空!"
							  >
					  <span class="Validform_checktip"></span>
					  <label class="Validform_label" style="display: none;">自定义OL模板 -  编辑页面</label>
				  </td>
			  </tr>
			  <tr>
				  <td align="right">
					  <label class="Validform_label" style="width: 100px">
						 自定义OL模板 -  查看页面:
					  </label>
				  </td>
				  <td class="value">
					  <input id="templateDetailName" name="templateDetailName" value="${cgformTemplatePage.templateDetailName}" type="text" style="width: 400px" class="inputxt"
							 datatype="*" errormsg="自定义OL模板 -  查看页面不能为空！" nullmsg="自定义OL模板 -  查看页面不能为空!"
							  >
					  <span class="Validform_checktip"></span>
					  <label class="Validform_label" style="display: none;">自定义OL模板 - 查看页面</label>
				  </td>
			  </tr>
		  </table>
	  </div>

		</t:formvalid>
 </body>
  <script src = "webpage/jeecg/cgform/template/cgformTemplate.js"></script>
 <script>
	 $(function () {
		 $("#prePic").attr("src","cgformTemplateController.do?showPic&path=${cgformTemplatePage.templatePic}&code=${cgformTemplatePage.templateCode}");
		 $('#templatePic_u').uploadify({buttonText:'浏览',
			 progressData:'speed',
			 multi:false,
			 height:25,
			 overrideEvents:['onDialogClose'],
			 fileTypeDesc:'文件格式:',
			 fileTypeExts:'*.jpg;*,jpeg;*.png;*.gif;*.bmp;*.ico;*.tif',
			 fileSizeLimit:'15MB',
			 swf:'plug-in/uploadify/uploadify.swf',
			 uploader:'cgformTemplateController.do?uploadPic&sessionId=${pageContext.session.id}',
			 auto:false,
			 onUploadSuccess : function(file, data, response) {
				 if(data){
					 var d=$.parseJSON(data);
					 if(d.success){
						 $("#prePic").attr("src","cgformTemplateController.do?showPic&path="+ d.obj);
						 $("#templatePic").val(d.obj);
					 }
				 }

			 }
		 });

		 $('#templateZip').uploadify({buttonText:'浏览文件',
			 progressData:'speed',
			 multi:false,
			 height:25,
			 overrideEvents:['onDialogClose'],
			 fileTypeDesc:'文件格式:',
			 fileTypeExts:'*.zip',
			 fileSizeLimit:'15MB',
			 swf:'plug-in/uploadify/uploadify.swf',
			 uploader:'cgformTemplateController.do?uploadZip&sessionId=${pageContext.session.id}',
			 auto:false,
			 onSelect: function (file) {
				 hasZipFile++;
			 },
			 onCancel : function(file) {
				 hasZipFile--;
			 },
			 onUploadSuccess : function(file, data, response) {
				 if(data){
					 var d=$.parseJSON(data);
					 if(d.success){
						 $("#templateZipName").val(d.obj);
						 $("#formobj").submit();
					 }
				 }

			 }
		 });
	 });
	 var hasZipFile=0;
	 //验证编码唯一性
	 function checkCode(){
		 var flag=false;
		 $.ajax({
			 url:"${pageContext.request.contextPath}/cgformTemplateController.do?checkCode",
			 data:{"param":$("#templateCode").val()},
			 dataType:"json",
			 async:false,
			 type:"post",
			 success: function (data) {
				 flag=data.success;
			 }
		 })
		 if(!flag) {
			 $.messager.alert('错误', "编码不能重复！");
			 return false;
		 }
		 return flag;
	 }
	 function uploadZip(){
		 var tCode=$("#templateCode").val();
		 if("default"==tCode){
			 $.messager.alert('错误', "编码不能default,请重新输入！");
			 return false;
		 }
		 if($("#formobj").Validform().check()) {
			 if (hasZipFile<=0) {
				 $("#formobj").submit();
			 }else
			 	$('#templateZip').uploadify("upload","*");
		 }
	 }
 </script>