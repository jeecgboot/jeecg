<#include "/ui/datatype.ftl"/>
<#include "/ui/datatypeJs.ftl"/>
<#include "/ui/dictInfo.ftl"/>
<#include "/ui/element.ftl"/>
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
<!-- Validform组件引用 -->
<link href="plug-in/themes/bootstrap-ext/css/validform-ext.css" rel="stylesheet" />
<script type="text/javascript" src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/Validform/js/datatype_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script>
<!-- 验证提示 -->
<script src="plug-in/themes/bootstrap-ext/js/common.js"></script>
<!-- vue -->
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<script src="https://cdn.bootcss.com/vue-resource/1.5.0/vue-resource.js"></script>  
<!-- element-ui -->
<link rel="stylesheet" href="https://unpkg.com/element-ui@2.3.7/lib/theme-chalk/index.css">
<script src="https://unpkg.com/element-ui@2.3.7/lib/index.js"></script>
<link rel="stylesheet" href="plug-in/themes/naturebt/css/ele-form.css">
</head>
<body>
<div class="vue-form" id="${entityName?uncap_first}VueForm">
<el-container>
    <el-header>
    	<div class="el-header-content">${ftl_description}</div>
    </el-header>
    <el-main>
	    <form class="form-horizontal" role="form" id="dailogForm" action="" method="POST">
			<button type="button" id="btn_sub" class="btn_sub" @click="doSubmitForm()" style="display:none"></button>
			<input name = "id" type = "hidden" value = "${'$'}{formId}" />
			<div class="main-form">
				<el-form label-width="110px">
				<#list pageColumns as po>
				<#if po.isShow == 'Y'>
					<el-col :span="8">
						<el-form-item label="${po.content}：">
		   	 			<@element po = po modelpre = "formdata." size = "mini"/>
		   	 			</el-form-item>
	                </el-col>
				</#if>
				</#list>
				</el-form>
			</div>
			
			<el-tabs type="card" class="el-col el-col-24">
			<#list subtables as key>
			 	<el-tab-pane label="${subsG['${key}'].ftlDescription}">
			 	<div class="el-tab-content">
			 		<!-- tab-content-begin -->
			 		<#if subsG['${key}'].cgFormHead.relationType==0 >
		    		<el-table :data="formdata.${subsG['${key}'].entityName?uncap_first}List" class="tb-edit" style="width: 100%" highlight-current-row @row-click="handleCurrentChange">
		    	 	<#list subColumnsMap['${key}'] as po>
		    	 		<#if po.isShow == 'N'>
		    	 		<#else>
	    	 			<el-table-column prop="${po.fieldName}" label="${po.content}" width="200">
		    	 			<template slot-scope="scope">
		    	 			<@element po = po modelpre = "scope.row." size = "mini"/>
                            </template>
                        </el-table-column>
		    	 		</#if>
		    	 	</#list>
			    	 	<el-table-column label="操作">
	                        <template slot-scope="scope">
	        					<a @click="delete${subsG['${key}'].entityName}(scope.$index, scope.row)" title="删除"><i class="el-icon-minus"></i></a>
	        					<a @click="add${subsG['${key}'].entityName}(scope.$index, scope.row)" title="新增"><i class="el-icon-plus"></i></a>
	                        </template>
	                    </el-table-column>
			    	 </el-table>
			    	<#else>
		    	 	<div class="one2one">
			    		<el-form label-width="110px">
				    		<el-row>
		    				<#list subColumnsMap['${key}'] as po>
			    	 		<#if po.isShow == 'Y'>
			    	 		<el-col :span="8">
			    	 			<el-form-item label="${po.content}：">
			   	 				<@element po = po modelpre = "${subsG['${key}'].entityName?uncap_first}Data." size = "mini"/>
			   	 				</el-form-item>
			   	 			</el-col>
			    	 		</#if>
			    	 		</#list>
				    		</el-row>
			    		</el-form>
		    		</div>
		    	 	</#if>
		    	 	<!-- tab-content-end -->
			 	</div>
			 	</el-tab-pane>
			  </#list>
			</el-tabs>
		</form>
		
	</el-main>
