<#include "/ui/datatype.ftl"/>
<#include "/ui/dictInfo.ftl"/>
<#include "/ui/tag.ftl"/>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>${ftl_description}</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">

<!-- Jquery组件引用 -->
<script src="https://cdn.bootcss.com/jquery/1.12.3/jquery.min.js"></script>

<!-- bootstrap组件引用 -->
<link href="https://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.css" rel="stylesheet">
<script src="https://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

<!-- icheck组件引用 -->
<link href="plug-in/icheck-1.x/skins/square/_all.css" rel="stylesheet">
<script type="text/javascript" src="plug-in/icheck-1.x/icheck.js"></script>

<!-- Validform组件引用 -->
<link href="plug-in/themes/bootstrap-ext/css/validform-ext.css" rel="stylesheet" />
<script type="text/javascript" src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/Validform/js/datatype_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script>
<!-- Layer组件引用 -->
<script src="plug-in/layer/layer.js"></script>
<script src="plug-in/laydate/laydate.js"></script>
<!-- 通用组件引用 -->
<link href="plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
<script src="plug-in/themes/bootstrap-ext/js/common.js"></script>
<#assign uploadFlag=0>
<#list pageColumns as po>
<#if po.showType=='file' || po.showType == 'image'>
<#assign uploadFlag=1>
<#break>
</#if>
</#list>
<#if uploadFlag==1>
<#assign fileName = "" />
<!-- 上传组件 -->
<link rel="stylesheet" href="plug-in/uploadify/css/uploadify.css" type="text/css" />
<script type="text/javascript" src="plug-in/uploadify/jquery.uploadify-3.1.js"></script>
<script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js"></script>
<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
</#if>
</head>
 <body style="overflow:hidden;margin-top: 20px">
 <form id="formobj" action="${entityName?uncap_first}Controller.do?doUpdate" class="form-horizontal validform" role="form"  method="post">
	<input type="hidden" id="btn_sub" class="btn_sub"/>
	<input type="hidden" id="id" name="id" value="${'$'}{${entityName?uncap_first}Page.id}"/>
	<#list pageColumns as po>
	<div class="form-group">
		<label for="${po.fieldName}" class="col-sm-3 control-label">${po.content}：</label>
		<div class="col-sm-7">
			<div class="input-group" style="width:100%">
			<#if po.showType=='text'>
				<input id="${po.fieldName}" name="${po.fieldName}" value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type="text" maxlength="${po.length?c}" class="form-control input-sm" placeholder="请输入${po.content}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/>/>
			<#elseif po.showType=='textarea'>
				<textarea id="${po.fieldName}" name="${po.fieldName}" class="form-control input-sm" placeholder="请输入${po.content}" rows="4">${'$'}{${entityName?uncap_first}Page.${po.fieldName}}</textarea>
			<#elseif po.showType=='password'>
				<input id="${po.fieldName}" name="${po.fieldName}" value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type="password" maxlength="${po.length?c}" class="form-control input-sm" placeholder="请输入${po.content}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
			<#elseif po.showType=='checkbox' || po.showType=='radio'>
				<t:dictSelect field="${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'i-checks'}" <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> hasLabel="false"  title="${po.content}" defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}"></t:dictSelect>
			<#elseif po.showType=='select' || po.showType=='list'>
               <t:dictSelect field="${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'form-control input-sm'}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> hasLabel="false"  title="${po.content}" defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}"></t:dictSelect>
	      	<#elseif po.showType=='date'>
      		    <input id="${po.fieldName}" name="${po.fieldName}" type="text" class="form-control input-sm" placeholder="请输入${po.content}" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="<fmt:formatDate pattern='yyyy-MM-dd' type='date' value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/>" />
                <span class="input-group-addon" >
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            <#elseif po.showType=='datetime'>
      		    <input id="${po.fieldName}" name="${po.fieldName}" type="text" class="form-control input-sm" placeholder="请输入${po.content}" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>  value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' type='both' value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/>" />
                <span class="input-group-addon" >
                    <span class="glyphicon glyphicon-calendar"></span>
                </span>
            <#elseif po.showType=='file' || po.showType == 'image'>
				<@uploadtag po = po opt = "update"/>
	      	<#else>
	      		<input id="${po.fieldName}" name="${po.fieldName}" value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type="text" maxlength="${po.length?c}" class="form-control input-sm" placeholder="请输入${po.content}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/>/>
			</#if>
			</div>
		</div>
	</div>
	</#list>
	<#list pageAreatextColumns as po>
		<#if po.showType=='textarea'>
		<div class="form-group">
			<label for="${po.fieldName}" class="col-sm-3 control-label">${po.content}：</label>
			<div class="col-sm-7">
				<div class="input-group" style="width:100%">
					<textarea id="${po.fieldName}" name="${po.fieldName}" class="form-control" placeholder="请输入${po.content}" rows="4">${'$'}{${entityName?uncap_first}Page.${po.fieldName}}</textarea>
				</div>
			</div>
		</div>
		</#if>
	</#list>
