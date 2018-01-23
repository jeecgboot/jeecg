<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<#include "../../ui/datatype.ftl"/>
<#include "../../ui/dictInfo.ftl"/>
<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<!DOCTYPE html>
<#assign callbackFlag = false />
<#assign fileName = "" />
<#list pageColumns as callBackTestPo>
	<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
	<#if callBackTestPo.showType=='file' || callBackTestPo.showType == 'image'>
		<#assign callbackFlag = true />
		<#break>
	</#if>
	<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
</#list>
<html>
 <head>
  <title>${ftl_description}</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <#if callbackFlag == true>
		<link rel="stylesheet" href="plug-in/uploadify/css/uploadify.css" type="text/css" />
		<script type="text/javascript" src="plug-in/uploadify/jquery.uploadify-3.1.js"></script>
		</#if>
	  <script src="plug-in/layer/layer.js"></script>
	 <script>
		function btn_ok(){
			$("#btnsub").click();
		}
		function callback(data){
			
			<#if callbackFlag == true>
		  	jeecgFormFileCallBack(data);
	  	</#if>
			
			if(data.success){
				layer.alert(data.msg, function(index){
					window.location.href="${entityName?uncap_first}Controller.do?list"
					layer.close(index);
				});       
			}
			else{
				layer.alert(data.msg);
			}
		}
	</script>
  <script type="text/javascript">
  //编写自定义JS代码
  </script>
 </head>
 <body>
  <#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
 <#assign ue_widget_count = 0>
 <#-- update--end--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
		<t:formvalid formid="formobj" dialog="false" usePlugin="password" layout="table" action="${entityName?uncap_first}Controller.do?doUpdate" tiptype="1" callback="callback">
			<#list columns as po>
				<#if po.isShow == 'N'>
					<#-- update--begin--author:zhoujf date:20170622 for:TASK #1967 【代码生成器优化】online生成代码，无用太多，简化代码(1. 系统标准字段，表单页面，添加和修改页面，不生成隐藏字段) -->
					<#if po.fieldName == 'id'>
					<input id="${po.fieldName}" name="${po.fieldName}" type="hidden" value="${'$'}{${entityName?uncap_first}Page.${po.fieldName} }"/>
					</#if>
					<#-- update--end--author:zhoujf date:20170622 for:TASK #1967 【代码生成器优化】online生成代码，无用太多，简化代码(1. 系统标准字段，表单页面，添加和修改页面，不生成隐藏字段) -->
				</#if>
			</#list>
		<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
			<#list pageColumns as po>
				<#if (pageColumns?size>10)>
					<#if po_index%2==0>
					<tr>
					</#if>
					<#else>
					<tr>
				</#if>
						<td align="right">
							<label class="Validform_label">
								${po.content}:
							</label>
						</td>
						<td class="value">
							<#if po.showType=='text'>
									<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						     	 <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/> value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/>
						    	<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						    <#elseif po.showType=='popup'>
						    	<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
								<input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/><#if po.dictTable?if_exists?html!=""> onclick="inputClick(this,'${po.dictField}','${po.dictTable}')"</#if> value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/>
						    	<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						    <#elseif po.showType=='textarea'>
						  	 	<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						  	 	<textarea id="${po.fieldName}" style="width:600px;" class="inputxt" rows="6" name="${po.fieldName}"  <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>>${'$'}{${entityName?uncap_first}Page.${po.fieldName}}</textarea>
						     	<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						     <#elseif po.showType=='password'>
						     		<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						      		<input id="${po.fieldName}" name="${po.fieldName}" type="password" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/> value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/>
									<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
								<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>	 
									<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
									<t:dictSelect field="${po.fieldName}" type="${po.showType?if_exists?html}"<@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" inputCheck="2"/> defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
									<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
								<#elseif po.showType=='date'>
									 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
									   <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" class="Wdate" onClick="WdatePicker()" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value='<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type="date" pattern="yyyy-MM-dd"/>'/>
						      		<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						      	<#elseif po.showType=='datetime'>
									 <#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
									   <input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value='<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>'/>
						      			<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						      	<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
						      	<#elseif po.showType=='file' || po.showType == 'image'>
						      	<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
									<#-- update--begin--author:zhangjiaqiang date:20170531 for:数据回显表格ID区分 -->
									<table id="${fieldMeta[po.fieldName]?lower_case}_fileTable"></table>
									<#-- update--end--author:zhangjiaqiang date:20170531 for:数据回显表格ID区分 -->
									<#if !(po.operationCodesReadOnly ??)>
									<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
										<#assign fileName = fileName + "${po.fieldName}," />
										<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
										<table></table>
										<script type="text/javascript">
											var serverMsg="";
											$(function(){
												$('#${po.fieldName}').uploadify({
													<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
													<#if po.showType == 'image'>
													buttonText:'添加图片',
													<#else>
													buttonText:'添加文件',
													</#if>
													<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
													auto:false,
													progressData:'speed',
													multi:true,
													height:25,
													overrideEvents:['onDialogClose'],
													fileTypeDesc:'文件格式:',
													<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
													queueID:'filediv_${po.fieldName}',
													<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
													<#-- fileTypeExts:'*.rar;*.zip;*.doc;*.docx;*.txt;*.ppt;*.xls;*.xlsx;*.html;*.htm;*.pdf;*.jpg;*.gif;*.png',   页面弹出很慢解决 20170317 scott -->
													fileSizeLimit:'15MB',
													swf:'plug-in/uploadify/uploadify.swf',	
													uploader:'cgUploadController.do?saveFiles&jsessionid='+$("#sessionUID").val()+'',
													onUploadStart : function(file) { 
														var cgFormId=$("input[name='id']").val();
														$('#${po.fieldName}').uploadify("settings", "formData", {
															'cgFormId':cgFormId,
															'cgFormName':'${tableName}',
															'cgFormField':'${fieldMeta[po.fieldName]}'
														});
													} ,
													onQueueComplete : function(queueData) {
													},
													onUploadSuccess : function(file, data, response) {
														var d=$.parseJSON(data);
														if(d.success){
															serverMsg = d.msg;
														}
													},
													onFallback: function() {
									                    tip("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试")
									                },
									                onSelectError: function(file, errorCode, errorMsg) {
									                    switch (errorCode) {
									                    case - 100 : tip("上传的文件数量已经超出系统限制的" + $('#file').uploadify('settings', 'queueSizeLimit') + "个文件！");
									                        break;
									                    case - 110 : tip("文件 [" + file.name + "] 大小超出系统限制的" + $('#file').uploadify('settings', 'fileSizeLimit') + "大小！");
									                        break;
									                    case - 120 : tip("文件 [" + file.name + "] 大小异常！");
									                        break;
									                    case - 130 : tip("文件 [" + file.name + "] 类型不正确！");
									                        break;
									                    }
									                },
									                onUploadProgress: function(file, bytesUploaded, bytesTotal, totalBytesUploaded, totalBytesTotal) {}
												});
											});
										</script>
										<span id="file_uploadspan"><input type="file" name="${po.fieldName}" id="${po.fieldName}" /></span> 
										<div class="form" id="filediv_${po.fieldName}"></div>
									</#if>
								<#--update-start--Author: jg_huangxg  Date:20160421 for：TASK #1027 【online】代码生成器模板不支持UE编辑器 -->
								<#elseif po.showType='umeditor'>
									<#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
									<#assign ue_widget_count = ue_widget_count + 1>
									<#if ue_widget_count == 1>
									<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
									<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
									</#if>
									<#-- update--end--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
							<#--update-start--Author: dangzhenghui  Date:20170510 for：TASK #1899 【代码生成器bug】控件类型为UE编辑器 ,编辑页面内容显示为空-->
                                <textarea name="${po.fieldName}" id="${po.fieldName}" style="width: 650px;height:300px">${'$'}{${entityName?uncap_first}Page.${po.fieldName} }</textarea>
							<#--update-end--Author: dangzhenghui  Date:20170510 for：TASK #1899 【代码生成器bug】控件类型为UE编辑器 ,编辑页面内容显示为空-->
									<script type="text/javascript">
								        <#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
								        var ${po.fieldName}_editor = UE.getEditor('${po.fieldName}');
								        <#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
								    </script>
								<#--update-end--Author: jg_huangxg  Date:20160421 for：TASK #1027 【online】代码生成器模板不支持UE编辑器 -->
								 <#-- update--begin--author:zhangjiaqiang date:20170815 for:TASK #2274 【online】Online 表单支持树控件 -->
							<#elseif po.showType=='tree'>
								<input id="${po.fieldName}" ${po.extendJson?if_exists}  type="text"
							       style="width: 150px" class="inputxt" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>
					               onclick="show${po.fieldName?cap_first }Tree();" readonly="readonly">
					               <input type="hidden" id="${po.fieldName}Id" name="${po.fieldName}"  class="show${po.fieldName?cap_first}">  
									<div id="show${po.fieldName?cap_first }TreeContent" class="menuContent" style="display: none; position: absolute; border: 1px #CCC solid; background-color: #F0F6E4;z-index:9999;">  
									    <ul id="show${po.fieldName?cap_first }Tree" class="ztree" style="margin-top:0;"></ul>  
									</div>
								<script>
									$(function(){
										if(!$.fn.zTree){
											$("head").append('<link rel="stylesheet" href="plug-in/ztree/css/zTreeStyle.css"/>');
											$("head").append('<script type=\"text/javascript\" src=\"plug-in/ztree/js/jquery.ztree.core-3.5.min.js\"><\/script>');
											$("head").append('<script type=\"text/javascript\" src=\"plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js\"><\/script>');
										}
										var defaultVal = $("#${po.fieldName}Id").val();
										$("#${po.fieldName}").val(getTreeResult(defaultVal));
										$("body").bind("mousedown", onBodyDownBy${po.fieldName?cap_first });  
									});
									
									var ${po.fieldName}Setting = {  
										   check: {  
								                enable: true
									        }, 
										    view: {  
										        dblClickExpand: false  
										    },  
										    data: {  
										        simpleData: {  
										            enable: true  
										        },
										        key:{
										        	name:'text'
										        }
										    },  
										    callback: {  
										        onClick: ${po.fieldName}OnClick,
										        onCheck: ${po.fieldName}OnCheck
										    }   
										}; 
									function ${po.fieldName}OnCheck(e, treeId, treeNode) { 
										    var idVal = $("#${po.fieldName}Id").val();
										    var textVal = $("#${po.fieldName}").val();
										    if(treeNode.checked){
										    	//选中
										    	if(idVal != null && idVal != ''){
										    		$("#${po.fieldName}Id").val(idVal + ',' +treeNode.id);  
											    }else{
												    $("#${po.fieldName}Id").val(treeNode.id);  
											    }
											    if(textVal != null && textVal != ''){
											    	 $("#${po.fieldName}").val(textVal + ',' + treeNode.text);  
											    }else{
												    $("#${po.fieldName}").val(treeNode.text);  
											    }
										    }else{
										    	idVal = idVal.replace(treeNode.id,"");
										    	if(idVal.indexOf(",") == 0){
										    		idVal = idVal.substring(1);
										    	}else if(idVal.indexOf(",,") > -1){
										    		idVal = idVal.replace(",,",",");
										    	}else if(idVal.indexOf(",") == idVal.length -1){
										    		idVal = idVal.substring(0,idVal.length - 1);
										    	}
										    	textVal = textVal.replace(treeNode.text,"");
										    	if(textVal.indexOf(",") == 0){
										    		textVal = textVal.substring(1);
										    	}else if(textVal.indexOf(",,") > -1){
										    		textVal = textVal.replace(",,",",");
										    	}else if(textVal.indexOf(",") == textVal.length -1){
										    		textVal = textVal.substring(0,textVal.length - 1);
										    	}
										    	$("#${po.fieldName}").val(textVal);
										    	 $("#${po.fieldName}Id").val(idVal);
										    }
										    e.stopPropagation();
										}  
									function ${po.fieldName}OnClick(e, treeId, treeNode) {  
										    var zTree = $.fn.zTree.getZTreeObj("show${po.fieldName?cap_first }Tree");  
										  	zTree.checkNode(treeNode, !treeNode.checked, true,true);
										  	e.stopPropagation();
										}    
									function show${po.fieldName?cap_first }Tree(){
										 $.ajax({  
									        url:'categoryController.do?tree',  
									        type:'POST',  
									        dataType:'JSON',
									        async:false,  
									         data:{
									        	selfCode:'${po.dictField}'
									        },
									        success:function(res){
									            var obj = res; 
									            $.fn.zTree.init($("#show${po.fieldName?cap_first }Tree"), ${po.fieldName}Setting, obj);  
									            var deptObj = $("#${po.fieldName}");  
									            var deptOffset = $("#${po.fieldName}").offset();  
									            $("#show${po.fieldName?cap_first }TreeContent").css({left:deptOffset.left + "px", top:deptOffset.top + deptObj.outerHeight() + "px"}).slideDown("fast");  
									            $('#show${po.fieldName?cap_first }Tree').css({width:deptObj.outerWidth() - 12 + "px"});  
									            var zTree = $.fn.zTree.getZTreeObj("show${po.fieldName?cap_first }Tree");  
									            var idVal =  $("#${po.fieldName}Id").val();
									            if(idVal != null && idVal != ''){
										             if(idVal.indexOf(",") > -1){
										            	var idArray = idVal.split(",");
										            	for(var i = 0; i < idArray.length; i++){
										            		var node = zTree.getNodeByParam("id", idArray[i], null);
										            		zTree.checkNode(node, true, true);
										            	}
										            }else{
										            	var node = zTree.getNodeByParam("id", idVal, null);
										            		zTree.checkNode(node, true, true);
										            } 
									            } 
									            
									        }  
									    });  
									    }
									    function onBodyDownBy${po.fieldName?cap_first }(event){
									    	if(event.target.id == '' || (event.target.id.indexOf('switch') == -1 
										    	&& event.target.id.indexOf('check') == -1 
										    	&& event.target.id.indexOf('span') == -1
										    	&& event.target.id.indexOf('ico') == -1)){  
										    	$("#show${po.fieldName?cap_first }TreeContent").fadeOut("fast");  
	   											 //$("body").unbind("mousedown", onBodyDownBy${po.fieldName?cap_first });
   											 }
									    }
								</script>
								<#-- update--begin--author:zhangjiaqiang date:20170815 for:TASK #2274 【online】Online 表单支持树控件 -->
						      	<#else>
						      		<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						      		<input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/>
									<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
								</#if>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
						</td>
			<#if (pageColumns?size>10)>
				<#if (po_index%2==0)&&(!po_has_next)>
				<td align="right">
					<label class="Validform_label">
					</label>
				</td>
				<td class="value">
				</td>
				</#if>
				<#if (po_index%2!=0)||(!po_has_next)>
					</tr>
				</#if>
				<#else>
					</tr>
			</#if>
				</#list>
				<#-- update--begin--author:zhoujf Date:20170523 for:TASK #1961 【代码生成器】一对多富文本编辑器，生成代码格式问题 -->
				<#list pageAreatextColumns as po>
					<tr>
						<td align="right">
							<label class="Validform_label">
								${po.content}:
							</label>
						</td>
						<td class="value" <#if (pageColumns?size>10)> colspan="3" </#if>>
						    <#if po.showType=='textarea'>
						  	 	<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
						  	 	<textarea id="${po.fieldName}" style="width:600px;" class="inputxt" rows="6" name="${po.fieldName}"  <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>>${'$'}{${entityName?uncap_first}Page.${po.fieldName}}</textarea>
						     	<#-- update--begin--author:zhangjiaqiangDate:20170509 for:修订生成代码不美观 -->
								<#elseif po.showType='umeditor'>
									<#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
									<#assign ue_widget_count = ue_widget_count + 1>
									<#if ue_widget_count == 1>
									<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
									<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
									</#if>
									<#-- update--end--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
							<#--update-start--Author: dangzhenghui  Date:20170510 for：TASK #1899 【代码生成器bug】控件类型为UE编辑器 ,编辑页面内容显示为空-->
                                <textarea name="${po.fieldName}" id="${po.fieldName}" style="width: 650px;height:300px">${'$'}{${entityName?uncap_first}Page.${po.fieldName} }</textarea>
							<#--update-end--Author: dangzhenghui  Date:20170510 for：TASK #1899 【代码生成器bug】控件类型为UE编辑器 ,编辑页面内容显示为空-->
									<script type="text/javascript">
								        <#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
								        var ${po.fieldName}_editor = UE.getEditor('${po.fieldName}');
								        <#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
								    </script>
								</#if>
							<span class="Validform_checktip"></span>
							<label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
						</td>
					</tr>
				</#list>
				<#-- update--end--author:zhoujf Date:20170523 for:TASK #1961 【代码生成器】一对多富文本编辑器，生成代码格式问题 -->
				
				<tr>
					<td height="50px" align="center" <#if (pageColumns?size>10)> colspan="4" <#else> colspan="2" </#if>>
						<a style="margin-left:80px" href="#" class="easyui-linkbutton l-btn"  plain="true" iconcls="icon-le-back" onclick="history.go(-1)">返回</a>
						<div style="display:none"><input type="submit" id ="btnsub" value=""/></div>
						<a  href="#" class="easyui-linkbutton l-btn"  iconcls="icon-le-ok" onclick="btn_ok()">提交</a>
					</td>
				</tr>
			</table>
		</t:formvalid>
 </body>
  <script src = "webpage/${bussiPackage?replace('.','/')}/${entityPackage}/${entityName?uncap_first}.js"></script>		
  <#if callbackFlag == true>
	  	<script type="text/javascript">
		  	//加载 已存在的 文件
		  	$(function(){
		  		var cgFormId=$("input[name='id']").val();
		  		$.ajax({
		  		   type: "post",
		  		   url: "${entityName?uncap_first}Controller.do?getFiles&id=" +  cgFormId,
		  		   success: function(data){
		  			 var arrayFileObj = jQuery.parseJSON(data).obj;
		  			 
		  			$.each(arrayFileObj,function(n,file){
		  				<#-- update--begin--author:zhangjiaqiang date:20170531 for:多个附件的数据显示 -->
		  				var fieldName = file.field.toLowerCase();
		  				var table = $("#"+fieldName+"_fileTable");
		  				<#-- update--end--author:zhangjiaqiang date:20170531 for:多个附件的数据显示 -->
		  				var tr = $("<tr style=\"height:34px;\"></tr>");
		  				var td_title = $("<td>" + file.title + "</td>")
		  		  		var td_download = $("<td><a href=\"commonController.do?viewFile&fileid=" + file.fileKey + "&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity\" title=\"下载\">下载</a></td>")
		  		  		var td_view = $("<td><a href=\"javascript:void(0);\" onclick=\"openwindow('预览','commonController.do?openViewFile&fileid=" + file.fileKey + "&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)\">预览</a></td>");
		  		  		var td_del = $("<td><a href=\"javascript:void(0)\" class=\"jeecgDetail\" onclick=\"del('cgUploadController.do?delFile&id=" + file.fileKey + "',this)\">删除</a></td>");
		  		  		
		  		  		tr.appendTo(table);
		  		  		td_title.appendTo(tr);
		  		  		td_download.appendTo(tr);
		  		  		td_view.appendTo(tr);
		  		  		td_del.appendTo(tr);
		  			 });
		  		   }
		  		});
		  	});
		  	
		  		<#-- update--begin--author:zhangjiaqiang date:20170531 for:附件资源删除处理 -->
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
		  	<#-- update--end--author:zhangjiaqiang date:20170531 for:附件资源删除处理 -->
		  	
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
	  		}
	  		function upload() {
				<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
				<#assign subFileName = fileName?substring(0,fileName?length - 1) />
	  			<#list subFileName?split(",") as name>
					$('#${name}').uploadify('upload', '*');
				</#list>
				<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
			}
			
			var neibuClickFlag = false;
			function neibuClick() {
				neibuClickFlag = true; 
				$('#btn_sub').trigger('click');
			}
			function cancel() {
				<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
				<#assign subFileName = fileName?substring(0,fileName?length - 1) />
	  			<#list subFileName?split(",") as name>
					$('#${name}').uploadify('cancel', '*');
				</#list>
				<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
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
					}
				}
			}
	  	</script>
  	</#if>