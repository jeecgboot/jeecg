<#setting number_format="0.#####################">
<!DOCTYPE html>
<htmlclass="not-ie" lang="en">
<head>
	<base href="${basePath}/"/>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>编辑</title>
    <link href="${basePath}/online/template/${this_olstylecode}/css/bootstrap.min.css" rel="stylesheet">
    <link href="${basePath}/online/template/${this_olstylecode}/css/scojs.css" rel="stylesheet">
    <link href="${basePath}/online/template/${this_olstylecode}/css/sco.message.css" rel="stylesheet">
    <link href="${basePath}/online/template/${this_olstylecode}/css/style.css" rel="stylesheet">
    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <script src="${basePath}/plug-in/Formdesign/js/html5shiv.min.js"></script>
    <script src="${basePath}/plug-in/Formdesign/js/respond.min.js"></script>
    <![endif]-->
    <script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/jquery-1.9.1.js"></script>
    <script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/respond.min.js"></script>
    <script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/bootstrap.js"></script>
    <script type="text/javascript" src="${basePath}/online/template/${this_olstylecode}/js/sco.message.js"></script>
    <script type="text/javascript" src="${basePath}/plug-in/tools/curdtools_zh-cn.js"></script>
    <script type="text/javascript" src="${basePath}/plug-in/tools/dataformat.js"></script>
    <script type="text/javascript" src="${basePath}/plug-in/My97DatePicker/WdatePicker.js"></script>
    <link rel="stylesheet" href="${basePath}/plug-in/Validform/css/style.css" type="text/css"></link>
    <link rel="stylesheet" href="${basePath}/plug-in/uploadify/css/uploadify.css" type="text/css"></link>
    <script type="text/javascript" src="${basePath}/plug-in/uploadify/jquery.uploadify-3.1.js"></script>
    <script type="text/javascript" src="${basePath}/plug-in/tools/Map.js"></script>
    <script type="text/javascript" src="${basePath}/plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
    <script type="text/javascript" src="${basePath}/plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
    <script type="text/javascript" src="${basePath}/plug-in/Validform/js/datatype_zh-cn.js"></script>
    <script type="text/javascript" src="${basePath}/plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script>
