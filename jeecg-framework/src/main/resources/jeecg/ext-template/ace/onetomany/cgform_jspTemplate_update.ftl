<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<#include "../../ui/datatype.ftl"/>
<#include "../../ui/dictInfo.ftl"/>
<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<#-- update--begin--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
<#include "../../ui/tag.ftl"/>
<#-- update--end--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
<!DOCTYPE html>
<#assign callbackFlag = false />
<#assign fileName = "" />
<#list pageColumns as callBackTestPo>
	<#if callBackTestPo.showType=='file' || callBackTestPo.showType == 'image'>
		<#assign callbackFlag = true />
		<#break>
	</#if>
</#list>
<html lang="zh-CN">
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>${ftl_description}</title>
  <meta name="description" content="">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="online/template/ledefault/css/vendor.css">
  <link rel="stylesheet" href="online/template/ledefault/css/bootstrap-theme.css">
  <link rel="stylesheet" href="online/template/ledefault/css/bootstrap.css">
  <link rel="stylesheet" href="online/template/ledefault/css/app.css">

  <link rel="stylesheet" href="plug-in/Validform/css/metrole/style.css" type="text/css"/>
  <link rel="stylesheet" href="plug-in/Validform/css/metrole/tablefrom.css" type="text/css"/>
  <script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script>
  <script type="text/javascript" src="plug-in/tools/dataformat.js"></script>
  <script type="text/javascript" src="plug-in/easyui/jquery.easyui.min.1.3.2.js"></script>
  <script type="text/javascript" src="plug-in/easyui/locale/zh-cn.js"></script>
  <script type="text/javascript" src="plug-in/tools/syUtil.js"></script>
  <script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script>
  <script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js"></script>
  <script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
  <script type="text/javascript" src="plug-in/tools/easyuiextend.js"></script>
  <script type="text/javascript" src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
  <script type="text/javascript" src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
  <script type="text/javascript" src="plug-in/Validform/js/datatype_zh-cn.js"></script>
  <script type="text/javascript" src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script>
    <#if callbackFlag == true>
		<link rel="stylesheet" href="plug-in/uploadify/css/uploadify.css" type="text/css" />
		<script type="text/javascript" src="plug-in/uploadify/jquery.uploadify-3.1.js"></script>
  </#if>
  <script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.config.js"></script>
  <script type="text/javascript"  charset="utf-8" src="plug-in/ueditor/ueditor.all.min.js"></script>
