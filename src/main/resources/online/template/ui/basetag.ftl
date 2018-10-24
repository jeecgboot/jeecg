<#-- form页面js/css引入通用宏 -->
<#macro basetag webRoot="" lang="" style="" hasFile=false validform=true>
<#if webRoot!="">
<#local webRootf=webRoot+"/"/>
</#if>
<#if style=="bootstrap">
  <!-- Jquery组件引用 -->
  <script type="text/javascript" src="${webRootf!''}plug-in/jquery/jquery-1.9.1.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/jquery-plugs/i18n/jquery.i18n.properties.js"></script>
  <!-- bootstrap组件引用 -->
  <link rel="stylesheet" href="${webRootf!''}plug-in/bootstrap3.3.5/css/bootstrap.min.css">
  <script type="text/javascript" src="${webRootf!''}plug-in/bootstrap3.3.5/js/bootstrap.min.js"></script>
  <!-- icheck组件引用 -->
  <link href="${webRootf!''}plug-in/hplus/css/plugins/iCheck/custom.css" rel="stylesheet">
  <script type="text/javascript" src="${webRootf!''}plug-in/hplus/js/plugins/iCheck/icheck.min.js"></script>
  <!-- Validform扩展样式 -->
  <link rel="stylesheet" href="plug-in/themes/bootstrap-ext/css/validform-ext.css" />
  <!-- Layer组件引用 -->
  <script src="${webRootf!''}plug-in/layer/layer.js"></script>
  <script src="${webRootf!''}plug-in/laydate/laydate.js"></script>
  <!-- 通用组件引用 -->
  <link href="${webRootf!''}plug-in/bootstrap3.3.5/css/default.css" rel="stylesheet" />
  <script src="${webRootf!''}plug-in/themes/bootstrap-ext/js/common.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/tools/curdtools.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/lhgDialog/lhgdialog.min.js?skin=metrole"></script>
<#else>
  <link rel="stylesheet" href="${webRootf!''}online/template/ledefault/css/vendor.css">
  <link rel="stylesheet" href="${webRootf!''}online/template/ledefault/css/bootstrap-theme.css">
  <link rel="stylesheet" href="${webRootf!''}online/template/ledefault/css/bootstrap.css">
  <link rel="stylesheet" href="${webRootf!''}online/template/ledefault/css/app.css">
  <link rel="stylesheet" href="${webRootf!''}plug-in/Validform/css/metrole/style.css" type="text/css"/>
  <link rel="stylesheet" href="${webRootf!''}plug-in/Validform/css/metrole/tablefrom.css" type="text/css"/>
  
  <script type="text/javascript" src="${webRootf!''}plug-in/jquery/jquery-1.8.3.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/jquery-plugs/i18n/jquery.i18n.properties.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/tools/dataformat.js"></script>
  <link rel="stylesheet" href="${webRootf!''}plug-in/easyui/themes/metrole/easyui.css" type="text/css"></link>
  <script type="text/javascript" src="${webRootf!''}plug-in/easyui/jquery.easyui.min.1.3.2.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/easyui/locale/${lang}.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/tools/syUtil.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/My97DatePicker/WdatePicker.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/lhgDialog/lhgdialog.min.js"></script>
  <#--update--begin--author:scott Date:20170304 for:替换layer风格提示框-->
  <script type="text/javascript" src="${webRootf!''}plug-in/layer/layer.js"></script>
  <#--update--end--author:scott Date:20170304 for:替换layer风格提示框-->
  <script type="text/javascript" src="${webRootf!''}plug-in/tools/curdtools.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/tools/easyuiextend.js"></script>

  <script type="text/javascript"  charset="utf-8" src="${webRootf!''}plug-in/ueditor/ueditor.config.js"></script>
  <script type="text/javascript"  charset="utf-8" src="${webRootf!''}plug-in/ueditor/ueditor.all.min.js"></script>
</#if>

<#if validform==true>
  <script type="text/javascript" src="${webRootf!''}plug-in/Validform/js/Validform_v5.3.1_min_${lang}.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/Validform/js/Validform_Datatype_${lang}.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/Validform/js/datatype_${lang}.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script>
</#if> 
<#if hasFile==true>
  <link rel="stylesheet" href="${webRootf!''}plug-in/uploadify/css/uploadify.css" type="text/css"></link>
  <#--update-begin--Author:taoYan  Date:20180821 for： Online上传改造 -->
  <#-- script type="text/javascript" src="${webRootf!''}plug-in/uploadify/jquery.uploadify-3.1.js"></script -->
  <script type="text/javascript" src="${webRootf!''}plug-in/plupload/plupload.full.min.js"></script>
  <script type="text/javascript" src="${webRootf!''}plug-in/tools/Map.js"></script>
  <#--update-end--Author:taoYan  Date:20180821 for： Online上传改造 -->
</#if>
</#macro>