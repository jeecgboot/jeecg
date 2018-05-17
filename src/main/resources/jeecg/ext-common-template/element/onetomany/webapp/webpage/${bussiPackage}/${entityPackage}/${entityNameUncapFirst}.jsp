<#include "/ui/datatypeJs.ftl"/>
<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<title>${ftl_description}</title>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<meta name=viewportcontent="width=device-width,initial-scale=1,minimum-scale=1,maximum-scale=1,user-scalable=no,minimal-ui">
	<link rel="stylesheet" href="https://unpkg.com/element-ui@2.3.7/lib/theme-chalk/index.css">
	<link href="plug-in/themes/bootstrap-ext/css/validform-ext.css" rel="stylesheet" />
	<style>
	[v-cloak] { display: none }
	</style>
</head>
<body style="background-color: #FFFFFF;">
	<div id="${entityName?uncap_first}Form" v-cloak>
	<form class="form-horizontal" role="form" id="form" action="" method="POST">
		<button type="button" id="btn_sub" class="btn_sub" @click="addSubmit()" style="display:none"></button>
			<!--新增界面-->
			<el-form label-width="80px" size="mini">
				<el-row>
				<#list pageColumns as po>
				  	<el-col :span="8">
				<#if po.showType=='text'>
					<el-form-item label="${po.content}" prop="${po.fieldName}">
						<el-input v-model="addForm.${po.fieldName}" name="${po.fieldName}" auto-complete="off" placeholder="请输入${po.content}"></el-input>
					</el-form-item>
				<#elseif po.showType=='textarea'>
					<el-form-item label="${po.content}">
						<el-input type="textarea" name="${po.fieldName}" v-model="addForm.${po.fieldName}"></el-input>
					</el-form-item>
				<#elseif po.showType=='password'>
					<el-form-item label="${po.content}">
						<el-input type="password" name="${po.fieldName}" v-model="addForm.${po.fieldName}"></el-input>
					</el-form-item>
				<#elseif po.showType=='date'>
					<el-form-item label="${po.content}">
						<el-date-picker type="date" name="${po.fieldName}" placeholder="选择${po.content}" v-model="addForm.${po.fieldName}"></el-date-picker>
					</el-form-item>
				<#elseif po.showType=='datetime'>
					<el-form-item label="${po.content}">
						 <el-date-picker type="datetime" name="${po.fieldName}" placeholder="选择${po.content}" v-model="addForm.${po.fieldName}"></el-date-picker>
					</el-form-item>
				<#elseif po.showType=='checkbox'>
					<el-form-item label="${po.content}">
						<el-select v-model="addForm.${po.fieldName}" name="${po.fieldName}" multiple placeholder="请选择${po.content}">
					      <el-option :label="option.typename" :value="option.typecode" v-for="option in ${po.dictField}Options"></el-option>
					    </el-select>
					</el-form-item>
				<#elseif po.showType=='select' || po.showType=='list' || po.showType=='radio'>
					<el-form-item label="${po.content}">
						<el-select v-model="addForm.${po.fieldName}" name="${po.fieldName}" placeholder="请选择${po.content}">
					      <el-option :label="option.typename" :value="option.typecode" v-for="option in ${po.dictField}Options"></el-option>
					    </el-select>
					</el-form-item>
				<#elseif po.showType=='file' || po.showType == 'image'>
					<el-form-item label="${po.content}" prop="${po.fieldName}">
						<el-upload
						  :action="url.upload"
						  :data="{isup:'1'}"
						  :on-success="handleMain${po.fieldName?cap_first}UploadFile"
						  :on-remove="handleMain${po.fieldName?cap_first}RemoveFile"
						  :file-list="formFile.main_${po.fieldName}">
						  <el-button size="small" type="primary">点击上传</el-button>
						</el-upload>
					</el-form-item>
				<#else>
					<el-form-item label="${po.content}" prop="${po.fieldName}">
						<el-input v-model="addForm.${po.fieldName}" name="${po.fieldName}" auto-complete="off" placeholder="请输入${po.content}"></el-input>
					</el-form-item>
				</#if>
					</el-col>
				</#list>
				</el-row>
			</el-form>
			
			<el-tabs type="card">
				<#list subtables as key>
				<el-tab-pane label="${subsG['${key}'].ftlDescription}">
				<#if subsG['${key}'].cgFormHead.relationType==1 >
				    <el-form size="mini" :model="${subsG['${key}'].entityName?uncap_first}Form" label-width="80px" ref="${subsG['${key}'].entityName?uncap_first}Form">
						<el-row>
						<#list subPageNoAreatextColumnsMap['${key}'] as po>
						  	<el-col :span="8">
						<#if po.showType=='text'>
							<el-form-item label="${po.content}" prop="${po.fieldName}">
								<el-input name="${po.fieldName}" v-model="${subsG['${key}'].entityName?uncap_first}Form.${po.fieldName}" auto-complete="off" placeholder="请输入${po.content}"></el-input>
							</el-form-item>
						<#elseif po.showType=='textarea'>
							<el-form-item label="${po.content}">
								<el-input  type="textarea" name="${po.fieldName}" v-model="${subsG['${key}'].entityName?uncap_first}Form.${po.fieldName}"></el-input>
							</el-form-item>
						<#elseif po.showType=='password'>
							<el-form-item label="${po.content}">
								<el-input  type="password" name="${po.fieldName}" v-model="${subsG['${key}'].entityName?uncap_first}Form.${po.fieldName}"></el-input>
							</el-form-item>
						<#elseif po.showType=='date'>
							<el-form-item label="${po.content}">
								<el-date-picker type="date" name="${po.fieldName}" placeholder="选择${po.content}" v-model="${subsG['${key}'].entityName?uncap_first}Form.${po.fieldName}"></el-date-picker>
							</el-form-item>
						<#elseif po.showType=='datetime'>
							<el-form-item label="${po.content}">
								 <el-date-picker type="datetime" name="${po.fieldName}" placeholder="选择${po.content}" v-model="${subsG['${key}'].entityName?uncap_first}Form.${po.fieldName}"></el-date-picker>
							</el-form-item>
						<#elseif po.showType=='checkbox'>
							<el-form-item label="${po.content}">
								<el-select name="${po.fieldName}" v-model="${subsG['${key}'].entityName?uncap_first}Form.${po.fieldName}" multiple placeholder="请选择${po.content}">
							       <el-option :label="option.typename" :value="option.typecode" v-for="option in ${po.dictField}Options"></el-option>
							    </el-select>
							</el-form-item>
						<#elseif po.showType=='select' || po.showType=='list' || po.showType=='radio'>
							<el-form-item label="${po.content}">
								<el-select name="${po.fieldName}" v-model="${subsG['${key}'].entityName?uncap_first}Form.${po.fieldName}" placeholder="请选择${po.content}">
							       <el-option :label="option.typename" :value="option.typecode" v-for="option in ${po.dictField}Options"></el-option>
							    </el-select>
							</el-form-item>
						<#else>
							<el-form-item label="${po.content}" prop="${po.fieldName}">
								<el-input name="${po.fieldName}" v-model="${subsG['${key}'].entityName?uncap_first}Form.${po.fieldName}" auto-complete="off" placeholder="请输入${po.content}"></el-input>
							</el-form-item>
						</#if>
							</el-col>
						</#list>
						</el-row>
					</el-form>
				<#else>
					<el-table size="mini" :data="${subsG['${key}'].entityName?uncap_first}List" class="tb-edit" highlight-current-row style="width: 100%;">
				  		<#list subColumnsMap['${key}'] as po>
				  		<#if po.isShow=="Y">
				  		<el-table-column prop="${po.fieldName}" label="${po.content}" min-width="${po.fieldLength}">
				  			<template scope="scope">
				  				<#if po.showType=='text'>
			                    <el-input size="mini" name="${po.fieldName}" v-model="scope.row.${po.fieldName}" placeholder="${po.content}"></el-input>
			                    <#elseif po.showType=='textarea'>
			                    <el-input size="mini" name="${po.fieldName}" type="textarea" v-model="scope.row.${po.fieldName}" placeholder="${po.content}"></el-input>
			                    <#elseif po.showType=='date'>
								<el-date-picker  size="mini" name="${po.fieldName}" type="date" placeholder="选择${po.content}" v-model="scope.row.${po.fieldName}"></el-date-picker>
								<#elseif po.showType=='datetime'>
								<el-date-picker  size="mini" name="${po.fieldName}" type="datetime" placeholder="选择${po.content}" v-model="scope.row.${po.fieldName}"></el-date-picker>
								<#elseif po.showType=='checkbox'>
								<el-select name="${po.fieldName}" v-model="scope.row.${po.fieldName}" multiple placeholder="请选择${po.content}"  size="mini">
							       <el-option :label="option.typename" :value="option.typecode" v-for="option in ${po.dictField}Options"></el-option>
							    </el-select>
								<#elseif po.showType=='select' || po.showType=='list' || po.showType=='radio'>
								<el-select name="${po.fieldName}" v-model="scope.row.${po.fieldName}" placeholder="请选择${po.content}"  size="mini">
							       <el-option :label="option.typename" :value="option.typecode" v-for="option in ${po.dictField}Options"></el-option>
							    </el-select>
			                    <#else>
			                    <el-input size="mini" name="${po.fieldName}" v-model="scope.row.${po.fieldName}" placeholder="${po.content}"></el-input>
			                    </#if>
			                </template>
				  		</el-table-column>
				  		</#if>
				  		</#list>
				  		
				  		<el-table-column label="操作" width="50">
			                <template scope="scope">
								<a @click="handleRowDelete('${subsG['${key}'].entityName?uncap_first}List',scope.$index, scope.row)"><i class="el-icon-minus"></i></a>
								<a @click="handle${subsG['${key}'].entityName?cap_first}Add('${subsG['${key}'].entityName?uncap_first}List',scope.$index, scope.row)"><i class="el-icon-plus"></i></a>
			                </template>
			            </el-table-column>
				  	</el-table>
				</#if>
				</el-tab-pane>
				</#list>
			</el-tabs>
	</form>
	</div>
