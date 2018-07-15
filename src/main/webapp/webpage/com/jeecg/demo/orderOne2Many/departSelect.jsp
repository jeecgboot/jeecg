<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html >
<html>
<head>
<title>组织机构集合</title>
<link rel="stylesheet" type="text/css" href="plug-in/ztree/css/zTreeStyle.css"></link>
<style>
.inuptxt {
    /* border: 1px solid #a5aeb6; */
     background-color: #fff;
    border: 1px solid #D7D7D7;
    border-radius: 3PX;
    /* height: 14PX; */
    height: 30px;
    /* padding: 7px 0 7px 5px; */
    padding: 0 2px;
    line-height: 14PX;
    font-size: 12px;
    display: inline-block;
}
</style>
</head>
<body>
<t:base type="jquery"></t:base>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.excheck-3.5.min.js"></script>
<script type="text/javascript">
	var setting = {
	  check: {
		  	enable: true,
			chkStyle: "radio",
			radioType: "all"
		},
		data: {
			simpleData: {
				enable: true
			}
		}
		  ,callback: {
			onExpand: zTreeOnExpand
		}  
	};
	
	//加载展开方法
	function zTreeOnExpand(event, treeId, treeNode){
		 var treeNodeId = treeNode.id;
		 $.post(
			'jformOrderMainController.do?getSubContent',
			{parentid:treeNodeId},
			function(data){
				var d = $.parseJSON(data);
				if (d.success) {
					var dbDate = eval(d.msg);
					var tree = $.fn.zTree.getZTreeObj("departSelect");

					if (!treeNode.zAsync){
						tree.addNodes(treeNode, dbDate);
						treeNode.zAsync = true;
					} else{
						tree.reAsyncChildNodes(treeNode, "refresh");
					}
				}
			}
		);
	}
	function initSelectTree(name){
		$.post(
			'jformOrderMainController.do?getDepartInfo3',
		    {name :name},
			function(data){
				var d = $.parseJSON(data);
				if (d.success) {
					var dbDate = eval(d.msg);
					//console.log(d.msg);
					var treeObj = $.fn.zTree.init($("#departSelect"), setting, dbDate);
					treeObj.expandAll(true); 
				}
			});
	}
	//首次进入加载level为1的
	$(function(){
		initSelectTree('${defaultName}');
		$("#input_txt").bind("input propertychange",function(){
			var name = $(this).val();
			if(name.indexOf("'")<0){
				initSelectTree(name);
			}
		});
		
	});
</script>
<!-- type="text" -->
<input id="input_txt"  type="hidden" class = "inuptxt" value="${defaultName}" placeholder="请输入关键字搜索"/>
<input id="defaultName"  type="hidden" value="${defaultName}">
<ul id="departSelect" class="ztree"></ul>
</body>
</html>
