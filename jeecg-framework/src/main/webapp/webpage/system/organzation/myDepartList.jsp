<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>我的机构管理</title>
<t:base type="jquery,easyui,tools"></t:base>
<link rel="stylesheet" href="plug-in/ztree/css/zTreeStyle.css" type="text/css">
<script type="text/javascript" src="plug-in/ztree/js/jquery.ztree.core-3.5.min.js"></script>
<script type="text/javascript" src="plug-in/ztree/js/ztreeCreator.js"></script>
</head>
<body>
	<div class="easyui-layout" fit="true" scroll="no">
		<div  data-options="region:'west',title:'我的机构管理',split:true" style="width:200px;overflow: auto;">
		   <!-- update-begin--Author:Yandong  Date:20180402 for： TASK #2601 【严重样式问题】我的组织机构，在shortcut风格下样式有问题-->
		   <div style="width:105px;margin-left: 8px;margin-top: 2px;">
			<a  icon="icon-add" class="easyui-linkbutton l-btn l-btn-plain"  onclick="addOneNode()">
				<span class="bigger-110 no-text-shadow" style="width: 50px;">添加公司</span>
			</a>
			</div>
			<!-- update-begin--Author:Yandong  Date:20180402 for： TASK #2601 【严重样式问题】我的组织机构，在shortcut风格下样式有问题-->
			 <div class="clear"></div> 
	        <div id="orgTree" class="ztree"></div>
	        <input type="hidden" id="userName" name="userName" value="${userName}"/>
		</div>
		<div data-options="region:'center'" title="">
    <!-- <iframe width="100%" height="100%" id="center"  src="" style="border:1px #fff solid; background:#fff;"></iframe> -->
		<div id="tt" tabPosition="top" border=flase style="width:100%;height:100%;margin:0px;padding:0px;overflow-x:hidden;width:auto;" class="easyui-tabs" fit="true"></div>
        </div>

		<div class="hidden">
			<div id="orgMenu" class="easyui-menu" data-options="onClick:menuHandler" style="width: 120px;">
				<!-- <div data-options="name:'addSubCompany'">添加下级公司</div> -->
				<div data-options="name:'addSubOrg'">添加下级部门</div>
				<div data-options="name:'addSubJob'">添加下级岗位</div>
				<div data-options="name:'edit'">编辑</div> 
				<div data-options="name:'remove'">删除 </div> 
				<div data-options="name:'fresh'">刷新</div>
			</div>
			<div id="gysMenu" class="easyui-menu" data-options="onClick:menuHandler" style="width: 120px;">
				<div data-options="name:'addSubOrg'">添加下级部门</div>
				<div data-options="name:'addSubJob'">添加下级岗位</div>
				<div data-options="name:'editSupplier'">编辑</div> 
				<div data-options="name:'removeSupplier'">删除 </div> 
				<div data-options="name:'fresh'">刷新</div>
			</div>
			<div id="gysMenuGW" class="easyui-menu" data-options="onClick:menuHandler" style="width: 120px;">
				<div data-options="name:'addSubOrg'">添加下级部门</div>
				<div data-options="name:'addSubJob'">添加下级岗位</div>
				<div data-options="name:'editSupplier'">编辑</div> 
				<div data-options="name:'removeSupplier'">删除 </div> 
				<div data-options="name:'fresh'">刷新</div>
			</div>
			<div id="gysRootMenu" class="easyui-menu" data-options="onClick:menuHandler" style="width: 120px;">
				<div data-options="name:'fresh'">刷新</div>
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


function addtt(title, url, id, icon, closable) {
	$('#tt').tabs('add',{
						id : id,
						title : title,
						content : createFramett(id,url),
						closable : closable = (closable == 'false') ? false
								: true,
						icon : icon
	});
}
$('#tt').tabs({onSelect : function(title) {
						var p = $(this).tabs('getTab', title);
						var url = p.find('iframe').attr('src');
						p.find('iframe').attr('src',url);
					}
				});
function createFramett(id,url) {
	var s = '<iframe id="'+id+'" scrolling="yes" frameborder="0"  src="'+url+'" width="100%" height="100%"></iframe>';
	return s;
}


//beforeDblClick事件
function beforeDbl(){
	flag = false;
	return true;
}
//加载树
var orgTree ;

function showIndex(){
var treeObj = $.fn.zTree.getZTreeObj("orgTree");
var node =treeObj.getNodes()[0];
$("#"+node.tId+" a").click();
}

function loadTree() {
	var zNodes;
	var ztreeCreator = new ZtreeCreator('orgTree',"","")

 			.setCallback({onClick:zTreeOnLeftClick,onRightClick:zTreeOnRightClick,onDblClick:zTreeOnDblClick,beforeDblClick:beforeDbl,onAsyncSuccess:showIndex})

 			.setAsync({
                enable: true,
                url:"organzationController.do?getMyTreeData",
                autoParam:["id", "name", "level"],
                dataFilter:filter
            }) 
 			.initZtree({},function(treeObj){
 				orgTree = treeObj
 				});
};

function filter(treeId, parentNode, childNodes){
	if (!childNodes) return null;
    for (var i=0, l=childNodes.length; i<l; i++) {
        childNodes[i].name = childNodes[i].name.replace(/\.n/g, '.');
    }
    return childNodes;
}

