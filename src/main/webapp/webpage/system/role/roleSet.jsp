<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">

	var setting = {
		check: {
			enable: true
		},
			data: {
			simpleData: {
				enable: true
			}
		}, 
		async: {
			enable: true,
			url:"roleController.do?setAuthority&roleId=${roleId}",
			dataFilter: filter				
		},
		callback: {
			beforeAsync: function(){},
			onAsyncSuccess: function(event, treeId, treeNode, msg){
				//将已选中子节点的父节点设置为选中状态,即级联父级
				/*var zTree = $.fn.zTree.getZTreeObj("functionid");				
				var node = zTree.getCheckedNodes(true);
				var pnode = null; 
				for ( var i = 0; i < node.length; i++) {
					pnode = node[i].getParentNode();
					while (pnode != null) {
						pnode.checked = true;
						zTree.updateNode(pnode);
						pnode = pnode.getParentNode();
					}			
				}*/			
				expandAll();
			},
			onAsyncError: function(){},
			onClick: function (event, treeId, treeNode){
						//console.info(treeNode.id + ", " + treeNode.tId + ", " + treeNode.name + ", " + treeNode.children);
						if (null == treeNode.children) {
							var roleId = $("#rid").val();
							$('#operationListpanel').panel(
									"refresh",
									"roleController.do?operationListForFunction&functionId="+ treeNode.id + "&roleId=" + roleId);
							$('#dataRuleListpanel').panel(
									"refresh",
									"roleController.do?dataRuleListForFunction&functionId="+ treeNode.id + "&roleId=" + roleId);
						} else {
						}
			}
		}
	};
	function filter(treeId, parentNode, childNodes) {
		if (!childNodes) return null;
		for (var i=0, l=childNodes.length; i<l; i++) {
			childNodes[i].name = childNodes[i].text;
			//childNodes[i].open = (childNodes[i].state === "open");//异步加载，该项无效
			if (childNodes[i].children != null) {					
				childNodes[i].nodes = childNodes[i].children;
				filter(null, childNodes[i], childNodes[i].nodes);//递归设置子节点
			}
		}		
		return childNodes;
	}
	$(function() {	
		
		$.fn.zTree.init($("#functionid"), setting);
		
		$("#functionListPanel").panel({
			title : '<t:mutiLang langKey="menu.list"/>',
			tools : [ {
				iconCls : 'icon-save',
				handler : function() {
					mysubmit();
				}
			} ]
		});
		$("#operationListpanel").panel({
			title : '<t:mutiLang langKey="operate.manage"/>',
			tools : [ {
				iconCls : 'icon-save',
				handler : function() {
					submitOperation();
				}
			} ]
		});

		$("#dataRuleListpanel").panel({
			title : '数据规则权限',
			tools : [ {
				iconCls : 'icon-save',
				handler : function() {
					submitDataRule();
				}
			} ]
		});
	});
	
	function mysubmit() {
		var roleId = $("#rid").val();
		var s = GetNode();
		doSubmit("roleController.do?updateAuthority&rolefunctions=" + s + "&roleId=" + roleId);
	}
	function GetNode() {
		var zTree = $.fn.zTree.getZTreeObj("functionid");				
		var node = zTree.getCheckedNodes(true);
		//加入实际被选中的节点
		var cnodes = '';
		for ( var i = 0; i < node.length; i++) {
			cnodes += node[i].id + ',';		
		}
		cnodes = cnodes.substring(0, cnodes.length - 1);
		return cnodes;
		//加入实际被选中的节点,以及该节点的所有上级节点,即级联父级
		/*var cnodes = '';
		var pnodes = '';
		var pnode = null; //保存上一步所选父节点
		for ( var i = 0; i < node.length; i++) {
			if(!node[i].isParent){
				cnodes += node[i].id + ',';
				pnode = node[i].getParentNode();//获取当前节点的父节点
				while (pnode != null) {//添加全部父节点
					pnodes += pnode.id + ',';
					pnode = pnode.getParentNode();
				}
			} 				
		}
		cnodes = cnodes.substring(0, cnodes.length - 1);
		pnodes = pnodes.substring(0, pnodes.length - 1);
		return cnodes + "," + pnodes;*/
	}

	function expandAll() {
		var zTree = $.fn.zTree.getZTreeObj("functionid");
		zTree.expandAll(true);
	}
	function selecrAll() {
		var zTree = $.fn.zTree.getZTreeObj("functionid");
		zTree.checkAllNodes(true);
	}
	function reset() {
		$.fn.zTree.init($("#functionid"), setting);
	}
	function changeMode(){
		var zTree = $.fn.zTree.getZTreeObj("functionid");			
		var typeMode = $("#typeMode").val();			
		var type = typeMode == 1 ? {"Y" : "", "N" : ""} : {"Y" : "ps", "N" : "ps"};	
		zTree.setting.check.chkboxType = type;
		$("#typeMode").val(typeMode % 2 + 1);			
	}

	$('#selecrAllBtn').linkbutton({});
	$('#resetBtn').linkbutton({});
	$('#changeBtn').linkbutton({});
</script>
<div class="easyui-layout" fit="true">
	<div region="center" style="padding: 1px;">
		<div class="easyui-panel" style="padding: 1px;" fit="true" border="false" id="functionListPanel">
			<input type="hidden" name="roleId" value="${roleId}" id="rid"> 
			<input type="hidden" id="typeMode" value="1"/>
			<a id="selecrAllBtn" onclick="selecrAll();"><t:mutiLang langKey="select.all" /></a> 
			<a id="resetBtn" onclick="reset();"><t:mutiLang langKey="common.reset" /></a>
			<a id="changeBtn" onclick="changeMode();"><t:mutiLang langKey="common.typemode" /></a>
			<ul id="functionid" class="ztree"></ul>
		</div>
	</div>
	<div region="east" style="width: 300px; overflow: hidden;" split="true">
		<div class="easyui-layout" fit="true">
			<div region="center" style="padding: 1px; border: 0px;">
				<div class="easyui-panel" style="padding: 1px;" fit="true" border="false" id="operationListpanel"></div>
			</div>
			<div region="east" style="width: 150px; overflow: hidden;" split="true">
				<div class="easyui-panel" style="padding: 1px;" fit="true" border="false" id="dataRuleListpanel"></div>
			</div>
		</div>
	</div>
</div>
