<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<#assign callbackFlag = false />
<#assign fileName = "" />
<#list pageColumns as callBackTestPo>
<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
	<#if callBackTestPo.showType=='file' || callBackTestPo.showType=='image'>
		<#assign callbackFlag = true />
		<#break>
	</#if>
<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
</#list>
<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<#include "../../ui/datatype.ftl"/>
<#include "../../ui/dictInfo.ftl"/>
<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<#-- update--begin--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
<#include "../../ui/tag.ftl"/>
<#-- update--end--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${ftl_description}</title>
  <meta name="description" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <t:base type="jquery,aceform,DatePicker,validform,ueditor<#if callbackFlag == true>,uploadify</#if>"></t:base>
  <#-- update--begin--author:gj_shaojc Date:20180404 for:TASK #2610 【严重bug】代码生成树，ace风格，无法选择树 -->
  <#if cgformConfig.cgFormHead.isTree=='Y'>  
  <link rel="stylesheet" href="plug-in/easyui/themes/metrole/easyui.css" type="text/css">
  <style type="text/css">
  	.combo_self{height: 26px !important;width:164px !important;padding-top:0px !important;}
  	.layout-header .btn {
	    margin:0px;
	   float: none !important;
	}
	.btn-default {
	    height: 35px;
	    line-height: 35px;
	    font-size:14px;
	}
  </style>
  <script type="text/javascript">
	$(function(){
		$(".combo").removeClass("combo").addClass("combo combo_self");
		$(".combo").each(function(){
			$(this).parent().css("padding-top","10px !important;");
		});   
	});
  		
  		 /**树形列表数据转换**/
  function convertTreeData(rows, textField) {
      for(var i = 0; i < rows.length; i++) {
          var row = rows[i];
          row.text = row[textField];
          if(row.children) {
          	row.state = "open";
              convertTreeData(row.children, textField);
          }
      }
  }
  /**树形列表加入子元素**/
  function joinTreeChildren(arr1, arr2) {
      for(var i = 0; i < arr1.length; i++) {
          var row1 = arr1[i];
          for(var j = 0; j < arr2.length; j++) {
              if(row1.id == arr2[j].id) {
                  var children = arr2[j].children;
                  if(children) {
                      row1.children = children;
                  }
                  
              }
          }
      }
  }
  </script>
  </#if>
   <#-- update--end--author:gj_shaojc Date:20180404 for:TASK #2610 【严重bug】代码生成树，ace风格，无法选择树 -->
   <script type="text/javascript">
  //编写自定义JS代码
  </script>