</head>


 <script type="text/javascript">
 $(document).ready(function(){
	 init();
	 $("#jform_tab .con-wrapper").hide(); //Hide all tab content  
	 $("#jform_tab li:first").addClass("active").show(); //Activate first tab  
	 $("#jform_tab .con-wrapper:first").show(); //Show first tab content
	 
	 
	 //On Click Event  
    $("#jform_tab li").click(function() {  
        $("#jform_tab li").removeClass("active"); //Remove any "active" class  
        $(this).addClass("active"); //Add "active" class to selected tab  
        $("#jform_tab .con-wrapper").hide(); //Hide all tab content  
        var activeTab = $(this).find("a").attr("href"); //Find the rel attribute value to identify the active tab + content  
        $(activeTab).fadeIn(); //Fade in the active content
        //$(""+activeTab).show();   
        if( $(activeTab).html()!="") {
        	return false;
        }else{
        	$(activeTab).html('正在加载内容，请稍后...');
        	var url = $(this).attr("tab-ajax-url");
        	$.post(url, {}, function(data) {
        		 //$(this).attr("tab-ajax-cached", true);
        		$(activeTab).html(data);
        		
            });
        }  
        return false;  
    });  
  });
  //初始化下标
	function resetTrNum(tableId) {
		$tbody = $("#"+tableId+"");
		$tbody.find('>tr').each(function(i){
			$(':input, select', this).each(function(){
				var $this = $(this), name = $this.attr('name'), val = $this.val();
				if(name!=null){
					if (name.indexOf("#index#") >= 0){
						$this.attr("name",name.replace('#index#',i));
					}else{
						var s = name.indexOf("[");
						var e = name.indexOf("]");
						var new_name = name.substring(s+1,e);
						$this.attr("name",name.replace(new_name,i));
					}
				}
			});
			$(this).find('div[name=\'xh\']').html(i+1);
		});
	}
	
	function init(){
    	var tabHead =$("#jform_tab li:first");
    	var tabBox = $("#jform_tab .con-wrapper:first"); 
    	var url = tabHead.attr("tab-ajax-url");
    	tabBox.html('正在加载内容，请稍后...');
    	$.post(url, {}, function(data) {
            tabBox.html(data);
    		//tabHead.attr("tab-ajax-cached", true);
        });
    }
 </script>
 <body>
  <#-- update--begin--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
 <#assign ue_widget_count = 0>
 <#-- update--end--author:zhangjiaqiang date:20170522 for:ueditor配置文件只加载一次 -->
  <form id="formobj" action="${entityName?uncap_first}Controller.do?doUpdate" name="formobj" method="post"><input type="hidden" id="btn_sub" class="btn_sub"/>
				
			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<input type="hidden" name="id" value='${'$'}{${entityName?uncap_first}Page.id}' >
			
			
			<div class="tab-wrapper">
			    <!-- tab -->
			    <ul class="nav nav-tabs">
			      <li role="presentation" class="active"><a href="javascript:void(0);">${ftl_description}</a></li>
			    </ul>
			    <!-- tab内容 -->
			    <div class="con-wrapper" style="display: block;">
			      <div class="row form-wrapper">
			        <#list pageColumns as po>
				        <#if (pageColumns?size>1)>
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
			          		<div class="col-xs-9">
			          <#else>
			          		<div class="col-xs-3">
			          </#if>
					  <#-- update--end--author:Yandong date:20180320 for:TASK #2574 【代码生成器】代码生成效果有问题  2. 有附件的，应该弹窗宽一些  -->
							<#if po.showType=='text'>
								<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
								<#-- update--begin--author:Yandong Date:20180226 for:TASK #2513 【bug】代码生成器，新添加的online唯一校验生成代码问题-->
								<#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
								<input id="${po.fieldName}" name="${po.fieldName}" type="text" maxlength="${po.length?c}" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/> value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' />
								<#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
						    	<#-- update--end--author:Yandong Date:20180226 for:TASK #2513 【bug】代码生成器，新添加的online唯一校验生成代码问题-->
						    	<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						   <#elseif po.showType=='popup'>
								<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
								<#-- update--begin--author:baiyu Date:20171031 for:popup方法支持返回多个字段-->
								<#-- update--begin--author:gj_shaojc Date:20180302 for:TASK #2548 【代码生成器】样式问题-->
								<input id="${po.fieldName}" name="${po.fieldName}" type="text"  class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> <#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictField}','${po.dictTable}')"</#if>  value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/> 
								<#-- update--end--author:gj_shaojc Date:20180302 for:TASK #2548 【代码生成器】样式问题-->
								<#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
						    	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						    <#elseif po.showType=='textarea'>
						  	 	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						  	 	<textarea id="${po.fieldName}" class="form-control" rows="6" name="${po.fieldName}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />>${'$'}{${entityName?uncap_first}Page.${po.fieldName}}</textarea>
						    	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						    <#elseif po.showType=='password'>
						      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						      	<#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
						      	<input id="${po.fieldName}" name="${po.fieldName}" type="password" maxlength="${po.length?c}" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' />
						      	<#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
								<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>	 
								<#-- update-begin-author:taoyan Date:20180519 for:dictselect改用标签便于以后统一修改 -->
								<@dictSelecttag po = po namePre="" valuePre = "${entityName?uncap_first}Page." formStyle="aces" opt="update" />
								<#-- update-end-author:taoyan Date:20180519 for:dicselect改用标签便于以后统一修改 -->
							<#elseif po.showType=='date'>
								<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
								<input id="${po.fieldName}" name="${po.fieldName}" type="text"  <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;"  class="form-control" onClick="WdatePicker()" value="<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type='date' pattern='yyyy-MM-dd'/>" />
						    	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						    <#elseif po.showType=='datetime'>
								<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
								<input id="${po.fieldName}" name="${po.fieldName}" type="text" style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;" class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>  value="<fmt:formatDate value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}' type='date' pattern='yyyy-MM-dd hh:mm:ss'/>" />
						   		<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						   <#elseif po.showType=='file' || po.showType == 'image'>
								<#-- update--begin--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
								<@uploadtag po = po  opt = "update"/>
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
								<#-- update--begin--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
								<@treetag po = po formStyle="ace" opt = "update"/>
								<#-- update--end--author:taoyan date:20180427 for:TASK #2660 【代码生成器】代码生成器改造，上传控件、树控件，生成的代码太乱了 -->
								<#-- update--begin--author:zhangjiaqiang date:20170815 for:TASK #2274 【online】Online 表单支持树控件 -->
						    <#else>
						      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						      	<#-- update--begin--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
						      	<input id="${po.fieldName}" name="${po.fieldName}" type="text" maxlength="${po.length?c}" style="width: 150px" class="form-control"  <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>   value='${'$'}{${entityName?uncap_first}Page.${po.fieldName}}'/>
								<#-- update--end--author:Yandong Date:20180326 for:TASK #2571 【代码生成器bug】[Online开发] 主从表主表生成的代码字段没有长度限制-->
								<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							</#if>
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">${po.content?if_exists?html}</label>
			          </div>
			        <#if (pageColumns?size>1)>
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
						  	 	<#-- update--begin--author:gj_shaojc Date:20180315 for:TASK #2548 【代码生成器】样式问题-->
						  	 	<textarea id="${po.fieldName}" class="form-control" rows="6" name="${po.fieldName}" cols="22" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />>${'$'}{${entityName?uncap_first}Page.${po.fieldName}}</textarea>
						    	<#-- update--end--author:gj_shaojc Date:20180315 for:TASK #2548 【代码生成器】样式问题-->
						    	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
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
						<span class="Validform_checktip" style="float:left;height:0px;"></span>
						<label class="Validform_label" style="display: none">${po.content?if_exists?html}</label>
			          </div>
						</div>
			        </#list>
			        <#-- update--end--author:zhoujf Date:20170523 for:TASK #1961 【代码生成器】一对多富文本编辑器，生成代码格式问题 -->

			     </div>
			   </div>
			   
			   <div class="con-wrapper" style="display: block;"></div>
	</div>
		
			
			
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

