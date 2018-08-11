<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div id="main_depart_list" class="easyui-layout" fit="true">
    <div region="center" style="padding:0px;border:0px">
        <t:datagrid name="departList" title="common.department.list" fitColumns="true" actionUrl="departController.do?departgrid" treegrid="true" idField="departid" pagination="false">
            <t:dgCol title="common.id" field="id" treefield="id" hidden="true"></t:dgCol>
            <t:dgCol title="common.id" field="parentId" treefield="parentId" hidden="true"></t:dgCol>
            <t:dgCol title="common.department.name" field="departname" treefield="text" width="120"></t:dgCol>
            <t:dgCol title="position.desc" field="description" treefield="src" width="70"></t:dgCol>
            <t:dgCol title="common.org.code" field="orgCode" treefield="fieldMap.orgCode" width="50"></t:dgCol>
            <t:dgCol title="common.org.type" field="orgType" dictionary="orgtype" treefield="fieldMap.orgType" width="60"></t:dgCol>
            <t:dgCol title="common.mobile" field="mobile" treefield="fieldMap.mobile" width="60"></t:dgCol>
            <t:dgCol title="common.fax" field="fax" treefield="fieldMap.fax" width="60"></t:dgCol>
            <t:dgCol title="common.address" field="address" treefield="fieldMap.address" width="100"></t:dgCol>
            <t:dgCol title="common.operation" field="opt" width="200"></t:dgCol>
            <%-- <t:dgDelOpt url="departController.do?del&id={id}" title="common.delete" urlclass="ace_button"  urlfont="fa-trash-o" urlStyle="background-color:#ec4758;"></t:dgDelOpt> --%>
            <t:dgFunOpt funname="delDepart(id)" title="common.delete" urlclass="ace_button" urlStyle="background-color:#ec4758;" urlfont="fa-trash-o"></t:dgFunOpt>
        	<t:dgFunOpt funname="queryUsersByDepart(id)" title="view.member" urlclass="ace_button"  urlfont="fa-user"></t:dgFunOpt>
            <t:dgFunOpt funname="setRoleByDepart(id,text)" title="role.set" urlclass="ace_button"  urlfont="fa-cog" urlStyle="background-color:#1a7bb9;"></t:dgFunOpt>
        </t:datagrid>
        <div id="departListtb" style="padding: 3px; height: 25px">
            <div style="float: left;">
                <a href="#" class="easyui-linkbutton" plain="true" icon="icon-add" onclick="addOrg()"><t:mutiLang langKey="common.add.param" langArg="common.department"/></a>
                <a href="#" class="easyui-linkbutton" plain="true" icon="icon-edit" onclick="update('<t:mutiLang langKey="common.edit.param" langArg="common.department"/>','departController.do?update','departList','680px','450px')"><t:mutiLang langKey="common.edit.param" langArg="common.department"/></a>
                <!-- //update--end--author:zhangjiaqiang Date:20170112 for:增加排序功能 
                <a href="#" class="easyui-linkbutton" plain="true" icon="icon-put" onclick="ImportXls()"><t:mutiLang langKey="excelImport" langArg="common.department"/></a>
                -->
                <a href="#" class="easyui-linkbutton" plain="true" icon="icon-putout" onclick="ExportXls()"><t:mutiLang langKey="excelOutput" langArg="common.department"/></a>
                <a href="#" class="easyui-linkbutton" plain="true" icon="icon-putout" onclick="ExportXlsByT()"><t:mutiLang langKey="templateDownload" langArg="common.department"/></a>
                <a href="#" class="easyui-linkbutton" plain="true" icon="icon-put" onclick="ImportDepartXls()"><t:mutiLang langKey="excelDepartImport" langArg="common.department"/></a>
            </div>
        </div>
    </div>
</div>
<div data-options="region:'east',
	title:'<t:mutiLang langKey="member.list"/>',
	collapsed:true,
	split:true,
	border:false,
	onExpand : function(){
		li_east = 1;
	},
	onCollapse : function() {
	    li_east = 0;
	}"
	style="width: 400px; overflow: hidden;" id="eastPanel">
    <div class="easyui-panel" style="padding:0px;border:0px" fit="true" border="false" id="userListpanel"></div>
</div>

<script type="text/javascript">
<!--

    $(function() {
        var li_east = 0;
    });
    function addOrg() {
        var id = "";
        var rowsData = $('#departList').datagrid('getSelections');
        if (rowsData.length == 1) {
            id = rowsData[0].id;
        }
        var url = "departController.do?add&id=" + id;

        add('<t:mutiLang langKey="common.add.param" langArg="common.department"/>', url, "departList","660px","480px");

    }

    function queryUsersByDepart(departid){
        var title = '<t:mutiLang langKey="member.list"/>';
        if(li_east == 0 || $('#main_depart_list').layout('panel','east').panel('options').title != title){
            $('#main_depart_list').layout('expand','east');
        }
        <%--$('#eastPanel').panel('setTitle','<t:mutiLang langKey="member.list"/>');--%>
        $('#main_depart_list').layout('panel','east').panel('setTitle', title);
        $('#main_depart_list').layout('panel','east').panel('resize', {width: 560});
        $('#userListpanel').panel("refresh", "departController.do?userList&departid=" + departid);
    }
    /**
     * 为 组织机构 设置 角色
     * @param departid 组织机构主键
     * @param departname 组织机构名称
     */
    function setRoleByDepart(departid, departname){
        var currentTitle = $('#main_depart_list').layout('panel', 'east').panel('options').title;
        if(li_east == 0 || currentTitle.indexOf("<t:mutiLang langKey="current.org"/>") < 0){
            $('#main_depart_list').layout('expand','east');
        }
        var title = departname + ':<t:mutiLang langKey="current.org"/>';
        $('#main_depart_list').layout('panel','east').panel('setTitle', title);
        $('#main_depart_list').layout('panel','east').panel('resize', {width: 200});
        var url = {
            <%--title :"test",--%>
            href:"roleController.do?roleTree&orgId=" + departid
        }
        $('#userListpanel').panel(url);
        $('#userListpanel').panel("refresh");
    }
    //导入
    function ImportXls() {
        openuploadwin('Excel导入', 'departController.do?upload', "departList");
    }
    //导入
    function ImportDepartXls() {
        openuploadwin('Excel导入', 'departController.do?uploadDepart', "departList");
    }

    //导出
    function ExportXls() {
        JeecgExcelExport("departController.do?exportXls","departList");
    }

    //模板下载
    function ExportXlsByT() {
//        JeecgExcelExport("departController.do?exportXlsByT","departList");
		location.href = "${webRoot}/export/template/departTemplate.xls";
    }

function reloadTreeNode(){
	var node = $('#departList').treegrid('getSelected');
    if (node) {
	   	 var pnode = $('#departList').treegrid('getParent',node.id);
	   	 if(pnode){
	   		 if(node.parentId==""){
	   			$('#departList').treegrid('reload');
	   		 }else{
	   	 		$('#departList').treegrid('reload',pnode.id);
	   		 }
	   	 }else{
	   		if(node.parentId==""){
	   			$('#departList').treegrid('reload');
	   		 }else{
	   			$('#departList').treegrid('reload',node.id);
	   		 }
	   	 }
    }else{
    	 $('#departList').treegrid('reload');
    }
}
//删除部门
function delDepart(id,name) {
	var url = "departController.do?del&id="+id
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

//-->
</script>