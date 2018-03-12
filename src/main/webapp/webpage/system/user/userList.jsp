<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>

<t:datagrid name="userList" title="common.operation" actionUrl="userController.do?datagrid" fit="true" fitColumns="true" idField="id" queryMode="group" sortName="createDate,userName" sortOrder="asc,desc">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.username" sortable="false" field="userName" query="true" width="100"></t:dgCol>
	<t:dgCol title="common.real.name" field="realName" query="false" width="100"></t:dgCol>
	<t:dgCol title="common.user.type" field="userType" dictionary="user_type" width="80"></t:dgCol>
	<%--<t:dgCol title="common.department" field="TSDepart_id" query="true" replace="${departsReplace}"></t:dgCol>--%>
	<t:dgCol title="common.department" sortable="false" field="userOrgList.tsDepart.departname" query="false" width="100"></t:dgCol>
	<t:dgCol title="common.role" field="userKey" width="100"></t:dgCol>
	<t:dgCol title="common.createby" field="createBy" hidden="true" width="100"></t:dgCol>
	<t:dgCol title="common.createtime" field="createDate" formatter="yyyy-MM-dd"  width="50" hidden="false"></t:dgCol>
	<t:dgCol title="common.updateby" field="updateBy" hidden="true"></t:dgCol>
	<t:dgCol title="common.updatetime" field="updateDate" formatter="yyyy-MM-dd" hidden="true"></t:dgCol>
	<t:dgCol title="common.status" sortable="true" field="status" width="50" replace="common.active_1,common.inactive_0,super.admin_-1" ></t:dgCol>
	
	<t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
	<t:dgFunOpt funname="deleteDialog(id)" title="common.delete" urlclass="ace_button"  urlfont="fa-trash-o"></t:dgFunOpt>
	<t:dgToolBar title="common.add.param" langArg="common.user" icon="icon-add" url="userController.do?addorupdate" funname="add" height="420"></t:dgToolBar>
	<t:dgToolBar title="common.edit.param" langArg="common.user" icon="icon-edit" url="userController.do?addorupdate" funname="update"></t:dgToolBar>
	<t:dgToolBar title="common.password.reset" icon="icon-edit" url="userController.do?changepasswordforuser" funname="update"></t:dgToolBar>
	<t:dgToolBar title="common.lock.user" icon="icon-edit" url="userController.do?lock&lockvalue=0" funname="lockObj"></t:dgToolBar>
	<t:dgToolBar title="common.unlock.user" icon="icon-edit" url="userController.do?lock&lockvalue=1" funname="unlockObj"></t:dgToolBar>
	<t:dgToolBar title="excelImport" icon="icon-put" funname="ImportXls"></t:dgToolBar>
	<t:dgToolBar title="excelOutput" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
	<t:dgToolBar title="templateDownload" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
</t:datagrid>
<script>
    $(function() {
        var datagrid = $("#userListtb");
		datagrid.find("div[name='searchColums']").find("form#userListForm").append($("#realNameSearchColums div[name='searchColumsRealName']").html());
		$("#realNameSearchColums").html('');
        datagrid.find("div[name='searchColums']").find("form#userListForm").append($("#tempSearchColums div[name='searchColums']").html());
        $("#tempSearchColums").html('');
	});
</script>
<div id="realNameSearchColums" style="display: none;">
	<div name="searchColumsRealName">
		<t:userSelect hasLabel="true" selectedNamesInputId="realName" windowWidth="1000px" windowHeight="600px" title="用户名称"></t:userSelect>
	</div>
</div>
<div id="tempSearchColums" style="display: none;">
    <div name="searchColums">
       <t:departSelect hasLabel="true" selectedNamesInputId="orgNames"></t:departSelect>
    </div>
</div>
<script type="text/javascript">
function deleteDialog(id){
	var url = "userController.do?deleteDialog&id=" + id
	createwindow("删除模式", url, 200, 100);
}
function lockObj(title,url, id) {

	gridname=id;
	var rowsData = $('#'+id).datagrid('getSelections');
	if (!rowsData || rowsData.length==0) {
		tip('<t:mutiLang langKey="common.please.select.edit.item"/>');
		return;
	}
		url += '&id='+rowsData[0].id;

	$.dialog.confirm('<t:mutiLang langKey="common.lock.user.tips"/>', function(){
		lockuploadify(url, '&id');
	}, function(){
	});
}
function unlockObj(title,url, id) {
	gridname=id;
	var rowsData = $('#'+id).datagrid('getSelections');
	if (!rowsData || rowsData.length==0) {
		tip('<t:mutiLang langKey="common.please.select.edit.item"/>');
		return;
	}

    if(rowsData[0].status == 1){
        tip('<t:mutiLang langKey="common.please.select.user.status.inactive"/>');
        return;
    }

		url += '&id='+rowsData[0].id;

	$.dialog.confirm('<t:mutiLang langKey="common.unlock.user.tips"/>', function(){
		lockuploadify(url, '&id');
	}, function(){
	});
}


function lockuploadify(url, id) {
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
				reloadTable();
			}
		}
	});
}
</script>

<script type="text/javascript">
	//导入
	function ImportXls() {
		openuploadwin('Excel导入', 'userController.do?upload', "userList");
	}

	//导出
	function ExportXls() {
		JeecgExcelExport("userController.do?exportXls", "userList");
	}

	//模板下载
	function ExportXlsByT() {
		JeecgExcelExport("userController.do?exportXlsByT", "userList");
	}
</script>