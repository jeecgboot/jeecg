<!DOCTYPE html>
<html>
 <head>
  <title>DEMO示例</title>
  <script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script><script type="text/javascript" src="plug-in/tools/dataformat.js"></script><link id="easyuiTheme" rel="stylesheet" href="plug-in/easyui/themes/default/easyui.css" type="text/css"></link><link rel="stylesheet" href="plug-in/easyui/themes/icon.css" type="text/css"></link><link rel="stylesheet" type="text/css" href="plug-in/accordion/css/accordion.css"><script type="text/javascript" src="plug-in/easyui/jquery.easyui.min.1.3.2.js"></script><script type="text/javascript" src="plug-in/easyui/locale/zh-cn.js"></script><script type="text/javascript" src="plug-in/tools/syUtil.js"></script><script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script><script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js"></script>
  <!--//update--begin--author:zhangjiaqiang date:20170315 for:修订layer对话框风格-->
	<script type="text/javascript" src="plug-in/layer/layer.js"></script>
	<!--//update--end--author:zhangjiaqiang date:20170315 for:修订layer对话框风格-->
  <script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script><script type="text/javascript" src="plug-in/tools/easyuiextend.js"></script>
 </head>
 <body style="overflow-y: hidden" scroll="no">
  <form id="formobj" action="cgFormBuildController.do?saveOrUpdate" name="formobj" method="post">
			<input type="hidden" id="btn_sub" class="btn_sub"/>
			<input type="hidden" name="tableName" value="${tableName?if_exists?html}" >
			<input type="hidden" name="id" value="${id?if_exists?html}" >
			<table style="width: 600px;" cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right" width="15%" nowrap>
						<label class="Validform_label">
							用户名:
						</label>
					</td>
					<td class="value" width="85%">
							<input id="name" class="inputxt" name="name"
								value="${name?if_exists?html}" datatype="*">
							<span class="Validform_checktip">用户名范围在2~10位字符</span>
					</td>
				</tr>

			</table>
		<link rel="stylesheet" href="plug-in/Validform/css/style.css" type="text/css"/><link rel="stylesheet" href="plug-in/Validform/css/tablefrom.css" type="text/css"/><script type="text/javascript" src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script><script type="text/javascript" src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script><script type="text/javascript" src="plug-in/Validform/js/datatype_zh-cn.js"></script><SCRIPT type="text/javascript" src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></SCRIPT><script type="text/javascript">$(function(){$("#formobj").Validform({tiptype:4,btnSubmit:"#btn_sub",btnReset:"#btn_reset",ajaxPost:true,usePlugin:{passwordstrength:{minLen:6,maxLen:18,trigger:function(obj,error){if(error){obj.parent().next().find(".Validform_checktip").show();obj.find(".passwordStrength").hide();}else{$(".passwordStrength").show();obj.parent().next().find(".Validform_checktip").hide();}}}},callback:function(data){var win = frameElement.api.opener;if(data.success==true){frameElement.api.close();win.tip(data.msg);}else{if(data.responseText==''||data.responseText==undefined)$("#formobj").html(data.msg);else $("#formobj").html(data.responseText); return false;}win.reloadTable();}});});</script></form>
 </body>
