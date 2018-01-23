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
  <style>
.tab-wrapper .nav-tabs > li.active > a, .tab-wrapper .nav-tabs > li.active > a:hover, .tab-wrapper .nav-tabs > li.active > a:focus {
    color: #8f0911;
}

.columns_tbz td {padding:2px;}
.table > tbody > tr{border-bottom:1px solid #ddd;}
.table input,.table select{width:157px;}

/* 数量table下的input宽度设置 */
.num_tbz input{
	width:80px;
}
/* 价格table下的input/select宽度设置 */
.price_tbz input,.price_tbz select{
	width:100px;
}
.table textarea{width:157px;height:95%;}
.xh input,ck input{width:40px !important;}

</style>
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
  <form id="formobj" action="${entityName?uncap_first}Controller.do?${'$'}{empty mainId?'doAdd':'doUpdate'}" name="formobj" method="post">
  			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<input name="id" type="hidden" value="${'$'}{mainId}">
			
			<div id="jform_tab" class="tab-wrapper">
	
				<!-- tab -->
				<ul class="nav nav-tabs">
					<li role="presentation" tab-ajax-url="${entityName?uncap_first}Controller.do?mainPage&id=${'$'}{mainId}&load=${'$'}{load}">
						<a href="#con-wrapper0">${ftl_description}</a>
					</li>
					<#list subTab as sub>
						<li role="presentation" tab-ajax-url="${entityName?uncap_first}Controller.do?${sub.entityName?uncap_first}List<#list sub.foreignKeys as key><#if key?lower_case?index_of("${jeecg_table_id}")!=-1>&${jeecg_table_id}=${'$'}{mainId}<#else>&${key?uncap_first}=${'$'}{mainId}</#if></#list>">
							<a href="#con-wrapper${sub_index+1}">${sub.ftlDescription}</a>
						</li>
					</#list>
					
					
				</ul>
				
				 <div class="con-wrapper" id="con-wrapper0" style="display: none;"></div>
				 <#list subTab as sub>
					<div class="con-wrapper" id="con-wrapper${sub_index+1}" style="display: none;"></div>
				</#list>
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
		<div align="center"  id = "sub_tr" style="display: none;" > <input type="button" value="提交" onclick="neibuClick();" class="ui_state_highlight"></div>
		<script src="plug-in/layer/layer.js"></script>
		<script type="text/javascript">
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
					<#if callbackFlag == true >
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
					 <td><input style="width:20px;" type="checkbox" name="ck"/></td>
					 <th scope="row"><div name="xh"></div></th>
					 <#assign index = 0 >
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
							<#if (subPageColumnsMap[sub.tableName]?size-sub.foreignKeys?size) gte 8>
								<#if index%2==0>
									<table class="columns_tbz">
								</#if>
								<tr>
									<td>${po.content?if_exists?html}：</td>
									<td>
										<#if po.showType == "text">
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> type="text" class="form-control"  style="width:120px;" />
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
										<#elseif po.showType=='password'>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" type="password" class="form-control"  style="width:120px;" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> />
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
										<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<t:dictSelect field="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'form-control',style:'width:150px'}" <#if po.isNull != 'Y'>datatype="*"</#if> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="" hasLabel="false"  title="${po.content}"></t:dictSelect>     
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
										<#elseif po.showType=='date'>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control" onClick="WdatePicker()"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
										<#elseif po.showType=='datetime'>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" type="text"  class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
										<#elseif po.showType=='popup'>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<#-- update--begin--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
											<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" type="text" style="width: 150px" class="searchbox-inputtext" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/> 
											<#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
										
										 <#elseif po.showType=='file' || po.showType == 'image'>
											<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
														<input type="hidden" id="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" />
														<#-- update--begin--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
													  <#-- update--begin--author:zhangjiaqiang date:20170614 for:修订上传附件按钮的大小 -->
														<input class="btn btn-sm btn-success" style="margin-left:10px;" type="button" value="上传附件"
																	onclick="commonUpload(commonUploadDefaultCallBack,'${sub.entityName?uncap_first}List\\[#index#\\]\\.${po.fieldName}')"/>
														<a  target="_blank" id="${sub.entityName?uncap_first}List[#index#].${po.fieldName}_href"></a>
														<#-- update--end--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
														<#-- update--begin--author:zhangjiaqiang date:20170614 for:修订上传附件按钮的大小 -->
										 <#else>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}"  type="text" class="form-control"  style="width:120px;"<@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
									  	 </#if>
									 </td>
								</tr>
								<#if (index+1)%2==0>
									</table>
								</#if>
								<#assign index = index+1 >
							<#else>
								<#if po.showType == "text">
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> type="text" class="form-control"  style="width:120px;" />
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
										<#elseif po.showType=='password'>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" type="password" class="form-control"  style="width:120px;" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> />
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
										<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<t:dictSelect field="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'form-control',style:'width:150px'}" <#if po.isNull != 'Y'>datatype="*"</#if> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="" hasLabel="false"  title="${po.content}"></t:dictSelect>     
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
										<#elseif po.showType=='date'>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control" onClick="WdatePicker()"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
										<#elseif po.showType=='datetime'>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}" type="text"  class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;"<@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
										<#elseif po.showType=='popup'>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<#-- update--begin--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
											<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" type="text" style="width: 150px" class="searchbox-inputtext" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/> 
											<#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
										
										 <#elseif po.showType=='file' || po.showType == 'image'>
											<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
														<input type="hidden" id="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" />
														<#-- update--begin--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
													  <#-- update--begin--author:zhangjiaqiang date:20170614 for:修订上传附件按钮的大小 -->
														<input class="btn btn-sm btn-success" style="margin-left:10px;" type="button" value="上传附件"
																	onclick="commonUpload(commonUploadDefaultCallBack,'${sub.entityName?uncap_first}List\\[#index#\\]\\.${po.fieldName}')"/>
														<a  target="_blank" id="${sub.entityName?uncap_first}List[#index#].${po.fieldName}_href"></a>
														<#-- update--end--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
														<#-- update--begin--author:zhangjiaqiang date:20170614 for:修订上传附件按钮的大小 -->
										   <#else>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
											<input name="${sub.entityName?uncap_first}List[#index#].${po.fieldName}" maxlength="${po.length?c}"  type="text" class="form-control"  style="width:120px;"<@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
											<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
									  </#if>
							</#if>
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