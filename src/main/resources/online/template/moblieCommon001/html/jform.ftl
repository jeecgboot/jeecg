<#setting number_format="0.#####################">
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
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/head.load.min.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/jquery-1.7.2.min.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/lang-cn.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/ajaxfileupload.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/address-cn.js"></script>
		<script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/utils.js"></script>
		<script type="text/javascript" src="http://res.wx.qq.com/open/js/jweixin-1.0.0.js"></script>
		<script type="text/javascript" src="${basePath}/plug-in/My97DatePicker/WdatePicker.js"></script>
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
		</style>
	</head>
	<body class="wallpaper wallpaperm">
	<div id="container" class="container" mobile="1">
		<div>
			<h1 id="logo" class="logo"><a></a></h1>
		</div>
		<div class="ui-content">
			<form id="form1" class="form" action="${basePath}/cgFormBuildController.do?saveOrUpdate" name="formobj" method="post">
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
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
										<#if po.field_valid_type?if_exists?html != ''>
											datatype="${po.field_valid_type?if_exists?html}" 
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
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
															<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
															<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
															<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
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
															<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
															<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
															<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
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
												<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
							<#elseif po.show_type=="textarea">
								<li id="${po.field_name}" class="clearfix " typ="textarea">
									<label class="desc">${po.content}: <#if po.is_null != 'Y'><span class="req">*</span></#if></label>
									<div class="content">
										<textarea 
											id="${po.field_name}" ${po.extend_json?if_exists} 
											placeholder="${po.content}" 
											class="ui-input-text s detail fld" 
											name="${po.field_name}"> 
											<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
											<#if po.operationCodesReadOnly?if_exists>readonly = "readonly" </#if>
											<#if po.field_valid_type?if_exists?html != ''>datatype="${po.field_valid_type?if_exists?html}" 
												<#else>
													<#if po.is_null != 'Y'>datatype="*" </#if> 
											</#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}
										</textarea>
									</div>
								</li>
							<#elseif po.show_type=='date'>
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
											value="<#if data['${tableName}']['${po.field_name}']??>${data['${tableName}']['${po.field_name}']?if_exists?string("yyyy-MM-dd")}</#if>"
											onClick="WdatePicker({<#if po.operationCodesReadOnly?if_exists> readonly = true</#if>})" 
											<#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
						</#if>
					</#list>
					<#-- 提交按钮 -->
					<li>
						<input id="btnSubmit" type="button" class="btn-submit" value="提交" />
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
				
				$(function() {
					$("#btnSubmit").click(function(){
						if(validateForm()){
							$.post(
							   '${basePath}/cgFormBuildController.do?saveOrUpdate',
							   $("#form1").serialize(),
							   function(data){
							   	  var d = $.parseJSON(data);
							   	  if(data.success){
				            		alert(d.msg);
				            	  }else{
				            		alert(d.msg);
				            	  }
							   }
							);
						}
					});
				 });
				 
				 function validateForm(){
				 	
				 	var flag = true;
				 	$("input[datatype]").each(function(){
				 	  var value = $(this).val(),$this = $(this);
				 	  if(value == ''){
				 		$this.focus();
				 		var html = $this.parent().prev().html();
				 		var s = html.indexOf(":");
				 		var new_html = html.substring(0,s);
				 		alert($.trim(new_html)+'不能为空!');
				 		flag = false;
				 		return false;
				 	  }
				 	});
				 	return flag;
				 }
		</script>
	</div>
</body>
</html>