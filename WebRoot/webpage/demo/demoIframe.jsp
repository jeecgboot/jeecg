<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	$(function() {
		$('#demotree').tree({
			animate : true,
			url : 'demoController.do?pDemoList',
			onClick : function(node) {
				if ($('#demotree').tree('isLeaf', node.target)) {
				//	$('#demopanle').panel("refresh", "demoController.do?demoTurn&id=" + node.id + "&page=" + node.attributes.href);
					$.ajax({
						url:"demoController.do?demoTurn&id=" + node.id,
						dataType:'json',
						success:function(html){
							$("#demopanle").html(html+'<script type="text/javascript">$(function(){$("#demopanle").Validform({tiptype:4,btnSubmit:"#btn_sub",btnReset:"#btn_reset",ajaxPost:true,callback:function(data){var win = frameElement.api.opener;if(data.success==true){frameElement.api.close();win.tip(data.msg);}else{'+
									'if(data.responseText==""||data.responseText==undefined)$("#demopanle").html(data.msg);'+
									'else $("#demopanle").html(data.responseText); return false;}win.reloadTable();}});});<\/script>');
						}
					});
				//$('#demo').attr("src", "demoController.do?demoTurn&id=" + node.id + "&page=" + node.attributes.href);
				} else {
					$('#demotree').tree('expand', node.target);
				}
			}
		});
		
	});
</script>
<div class="easyui-layout" fit="true">
 <!-- update-begin--Author:TangHong  Date:20130515 for：[91]demo分类菜单中点击表单验证报错 -->
 <link rel="stylesheet" href="plug-in/Validform/css/divfrom.css" type="text/css">
 <link rel="stylesheet" href="plug-in/Validform/css/style.css" type="text/css">
 <link rel="stylesheet" href="plug-in/Validform/css/tablefrom.css" type="text/css">
 <script type="text/javascript" src="plug-in/Validform/js/Validform_v5.3.1_min.js"></script>
 <script type="text/javascript" src="plug-in/Validform/js/Validform_Datatype.js"></script>
 <script type="text/javascript" src="plug-in/Validform/js/datatype.js"></script>
 <!-- update-end--Author:TangHong  Date:20130515 for：[91]demo分类菜单中点击表单验证报错 -->
 
 <div region="center" style="padding: 3px;" class="easyui-panel" id="demopanle">
 
  <%--<iframe name="demo" id="demo" scrolling="no" frameborder="0" style="width: 100%; height: 99%;"></iframe>
 --%>
 </div>
 <div region="west" style="width: 150px;" title="DEMO分类" split="true">
  <div class="easyui-panel" style="padding:1px;" fit="true" border="false">
   <ul id="demotree">
   </ul>
  </div>
 </div>
</div>