//左击
function zTreeOnLeftClick(event, treeId, treeNode) {
	var selectNode = getSelectNode();
	flag = true;
	clearTimeout(TimeFn);
	setTimeout(function(){
		if(flag){
			curSelectNode = treeNode;
			var parentId = treeNode.id;
			var orgType = treeNode.orgType;
			closeAllTab();
			if(orgType=="1"){
				var url = "organzationController.do?comDetail&id="+treeNode.id;
				addtt('基本信息', url, '01','icon-comturn', 'false');
				url = "organzationController.do?myUserOrgList&departid="+treeNode.id;
				addtt('用户信息', url, '02','icon-user-set', 'false');
				url = "tSCompanyPositionController.do?list&companyId="+treeNode.id;;
				addtt('职务信息', url, '03','icon-chart-organisation', 'false');
			}else if(orgType=="4"){
				var url = "organzationController.do?comDetail&id="+treeNode.id;
				addtt('基本信息', url, '01','icon-comturn', 'false');
				url = "organzationController.do?myUserOrgList&departid="+treeNode.id;
				addtt('用户信息', url, '02','icon-user-set', 'false');
				url = "tSCompanyPositionController.do?list&companyId="+treeNode.id;;
				addtt('职务信息', url, '03','icon-chart-organisation', 'false');
			}else if(orgType=="9"){
				//var url = "organzationController.do?comDetail&id="+treeNode.id;
				//addtt('基本信息', url, '01','icon-comturn', 'false');
			}else{
				var url = "organzationController.do?comDetail&id="+treeNode.id;
				addtt('基本信息', url, '01','icon-comturn', 'false');
				url = "organzationController.do?myUserOrgList&departid="+treeNode.id;
				addtt('用户信息', url, '02','icon-user-set', 'false');
			}
			$("#tt").tabs("select", 0);
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
			var orgType = treeNode.orgType;
			if(orgType=="4"){
				menu = $('#gysMenu');
			}else if(orgType=="9"){
				menu = $('#gysRootMenu');
			}else if(orgType=="2"){
				menu = $('#gysMenu');
			}else if(orgType=="3"){
				menu = $('#gysMenuGW');
			}else{
				menu = $('#gysMenu');
			}
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
	curSelectNode = treeNode;
	//var url = "functionGroupController.do?groupRel&id="+selectNode.id;
	//$("#listFrame").attr("src", url);
	//var url = "autoFormController/af/employee_leave_form/goAddPage.do";
	//addtt('基本信息', url, '1','icon-search', 'false');
}
//菜单对应项
function menuHandler(item) {
	if ('addSubCompany' == item.name) {
		addSubCompany();
	} else if ('addSubOrg' == item.name) {
		addSubOrg();
	} else if ('addSubJob' == item.name) {
		addSubJob();
	} else if ('editSupplier' == item.name) {
		editNode();
	} else if ('removeSupplier' == item.name) {
		delNode();
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

//添加下级公司
function addSubCompany() {
	var selectNode = getSelectNode();
	//if(selectNode.level == 1) {
	//	tip('不可再添加下级节点');
	//	return false;
	//}
	if (!selectNode) 	return;
	closeAllTab();
	//var url = "functionGroupController.do?add&id="+selectNode.id;
	//$("#listFrame").attr("src", url);
	var url = "organzationController.do?toAddSubCompany&pid="+selectNode.id;
	addtt('添加下级公司', url, '01','icon-search', 'false');
};

//添加下级部门
function addSubOrg() {
	var selectNode = getSelectNode();
	//if(selectNode.level == 1) {
	//	tip('不可再添加下级节点');
	//	return false;
	//}
	if (!selectNode) 	return;
	closeAllTab();
	//var url = "functionGroupController.do?add&id="+selectNode.id;
	//$("#listFrame").attr("src", url);
	var url = "organzationController.do?toAddSubOrg&pid="+selectNode.id;
	addtt('添加下级部门', url, '01','icon-search', 'false');
};

//添加下级岗位
function addSubJob() {
	var selectNode = getSelectNode();
	//if(selectNode.level == 1) {
	//	tip('不可再添加下级节点');
	//	return false;
	//}
	if (!selectNode) 	return;
	closeAllTab();
	//var url = "functionGroupController.do?add&id="+selectNode.id;
	//$("#listFrame").attr("src", url);
	var url = "organzationController.do?toAddSubJob&pid="+selectNode.id;
	addtt('添加下级岗位', url, '01','icon-search', 'false');
}


function closeAllTab(){
	var tabs = $('#tt').tabs("tabs");
	var length = tabs.length;
    for(var i=0; i<length; i++){
    	var onetab = tabs[0];
        var title = onetab.panel('options').tab.text();
        $("#tt").tabs("close", title);
    }
	
}

//添加一级节点
function addOneNode() {
	closeAllTab();
	var url = "organzationController.do?toAddCompany";
	addtt('添加一级公司', url, '01','icon-search', 'false');
};
//编辑节点
function editNode() {
	var selectNode = getSelectNode();
	if (!selectNode) 	return;
	//var url = "functionGroupController.do?update&id="+selectNode.id;
	//$("#listFrame").attr("src", url);
	closeAllTab();
	var url = "organzationController.do?comUpdate&id="+selectNode.id;
	addtt('编辑', url, '01','icon-search', 'false');
};

//删除
function delNode() {
	var selectNode = getSelectNode();
	var nodeId = selectNode.id;
	//if (nodeId == "0") {
	//	tip('该节点为根节点，不可删除');return;
	//} 
	var url = "organzationController.do?del&id="+selectNode.id;
	if(selectNode.isParent){
		tip('存在下级机构，不可删除!');return;
	}
	layer.confirm('确定删除该机构吗？',{
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

</script>