</body>
<script src="https://unpkg.com/vue/dist/vue.js"></script>
<script src="https://cdn.bootcss.com/vue-resource/1.5.0/vue-resource.js"></script>  
<script src="https://unpkg.com/element-ui@2.3.7/lib/index.js"></script>
<script src="https://cdn.bootcss.com/jquery/3.3.1/jquery.js"></script>
<script src="https://cdn.bootcss.com/layer/3.1.0/layer.js"></script>
<!-- Jquery组件引用 -->
<script src="https://cdn.bootcss.com/jquery/1.12.3/jquery.min.js"></script>
<!-- Validform组件引用 -->
<script src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
<script src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
<script src="plug-in/Validform/js/datatype_zh-cn.js"></script>
<script src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script>
<!-- 验证提示 -->
<script src="plug-in/themes/bootstrap-ext/js/common.js"></script>
<script>
	var valid=null;
	$(function(){
		valid=$("#form").Validform({
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
						setTimeout(function(){validationMessage(o.obj,msg);},500);
					}else{
						validationMessage(o.obj,msg);
					}
				}else{
					removeMessage(o.obj);
				}
			},
			btnSubmit : "#btn_sub",
			ajaxPost : true,
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
	var vue = new Vue({ 			
		el:"#${entityName?uncap_first}Form",
		data() {
			return {
				url:{
					save:'${entityName?uncap_first}Controller.do?doAdd',
					edit:'${entityName?uncap_first}Controller.do?doUpdate',
					queryDict:'systemController.do?typeListJson',
					upload:'systemController/filedeal.do',
					<#list subtables as key>
					${subsG['${key}'].entityName?uncap_first}List:'${entityName?uncap_first}Controller.do?${subsG['${key}'].entityName?uncap_first}List',
					</#list>
				},

				//新增界面数据
				addForm: {
					<#list pageColumns as po>
					<#if po.showType=='checkbox'>
					${po.fieldName}:[],
					</#if>
					</#list>
				}, 
				formFile: {
				<#list pageColumns as po>
				<#if po.showType=='file' || po.showType == 'image'>
					main_${po.fieldName}:[],
				</#if>
				</#list>
				},
				<#assign optionCodes="">
				<#list subtables as key>
				//子表数据对象
				<#if subsG['${key}'].cgFormHead.relationType==1 >
				${subsG['${key}'].entityName?uncap_first}List:[],
				${subsG['${key}'].entityName?uncap_first}Form:{
					<#list subColumnsMap['${key}'] as po>
			  		<#if po.isShow=="Y" && po.showType=='checkbox'>
			  		${po.fieldName}:[],
			  		</#if>
			  		</#list>
				},
				<#else>
				${subsG['${key}'].entityName?uncap_first}List:[{
					<#list subColumnsMap['${key}'] as po>
			  		<#if po.isShow=="Y" && po.showType=='checkbox'>
			  		${po.fieldName}:[],
			  		</#if>
			  		</#list>
				}],
				</#if>
				//子表数据字典对象
				<#list subColumnsMap['${key}'] as po>
		   		<#if po.showType=='select' || po.showType=='list' || po.showType=='checkbox' || po.showType=='radio'>
		   		<#if optionCodes?index_of(po.dictField) lt 0>
		   		<#assign optionCodes=optionCodes+","+po.dictField >
		   		${po.dictField}Options:[],
		   		</#if>
		   		</#if>
		   		</#list>
				</#list>
				<#list pageColumns as mpo>
	    	 	<#if mpo.showType=='select' || mpo.showType=='list'  || mpo.showType=='checkbox' || mpo.showType=='radio'>
	    	 	<#if optionCodes?index_of(mpo.dictField) lt 0>
		   		<#assign optionCodes=optionCodes+","+mpo.dictField >
		   		${mpo.dictField}Options:[],
		   		</#if>
	    	 	</#if>
	    	 	</#list>
			}
		},
		methods: {
			<#list pageColumns as po>
			<#if po.showType=='file' || po.showType == 'image'>
			handleMain${po.fieldName?cap_first}UploadFile: function(response, file, fileList){
				file.url=response.obj;
				this.addForm.${po.fieldName}=response.obj;
				if(fileList.length>1){
					this.handleRemoveFile(fileList.splice(0,1)[0],fileList);
				}
			},
			handleMain${po.fieldName?cap_first}RemoveFile: function(file, fileList){
				if(fileList.length==0){
					this.addForm.${po.fieldName}="";
				}
				this.$http.get(this.url.upload,{
					params:{
						isdel:'1',
						path:file.url
					}
				}).then((res) => {
				});
			},
			</#if>
			</#list>
			formatDate: function(row,column,cellValue, index){
				return !!cellValue?utilFormatDate(new Date(cellValue), 'yyyy-MM-dd'):'';
			},
			formatDateTime: function(row,column,cellValue, index){
				return !!cellValue?utilFormatDate(new Date(cellValue), 'yyyy-MM-dd hh:mm:ss'):'';
			},
			<#list subtables as key>
			<#if subsG['${key}'].cgFormHead.relationType==0 >
			handle${subsG['${key}'].entityName?cap_first}Add(rowsName,index, row) {
	        	this[rowsName].push({
	        		<#list subColumnsMap['${key}'] as po>
			  		<#if po.isShow=="Y" && po.showType=='checkbox'>
			  		${po.fieldName}:[]
			  		</#if>
			  		</#list>
	        	});
	        	this.addValidType();
	        },
	        </#if>
	      	//获取子表数据
			get${subsG['${key}'].entityName?cap_first}List(id){
				this.${subsG['${key}'].entityName?uncap_first}List=[{
					<#list subColumnsMap['${key}'] as po>
			  		<#if po.isShow=="Y" && po.showType=='checkbox'>
			  		${po.fieldName}:[]
			  		</#if>
			  		</#list>
				}];
				if(!id){
					return;
				}
				this.${'$'}http.get(this.url.${subsG['${key}'].entityName?uncap_first}List,{
					params: {
						id:id
					}
				}).then((res) => {
					if(res.data.length>0){
						for (var i = 0; i < res.data.length; i++) {
							var data = res.data[i];
							<#list subColumnsMap['${key}'] as po>
					  		<#if po.isShow=="Y" && po.showType=='checkbox'>
					  		data.${po.fieldName}=!!data.${po.fieldName}?data.${po.fieldName}.split(','):[];
					  		</#if>
					  		</#list>
						}
						this.${subsG['${key}'].entityName?uncap_first}List = res.data;
					}
					<#if subsG['${key}'].cgFormHead.relationType==1 >
					this.${subsG['${key}'].entityName?uncap_first}Form=this.${subsG['${key}'].entityName?uncap_first}List[0];
					</#if>
				});
			},
			</#list>
	        handleRowDelete(rowsName,index, row) {
	        	this[rowsName].splice(index, 1);
	        },
			//显示编辑界面
			initForm: function (row) {
				if(!!row){
					this.addForm = Object.assign({}, row);
					<#list pageColumns as po>
					<#if po.showType=='file' || po.showType == 'image'>
					var ${po.fieldName}=[];
					if(!!this.addForm.${po.fieldName}){
						${po.fieldName}=[{
							name:this.addForm.${po.fieldName}.substring(this.addForm.${po.fieldName}.lastIndexOf('\\')+1),
							url:this.addForm.${po.fieldName}
						}]
					}
					</#if>
					</#list>
					this.formFile={
						<#list pageColumns as po>
						<#if po.showType=='file' || po.showType == 'image'>
						${po.fieldName}:${po.fieldName},
						</#if>
						</#list>
					};
					//加载子表列表
					<#list subtables as key>
					this.get${subsG['${key}'].entityName?cap_first}List(this.addForm.id);
					</#list>
				}
				this.initDictsData();
				this.addValidType();
			},
			//初始化校验
			addValidType:function(){
	        	<#list pageColumns as po>
				<#if po.isShow == 'Y' && po.showType !='checkbox'>
				<@datatypeJs descriptb="${ftl_description}" po = po/>
				</#if>
	    	 	</#list>
	    	 	setTimeout(function(){
	    	 	<#list subtables as key>
	    	 	<#list subColumnsMap['${key}'] as spo>
    	 		<#if spo.isShow == 'Y' && spo.showType !='checkbox'>
    	 		<@datatypeJs descriptb="${subsG['${key}'].ftlDescription}" po = spo/>
    	 		</#if>
	    	 	</#list>
	    	 	</#list>
	    	 	},1000);
	        },
			//初始化数据字典
			initDictsData:function(){
	        	var _this = this;
	        	<#assign optionCodes="">
	        	<#list subtables as key>
		   		<#list subColumnsMap['${key}'] as po>
		   		<#if po.showType=='select' || po.showType=='list' || po.showType=='checkbox' || po.showType=='radio'>
		   		<#if optionCodes?index_of(po.dictField) lt 0>
		   		<#assign optionCodes=optionCodes+","+po.dictField >
		   		_this.initDictByCode('${po.dictField}',_this,'${po.dictField}Options');
		   		</#if>
		   		</#if>
	    	 	</#list>
	    	 	</#list>
	    		<#list pageColumns as mpo>
	    	 	<#if mpo.showType=='select' || mpo.showType=='list'  || mpo.showType=='checkbox' || mpo.showType=='radio'>
	    	 	<#if optionCodes?index_of(mpo.dictField) lt 0>
		   		<#assign optionCodes=optionCodes+","+mpo.dictField >
		   		_this.initDictByCode('${mpo.dictField}',_this,'${mpo.dictField}Options');
		   		</#if>
	    	 	</#if>
	    	 	</#list>
	        },
	        initDictByCode:function(code,_this,dictOptionsName){
	        	if(!code || !_this[dictOptionsName] || _this[dictOptionsName].length>0)
	        		return;
	        	this.${'$'}http.get(this.url.queryDict,{params: {typeGroupName:code}}).then((res) => {
	        		var data=res.data;
					if(data.success){
					  _this[dictOptionsName] = data.obj;
					  _this[dictOptionsName].splice(0, 1);//去掉请选择
					}
				});
	        },
			//新增
			addSubmit: function () {
				if(!valid.check(true)){
					return false;
				}
				var _this=this;
				_this.${'$'}confirm('确认提交吗？', '提示', {}).then(() => {
					let para = Object.assign({}, _this.addForm);
					<#list pageColumns as po>
					<#if po.showType=='date'>
					para.${po.fieldName} = !para.${po.fieldName} ? '' : utilFormatDate(new Date(para.${po.fieldName}), 'yyyy-MM-dd');
					<#elseif po.showType=='datetime'>
					para.${po.fieldName} = !para.${po.fieldName} ? '' : utilFormatDate(new Date(para.${po.fieldName}), 'yyyy-MM-dd hh:mm:ss');
					<#elseif po.showType=='checkbox'>
					para.${po.fieldName} = para.${po.fieldName}.join(',');
					</#if>
					</#list>
					<#list subtables as key>
					<#if subsG['${key}'].cgFormHead.relationType==1 >
					_this.${subsG['${key}'].entityName?uncap_first}List.splice(0,1,_this.${subsG['${key}'].entityName?uncap_first}Form);
					</#if>
					</#list>
					<#list subtables as key>
					for (var i = 0; i < _this.${subsG['${key}'].entityName?uncap_first}List.length; i++) {
						_this.${subsG['${key}'].entityName?uncap_first}List[i].test4=!_this.${subsG['${key}'].entityName?uncap_first}List[i].test4 ? '' : utilFormatDate(new Date(_this.manyOneList[i].test4), 'yyyy-MM-dd');
						<#list subColumnsMap['${key}'] as po>
				  		<#if po.isShow=="Y">
				  		<#if po.showType=='checkbox'>
				  		_this.${subsG['${key}'].entityName?uncap_first}List[i].${po.fieldName}=_this.${subsG['${key}'].entityName?uncap_first}List[i].${po.fieldName}.join(',');
				  		<#elseif po.showType=='date'>
				  		_this.${subsG['${key}'].entityName?uncap_first}List[i].${po.fieldName}=!_this.${subsG['${key}'].entityName?uncap_first}List[i].${po.fieldName} ? '' : utilFormatDate(new Date(_this.${subsG['${key}'].entityName?uncap_first}List[i].${po.fieldName}), 'yyyy-MM-dd');
				  		<#elseif po.showType=='datetime'>
				  		_this.${subsG['${key}'].entityName?uncap_first}List[i].${po.fieldName}=!_this.${subsG['${key}'].entityName?uncap_first}List[i].${po.fieldName} ? '' : utilFormatDate(new Date(_this.${subsG['${key}'].entityName?uncap_first}List[i].${po.fieldName}), 'yyyy-MM-dd hh:mm:ss');
				  		</#if>
				  		</#if>
				  		</#list>
					}
					para.${subsG['${key}'].entityName?uncap_first}ListStr=JSON.stringify(_this.${subsG['${key}'].entityName?uncap_first}List);
					</#list>
					var url=_this.url.save;
					if(!!para.id)url=_this.url.edit;
					_this.${'$'}http.post(url,para,{emulateJSON: true}).then((res) => {
						var win = window.parent;
						var index = parent.layer.getFrameIndex(window.name); //获取窗口索引
						parent.layer.close(index); 
						win.vue.get${entityName?cap_first}s();
						var data=res.data;
						if (data.success == true) {
							win.vue.${'$'}message({
								message: '提交成功',
								type: 'success',
								duration:1500
							});
						} else {
							win.vue.${'$'}message({
								message: '提交失败',
								type: 'error',
								duration:1500
							});
						}
					});
				});
			},
		}
	});
	
	function utilFormatDate(date, pattern) {
        pattern = pattern || "yyyy-MM-dd";
        return pattern.replace(/([yMdhsm])(\1*)/g, function (${'$'}0) {
            switch (${'$'}0.charAt(0)) {
                case 'y': return padding(date.getFullYear(), ${'$'}0.length);
                case 'M': return padding(date.getMonth() + 1, ${'$'}0.length);
                case 'd': return padding(date.getDate(), ${'$'}0.length);
                case 'w': return date.getDay() + 1;
                case 'h': return padding(date.getHours(), ${'$'}0.length);
                case 'm': return padding(date.getMinutes(), ${'$'}0.length);
                case 's': return padding(date.getSeconds(), ${'$'}0.length);
            }
        });
    };
	function padding(s, len) {
	    var len = len - (s + '').length;
	    for (var i = 0; i < len; i++) { s = '0' + s; }
	    return s;
	};
</script>
</html>