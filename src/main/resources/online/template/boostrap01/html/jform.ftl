<#setting number_format="0.#####################">
<#-- update-begin-author:taoyan date:20180705 for:宏封装 -->
<#include "online/template/ui/tag.ftl"/>
<#include "online/template/ui/basetag.ftl"/>
<#-- update-end-author:taoyan date:20180705 for: 宏封装 -->
<!DOCTYPE html>
<htmlclass="not-ie" lang="en">
<head>
  <base href="${basePath}/"/>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <title>编辑</title>
  <@basetag webRoot=basePath hasFile=true lang=lang style="bootstrap"/>
</head>
<body style="margin: 20px">
<script type="text/javascript">

    jQuery(function(){
    	if(location.href.indexOf("goAddButton.do")!=-1||location.href.indexOf("goUpdateButton.do")!=-1){
			//其他模式显示提交按钮
			$("#sub_tr").show();
		}
    
    	formControlInit();
        //查看模式情况下,删除和上传附件功能禁止使用
        if(location.href.indexOf("goDetail.do")!=-1){
			$(".jeecgDetail").hide();
		}
		
		if(location.href.indexOf("goDetail.do")!=-1){
			//查看模式控件禁用
			$("#formobj").find(":input").attr("disabled","disabled");
			$("#closeButton").removeAttr("disabled");
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
	            }
				}
			});
    });
    
    function formControlInit(){
		$(".laydate-datetime").each(function(){
			var _this = this;
			laydate.render({
			  elem: _this,
			  format: 'yyyy-MM-dd HH:mm:ss',
			  type: 'datetime',
			  ready: function(date){
			  	 $(_this).val(DateJsonFormat(date,this.format));
			  }
			});
		});
		$(".laydate-date").each(function(){
			var _this = this;
			laydate.render({
			  elem: _this,
			  format: 'yyyy-MM-dd',
			  ready: function(date){
			  	 $(_this).val(DateJsonFormat(date,this.format));
			  }
			});
		});
		//自定义checkbox、radio 样式
	    $('.i-checks').iCheck({
	        checkboxClass: 'icheckbox_square-green',
	        radioClass: 'iradio_square-green'
	    });
	}
    
    function upload() {
    <#list columns as po>
        <#if po.show_type=='file'>
            $('#${po.field_name}').uploadify('upload', '*');
        </#if>
        <#if po.show_type=='image'>
  			$('#${po.field_name}').uploadify('upload', '*');		
  		</#if>
    </#list>
    }
    var neibuClickFlag = false;
    function neibuClick() {
        neibuClickFlag = true;
        $('#btn_sub').trigger('click');
    }
    function cancel() {
    <#list columns as po>
        <#if po.show_type=='file'>
            $('#${po.field_name}').uploadify('cancel', '*');
        </#if>
        <#if po.show_type=='image'>
 	 		$('#${po.field_name}').uploadify('cancel', '*');
 	 	</#if>
    </#list>
    }
    function uploadFile(data){
        if(!$("input[name='id']").val()){
            <#--update-start--Author:luobaoli  Date:20150614 for：需要判断data.obj存在，才能取id值-->
            if(data.obj!=null && data.obj!='undefined'){
                $("input[name='id']").val(data.obj.id);
            }
            <#--update-end--Author:luobaoli  Date:20150614 for：需要判断data.obj存在，才能取id值-->
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
    function openwindow(title, url,name, width, height){
        $("#modal-url").attr("src",url);
        $('#myModal').modal("show");
    }
    function del(url,obj){
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
                        $.scojs_message("操作成功！",$.scojs_message.TYPE_OK)
                        $(obj).closest("tr").hide("slow");
                    }
                }
            });

    }
