<html
xmlns:m="http://schemas.microsoft.com/office/2004/12/omml">





<script type="text/javascript" src="plug-in/jquery/jquery-1.8.3.js"></script><script type="text/javascript" src="plug-in/tools/dataformat.js"></script><link id="easyuiTheme" rel="stylesheet" href="plug-in/easyui/themes/default/easyui.css" type="text/css"></link><link rel="stylesheet" href="plug-in/easyui/themes/icon.css" type="text/css"></link><link rel="stylesheet" type="text/css" href="plug-in/accordion/css/accordion.css"></link><script type="text/javascript" src="plug-in/easyui/jquery.easyui.min.1.3.2.js"></script><script type="text/javascript" src="plug-in/easyui/locale/zh-cn.js"></script><script type="text/javascript" src="plug-in/tools/syUtil.js"></script><script type="text/javascript" src="plug-in/My97DatePicker/WdatePicker.js"></script><script type="text/javascript" src="plug-in/lhgDialog/lhgdialog.min.js"></script><script type="text/javascript">$(function(){$("#formobj").Validform({tiptype:4,btnSubmit:"#btn_sub",btnReset:"#btn_reset",ajaxPost:true,usePlugin:{passwordstrength:{minLen:6,maxLen:18,trigger:function(obj,error){if(error){obj.parent().next().find(".Validform_checktip").show();obj.find(".passwordStrength").hide();}else{$(".passwordStrength").show();obj.parent().next().find(".Validform_checktip").hide();}}}},callback:function(data){if(data.success==true){if(!neibuClickFlag){var win = frameElement.api.opener;frameElement.api.close();win.tip(data.msg);win.reloadTable();}else {alert(data.msg)}}else{if(data.responseText==''||data.responseText==undefined)$("#formobj").html(data.msg);else $("#formobj").html(data.responseText); return false;}if(!neibuClickFlag){var win = frameElement.api.opener;win.reloadTable();}}});});</script><script type="text/javascript" src="plug-in/tools/curdtools_zh-cn.js"></script><script type="text/javascript" src="plug-in/tools/easyuiextend.js"></script><link rel="stylesheet" href="plug-in/Validform/css/style.css" type="text/css"/><link rel="stylesheet" href="plug-in/Validform/css/tablefrom.css" type="text/css"/><script type="text/javascript" src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script><script type="text/javascript" src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script><script type="text/javascript" src="plug-in/Validform/js/datatype_zh-cn.js"></script><script type="text/javascript" src="plug-in/Validform/plugin/passwordStrength/passwordStrength-min.js"></script><style>body{font-size:12px;}table{border: 1px solid #000000;padding:0; margin:0 auto;border-collapse: collapse;width:100%;align:right;}td {border: 1px solid #000000;background: #fff;font-size:12px;padding: 3px 3px 3px 8px;color: #000000;word-break: keep-all;}</style>
<body  >

<div  >

<p  align=center >请假单</p>

<form action="cgFormBuildController.do?saveOrUpdate" id="formobj" name="formobj" method="post">
<input type="hidden" name="tableName" value="${tableName?if_exists?html}"/>
<input type="hidden" name="id" value="${id?if_exists?html}"/>
<input type="hidden" id="btn_sub" class="btn_sub"/>
#{jform_hidden_field}<table  border=1 cellspacing=0 cellpadding=0
 >
 <tr >
  <td width=142  >
  <p  >请假标题</p>
  </td>
  <td width=142  >
  <p  >#{title}</p>
  </td>
  <td width=142  >
  <p  >请假开始时间</p>
  </td>
  <td width=142  >
  <p  >#{begindate}</p>
  </td>
 </tr>
 <tr >
  <td width=142  >
  <p  >请假人</p>
  </td>
  <td width=142  >
  <p  >#{people}</p>
  </td>
  <td width=142  >
  <p  >请假结束时间</p>
  </td>
  <td width=142  >
  <p  >#{enddate}</p>
  </td>
 </tr>
 <tr >
  <td width=142  >
  <p  >性别</p>
  </td>
  <td width=142  >
  <p  >#{sex}</p>
  </td>
  <td width=142  >
  <p  >所属部门</p>
  </td>
  <td width=142  >
  <p  >#{hol_dept}</p>
  </td>
 </tr>
 <tr >
  <td width=142  >
  <p  >请假原因</p>
  </td>
  <td width=426 colspan=3  >
  <p  >#{hol_reson}</p>
  </td>
 </tr>
 <tr >
  <td width=142  >
  <p  >部门审批人</p>
  </td>
  <td width=426 colspan=3  >
  <p  >#{dep_leader}</p>
  </td>
 </tr>
 <tr >
  <td width=142  >
  <p  >部门审批意见</p>
  </td>
  <td width=426 colspan=3  >
  <p  >#{content}</p>
  </td>
 </tr>
</table>
</form>

<p ></p>

</div>

</body>

</html>
