<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<script type="text/javascript">
	$(function() {
		$('#demotree').tree({
			animate : true,
			url : 'demoController.do?pDemoList',
			onClick : function(node) {
				if ($('#demotree').tree('isLeaf', node.target)) {
					$.ajax({
						url:"demoController.do?demoTurn&id=" + node.id,
						dataType:'json',
						success:function(html){
							$("#demopanle").html(html+'<script type="text/javascript">$(function(){$("#demopanle").Validform({tiptype:4,btnSubmit:"#btn_sub",btnReset:"#btn_reset",ajaxPost:true,callback:function(data){var win = frameElement.api.opener;if(data.success==true){frameElement.api.close();win.tip(data.msg);}else{'+
									'if(data.responseText==""||data.responseText==undefined)$("#demopanle").html(data.msg);'+
									'else $("#demopanle").html(data.responseText); return false;}win.reloadTable();}});});<\/script>');
						}
					});
				} else {
					$('#demotree').tree('expand', node.target);
				}
			}
		});
		
	});
</script>
<div class="easyui-layout" fit="true">
<link rel="stylesheet" href="plug-in/Validform/css/divfrom.css" type="text/css">
<link rel="stylesheet" href="plug-in/Validform/css/style.css" type="text/css">
<link rel="stylesheet" href="plug-in/Validform/css/tablefrom.css" type="text/css">
<script type="text/javascript" src="plug-in/Validform/js/Validform_v5.3.1_min_zh-cn.js"></script> <script type="text/javascript" src="plug-in/Validform/js/Validform_Datatype_zh-cn.js"></script> <script
	type="text/javascript" src="plug-in/Validform/js/datatype_zh-cn.js"></script>
<div region="center" style="padding: 3px;" class="easyui-panel" id="demopanle"></div>
<div region="west" style="width: 150px;" title="DEMO分类" split="true">
<div class="easyui-panel" style="padding:0px;border:0px" fit="true" border="false">
<ul id="demotree">
</ul>
</div>
</div>
</div>
