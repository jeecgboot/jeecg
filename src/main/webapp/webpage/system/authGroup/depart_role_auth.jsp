<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>部门角色管理</title>
<t:base type="jquery,easyui,tools"></t:base>
<link rel="stylesheet" href="plug-in/ztree/css/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/ztree/js/ztreeCreator.js"></script>
</head>
<body>
	<div class="easyui-layout" fit="true" scroll="no">
		<div  data-options="region:'west',title:'部门角色管理',split:true" style="width:254px;overflow: auto;">
			<input style="width:120px;" type="text" id="supplier" name="supplier" placeholder="供应商检索"/>
			<a icon="icon-search" class="easyui-linkbutton l-btn l-btn-plain" onclick="selectSupplier()">
				<span class="bigger-110 no-text-shadow">检索</span>
			</a>
	        <div id="orgTree" class="ztree"></div>
		</div>
		<div id="iframeDiv" data-options="region:'center',border:false" style="text-align: center;overflow:hidden;">
			<iframe id="listFrame" src="" frameborder="no" width="100%" height="100%"></iframe>
		</div>
		<div class="hidden">
			<div id="orgMenu" class="easyui-menu" data-options="onClick:menuHandler" style="width: 120px;">
				<div data-options="name:'add'">添加角色</div>
				<div data-options="name:'edit'" >编辑角色</div> 
				<div data-options="name:'remove'">删除角色 </div> 
			</div>
		</div>
	</div>
</body>
</html>
<script>
$(function() {
	loadTree();
});
var flag = true;
var TimeFn = null;
//beforeDblClick事件
function beforeDbl(){
	flag = false;
	return true;
}
//加载树
var orgTree ;
function loadTree() {
	var zNodes;
	jQuery.ajax({  
        async : false,  
        cache:false,  
        type: 'POST',  
        dataType : "json",  
        url: 'departAuthGroupController.do?getDepartRoleTree',//请求的action路径  
        error: function () {//请求失败处理函数  
            alert('请求失败');  
        },  
        success:function(data){ //请求成功后处理函数。
            zNodes = data.obj;   //把后台封装好的简单Json格式赋给zNodes  
        }  
    });  
	var ztreeCreator = new ZtreeCreator('orgTree',"departAuthGroupController.do?getDepartRoleTree",zNodes)
 			.setCallback({onClick:zTreeOnLeftClick,onRightClick:zTreeOnRightClick,onDblClick:zTreeOnDblClick,beforeDblClick:beforeDbl})
 			.initZtree({},function(treeObj){orgTree = treeObj});
};

//左击
function zTreeOnLeftClick(event, treeId, treeNode) {
	var selectNode = getSelectNode();
	var level = selectNode.level;
	flag = true;
	clearTimeout(TimeFn);
	setTimeout(function(){
		if(flag){
			curSelectNode = treeNode;
			var parentId = treeNode.id;
			var url = "departAuthGroupController.do?departRoleAuthGroupRel&id="+selectNode.id;
			if(level == 0) {
				url = "departAuthGroupController.do?showDepartRoleAuth&id="+selectNode.id;
			}
			$("#listFrame").attr("src", url);
		}
	},301);
};
/**
 * 树右击事件
 */
function zTreeOnRightClick(e, treeId, treeNode) {	
	if (treeNode) {
		orgTree.selectNode(treeNode);
		curSelectNode=treeNode;
		var isfolder = treeNode.isFolder;
		var h = $(window).height();
		var w = $(window).width();
		var menuWidth = 120;
		var menuHeight = 75;
		var menu = null;
		if (treeNode != null) {
			menu = $('#orgMenu');
		}
		var x = e.pageX, y = e.pageY;
		if (e.pageY + menuHeight > h) {
			y = e.pageY - menuHeight;
		}
		if (e.pageX + menuWidth > w) {
			x = e.pageX - menuWidth;
		}
		menu.menu('show', {
			left : x,
			top : y
		});
	}
};
//双击事件
function zTreeOnDblClick(event, treeId, treeNode) {
	var selectNode = getSelectNode();
	var level = selectNode.level;
	curSelectNode = treeNode;
	var url = "departAuthGroupController.do?departRoleAuthGroupRel&id="+selectNode.id;
	if(level == 0) {
		url = "departAuthGroupController.do?showDepartRoleAuth&id="+selectNode.id;
	}
	$("#listFrame").attr("src", url);
}
//菜单对应项
function menuHandler(item) {
	if ('add' == item.name) {
		addNode();
	} else if ('remove' == item.name) {
		delNode();
	} else if ('sort' == item.name) {
		sortNode();
	} else if ('edit' == item.name) {
		editNode();
	} else if ('fresh' == item.name) {
		refreshNode();
	}
};
function refreshNode() {
	loadTree();
};

//添加节点
function addNode() {
	var selectNode = getSelectNode();
	if(selectNode.level == 1) {
		tip("不可再添加下级节点");
		return false;
	}
	if (!selectNode) 	return;
	var url = "departAuthGroupController.do?addDepartRoleAuth&id="+selectNode.id;
	$("#listFrame").attr("src", url);
};
//编辑节点
function editNode() {
	var selectNode = getSelectNode();
	var level = selectNode.level;
	if(level == 0) {
		tip('非超级管理员不可修改此管理员组');
		return false;
	}
	if (!selectNode) 	return;
	var url = "departAuthGroupController.do?updateDepartRoleAuth&id="+selectNode.id;
	$("#listFrame").attr("src", url);
};


//删除
function delNode() {
	var selectNode = getSelectNode();
	var nodeId = selectNode.id;
	if (nodeId == "0") {
		tip('该节点为根节点，不可删除');return;
	} 
	var url = "departAuthGroupController.do?delDepartRoleAuth&id="+selectNode.id;
	if(selectNode.isParent){
		tip('该节点下有子节点，不可删除!');return;
	}
	layer.confirm('确定删除该角色吗？',{
		btn:['确认','取消']
	},function() {
		jQuery.ajax({  
	        async : false,  
	        cache:false,  
	        type: 'GET',  
	        dataType : "json",  
	        url: url,//请求的action路径  
	        error: function () {//请求失败处理函数  
	            tip('请求失败');  
	        },  
	        success:function(data){ //请求成功后处理函数。
			    if(data.success){
			    	tip(data.msg);
			    	orgTree.removeNode(selectNode);
					//$("#listFrame").attr("src", "about:blank");
			    }else{
			    	tip(data.msg);
			    }
	        }  
	    });  
	},function(){
		return;
	});
};
//选择资源节点。
function getSelectNode() {
	orgTree = $.fn.zTree.getZTreeObj("orgTree");
	var nodes = orgTree.getSelectedNodes();
	var node = nodes[0];
	return node;
};

//查询供应商信息
function selectSupplier() {
	var supplier = $("#supplier").val();
	if (supplier == null || supplier.trim() == "") {
		loadTree();
	} else {
		jQuery.ajax({
			type : 'POST',
			dataType : "json",
			url : "departAuthGroupController.do?selectSupplier&supplier="+ supplier,
			error : function() {
				tip('查询供应商信息失败');
			},
			success : function(data) {
				var ztreeCreator = new ZtreeCreator('orgTree',"departAuthGroupController.do?getMainTreeData",data)
	 			.setCallback({onClick:zTreeOnLeftClick,onRightClick:zTreeOnRightClick,onDblClick:zTreeOnDblClick,beforeDblClick:beforeDbl})
	 			.initZtree({},function(treeObj){orgTree = treeObj});
			}
		});
	}
}
</script>
