<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div id="main_typegroup_list" class="easyui-layout" fit="true">  
    <div region="center" style="padding:0px;border:0px">
        <t:datagrid name="typeGridTree" title="common.data.dictionary" actionUrl="systemController.do?typeGroupGrid" 
        idField="id" treegrid="false" pagination="false"  sortOrder="desc" sortName="createDate" onLoadSuccess="loadSuccess" queryMode="group" btnCls="bootstrap btn btn-info btn-xs">
            <t:dgCol title="common.code" field="id" hidden="true"></t:dgCol>
            <t:dgCol title="dict.name" field="typegroupname" width="100" query="true"></t:dgCol>
            <t:dgCol title="dict.code" field="typegroupcode" width="100" treefield="code" query="true"></t:dgCol>
            <t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
            <t:dgDelOpt url="systemController.do?delTypeGroup&id={id}" title="common.delete" urlclass="ace_button" urlStyle="background-color:#ec4758;" urlfont="fa-trash-o"></t:dgDelOpt>
            <t:dgFunOpt funname="queryTypeValue(id)" title="common.type.view" urlclass="ace_button"  urlfont="fa-search"></t:dgFunOpt>
            <t:dgToolBar title="common.add.param" langArg="lang.dictionary.type" icon="fa fa-plus" url="systemController.do?aouTypeGroup" funname="add"></t:dgToolBar>
            <%--<t:dgToolBar title="common.add.param" langArg="lang.dictionary.value" icon="icon-add" funname="typeGridTree_AddType"></t:dgToolBar>--%>
            <t:dgToolBar title="common.edit" icon="fa fa-edit" url="systemController.do?aouTypeGroup" funname="update"></t:dgToolBar>
            <t:dgToolBar title="common.refreshType" icon="fa fa-refresh" url="systemController.do?refreshTypeGroupAndTypes" funname="doSubmit"></t:dgToolBar>
        </t:datagrid>
    </div>
</div>

<div data-options="region:'east',
	title:'mytitle',
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
    $(function() {
        var li_east = 0;
    });

    function queryTypeValue(typegroupid,index){
    	var row = $('#typeGridTree').datagrid('getData').rows[index];
    	//console.log(row);
    	
        var title = '<t:mutiLang langKey="lang.dictionary.type"/>: '+row.typegroupname ;
        if(li_east == 0){
            $('#main_typegroup_list').layout('expand','east');
        }
        $('#main_typegroup_list').layout('panel','east').panel('setTitle', title);
        $('#userListpanel').panel("refresh", "systemController.do?goTypeGrid&typegroupid=" + typegroupid);
    }
    function loadSuccess() {
        $('#main_typegroup_list').layout('panel','east').panel('setTitle', "");
        $('#main_typegroup_list').layout('collapse','east');
        $('#userListpanel').empty();
    }
</script>
<%--// add-end--Author:zhangguoming  Date:20140928 for：数据字典修改--%>
