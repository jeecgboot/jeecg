<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#include "../../ui/datatype.ftl"/>
<#include "../../ui/dictInfo.ftl"/>
<link rel="stylesheet" href="plug-in/themes/fineui/css/mainform.css" type="text/css"/>
<style>
.conc-wrapper input:not([type='radio']){
width:95%;
}
.conc-wrapper select{
width:95% !important;
}
</style>

<div style="margin: 0 15px;overflow: auto;">
<div class="conc-wrapper" style="margin-top:10px">
	<#list pageColumns as po>
	<#-- 4个字段为一行，2行一个模块 -->
		<#-- 模块头部开始 -->
			<#if po_index%8==0>
			<#assign index_m = po_index>
			<div class="main-tab">
				<ul class="tab-info">
				  <li role="presentation" class="active">
					<a href="javascript:void(0);"> &nbsp;&nbsp;信息模块${(po_index/8)+1}</a>
				  </li>
				</ul>
				<!-- tab内容 -->
				<div class="con-wrapper1">
				  <div class="row form-wrapper">
			</#if>
		<#-- 模块头部结束 -->
		<#-- 行头部开始 -->
			<#if po_index%4==0>
			<#assign index_h = po_index>
			<div class="row show-grid">
			</#if>
		<#-- 行头部结束 -->
		
		<#-- 字段内容开始 -->
		<div class="col-xs-1 text-center">
			<b>${po.content}：</b>
		</div>
		<div class="col-xs-2">
			<#if po.showType=='text'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<input id="${po.fieldName}" name="${po.fieldName}" type="text" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' />
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
		   <#elseif po.showType=='popup'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<#-- update--begin--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
				<input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" class="searchbox-inputtext" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> <#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictField}','${po.dictTable}')"</#if>  value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/> 
				<#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
			<#elseif po.showType=='textarea'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<textarea id="${po.fieldName}" class="form-control" rows="6" name="${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />>${'$'}{${entityName?uncap_first}Page.${po.fieldName}}</textarea>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
			<#elseif po.showType=='password'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<input id="${po.fieldName}" name="${po.fieldName}" type="password" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' />
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
			<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>	 
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<t:dictSelect field="${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'form-control',style:'width:150px'}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
			<#elseif po.showType=='date'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<input id="${po.fieldName}" name="${po.fieldName}" type="text"  <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;"  class="form-control" onClick="WdatePicker()" value="<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type='date' pattern='yyyy-MM-dd'/>" />
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
			<#elseif po.showType=='datetime'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<input id="${po.fieldName}" name="${po.fieldName}" type="text" style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;" class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>  value="<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type='date' pattern='yyyy-MM-dd hh:mm:ss'/>" />
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
		   <#elseif po.showType=='file' || po.showType == 'image'>
				<table id="${fieldMeta[po.fieldName]?lower_case}_fileTable"></table>
				<#if !(po.operationCodesReadOnly ??)>
					<#assign fileName = fileName + "${po.fieldName}," />
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
								queueID:'filediv_${po.fieldName}',
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
									 var win = frameElement.api.opener;
									 win.reloadTable();
									 win.tip(serverMsg);
									 frameElement.api.close();
								},
								onUploadSuccess : function(file, data, response) {
									var d=$.parseJSON(data);
									if(d.success){
										var win = frameElement.api.opener;
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
				<textarea name="${po.fieldName}" id="${po.fieldName}" style="width: 650px;height:300px">${'$'}{${entityName?uncap_first}Page.${po.fieldName} }</textarea>
				<script type="text/javascript">
					<#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
					var ${po.fieldName}_editor = UE.getEditor('${po.fieldName}');
					<#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
				</script>
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
				<input id="${po.fieldName}" name="${po.fieldName}" type="text" style="width: 150px" class="form-control"  <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>   value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/>
			</#if>
			<span class="Validform_checktip" style="float:left;height:0px;"></span>
			<label class="Validform_label" style="display: none">${po.content?if_exists?html}</label>
		</div>
		<#-- 字段内容结束 -->
		
		<#-- 行尾部开始 -->
			<#if ((po_index+1)%4==0 && (index_h+4)==(po_index+1)) || !po_has_next>
			</div>
			</#if>
		<#-- 行尾部结束 -->
		
		<#-- 模块尾部开始 -->
			<#if ((po_index+1)%8==0 && (index_m+8)==(po_index+1)) || !po_has_next>
					</div>
				</div>
			</div>
			</#if>
		<#-- 模块尾部结束 -->
	</#list>
	<#list pageAreatextColumns as po>
			<#if po_index%2==0>
			<#assign index_a = po_index>
			<div class="main-tab">
				<ul class="tab-info">
				  <li role="presentation" class="active">
					<a href="javascript:void(0);"> &nbsp;&nbsp;其他信息${po_index+1}</a>
				  </li>
				</ul>
				<!-- tab内容 -->
				<div class="con-wrapper1">
				  <div class="row form-wrapper">
				  <div class="row show-grid">
			</#if>
		
		<div class="col-xs-1 text-center">
			<b>${po.content}：</b>
		</div>
		<div class="col-xs-5">
			<#if po.showType=='textarea'>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
				<textarea id="${po.fieldName}" class="form-control" rows="6" name="${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />>${'$'}{${entityName?uncap_first}Page.${po.fieldName}}</textarea>
				<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
			<#elseif po.showType='umeditor'>
				<#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
				<#assign ue_widget_count = ue_widget_count + 1>
				<#if ue_widget_count == 1>
				<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
				<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
				</#if>
				<textarea name="${po.fieldName}" id="${po.fieldName}" style="width: 650px;height:300px">${'$'}{${entityName?uncap_first}Page.${po.fieldName} }</textarea>
				<script type="text/javascript">
					var ${po.fieldName}_editor = UE.getEditor('${po.fieldName}');
				</script>
			</#if>
			<span class="Validform_checktip" style="float:left;height:0px;"></span>
			<label class="Validform_label" style="display: none">${po.content?if_exists?html}</label>
		</div>
			<#if (po_index%2==0 && po_index==(index_a+2)) || !po_has_next>
			</div></div></div></div>
			</#if>
	</#list>
	
</div>
</div>
<script type="text/javascript">
   $(function(){
	    //查看模式情况下,删除和上传附件功能禁止使用
		if(location.href.indexOf("load=detail")!=-1){
			$(".jeecgDetail").hide();
			$("input,select,textarea").attr("disabled","disabled");
		}
   });
</script>