</form>
<script type="text/javascript">
	var subDlgIndex = '';
	$(document).ready(function() {
		<#list pageColumns as po>
			<#if po.showType=='date'|| po.showType=='datetime'>
				//${po.content} 日期控件初始化
			    laydate.render({
				   elem: '#${po.fieldName}'
				  ,type: '${po.showType}'
				  ,trigger: 'click' //采用click弹出
				  ,ready: function(date){
				  	 $("#${po.fieldName}").val(DateJsonFormat(date,this.format));
				  }
				});
			</#if>
		</#list>
		
		//单选框/多选框初始化
		$('.i-checks').iCheck({
			labelHover : false,
			cursor : true,
			checkboxClass : 'icheckbox_square-blue',
			radioClass : 'iradio_square-blue',
			increaseArea : '20%'
		});
		
		//表单提交
		$("#formobj").Validform({
			tiptype:function(msg,o,cssctl){
				if(o.type==3){
					validationMessage(o.obj,msg);
				}else{
					removeMessage(o.obj);
				}
			},
			btnSubmit : "#btn_sub",
			btnReset : "#btn_reset",
			ajaxPost : true,
			beforeSubmit : function(curform) {
			},
			usePlugin : {
				passwordstrength : {
					minLen : 6,
					maxLen : 18,
					trigger : function(obj, error) {
						if (error) {
							obj.parent().next().find(".Validform_checktip").show();
							obj.find(".passwordStrength").hide();
						} else {
							$(".passwordStrength").show();
							obj.parent().next().find(".Validform_checktip").hide();
						}
					}
				}
			},
			callback : function(data) {
				var win = frameElement.api.opener;
				if (data.success == true) {
					<#if uploadFlag==1>
					callbackUpload(data);
					<#else>
					frameElement.api.close();
					</#if>
				    win.reloadTable();
				    win.tip(data.msg);
				} else {
				    if (data.responseText == '' || data.responseText == undefined) {
				        $.messager.alert('错误', data.msg);
				        $.Hidemsg();
				    } else {
				        try {
				            var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'), data.responseText.indexOf('错误信息'));
				            $.messager.alert('错误', emsg);
				            $.Hidemsg();
				        } catch (ex) {
				            $.messager.alert('错误', data.responseText + "");
				            $.Hidemsg();
				        }
				    }
				    return false;
				}
			}
		});
	});
</script>
<#if uploadFlag==1>
<script>
$(function(){
	var cgFormId=$("input[name='id']").val();
	$.ajax({
		type: "post",
		url: "${entityName?uncap_first}Controller.do?getFiles&id=" +  cgFormId,
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
  				var td_title = $("<td title='"+file.title+"'>" + title + "</td>");
  		  		var td_download = $("<td><a  style=\"margin-left:10px;\" href=\"commonController.do?viewFile&fileid=" + file.fileKey + "&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity\" title=\"下载\">下载</a></td>")
  		  		var td_view = $("<td><a  style=\"margin-left:10px;\" href=\"javascript:void(0);\" onclick=\"openwindow('预览','commonController.do?openViewFile&fileid=" + file.fileKey + "&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)\">预览</a></td>");
  		  		var td_del = $("<td><a  style=\"margin-left:10px;\" href=\"javascript:void(0)\" class=\"jeecgDetail\" onclick=\"del('cgUploadController.do?delFile&id=" + file.fileKey + "',this)\">删除</a></td>");
  		  		tr.appendTo(table);
  		  		td_title.appendTo(tr);
  		  		td_download.appendTo(tr);
  		  		td_view.appendTo(tr);
  		  		td_del.appendTo(tr);
			});
		}
	});
	
});
		
	//表单提交成功后上传文件
	function callbackUpload(data) {
		if(!$("input[name='id']").val()){
			if(data.obj!=null && data.obj!='undefined'){
				$("input[name='id']").val(data.obj.id);
			}
		}
		if($(".uploadify-queue-item").length>0){
			<#assign subFileName = fileName?substring(0,fileName?length - 1) />
 			<#list subFileName?split(",") as name>
			$('#${name}').uploadify('upload', '*');
			</#list>
		}else{
			frameElement.api.close();
		}
	}
	function cancel() {
		<#assign subFileName2 = fileName?substring(0,fileName?length - 1) />
		<#list subFileName2?split(",") as name>
			$('#${name}').uploadify('cancel', '*');
		</#list>
	}
	//删除单个文件
	function del(url,obj){
		$.dialog.setting.zIndex =9999;
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
						$(obj).closest("tr").hide("slow");
					}
				}
			});  
		}, function(){
		});
	}
</script>
</#if>
</body>
</html>