</head>

 <body>
 <#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
 <#assign ue_widget_count = 0>
 <#-- update--end--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
	<t:formvalid formid="formobj" dialog="true" usePlugin="password" layout="table" action="${entityName?uncap_first}Controller.do?doAdd" tiptype="1" ${callbackFlag?string("callback=\"jeecgFormFileCallBack@Override\"", "")}>
			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<input type="hidden" id="id" name="id"/>
			<div class="tab-wrapper">
			    <!-- tab -->
			    <ul class="nav nav-tabs">
			      <li role="presentation" class="active"><a href="javascript:void(0);">${ftl_description}</a></li>
			    </ul>
			    <!-- tab内容 -->
			    <div class="con-wrapper" id="con-wrapper1" style="display: block;">
			      <div class="row form-wrapper">
			        <#list pageColumns as po>
				        <#if (pageColumns?size>10)>
							<#if po_index%2==0>
							<div class="row show-grid">
							</#if>
						<#else>
							<div class="row show-grid">
						</#if>
			          <div class="col-xs-3 text-center">
			          	<b>${po.content}：</b>
			          </div>
			          <#-- update--begin--author:Yandong date:20180320 for:TASK #2574 【代码生成器】代码生成效果有问题 2. 有附件的，应该弹窗宽一些  -->
			          <#if po.showType=='file' || po.showType == 'image'>
			          		<div class="col-xs-6">
			          <#else>
			          		<div class="col-xs-3">
			          </#if>
					  <#-- update--end--author:Yandong date:20180320 for:TASK #2574 【代码生成器】代码生成效果有问题  2. 有附件的，应该弹窗宽一些  -->
					  <#-- update--begin--author:gj_shaojc Date:20180404 for:TASK #2610 【严重bug】代码生成树，ace风格，无法选择树 -->
					  <#if cgformConfig.cgFormHead.isTree=='Y' && cgformConfig.cgFormHead.treeParentIdFieldNamePage==po.fieldName>
							<input id="${po.fieldName}" name="${po.fieldName}" type="text"  class="inputxt easyui-combotree" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>
							data-options="panelHeight:'220',
				                    url: '${entityName?uncap_first}Controller.do?datagrid&field=id,${cgformConfig.cgFormHead.treeFieldnamePage}',  
				                    loadFilter: function(data) {
				                    	var rows = data.rows || data;
				                    	var win = frameElement.api.opener;
				                    	var listRows = win.getDataGrid().treegrid('getData');
				                    	joinTreeChildren(rows, listRows);
				                    	convertTreeData(rows, '${cgformConfig.cgFormHead.treeFieldnamePage}');
				                    	return rows; 
				                    },
				                      onSelect:function(node){
				                    	$('#${po.fieldName}').val(node.id);
				                    },
				                    onLoadSuccess: function() {
				                    	var win = frameElement.api.opener;
				                    	var currRow = win.getDataGrid().treegrid('getSelected');
				                    	if(!'${'$'}{${entityName?uncap_first}Page.id}') {
				                    		//增加时，选择当前父菜单
				                    		if(currRow) {
				                    			$('#${po.fieldName}').combotree('setValue', currRow.id);
				                    		}
				                    	}else {
				                    		//编辑时，选择当前父菜单
				                    		if(currRow) {
				                    			$('#${po.fieldName}').combotree('setValue', currRow.${po.fieldName});
				                    		}
				                    	}
				                    }"/>
							<#elseif po.showType=='text'>
							<#-- update--end--author:gj_shaojc Date:20180404 for:TASK #2610 【严重bug】代码生成树，ace风格，无法选择树 -->
								<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
								<#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
								<input id="${po.fieldName}" name="${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/>/>
						   		<#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
						   		<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						     <#elseif po.showType=='popup'>
						     	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						   		<#-- update--begin--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
								<input id="${po.fieldName}" name="${po.fieldName}" type="text" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/><#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>  />
								<#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
						    	<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						    <#elseif po.showType=='textarea'>
						   		 <#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						  	 	<textarea id="${po.fieldName}" class="form-control" rows="6" name="${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>></textarea>
						     	<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						     <#elseif po.showType=='password'>
						     	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						     	<#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
						      	<input id="${po.fieldName}" name="${po.fieldName}" type="password" maxlength="${po.length?c}" class="form-control"<@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>/>
								<#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
								<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>	 
								<#-- update-begin-author:taoyan Date:20180519 for:dictselect改用标签便于以后统一修改 -->
								<@dictSelecttag po = po namePre="" valuePre = "" formStyle="ace" opt="" />
								<#-- update-end-author:taoyan Date:20180519 for:dicselect改用标签便于以后统一修改 -->
							<#elseif po.showType=='date'>
								<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
								<input id="${po.fieldName}" name="${po.fieldName}" type="text"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;"  class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd'})" />
						    	<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						    <#elseif po.showType=='datetime'>
								<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
								<input id="${po.fieldName}" name="${po.fieldName}" type="text" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;" class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" />
						    	<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						    	<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
						    <#elseif po.showType=='file' || po.showType == 'image'>
								<#-- update--begin--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
								<@uploadtag po = po/>
								<#-- update--end--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
							<#--update-start--Author: jg_huangxg  Date:20160421 for：TASK #1027 【online】代码生成器模板不支持UE编辑器 -->
							<#elseif po.showType='umeditor'>
								<#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
								<#assign ue_widget_count = ue_widget_count + 1>
								<#if ue_widget_count == 1>
								<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
								<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
								</#if>
								<#-- update--end--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
						    	<textarea name="${po.fieldName}" id="${po.fieldName}" style="width: 650px;height:300px"></textarea>
							    <script type="text/javascript">
							       <#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
							        var ${po.fieldName}_editor = UE.getEditor('${po.fieldName}');
							        <#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
							    </script>
							<#--update-end--Author: jg_huangxg  Date:20160421 for：TASK #1027 【online】代码生成器模板不支持UE编辑器 -->
						    <#-- update--begin--author:zhangjiaqiang date:20170815 for:TASK #2274 【online】Online 表单支持树控件 -->
							<#elseif po.showType=='tree'>
								<#-- update--begin--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
								<@treetag po = po formStyle="ace"/>
								<#-- update--end--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
						    <#else>						    	
						      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						      	<#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
						      	<input id="${po.fieldName}" name="${po.fieldName}" maxlength="${po.length?c}" type="text" style="width: 150px" class="form-control"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> >
								<#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
								<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							</#if>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">${po.content?if_exists?html}</label>
			          </div>
			        <#if (pageColumns?size>10)>
						<#if (po_index%2==0)&&(!po_has_next)>
							<div class="col-xs-2 text-center"><b></b></div>
			         		<div class="col-xs-4"></div>
						</#if>
						<#if (po_index%2!=0)||(!po_has_next)>
							</div>
						</#if>
					<#else>
						</div>
					</#if>
			          
			        
			        </#list>
			        
			        <#-- update--begin--author:zhoujf Date:20170523 for:TASK #1961 【代码生成器】一对多富文本编辑器，生成代码格式问题 -->
			        <#list pageAreatextColumns as po>
					 <div class="row show-grid">
			          <div class="col-xs-3 text-center">
			          	<b>${po.content}：</b>
			          </div>
			          <div class="col-xs-3">
						    <#if po.showType=='textarea'>
						   		 <#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						  	 	<textarea id="${po.fieldName}" class="form-control" rows="6" style="width: 600px" name="${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>></textarea>
						     	<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<#elseif po.showType='umeditor'>
								<#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
								<#assign ue_widget_count = ue_widget_count + 1>
								<#if ue_widget_count == 1>
								<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
								<script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
								</#if>
								<#-- update--end--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
						    	<textarea name="${po.fieldName}" id="${po.fieldName}" style="width: 650px;height:300px"></textarea>
							    <script type="text/javascript">
							       <#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
							        var ${po.fieldName}_editor = UE.getEditor('${po.fieldName}');
							        <#-- update--begin--author:zhangjiaqiang date:20170522 for:editor编辑器变量唯一 -->
							    </script>
							</#if>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">${po.content?if_exists?html}</label>
			          </div>
						</div>
			        </#list>
					 <#-- update--end--author:zhoujf Date:20170523 for:TASK #1961 【代码生成器】一对多富文本编辑器，生成代码格式问题 -->
			       
			          <div class="row" id = "sub_tr" style="display: none;">
				        <div class="col-xs-12 layout-header">
				          <div class="col-xs-6"></div>
				          <div class="col-xs-6"><button type="button" onclick="neibuClick();" class="btn btn-default">提交</button></div>
				        </div>
				      </div>
			     </div>
			   </div>
			   
			   <div class="con-wrapper" id="con-wrapper2" style="display: block;"></div>
			 </div>
  </t:formvalid>
	<#if callbackFlag == true>
  	<script type="text/javascript">
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
				}else {
					var win = frameElement.api.opener;
					win.reloadTable();
					win.tip(data.msg);
					frameElement.api.close();
				}
			}
		}
  	</script>
  </#if>	

<script type="text/javascript">
   $(function(){
    //查看模式情况下,删除和上传附件功能禁止使用
	if(location.href.indexOf("load=detail")!=-1){
		$(".jeecgDetail").hide();
	}
	
	if(location.href.indexOf("mode=read")!=-1){
		//查看模式控件禁用
		$("#formobj").find(":input").attr("disabled","disabled");
	}
	if(location.href.indexOf("mode=onbutton")!=-1){
		//其他模式显示提交按钮
		$("#sub_tr").show();
	}
   });

  var neibuClickFlag = false;
  function neibuClick() {
	  neibuClickFlag = true; 
	  $('#btn_sub').trigger('click');
  }

</script>
<#if (cgformConfig.formJs.cgJsStr)?? && cgformConfig.formJs.cgJsStr!="">
<script type="text/javascript">
//JS增强
${cgformConfig.formJs.cgJsStr}
</script>
</#if>
 </body>
</html>