</el-container>
</div>
 <script type="text/javascript">
 var ${entityName?uncap_first}VueForm = new Vue({
	    el: "${'#'}${entityName?uncap_first}VueForm",
	    data: {
		    formdata:''
			<#list subtables as key>
	   		<#if subsG['${key}'].cgFormHead.relationType==1>
	   		,${subsG['${key}'].entityName?uncap_first}Data:''
	   		</#if>
	   		<#assign optionCodesUpdate="">
	   		<#list subColumnsMap['${key}'] as po>
	   		<#if po.isShow == 'Y'>
	   		<#if po.showType=='select' || po.showType=='list' || po.showType=='radio' || po.showType=='checkbox'>
	   		<#if optionCodesUpdate?index_of(po.dictField) lt 0>
	   		<#assign optionCodesUpdate=optionCodesUpdate+","+po.dictField >
	   		,${po.dictField}Options:''
	   		</#if>
	   		</#if>
	   		</#if>
	   		</#list>
	   		</#list>
    	 	<#list pageColumns as mpo>
    	 	<#if mpo.isShow == 'Y'>
    	 	<#if mpo.showType=='select' || mpo.showType=='list' || mpo.showType=='radio' || mpo.showType=='checkbox'>
    	 	<#if optionCodesUpdate?index_of(mpo.dictField) lt 0>
	   		<#assign optionCodesUpdate=optionCodesUpdate+","+ mpo.dictField >
    	 	,${mpo.dictField}Options:''
    	 	</#if>
    	 	</#if>
    	 	</#if>
    	 	</#list>
	    },
	    methods: {
	    	loadData:function(){
	    		return new Promise(function(resolve, reject){
	        		jQuery.ajax({
		                url: "${entityName?uncap_first}Controller.do?initFormData&id=${'$'}{formId}",
		        		type:"GET",
		           		dataType:"JSON",
		                success: function (back) {
		                	if(back.success){
		                		resolve(back.obj);
		                	}
		                }
		             });
	        	});
	    	},
	    	init:function(backtemp){
	            var _this = this;
         	    <#list pageColumns as po>
				<#if po.isShow == 'Y' && po.showType=='checkbox'>
				<#-- 主表checkbox值替换 -->
				backtemp.${po.fieldName} = (!!backtemp.${po.fieldName})?backtemp.${po.fieldName}.split(","):[];
				</#if>
    	       	</#list>
         	    <#list subtables as key>
         	    var temp${subsG['${key}'].entityName}List = backtemp.${subsG['${key}'].entityName?uncap_first}List;
    	       	<#if subsG['${key}'].cgFormHead.relationType==1>
    	       	<#-- 1对1子表值替换为单个实体 -->
    	       	_this.${subsG['${key}'].entityName?uncap_first}Data = temp${subsG['${key}'].entityName}List[0];
    	        <#list subColumnsMap['${key}'] as po>
    	        <#if po.isShow == 'Y' && po.showType=='checkbox'>
    	       	<#-- 1对1子表checkbox值替换 -->
    	        _this.${subsG['${key}'].entityName?uncap_first}Data.${po.fieldName}=(!!_this.${subsG['${key}'].entityName?uncap_first}Data.${po.fieldName})?_this.${subsG['${key}'].entityName?uncap_first}Data.${po.fieldName}.split(","):[];
    	        </#if>
    	        </#list>
    	       	<#else>
    	        <#list subColumnsMap['${key}'] as po>
    	        <#if po.isShow == 'Y' && po.showType=='checkbox'>
    	        <#-- 1对n子表checkbox值替换 需要循环 -->
    	        if(!!temp${subsG['${key}'].entityName}List && temp${subsG['${key}'].entityName}List.length>0){
    	        	for(var a = 0;a<temp${subsG['${key}'].entityName}List.length;a++){
    	        		temp${subsG['${key}'].entityName}List[a].${po.fieldName} = (!!temp${subsG['${key}'].entityName}List[a].${po.fieldName})?temp${subsG['${key}'].entityName}List[a].${po.fieldName}.split(","):[];
    	        	}
    	         }
    	         </#if>
    	         </#list>
    	       	 </#if>
    	       	 </#list>
    	         _this.formdata = backtemp;
    	         _this.addValidType();
	        },
	        initDictsData:function(){
	        	var _this = this;
	        	<#assign optionCodesUpdate2="">
	        	<#list subtables as key>
		   		<#list subColumnsMap['${key}'] as po>
		   		<#if po.isShow == 'Y'>
		   		<#if po.showType=='select' || po.showType=='list' || po.showType=='radio' || po.showType=='checkbox'>
		   		<#if optionCodesUpdate2?index_of(po.dictField) lt 0>
		   		<#assign optionCodesUpdate2=optionCodesUpdate2+","+po.dictField >
		   		initDictByCode('${po.dictField}',_this,'${po.dictField}Options');
		   		</#if>
		   		</#if>
		   		</#if>
	    	 	</#list>
	    	 	</#list>
	    		<#list pageColumns as mpo>
	    	 	<#if mpo.isShow == 'Y'>
	    	 	<#if mpo.showType=='select' || mpo.showType=='list' || mpo.showType=='radio' || mpo.showType=='checkbox'>
	    	 	<#if optionCodesUpdate2?index_of(mpo.dictField) lt 0>
		   		<#assign optionCodesUpdate2=optionCodesUpdate2+","+mpo.dictField >
	    	 	initDictByCode('${mpo.dictField}',_this,'${mpo.dictField}Options');
	    	 	</#if>
	    	 	</#if>
	    	 	</#if>
	    	 	</#list>
	        },
	        addValidType:function(){
	        	this.$nextTick(() => {
	        		<#list pageColumns as po>
					<#if po.isShow == 'Y' && po.showType !='input' && po.showType !='checkbox'>
					<@datatypeJs descriptb="${ftl_description}" po = po />
					</#if>
		    	 	</#list>
		    	 	<#list subtables as key>
		    	 	<#list subColumnsMap['${key}'] as spo>
	    	 		<#if spo.isShow == 'Y' && spo.showType !='input' && spo.showType !='checkbox'>
	    	 			<@datatypeJs descriptb="${subsG['${key}'].ftlDescription}" po = spo />
	    	 		</#if>
		    	 	</#list>
		    	 	</#list>
	        	});
	        },
	        <#list subTab as sub>
        	delete${sub.entityName}:function(index, row) {
				 this.formdata.${sub.entityName?uncap_first}List.splice(index, 1);
	        },add${sub.entityName}:function(index, row) {
				 this.formdata.${sub.entityName?uncap_first}List.push({});
				 this.addValidType();
	        },
	        </#list>
	        handleCurrentChange:function(row, event, column) {
	            //console.log(row, event, column, event.currentTarget)
	        },
	        handleEdit:function(index, row) {
	            //console.log(index, row);
	        },
			doSubmitForm:function() {
			    var check = $("#dailogForm").Validform().check(true);
			    if(!check){
				   return false;
			    }
			    var myFormData = this.formdata;
			    <#list pageColumns as po>
			    <#if po.isShow == 'Y' && po.showType=='checkbox'>
			    <#-- 主表checkbox值替换 -->
			    myFormData.${po.fieldName} = (!!myFormData.${po.fieldName})?myFormData.${po.fieldName}.join(","):"";
			    </#if>
		        </#list>
     	   <#list subtables as key>
     	   	    var temp${subsG['${key}'].entityName}List = myFormData.${subsG['${key}'].entityName?uncap_first}List;
	       	    <#if subsG['${key}'].cgFormHead.relationType==1>
	            <#list subColumnsMap['${key}'] as spo>
	            <#if spo.isShow == 'Y' && spo.showType=='checkbox'>
	       	    <#-- 1对1子表checkbox值替换 -->
	            this.${subsG['${key}'].entityName?uncap_first}Data.${spo.fieldName}=(!!this.${subsG['${key}'].entityName?uncap_first}Data.${spo.fieldName})?this.${subsG['${key}'].entityName?uncap_first}Data.${spo.fieldName}.join(","):"";
	           </#if>
	           </#list>
	            <#-- 1对1子表值替换由单个实体到集合 -->
	       	    temp${subsG['${key}'].entityName}List.splice(0, 1);
	       	    temp${subsG['${key}'].entityName}List.push(this.${subsG['${key}'].entityName?uncap_first}Data);
	       	   <#else>
	           <#list subColumnsMap['${key}'] as spo>
	           <#if spo.isShow == 'Y' && spo.showType=='checkbox'>
	           <#-- 1对n子表checkbox值替换 需要循环 -->
	            if(!!temp${subsG['${key}'].entityName}List && temp${subsG['${key}'].entityName}List.length>0){
	        	   for(var a = 0;a<temp${subsG['${key}'].entityName}List.length;a++){
	        	   	  temp${subsG['${key}'].entityName}List[a].${spo.fieldName} = (!!temp${subsG['${key}'].entityName}List[a].${spo.fieldName})?temp${subsG['${key}'].entityName}List[a].${spo.fieldName}.join(","):"";
	        	   }
	            }
	           </#if>
	           </#list>
	       	   </#if>
	       	 </#list>
				var url = "${entityName?uncap_first}Controller.do?doUpdate";
				jQuery.ajax({
				  type: 'POST',
				  url: url,
				  data:{"formdata":JSON.stringify(myFormData)},
				  dataType: "JSON",
				  success: function (data) {
					  vueFormCallback(data);
                   	}
				});
			}
	    },
	    mounted:function() {
			var _this = this;
			_this.loadData().then(function(data){
				_this.init(data);
			});
			_this.initDictsData();			
		}
	});
 $(document).ready(function() {
	//表单提交
	var dailogForm = $("#dailogForm").Validform({
		tiptype:function(msg,o,cssctl){
			if(o.type==3){
				var oopanel = $(o.obj).closest(".el-tab-pane");
				var a = 0;
				if(oopanel.length>0){
					var panelID = oopanel.attr("id");
					if(!!panelID){
						var waitActive = $("#tab-"+panelID.substring(panelID.indexOf("-")+1));
						if(!waitActive.attr(".aria-selected")){
							waitActive.click();
							a = 1;
						}
					}
				}
				if(a==1){
					setTimeout(function(){validationMessage(o.obj,msg);},366);
				}else{
					validationMessage(o.obj,msg);
				}
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
		}
	});

 });
 
 	//doSubmitForm 完成后调用
	function vueFormCallback(data){
		var win = frameElement.api.opener;
		if (data.success == true) {
		    frameElement.api.close();
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
	
	//加载字典数据
	function initDictByCode(code,_this,dictOption){
		if(!_this[dictOption]){
			jQuery.ajax({
	            url: "systemController.do?typeListJson&typeGroupName="+code,
	    		type:"GET",
	       		dataType:"JSON",
	            success: function (back) {
	               if(back.success){
	            	   _this[dictOption] = back.obj;
	               }
	             }
	         });
		}
	}

 </script>
</body>
</html>