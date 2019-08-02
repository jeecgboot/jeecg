<#setting number_format="0.#####################">
<#include "online/template/ui/tag.ftl"/>
﻿<html>
	<head>
		<base href="${basePath}/"/>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
		<meta name="viewport" content="width=device-width,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no" />
		<meta name="keywords" content="Jeecg 移动表单" />
		<meta name="description" content="Jeecg 移动表单" />
		<title>Jeecg 移动表单</title>
		<link type="text/css" rel="stylesheet" href="${basePath}/online/template/${this_olstylecode}/css/formviewm.css" />
		<link type="text/css" rel="stylesheet" href="${basePath}/online/template/${this_olstylecode}/css/theme/default.css" />
		<#--<link rel="stylesheet" href="${basePath}/plug-in/bootstrap3.3.5/css/bootstrap.min.css">-->
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/head.load.min.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/jquery/jquery-1.9.1.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/jquery-plugs/i18n/jquery.i18n.properties.js"></script>
  		<script type="text/javascript" src="${basePath}/plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/lang-cn.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/ajaxfileupload.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/address-cn.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/utils.js"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/My97DatePicker/WdatePicker.js"></script>
		<link rel="stylesheet" href="${basePath}/plug-in/uploadify/css/uploadify.css" type="text/css"></link>
		<#--update-begin--Author:taoYan  Date:20180821 for： Online上传改造 -->
  		<#-- script type="text/javascript" src="${basePath}/plug-in/uploadify/jquery.uploadify-3.1.js"></script -->
  		<script type="text/javascript" src="${basePath}/plug-in/plupload/plupload.full.min.js"></script>
  		<script type="text/javascript" src="${basePath}/plug-in/tools/Map.js"></script>
  		<link rel="stylesheet" href="${basePath}/plug-in/webuploader/custom.css" type="text/css"></link>
  		<#--update-end--Author:taoYan  Date:20180821 for： Online上传改造 -->
  		<!-- Validform组件引用 -->
		<link href="${basePath}/plug-in/themes/bootstrap-ext/css/validform-ext.css" rel="stylesheet" />
		<script type="text/javascript" src="${basePath}/plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/Validform/js/datatype_zh-cn.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script>
		<script src="${basePath}/plug-in/themes/bootstrap-ext/js/common.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/lhgDialog/lhgdialog.min.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/tools/curdtools.js"></script>
		<style id="__wechat_default_css">
			::-webkit-scrollbar{
				width: 10px;
				height: 10px;
				background-color: #FFF;
			}
			::-webkit-scrollbar-button:start:decrement,::-webkit-scrollbar-button:end:increment{
				display: block;
			}
			::-webkit-scrollbar-button:vertical:start:increment,::-webkit-scrollbar-button:vertical:end:decrement{
				display: none;
			}
			::-webkit-scrollbar-button:end:increment{
				background-color: transparent;
			}
			::-webkit-scrollbar-button:start:decrement{
				background-color: transparent;
			}
			::-webkit-scrollbar-track-piece:vertical:start{
				background-color: transparent;
			}
			::-webkit-scrollbar-track-piece:vertical:end{
				background-color: transparent;
			}
			::-webkit-scrollbar-thumb:vertical{
				background: rgb(191, 191, 191);
			}
			.upload_generate {
				font-size:13px;
			}
			.li_upload{
				padding:0 !important;
				clear:none !important;
				float:left;
			}
			/*update-begin-author:toayan date:20181112 for:TASK #3153 JEECG 问题确认处理 -->4.Online 单表移动模板，文件上 传格式太丑*/
			.uploadify-button{
				width: 100% !important;
			    background-color: #3598dc !important;
			    background-image: -webkit-gradient(linear, 0% 100%, 0% 0%, from(#3598dc), to(#5cade2));
			    border: 1px solid #3598dc;
			    color: #fff !important;
			    font-size: 14px;
			    font-family: Hiragino Sans GB;
			    height: 28px !important;
			    line-height: 28px !important;
			    border-radius: 4px;
			}
			.list-li{ 
				-webkit-transform: translateX(0px);
				border:1px solid #ddd;
				border-right:none;
			}
			.os-file-type {
			    background-size:36px 36px;
			    display: inline-block;
			    width: 36px;
			    height: 36px;
			    vertical-align:middle;
			}
			 .os-file-name{
				display: inline-block;
				height: 36px;
				width: 100px;
				vertical-align:middle;
				font-size: 12px;
			}
			 .os-file-del{ 
			 	position: absolute; 
			 	top: -2px; right: -80px;
			  	text-align: center; 
			  	font-family: Hiragino Sans GB;
			  	font-size:14px;
			  	background: #ffcb20; color: #fff; 
			  	width: 80px;
			  	height: 40px;
			  	line-height: 40px;
			}
	/*update-end-author:toayan date:20181112 for:TASK #3153 JEECG 问题确认处理 -->4.Online 单表移动模板，文件上 传格式太丑*/
	</style>
	</head>
	<body class="wallpaper wallpaperm">
	<div id="container" class="container" mobile="1">
		<div>
			<h1 id="logo" class="logo"><a></a></h1>
		</div>
		<div class="ui-content">
			<form id="formobj" class="form" action="${basePath}/cgFormBuildController.do?saveOrUpdate" name="formobj" method="post">
				<input type="hidden" id="btn_sub" class="btn_sub"/>
				<input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
				<input type="hidden" name="id" value="${id?if_exists?html}" >
				<#list columnhidden as po>
				  <input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
				</#list>
				<ul id="fields" class="fields">
					<#list columns as po>
						<#if po.show_type=='text'>
							<li id="${po.field_name}" class="clearfix " typ="name" reqd="1">
								<label class="desc">${po.content}:<#if po.is_null != 'Y'><span class="req">*</span></#if></label>
								<div class="content">
									<input 
										type="text" 
										maxlength="256" 
										class="ui-input-text xl input fld" 
										name="${po.field_name}" 
										id="${po.field_name}" 
										${po.extend_json?if_exists}
										value="${data['${tableName}']['${po.field_name}']?if_exists?html}" 
										<#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
										<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
										<#if po.field_valid_type?if_exists?html != ''>
											<#if po.field_valid_type=='only'>
								       		   validType="${tableName},${po.field_name},id"
								       		   datatype="*"
								       		<#else>
							                   datatype="${po.field_valid_type?if_exists?html}"
							               </#if>
											<#else>
												<#if po.type == 'int'>
													datatype="n" 
													<#elseif po.type=='double'>
													datatype="/^(-?\d+)(\.\d+)?$/"
													<#else>
													<#if po.is_null != 'Y'>datatype="*"</#if>
												</#if>
										</#if>
									/>
								</div>
							</li>
							<#elseif po.show_type=='password'>
								<li id="${po.field_name}" class="clearfix " typ="password" reqd="1">
									<label class="desc">${po.content}: <#if po.is_null != 'Y'><span class="req">*</span></#if></label>
									<div class="content">
										<input 
											type="text" 
											maxlength="256" 
											class="ui-input-text xl input fld" 
											name="${po.field_name}" 
											id="${po.field_name}" 
											${po.extend_json?if_exists}
											value="${data['${tableName}']['${po.field_name}']?if_exists?html}" 
											<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
											<#if po.field_valid_type?if_exists?html != ''>
												datatype="${po.field_valid_type?if_exists?html}" 
												<#else>
													<#if po.is_null != 'Y'>datatype="*"</#if>
											</#if>
										/>
									</div>
								</li>
							<#elseif po.show_type=='radio'>
								<li id="${po.field_name}" class="clearfix " typ="radio" reqd="1">
									<label class="desc">${po.content} <#if po.is_null != 'Y'><span class="req">*</span></#if></label>
									<div class="content">
										<fieldset class="controlgroup">
											<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
												<#list dataList as dictdata> 
													<label <#if dictdata_index==0>class="first"</#if>>
														<input 
															value="${dictdata.typecode?if_exists?html}" 
															${po.extend_json?if_exists} 
															name="${po.field_name}" 
															type="radio" 
															<#if dictdata_index==0&&po.is_null != 'Y'>datatype="*"</#if> 
															<#if po.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
															<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}"> checked="true</#if> 
														/><label></label>${dictdata.typename?if_exists?html}
													</label>
												</#list> 
											</@DictData>
										</fieldset>
									</div>
								</li>
							<#elseif po.show_type=='checkbox'>
								<li id="${po.field_name}" class="clearfix " typ="radio" reqd="1">
									<label class="desc">${po.content}: <#if po.is_null != 'Y'><span class="req">*</span></#if></label>
									<div class="content">
										<fieldset class="controlgroup">
											<#assign checkboxstr>${data['${tableName}']['${po.field_name}']?if_exists?html}</#assign>
											<#assign checkboxlist=checkboxstr?split(",")>
											<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
												<#list dataList as dictdata> 
													<label <#if dictdata_index==0>class="first"</#if>>
														<input 
															value="${dictdata.typecode?if_exists?html}" 
															${po.extend_json?if_exists} 
															name="${po.field_name}" 
															type="checkbox" 
															<#if po.operationCodesReadOnly?if_exists>onclick="return false;"</#if>
															<#if dictdata_index==0&&po.is_null != 'Y'>datatype="*"</#if> 
															<#list checkboxlist as x >
																<#if dictdata.typecode?if_exists?html=="${x?if_exists?html}"> checked="true" </#if>
															</#list>
														/><label></label>${dictdata.typename?if_exists?html}
													</label>
												</#list> 
											</@DictData>
										</fieldset>
									</div>
								</li>
							<#elseif po.show_type=='list'>
								<li id="${po.field_name}" class="clearfix " typ="list">
									<label class="desc">${po.content}:<#if po.is_null != 'Y'><span class="req">*</span></#if></label>
									<div class="content">
											<@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
												<select 
													id="${po.field_name}" 
													${po.extend_json?if_exists} 
													name="${po.field_name}" 
													<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
												<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
												<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
													<#if po.operationCodesReadOnly?if_exists>
														onfocus="this.defOpt=this.selectedIndex" onchange="this.selectedIndex=this.defOpt;"</#if><#if po.is_null != 'Y'>datatype="*"
													</#if> 
													class="ui-input-select fld"
													>
													<#list dataList as dictdata> 
														<option 
															value="${dictdata.typecode?if_exists?html}" 
															<#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}">
																selected="selected"
															</#if>>${dictdata.typename?if_exists?html}
														</option> 
													</#list> 
												</select>
											</@DictData>
									</div>
								</li>
							<#elseif po.show_type=='date'>
								<li id="${po.field_name}" class="clearfix " typ="date" reqd="1">
									<label class="desc">${po.content}: <#if po.is_null != 'Y'><span class="req">*</span></#if></label>
									<div class="content">
										<input 
											type="text" 
											maxlength="256" 
											class="ui-input-text xl input fld Wdate" 
											name="${po.field_name}" 
											id="${po.field_name}" 
											${po.extend_json?if_exists}
											value="<#if data['${tableName}']['${po.field_name}']??>${data['${tableName}']['${po.field_name}']?if_exists?string("yyyy-MM-dd")}</#if>"
											onClick="WdatePicker({<#if po.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
											<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
											<#if po.field_valid_type?if_exists?html != ''>
												datatype="${po.field_valid_type?if_exists?html}" 
												<#else>
													<#if po.is_null != 'Y'>datatype="*"</#if>
											</#if>
										/>
									</div>
								</li>
							<#elseif po.show_type=='datetime'>
								<li id="${po.field_name}" class="clearfix " typ="date" reqd="1">
									<label class="desc">${po.content}: <#if po.is_null != 'Y'><span class="req">*</span></#if></label>
									<div class="content">
										<input 
											type="text" 
											maxlength="256" 
											class="ui-input-text xl input fld" 
											name="${po.field_name}" 
											id="${po.field_name}" 
											${po.extend_json?if_exists}
											value="<#if data['${tableName}']['${po.field_name}']??>${data['${tableName}']['${po.field_name}']?if_exists?string("yyyy-MM-dd HH:mm:ss")}</#if>"
											onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'<#if po.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
											<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if po.operationCodesReadOnly?exists> readonly = "readonly"</#if>
											<#if po.field_valid_type?if_exists?html != ''>
												datatype="${po.field_valid_type?if_exists?html}" 
												<#else>
													<#if po.is_null != 'Y'>datatype="*"</#if>
											</#if>
										/>
									</div>
								</li>
							<#-- update-begin-author:taoYan date:20180903 for:移动模板文件上传改造 -->
							<#elseif po.show_type=='file'>
								<li class="clearfix " typ="name" reqd="1">
									<label class="desc">${po.content}:<#if po.is_null != 'Y'><span class="req">*</span></#if></label>
									<@uploadFile po = po />
								</li>
							<#elseif po.show_type=='image'>
								<li class="clearfix " typ="name" reqd="1">
									<label class="desc">${po.content}:<#if po.is_null != 'Y'><span class="req">*</span></#if></label>
									<@uploadImg po = po />
								</li>
							<#-- update-end-author:taoYan date:20180903 for:移动模板文件上传改造 -->
						</#if>
					</#list>
					<#list columnsarea as po>
						<li id="${po.field_name}" class="clearfix " typ="textarea">
							<label class="desc">${po.content}: <#if po.is_null != 'Y'><span class="req">*</span></#if></label>
							<div class="content">
								<textarea 
									id="${po.field_name}" ${po.extend_json?if_exists} 	
									class="ui-input-text s detail fld" 
									name="${po.field_name}"
									<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
							<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
							<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.operationCodesReadOnly?if_exists>readonly = "readonly" </#if>
									<#if po.field_valid_type?if_exists?html != ''>datatype="${po.field_valid_type?if_exists?html}" 
										<#else>
											<#if po.is_null != 'Y'>datatype="*" </#if> 
									</#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}</textarea>
							</div>
						</li>
					</#list>
					<#-- 提交按钮 -->
					<li>
						<div id = "sub_tr" style="display: none;">
							<input id="btnSubmit" type="button" onclick="neibuClick();" class="btn-submit" value="提交" />
						</div>
					</li>
					</ul>
				</form>
				<div style="display:block !important;" class="powerby">由<a href="#">JEECG</a>提供技术支持</div>
			</div>
			<div id="status" class="mobile hide"></div>
			<script type="text/javascript">
				var isEmbed=false,F={"DISSHARE":""};
				var RULE={FIELDSRULE:[]};
				var ADVPERM={};

				var signature={"timestamp":"1452579499","appId":"wxa88dd90f5f559968","nonceStr":"36d3857e-4ff1-4843-ad06-4a4c45518f79","jsapi_ticket":"sM4AOVdWfPE4DxkXGEs8VEwkz5fST0hI4gaRTYdQMTfWeqiKRj_EWv8_UDScCucbx1cyUO2_vwkS8mHo2k_ZnQ","signature":"1e7512cc14f6d833d8d2d11b3393ee22d7862fec","url":""};
				var isForMobile=true;
				//var IMAGEURL="",FILEIMAGEEDITSTYLE="@100w_90Q";
				//head.js("js/jquery-1.7.2.min.js",'js/lang-cn.js?v=20151214','js/ajaxfileupload.js?v=20151214','js/address-cn.js?v=20151214',
				//"js/utils.js?v=20151214",
				//"js/formview.js?v=20151214","http://res.wx.qq.com/open/js/jweixin-1.0.0.js");

				//微信分享自动带图片和说明
				head.ready(function(){
					$(function(){
						var title =$("#formHeader div:eq(0)").text();;
						var urlImg= $(".logo a").css("backgroundImage");
						var url = window.location.href;
						if("none"==urlImg){
							var img = $(".image-img:eq(0)")[0];
							if( typeof(img) != "undefined"){
									urlImg =img.src;
							}
						}else{
							//urlImg="url(htpp://xxxx)";
							var reg = new RegExp("[a-zA-z]+://[^\\s^\\)]*");
							urlImg = urlImg.match(reg)[0];
						}
						if(!window.signature){
							return;
						}
						wx.config({
						　　　　debug: false,
						　　　　appId:signature.appId,
						　　　　timestamp:parseInt(signature.timestamp),
						　　　　nonceStr: signature.nonceStr,
						　　　　signature:signature.signature,
						　　　　jsApiList: ['onMenuShareTimeline','onMenuShareAppMessage','onMenuShareQQ','onMenuShareWeibo','onMenuShareQZone']
							　　});
						wx.ready(function(){
							wx.onMenuShareTimeline({
								title:title,
								link: url,
								imgUrl:urlImg,
								success: function () {
									// 用户确认分享后执行的回调函数
								},
								cancel: function () {
									// 用户取消分享后执行的回调函数
								}
							});
							wx.onMenuShareAppMessage({
								title:'', // 分享标题
								desc: title, // 分享描述
								link: url, // 分享链接
								imgUrl:urlImg, // 分享图标
								type: '', // 分享类型,music、video或link，不填默认为link
								dataUrl: '', // 如果type是music或video，则要提供数据链接，默认为空
								success: function () {
									// 用户确认分享后执行的回调函数
								},
								cancel: function () {
									// 用户取消分享后执行的回调函数
								}
							});
						});
					});
				});

				 var neibuClickFlag = false;
				 function neibuClick() {
			        neibuClickFlag = true;
			        $('#btn_sub').trigger('click');
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
			    
		    	<#-- update-begin-author:taoYan date:20180903 for:移动模板文件上传改造 -->
			    function upload() {
			    	var iattachment = getFileIDArray();
				    var icgFormId = $("input[name='id']").val();
					$.ajax({
						async : false,
						cache : false,
						url:"cgUploadController.do?updateCgformFile",
						data:{
							'cgFormName':'${tableName?if_exists?html}',
	    					'cgFormId':icgFormId,
	    					'attachment': iattachment
						},
						type:"POST",
						dataType:"JSON",
						error : function() {// 请求失败处理函数
						},
						success : function(data) {
							if (data.success) {
								 var win = frameElement.api.opener;
								 win.reloadTable();
								 win.tip("操作成功！");
								 frameElement.api.close();
							}else{
								tip(data.msg);
							}
						}
					});
			    }
			   	function getFileIDArray(){
			    	var arr = [];
			     	<#list columns as po>
				       <#if po.show_type=='file' || po.show_type=='image'>
				             var ${po.field_name}_attachment = [];
				    		 $("#${po.field_name}thelist").find('.uploadify-queue-item').each(function(){
				    		 	var temp = $(this).attr("id");
				    		 	if(!!temp){
				    		 		if($(this).is(":hidden")){
				    		 			temp = temp+"_D";//删除文件
				    		 		}else if($(this).hasClass('history')){
				    		 			temp = temp+"_O";//老文件
				    		 		}
				    		 		${po.field_name}_attachment.push(temp);
				    		 	}
					         });
					         if(${po.field_name}_attachment.length>0){
					        	arr.push({cgFormField:'${po.field_name}',attachment: ${po.field_name}_attachment.join(',')});
					         }
				        </#if>
				    </#list>
			        return JSON.stringify(arr);
		    	}
			    <#-- update-end-author:taoYan date:20180903 for:移动模板文件上传改造 -->
			    
			    $(function(){
			    	if(location.href.indexOf("goAddButton.do")!=-1||location.href.indexOf("goUpdateButton.do")!=-1){
						//其他模式显示提交按钮
						$("#sub_tr").show();
					}	
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
										obj.parent().next().find(
												".Validform_checktip")
												.show();
										obj.find(".passwordStrength")
												.hide();
									} else {
										$(".passwordStrength").show();
										obj.parent().next().find(
												".Validform_checktip")
												.hide();
									}
								}
							}
						},
						callback : function(data) {
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
				            }else{
				                alert(data.msg);
			                    neibuClickFlag = false;
				            }
							}
						});
					});
		</script>
	</div>
</body>
<#-- update--begin--author:liushaoqian date:20180713 for:TASK #2961 【online表单--张伟健】测试问题 -->
<script type="text/javascript">${js_plug_in?if_exists}</script>	
<#-- update--end--author:liushaoqian date:20180713 for:TASK #2961 【online表单--张伟健】测试问题 -->
</html>