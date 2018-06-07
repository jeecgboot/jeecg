<%@ page language="java" import="java.util.*"
	contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>填值规则表</title>
<meta name="description" content="">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="online/template/ledefault/css/vendor.css">
<link rel="stylesheet"
	href="online/template/ledefault/css/bootstrap-theme.css">
<link rel="stylesheet"
	href="online/template/ledefault/css/bootstrap.css">
<link rel="stylesheet" href="online/template/ledefault/css/app.css">

<link rel="stylesheet" href="plug-in/Validform/css/metrole/style.css"
	type="text/css" />
<link rel="stylesheet"
	href="plug-in/Validform/css/metrole/tablefrom.css" type="text/css" />

<script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script>
<script type="text/javascript" src="plug-in/tools/dataformat.js"></script>
<script type="text/javascript"
	src="plug-in/easyui/jquery.easyui.min.1.3.2.js"></script>
<script type="text/javascript" src="plug-in/easyui/locale/zh-cn.js"></script>
<script type="text/javascript" src="plug-in/tools/syUtil.js"></script>
<script type="text/javascript"
	src="plug-in/My97DatePicker/WdatePicker.js"></script>
<script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js"></script>
<script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script>
<script type="text/javascript" src="plug-in/tools/easyuiextend.js"></script>
<script type="text/javascript"
	src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script>
<script type="text/javascript"
	src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script>
<script type="text/javascript"
	src="plug-in/Validform/js/datatype_zh-cn.js"></script>
<script type="text/javascript"
	src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script>
<script type="text/javascript" charset="utf-8"
	src="plug-in/ueditor/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8"
	src="plug-in/ueditor/ueditor.all.min.js"></script>

<script type="text/javascript">
  //编写自定义JS代码
  </script>
</head>

<body>
	<t:formvalid formid="formobj" dialog="true" usePlugin="password"
		layout="table" action="tSFillRuleController.do?doAdd" tiptype="1">
		<input type="hidden" id="btn_sub" class="btn_sub" />
		<input type="hidden" id="id" name="id" />
		<div class="tab-wrapper">
			<!-- tab -->
			<ul class="nav nav-tabs">
				<li role="presentation" class="active"><a
					href="javascript:void(0);">填值规则表</a></li>
			</ul>
			<!-- tab内容 -->
			<div class="con-wrapper" id="con-wrapper1" style="display: block;">
				<div class="row form-wrapper">
					<div class="row show-grid">
						<div class="col-xs-3 text-center">
							<b>规则code：</b>
						</div>
						<div class="col-xs-3">
							<input id="ruleCode" name="ruleCode" type="text"
								class="form-control" datatype="*" /> <span
								class="Validform_checktip" style="float: left; height: 0px;"></span>
							<label class="Validform_label" style="display: none">规则code</label>
						</div>
					</div>


					<div class="row show-grid">
						<div class="col-xs-3 text-center">
							<b>规则名称：</b>
						</div>
						<div class="col-xs-3">
							<input id="ruleName" name="ruleName" type="text"
								class="form-control" ignore="ignore" /> <span
								class="Validform_checktip" style="float: left; height: 0px;"></span>
							<label class="Validform_label" style="display: none">规则名称</label>
						</div>
					</div>


					<div class="row show-grid">
						<div class="col-xs-3 text-center">
							<b>规则实现类：</b>
						</div>
						<div class="col-xs-3">
							<input id="ruleClass" name="ruleClass" type="text" style="width: 380px"
								class="form-control" ignore="ignore" /> <span
								class="Validform_checktip" style="float: left; height: 0px;"></span>
							<label class="Validform_label" style="display: none">规则实现类</label>
						</div>
					</div>


					<div class="row show-grid">
						<div class="col-xs-3 text-center">
							<b>规则参数：</b>
						</div>
						<div class="col-xs-3">
							<textarea rows="7" cols="60" style="margin: 3px 0 4px 0;"
								id="ruleParam" name="ruleParam" class="form-control"
								ignore="ignore"></textarea>
							<span class="Validform_checktip"
								style="float: left; height: 0px;"></span> <label
								class="Validform_label" style="display: none">规则参数</label>
						</div>
					</div>




					<div class="row" id="sub_tr" style="display: none;">
						<div class="col-xs-12 layout-header">
							<div class="col-xs-6"></div>
							<div class="col-xs-6">
								<button type="button" onclick="neibuClick();"
									class="btn btn-default">提交</button>
							</div>
						</div>
					</div>
				</div>
			</div>

			<div class="con-wrapper" id="con-wrapper2" style="display: block;"></div>
		</div>
	</t:formvalid>

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
</body>
</html>