<div id="jform_tab" class="tab-wrapper">
	<!-- tab -->
    <ul class="nav nav-tabs">
	 <#list subTab as sub>
		    	<li role="presentation" tab-ajax-url="${entityName?uncap_first}Controller.do?${sub.entityName?uncap_first}List<#list sub.foreignKeys as key><#if key?lower_case?index_of("${jeecg_table_id}")!=-1>&${jeecg_table_id}=${"$"}{${entityName?uncap_first}Page.${jeecg_table_id}}<#else>&${key?uncap_first}=${"$"}{${entityName?uncap_first}Page.${key?uncap_first}}</#if></#list>"><a href="#con-wrapper${sub_index}">${sub.ftlDescription}</a></li>
	  </#list>
    </ul>
    
	<#list subTab as sub>
	     <div class="con-wrapper" id="con-wrapper${sub_index}" style="display: none;"></div>
	</#list>
</div>


			
		<div align="center"  id = "sub_tr" style="display: none;" > <input type="button" value="提交" onclick="neibuClick();" class="ui_state_highlight"></div>
		<script src="plug-in/layer/layer.js"></script>
		<script type="text/javascript">
		<#-- update-begin-author:taoyan date:20180428 for:一对多页面form不是标签生成js,需要加个变量  -->
		var subDlgIndex = null;
		<#-- update-end-author:taoyan  date:20180428 for:一对多页面form不是标签生成js,需要加个变量  -->
		$(function() {
			$("#formobj").Validform({
				tiptype: function(msg, o, cssctl) {
		            if (o.type == 3) {
		                layer.open({
		                    title: '提示信息',
		                    content: msg,
		                    icon: 5,
		                    shift: 6,
		                    btn: false,
		                    shade:false,time:5000,
		                    cancel: function(index) {
		                        o.obj.focus();
		                        layer.close(index);
		                    },
		                    yes: function(index) {
		                        o.obj.focus();
		                        layer.close(index);
		                    },
		                })
		            }
		        },
				btnSubmit: "#btn_sub",
				btnReset: "#btn_reset",
				ajaxPost: true,
				beforeSubmit: function(curform) {
					var tag = true;
					//提交前处理
					return tag;
				},
				usePlugin: {
					passwordstrength: {
						minLen: 6,
						maxLen: 18,
						trigger: function(obj, error) {
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
				callback: function(data) {
					<#-- update--begin--author:zhangjiaqiang date:20170607 for:修订回调函数的调用方式 -->
					<#if callbackFlag == true>
						jeecgFormFileCallBack(data);
					<#else>
						if (data.success == true) {
							 var win = frameElement.api.opener;
							 win.reloadTable();
							 win.tip(data.msg);
							 frameElement.api.close();
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
					</#if>
					<#-- update--begin--author:zhangjiaqiang date:20170607 for:修订回调函数的调用方式 -->
				}
			});
		});
		</script>
		
		</form>
		<!-- 添加 产品明细 模版 -->
		<table style="display:none">
			<#list subTab as sub>
			<tbody id="add_${sub.entityName?uncap_first}_table_template">
				<tr>
					 <th scope="row"><div name="xh"></div></th>
					 <td><input style="width:20px;" type="checkbox" name="ck"/></td>
					 <#list subPageColumnsMap[sub.tableName] as po>
						 <#assign check = 0 >
						  <#list sub.foreignKeys as key>
						  <#if subFieldMeta[po.fieldName]==key?uncap_first>
						  <#assign check = 1 >
						  <#break>
						  </#if>
						  </#list>
						  <#if check==0>
						  <td align="left">
							  <#if po.showType == "text">
								 	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
								  	<#-- update--begin--author:Yandong Date:20180226 for:TASK #2513 【bug】代码生成器，新添加的online唯一校验生成代码问题-->
								  	<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control"  style="width:120px;" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}" idFieldName="${sub.entityName?uncap_first}List[#index#].id"/>/>
									<#-- update--end--author:Yandong Date:20180226 for:TASK #2513 【bug】代码生成器，新添加的online唯一校验生成代码问题-->
									<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
								<#elseif po.showType=='password'>
									<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
									<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" type="password" class="form-control"  style="width:120px;"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
									<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
								<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
									<#-- update-begin-author:taoyan Date:20180519 for:dictselect改用标签便于以后统一修改 -->
									<@dictSelecttag po = po namePre="${sub.entityName?uncap_first}List[#index#]." valuePre = "" formStyle="aces" opt="" />
									<#-- update-end-author:taoyan Date:20180519 for:dicselect改用标签便于以后统一修改 -->
								<#elseif po.showType=='date'>
									<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
									<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" 
							  		type="text" class="form-control" onClick="WdatePicker()"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
							    	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							    <#elseif po.showType=='datetime'>
							      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							      	<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" 
								  		type="text"  class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
							    	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							    	<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
					
								<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
								<#elseif po.showType=='popup'>
							    	<#-- update--begin--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
							    	<#-- update--begin--author:gj_shaojc Date:20180302 for:TASK #2548 【代码生成器】样式问题-->
					  				<#-- update--begin--author:gj_shaojc Date:20180315 for:TASK #2548 【代码生成器】样式问题-->
					  				<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" type="text"  class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> <#if po.dictTable?if_exists?html!="">  onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if> value="${'$'}{poVal.${po.fieldName} }" />
									<#-- update--end--author:gj_shaojc Date:20180315 for:TASK #2548 【代码生成器】样式问题-->
									<#-- update--end--author:gj_shaojc Date:20180302 for:TASK #2548 【代码生成器】样式问题-->
									<#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
							    <#elseif po.showType=='file' || po.showType == 'image'>
							    <#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
												<input type="hidden" id="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" />
											  <#-- update--begin--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
											    <#-- update--begin--author:zhangjiaqiang date:20170614 for:修订上传附件按钮的大小 -->
											   <input class="btn btn-sm btn-success" style="margin-left:10px;" type="button" value="上传附件"
															onclick="commonUpload(commonUploadDefaultCallBack,'${sub.entityName?uncap_first}List\\[#index#\\]\\.${po.fieldName}')"/>
							       				<#-- update--begin--author:zhangjiaqiang date:20170614 for:修订上传附件按钮的大小 -->
							       				<a  target="_blank" id="${sub.entityName?uncap_first}List[#index#].${po.fieldName}_href"></a>
							       				<#-- update--end--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
									
									<#-- update--begin--author:taoyan date:20180514 for:新增模板、子页面都没有树控件 保持一致删除之 -->
									
									<#-- update--end--author:taoyan date:20180514 for:新增模板、子页面都没有树控件 保持一致删除之 -->
								<#-- update--begin--author:zhangjiaqiang date:20170815 for:TASK #2274 【online】Online 表单支持树控件 -->
							       <#else>
							       <#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							       	<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control"  style="width:120px;"<@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
							  		<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							  </#if>
							  <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
						  </td>
						  </#if>
		              </#list>
					</tr>
				 </tbody>
		 	</#list>
		</table>
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
	  				<#-- update--begin--author:zhangjiaqiang date:20170614 for:文件名称太长显示问题 -->
	  				var title = file.title;
	  				if(title.length > 15){
	  					title = title.substring(0,12) + "...";
	  				}
	  				var td_title = $("<td>" + title + "</td>");
	  				<#-- update--end--author:zhangjiaqiang date:20170614 for:文件名称太长显示问题 -->
	  		  		<#-- update--begin--author:zhangjiaqiang date:20170607 for:增加按钮之间的间隔 -->
	  		  		var td_download = $("<td><a style=\"margin-left:10px;\" href=\"commonController.do?viewFile&fileid=" + file.fileKey + "&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity\" title=\"下载\">下载</a></td>")
	  		  		var td_view = $("<td><a style=\"margin-left:10px;\" href=\"javascript:void(0);\" onclick=\"openwindow('预览','commonController.do?openViewFile&fileid=" + file.fileKey + "&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)\">预览</a></td>");
	  		  		var td_del = $("<td><a style=\"margin-left:10px;\" href=\"javascript:void(0)\" class=\"jeecgDetail\" onclick=\"del('cgUploadController.do?delFile&id=" + file.fileKey + "',this)\">删除</a></td>");
	  		  		<#-- update--end--author:zhangjiaqiang date:20170607 for:增加按钮之间的间隔 -->
	  		  		
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
 </body>
 </html>