</script>
    <form class="form-horizontal" role="form" action="${basePath}/cgFormBuildController.do?saveOrUpdateMore" name="formobj" method="post" id="formobj">
       	<input type="hidden" id="btn_sub" class="btn_sub"/>
        <input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
        <input type="hidden" name="id" value="${id?if_exists?html}" >
    <#list columnhidden as po>
        <input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
    </#list>
            <#list columns as po>
            <div class="form-group">
                   <label class="col-sm-3 control-label" >${po.content}:</label>
            <div class="col-sm-7">
                    <#if po.show_type=='text'>
                        <input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
                                class="form-control input-sm required" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
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
                                </#if></#if> />

                    <#elseif po.show_type=='password'>
                        <input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  type="password"
                                class="form-control input-sm required" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
                                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                            <#if po.field_valid_type?if_exists?html != ''>
                               datatype="${po.field_valid_type?if_exists?html}"
                            <#else>
                               <#if po.is_null != 'Y'>datatype="*"</#if>
                            </#if>>

                    <#elseif po.show_type=='radio'>
                        <@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
                            <#list dataList as dictdata>
                                <input value="${dictdata.typecode?if_exists?html}" ${po.extend_json?if_exists} name="${po.field_name}" type="radio" class="i-checks"
                                       <#if dictdata_index==0&&po.is_null != 'Y'>datatype="*"</#if>
                                    <#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}"> checked="true" </#if>>
                            ${dictdata.typename?if_exists?html}
                            &nbsp;&nbsp;
                            </#list>
                        </@DictData>

                    <#elseif po.show_type=='checkbox'>
                        <#assign checkboxstr>${data['${tableName}']['${po.field_name}']?if_exists?html}</#assign>
                        <#assign checkboxlist=checkboxstr?split(",")>
                        <@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
                            <#list dataList as dictdata>
                                <input value="${dictdata.typecode?if_exists?html}" ${po.extend_json?if_exists} name="${po.field_name}" type="checkbox" class="i-checks"
                                       <#if dictdata_index==0&&po.is_null != 'Y'>datatype="*"</#if>
                                    <#list checkboxlist as x >
                                        <#if dictdata.typecode?if_exists?html=="${x?if_exists?html}"> checked="true" </#if></#list>>
                            ${dictdata.typename?if_exists?html}
                            </#list>
                            &nbsp;&nbsp;
                        </@DictData>

                    <#elseif po.show_type=='list'>
                    <div class="input-group" style="width:100%">
                        <@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
                            <span class="input-group-btn">
		                        <button class="btn btn-default input-sm" type="button">Go!</button>
		                    </span>	 
                            <select id="${po.field_name}" class="form-control input-sm" ${po.extend_json?if_exists} name="${po.field_name}" 
                            <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								 <#if po.is_null != 'Y'>datatype="*"</#if>>
                                <#list dataList as dictdata>
                                    <option value="${dictdata.typecode?if_exists?html}"
                                        <#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}"> selected="selected" </#if>>
                                    ${dictdata.typename?if_exists?html}
                                    </option>
                                </#list>
                            </select>
                        </@DictData>
                    </div>

                    <#elseif po.show_type=='date'>
                    <div class="input-group" style="width:100%">
                        <input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text" 
                                value="<#if data['${tableName}']['${po.field_name}']??>${data['${tableName}']['${po.field_name}']?if_exists?string("yyyy-MM-dd")}</#if>"
                               class="form-control input-sm laydate-date" 
                               <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                            <#if po.field_valid_type?if_exists?html != ''>
                               datatype="${po.field_valid_type?if_exists?html}"
                            <#else>
                               <#if po.is_null != 'Y'>datatype="*"</#if>
                            </#if>>
                            <span class="input-group-addon" >
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
		             </div>

                    <#elseif po.show_type=='datetime'>
                    <div class="input-group" style="width:100%">
                        <input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text" 
                                 value="<#if data['${tableName}']['${po.field_name}']??>${data['${tableName}']['${po.field_name}']?if_exists?string("yyyy-MM-dd HH:mm:ss")}</#if>"
                               class="form-control input-sm laydate-datetime" 
                               <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                            <#if po.field_valid_type?if_exists?html != ''>
                               datatype="${po.field_valid_type?if_exists?html}"
                            <#else>
                               <#if po.is_null != 'Y'>datatype="*"</#if>
                            </#if>>
                            <span class="input-group-addon" >
		                        <span class="glyphicon glyphicon-calendar"></span>
		                    </span>
		             </div>

                    <#elseif po.show_type=='popup'>
                        <input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  type="text"
                                class="form-control"
                               onClick="inputClick(this,'${po.dict_text?if_exists?html}','${po.dict_table?if_exists?html}');"
                               value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
                            <#if po.field_valid_type?if_exists?html != ''>
                               datatype="${po.field_valid_type?if_exists?html}"
                            <#else>
                               <#if po.is_null != 'Y'>datatype="*"</#if>
                            </#if>>

                    <#-- update--begin--author:taoyan date:20180514 for:【Online表单】上传空间宏封装 -->
					<#elseif po.show_type=='file' || po.show_type=='image'>
						<@uploadtag po = po />
					<#-- update--end--author:taoyan date:20180514 for:【Online表单】上传空间宏封装 -->
                    <#else>
                        <input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
                                class="form-control" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
                                 <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
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
                                </#if></#if>>
                    </#if>
                    <span class="Validform_checktip"></span>
                    <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
                </div>
            </div>
            </#list>

            <#list columnsarea as po>
                <div class="form-group">
                    <label class="col-sm-3 control-label" >${po.content}:</label>
                    <div class="col-sm-7">
					<textarea id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"
                               class="form-control inputxt" rows="5"
                                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
								<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if><#elseif po.is_null != "Y">ignore="checked"<#else>ignore="ignore"</#if>
								<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                        <#if po.field_valid_type?if_exists?html != ''>
                              datatype="${po.field_valid_type?if_exists?html}"
                        <#else>
                              <#if po.is_null != 'Y'>datatype="*"</#if>
                        </#if>>${data['${tableName}']['${po.field_name}']?if_exists?html}</textarea>
                        <span class="Validform_checktip"></span>
                        <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
                    </div>
                </div>
            </#list>
            <div id = "sub_tr" style="display: none;">
            	<input type="button" class="btn-submit" onclick="neibuClick();" value="提交" />
            </div>
    </form>
</body>
<style>
	.btn-submit {
		width: 60%;
	    padding: 10px 34px;
	    font-size: 100%;
	    margin-left: 23%;
	    background-color: #95a5a6;
	    border: 1px solid #879595;
	    color: #fff;
	}
</style>
</html>
<#-- update--begin--author:liushaoqian date:20180713 for:TASK #2961 【online表单--张伟健】测试问题 -->
<script type="text/javascript">${js_plug_in?if_exists}</script>	
<#-- update--end--author:liushaoqian date:20180713 for:TASK #2961 【online表单--张伟健】测试问题 -->