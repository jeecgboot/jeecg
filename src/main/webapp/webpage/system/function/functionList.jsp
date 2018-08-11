<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div id="system_function_functionList" class="easyui-layout" fit="true"><%--   update-end--Author:duanql  Date:20130619 for：操作按钮窗口显示控制--%>
<div region="center" style="padding:0px;border:0px">
	<t:datagrid name="functionList" title="menu.manage" actionUrl="functionController.do?functionGrid" idField="id" fit="true" fitColumns="true" treegrid="true" pagination="false" btnCls="bootstrap btn btn-normal btn-xs">
        <t:dgCol title="common.id" field="id" treefield="id" hidden="true"></t:dgCol>
        <t:dgCol title="common.id" field="parentId" treefield="parentId" hidden="true"></t:dgCol>
        <t:dgCol title="menu.name" field="functionName" treefield="text" width="40"></t:dgCol>
        <t:dgCol title="common.icon" field="TSIcon_iconPath" treefield="code" image="true" ></t:dgCol>
        <t:dgCol title="funcType" field="functionType" treefield="functionType" replace="funcType.page_0,funcType.from_1" width="20"></t:dgCol>
        <t:dgCol title="menu.url" field="functionUrl" treefield="src" width="80"></t:dgCol>
        <t:dgCol title="menu.order" field="functionOrder" treefield="order"></t:dgCol>
        <t:dgCol title="menu.funiconstyle" field="functionIconStyle" treefield="iconStyle" width="25"></t:dgCol>
        <t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
        <t:dgFunOpt funname="delMenu(id)" title="common.delete" urlclass="ace_button" urlStyle="background-color:#ec4758;" urlfont="fa-trash-o"></t:dgFunOpt>
        <t:dgFunOpt funname="operationDetail(id)" title="button.setting" urlclass="ace_button" urlfont="fa-cog"></t:dgFunOpt>
        <t:dgFunOpt funname="operationData(id,src)" title="数据规则" urlclass="ace_button" urlStyle="background-color:#1a7bb9;" urlfont="fa-database"></t:dgFunOpt>
        <t:dgToolBar title="common.add.param" langArg="common.menu" icon="fa fa-plus" url="functionController.do?addorupdate" height="400" funname="addFun"></t:dgToolBar>
        <t:dgToolBar title="common.edit.param" langArg="common.menu" icon="fa fa-edit" url="functionController.do?addorupdate" height="490" funname="update"></t:dgToolBar>
    </t:datagrid>
</div>
</div>
<div data-options="region:'east',
	title:'<t:mutiLang langKey="operate.button.list"/>',
	collapsed:true,
	split:true,
	border:false,
	onExpand : function(){
		li_east = 1;
	},
	onCollapse : function() {
	    li_east = 0;
	}"
	style="width: 400px; overflow: hidden;">
<div class="easyui-panel" style="padding:0px;border:0px" fit="true" border="false" id="operationDetailpanel"></div>
</div>
</div>

<script type="text/javascript">
$(function() {
	var li_east = 0;
});
//数据规则权数
function  operationData(fucntionId, functionUrl){

	if(functionUrl.indexOf("datagrid") != -1 || functionUrl.indexOf("Datagrid") != -1) {
		if(li_east == 0){
		   $('#system_function_functionList').layout('expand','east'); 
		}
		$('#operationDetailpanel').panel("refresh", "functionController.do?dataRule&functionId=" +fucntionId);
	} else {
		var datarule = layer.confirm('<b>友好提醒：</b> 菜单URL不是加载数据请求，加载数据请求格式一般是： *Controller.do?datagrid ，请注意菜单地址是否正确  ! ', {
		  	btn: ['确认','取消'],
		  	area:['450px','200px']
		}, function(){
			if(li_east == 0){
			   $('#system_function_functionList').layout('expand','east'); 
			}
			$('#operationDetailpanel').panel("refresh", "functionController.do?dataRule&functionId=" +fucntionId);
			layer.close(datarule);
		}, function(){
			$("#system_function_functionList").layout('collapse','east');
		});
	}

}
function operationDetail(functionId)
{
	if(li_east == 0){
	   $('#system_function_functionList').layout('expand','east'); 
	}
	$('#operationDetailpanel').panel("refresh", "functionController.do?operation&functionId=" +functionId);
}
function addFun(title,url, id) {
	var rowData = $('#'+id).datagrid('getSelected');
	if (rowData) {
		url += '&TSFunction.id='+rowData.id;
	}
	add(title,url,'functionList',700,480);
}

function reloadTreeNode(){
	var node = $('#functionList').treegrid('getSelected');
    if (node) {
	   	 var pnode = $('#functionList').treegrid('getParent',node.id);
	   	 if(pnode){
	   		if(node.parentId==""){
	   			$('#functionList').treegrid('reload');
	   		 }else{
	   	 		$('#functionList').treegrid('reload',pnode.id);
	   		 }
	   	 
	   	 }else{
	   		if(node.parentId==""){
	   			$('#functionList').treegrid('reload');
	   		 }else{
	   	 		$('#functionList').treegrid('reload',pnode.id);
	   		 }
	   	 }
    }else{
    	 $('#functionList').treegrid('reload');
    }
}
//删除菜单
function delMenu(id,name) {
	var url = "functionController.do?del&id="+id
	var content = $.i18n.prop('del.this.confirm.msg');
	var title = $.i18n.prop('del.confirm.title');
	$.dialog.setting.zIndex = getzIndex(true);
	var navigatorName = "Microsoft Internet Explorer"; 
	if( navigator.appName == navigatorName ||"default,shortcut".indexOf(getCookie("JEECGINDEXSTYLE"))>=0){ 
		$.dialog.confirm(content, function(){
			doDelSubmit(url);
			rowid = '';
		}, function(){
		});
	}else{
		layer.open({
			title:title,
			content:content,
			icon:7,
			shade: 0.3,
			yes:function(index){
				doDelSubmit(url);
				rowid = '';
			},
			btn:[$.i18n.prop('common.ok'),$.i18n.prop('common.cancel')],
			btn2:function(index){
				layer.close(index);
			}
		});
	}
}

/**
 * 执行操作
 * 
 * @param url
 * @param index
 */
function doDelSubmit(url) {
	$.ajax({
		async : false,
		cache : false,
		type : 'POST',
		url : url,// 请求的action路径
		error : function() {// 请求失败处理函数
		},
		success : function(data) {
			var d = $.parseJSON(data);
			if (d.success) {
				var msg = d.msg;
				tip(msg);
				reloadTreeNode();
			} else {
				tip(d.msg);
			}
		}
	});
}

</script>