</head>
<body>
<script type="text/javascript">

    jQuery(function(){
        //查看模式情况下,删除和上传附件功能禁止使用
        if(location.href.indexOf("goDetail.do")!=-1){
			$(".jeecgDetail").hide();
		}
		
		if(location.href.indexOf("goDetail.do")!=-1){
			//查看模式控件禁用
			$("#formobj").find(":input").attr("disabled","disabled");
			$("#closeButton").removeAttr("disabled");
		}
		if(location.href.indexOf("goAddButton.do")!=-1||location.href.indexOf("goUpdateButton.do")!=-1){
			//其他模式显示提交按钮
			$("#sub_tr").show();
		}
    });
    function upload() {
    <#list columns as po>
        <#if po.show_type=='file'>
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
<div class="container bs-docs-container" >
        <form class="form-horizontal" role="form" action="${basePath}/cgFormBuildController.do?saveOrUpdateMore" name="formobj" method="post" id="formobj">
            <div class="form-group mno">
                <div class="col-xs-4 col-sm-4 col-md-4  col-xs-offset-4 col-sm-offset-4 col-md-offset-4">
                    <h3 >${head.content}</h3>
                </div>
            </div>
            <input type="hidden" id="btn_sub" class="btn_sub"/>
            <input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
            <input type="hidden" name="id" value="${id?if_exists?html}" >
        <#list columnhidden as po>
            <input type="hidden" id="${po.field_name}" name="${po.field_name}" value="${data['${tableName}']['${po.field_name}']?if_exists?html}" >
        </#list>
                <#list columns as po>
                <div class="form-group mno">
                       <label class="col-xs-2 col-sm-2 col-md-2  col-xs-offset-2 col-sm-offset-2  col-md-offset-2  control-label Validform_label" >${po.content}:</label>
                <div class=" col-xs-6 col-sm-6 col-md-6">
                        <#if po.show_type=='text'>
                            <input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
                                    class="form-control" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
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
                                    </#if></#if> />

                        <#elseif po.show_type=='password'>
                            <input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  type="password"
                                    class="form-control" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
                                    <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                                <#if po.field_valid_type?if_exists?html != ''>
                                   datatype="${po.field_valid_type?if_exists?html}"
                                <#else>
                                   <#if po.is_null != 'Y'>datatype="*"</#if>
                                </#if>>

                        <#elseif po.show_type=='radio'>
                            <@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
                                <#list dataList as dictdata>
                                <label class="radio-inline">
                                    <input value="${dictdata.typecode?if_exists?html}" ${po.extend_json?if_exists} name="${po.field_name}" type="radio"
                                    <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                                           <#if dictdata_index==0&&po.is_null != 'Y'>datatype="*"</#if>
                                        <#if dictdata.typecode?if_exists?html=="${data['${tableName}']['${po.field_name}']?if_exists?html}"> checked="true" </#if>>
                                ${dictdata.typename?if_exists?html}
                                </label>
                                </#list>
                            </@DictData>

                        <#elseif po.show_type=='checkbox'>
                            <#assign checkboxstr>${data['${tableName}']['${po.field_name}']?if_exists?html}</#assign>
                            <#assign checkboxlist=checkboxstr?split(",")>
                            <@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
                                <#list dataList as dictdata>
                                <label class="checkbox-inline">
                                    <input value="${dictdata.typecode?if_exists?html}" ${po.extend_json?if_exists} name="${po.field_name}" type="checkbox" 
                                    <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                                           <#if dictdata_index==0&&po.is_null != 'Y'>datatype="*"</#if>
                                        <#list checkboxlist as x >
                                            <#if dictdata.typecode?if_exists?html=="${x?if_exists?html}"> checked="true" </#if></#list>>
                                ${dictdata.typename?if_exists?html}
                                </label>
                                </#list>
                            </@DictData>

                        <#elseif po.show_type=='list'>
                            <@DictData name="${po.dict_field?if_exists?html}" text="${po.dict_text?if_exists?html}" tablename="${po.dict_table?if_exists?html}" var="dataList">
                                <select id="${po.field_name}" class="form-control" ${po.extend_json?if_exists} name="${po.field_name}" 
                                <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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

                        <#elseif po.show_type=='date'>
                            <input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text" class="form-control"
                                    value="<#if data['${tableName}']['${po.field_name}']??>${data['${tableName}']['${po.field_name}']?if_exists?string("yyyy-MM-dd")}</#if>"
                                   class="form-control Wdate" onClick="WdatePicker()"
                                   <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                                <#if po.field_valid_type?if_exists?html != ''>
                                   datatype="${po.field_valid_type?if_exists?html}"
                                <#else>
                                   <#if po.is_null != 'Y'>datatype="*"</#if>
                                </#if>>

                        <#elseif po.show_type=='datetime'>
                            <input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text" class="form-control"
                                     value="<#if data['${tableName}']['${po.field_name}']??>${data['${tableName}']['${po.field_name}']?if_exists?string("yyyy-MM-dd HH:mm:ss")}</#if>"
                                   class="form-control Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
                                   <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
									<#-- update--end--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
                                <#if po.field_valid_type?if_exists?html != ''>
                                   datatype="${po.field_valid_type?if_exists?html}"
                                <#else>
                                   <#if po.is_null != 'Y'>datatype="*"</#if>
                                </#if>>

                        <#elseif po.show_type=='popup'>
                            <input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"  type="text"
                                    class="searchbox-inputtext form-control"
                                   onClick="inputClick(this,'${po.dict_text?if_exists?html}','${po.dict_table?if_exists?html}');"
                                   value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
                                <#if po.field_valid_type?if_exists?html != ''>
                                   datatype="${po.field_valid_type?if_exists?html}"
                                <#else>
                                   <#if po.is_null != 'Y'>datatype="*"</#if>
                                </#if>>

                        <#elseif po.show_type=='file'>
                            <table class="table">
                                <#list filesList as fileB>
                                    <#if fileB['field'] == po.field_name>
                                        <tr style="height:34px;">
                                            <td>${fileB['title']}</td>
                                            <td><a href="${basePath}/commonController.do?viewFile&fileid=${fileB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity" title="下载">下载</a></td>
                                            <td><a href="javascript:void(0);" onclick="openwindow('预览','${basePath}/commonController.do?openViewFile&fileid=${fileB['fileKey']}&subclassname=org.jeecgframework.web.cgform.entity.upload.CgUploadEntity','fList',700,500)">预览</a></td>
                                            <td><a href="javascript:void(0)" class="jeecgDetail" onclick="del('${basePath}/cgUploadController.do?delFile&id=${fileB['fileKey']}',this)">删除</a></td>
                                        </tr>
                                    </#if>
                                </#list>
                            </table>
                            <div class="form jeecgDetail">
                                <script type="text/javascript">
                                    var serverMsg="";
                                    var m = new Map();
                                    $(function(){$('#${po.field_name}').uploadify(
                                            {buttonText:'添加文件',
                                                auto:false,
                                                progressData:'speed',
                                                multi:true,
                                                height:25,
                                                overrideEvents:['onDialogClose'],
                                                fileTypeDesc:'文件格式:',
                                                queueID:'filediv_${po.field_name}',
                                                <#-- fileTypeExts:'*.rar;*.zip;*.doc;*.docx;*.txt;*.ppt;*.xls;*.xlsx;*.html;*.htm;*.pdf;*.jpg;*.gif;*.png',   页面弹出很慢解决 20170317 scott -->
                                                fileSizeLimit:'15MB',swf:'${basePath}/plug-in/uploadify/uploadify.swf',
                                                uploader:'${basePath}/cgUploadController.do?saveFiles&jsessionid='+$("#sessionUID").val()+'',
                                                onUploadStart : function(file) {
                                                    var cgFormId=$("input[name='id']").val();
                                                    $('#${po.field_name}').uploadify("settings", "formData", {'cgFormId':cgFormId,'cgFormName':'${tableName?if_exists?html}','cgFormField':'${po.field_name}'});} ,
                                                onQueueComplete : function(queueData) {
                                                    var win = frameElement.api.opener;
                                                    win.reloadTable();
                                                    win.tip(serverMsg);
                                                    frameElement.api.close();},
                                                onUploadSuccess : function(file, data, response) {var d=$.parseJSON(data);if(d.success){var win = frameElement.api.opener;serverMsg = d.msg;}},onFallback : function(){tip("您未安装FLASH控件，无法上传图片！请安装FLASH控件后再试")},onSelectError : function(file, errorCode, errorMsg){switch(errorCode) {case -100:tip("上传的文件数量已经超出系统限制的"+$('#${po.field_name}').uploadify('settings','queueSizeLimit')+"个文件！");break;case -110:tip("文件 ["+file.name+"] 大小超出系统限制的"+$('#${po.field_name}').uploadify('settings','fileSizeLimit')+"大小！");break;case -120:tip("文件 ["+file.name+"] 大小异常！");break;case -130:tip("文件 ["+file.name+"] 类型不正确！");break;}},
                                                onUploadProgress : function(file, bytesUploaded, bytesTotal, totalBytesUploaded, totalBytesTotal) { }});});

                                </script><span id="file_uploadspan"><input type="file" name="${po.field_name}" id="${po.field_name}" /></span>
                            </div>
                            <div class="form" id="filediv_${po.field_name}"> </div>
                        <#else>
                            <input id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}" type="text"
                                    class="form-control" value="${data['${tableName}']['${po.field_name}']?if_exists?html}"
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
                                    </#if></#if>>
                        </#if>
                        <span class="Validform_checktip"></span>
                        <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
                    </div>
                </div>
                </#list>

                <#list columnsarea as po>
                    <div class="form-group mno">
                        <label class="col-xs-2 col-sm-2 col-md-2  col-xs-offset-2 col-sm-offset-2  col-md-offset-2 control-label Validform_label" >${po.content}:</label>
                        <div class="col-xs-6 col-sm-6 col-md-6">
						<textarea id="${po.field_name}" ${po.extend_json?if_exists} name="${po.field_name}"
                                   class="form-control inputxt" rows="5"
                                    <#-- update--begin--author:zhangjiaqiang Date:20170417 for:增加校验必填项 -->
									<#if po.field_must_input??><#if po.field_must_input == 'Y' || po.is_null != 'Y'>ignore="checked"<#else>ignore="ignore"</#if></#if>
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
            <script type="text/javascript">$(function(){$("#formobj").Validform({tiptype:1,btnSubmit:"#btn_sub",btnReset:"#btn_reset",ajaxPost:true,usePlugin:{passwordstrength:{minLen:6,maxLen:18,trigger:function(obj,error){if(error){obj.parent().next().find(".Validform_checktip").show();obj.find(".passwordStrength").hide();}else{$(".passwordStrength").show();obj.parent().next().find(".Validform_checktip").hide();}}}},callback:function(data){if(data.success==true){uploadFile(data);}else{if(data.responseText==''||data.responseText==undefined){$.scojs_message( data.msg,$.scojs_message.TYPE_ERROR);$.Hidemsg();}else{try{var emsg = data.responseText.substring(data.responseText.indexOf('错误描述'),data.responseText.indexOf('错误信息')); $.scojs_message( emsg,$.scojs_message.TYPE_ERROR);;$.Hidemsg();}catch(ex){$.scojs_message( data.responseText+'',$.scojs_message.TYPE_ERROR);}} return false;}if(!neibuClickFlag){var win = frameElement.api.opener; win.reloadTable();}}});});</script>
        </form>
    </div>

<!-- 模态框（Modal） -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
     aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button id="closeButton" class="close" data-dismiss="modal"
                        aria-hidden="true">×
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    预览
                </h4>
            </div>
            <div class="modal-body" style="width: 700px;height: 500px;">
                <iframe src="" id="modal-url" style="width: 80%;height: 80%;"/>
            </div>
        </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</body>
</html>