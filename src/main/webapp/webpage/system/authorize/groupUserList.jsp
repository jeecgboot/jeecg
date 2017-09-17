<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<input type="hidden" id="groupId" name="groupId" value="${groupId}">
<t:datagrid name="userList" title="common.operation" actionUrl="functionGroupController.do?groupUser&groupId=${groupId}" fit="true" fitColumns="true" idField="id" queryMode="group" sortName="createDate,userName" sortOrder="asc,desc">
	<t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="common.username" sortable="false" field="userName" query="true" width="100"></t:dgCol>
	<t:dgCol title="common.real.name" field="realName" query="false" width="100"></t:dgCol>
	<t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
	<t:dgFunOpt funname="deleteDialog(userName)" title="common.delete" urlclass="ace_button"  urlfont="fa-trash-o"></t:dgFunOpt>
</t:datagrid>
	<a class="easyui-linkbutton l-btn l-btn-plain" style="position: absolute;top: 40px" onclick="openSelectSort()">
		<i class="fa fa-plus"></i><span class="bigger-110 no-text-shadow"> 添加用户</span>
	</a>
<script>
    $(function() {
        var datagrid = $("#userListtb");
		datagrid.find("div[name='searchColums']").find("form#userListForm").append($("#realNameSearchColums div[name='searchColumsRealName']").html());
		$("#realNameSearchColums").html('');
	});
</script>
<script type="text/javascript">
//删除用户
function deleteDialog(userName){
	var groupId = $("#groupId").val();
    $.dialog.confirm('确定删除该用户吗?', function(){
    	$.ajax({
    		url : "functionGroupController.do?deleteByUser",
    		data : {
    			"userId":userName,
    			"groupId":groupId
    		},
    		type : "POST",
    		success:function(data){
    			var d = $.parseJSON(data);
    			tip(d.msg);
    			location.reload("functionGroupController.do?groupUser&groupId="+groupId);
    		},
    		error:function(data){
    			var d = $.parseJSON(data);
    			tip(d.msg);
    		}
    	});
	}, function(){
	});
}
//弹出用户选择界面
function openSelectSort() {
	$.dialog.setting.zIndex = getzIndex(); 
	$.dialog({content: 'url:functionGroupController.do?addUserSelect', zIndex: getzIndex(), title: '用户选择列表', lock: true, width: '700px', height: '400px', opacity: 0.4, button: [
		{name: '<t:mutiLang langKey="common.confirm"/>', callback: callbackRealNameSelect, focus: true},
		{name: '<t:mutiLang langKey="common.cancel"/>', callback: function (){}}
	]}).zindex();
}
//回调函数,把选中的值带过来
function callbackRealNameSelect() {
	var iframe = this.iframe.contentWindow;
	var table = iframe.$("#table1");
	var id='',userName='',realName='';
	$(table).find("tbody tr").each(function() {
		id += $(this).find("input").val()+",";
		realName += $(this).find("span").text()+",";
		userName += $(this).find("input[id=userName]").val()+",";
	})
	$("#id").val(id);
	var groupId = $("#groupId").val();
	//添加已选中用户
 	$.ajax({
		url : "functionGroupController.do?saveByUser",
		type : "POST",
		data : {
			"userName":userName,
			"groupId":groupId
		},
		success:function(data){
			location.reload("functionGroupController.do?groupUser&groupId="+groupId);
		},
		error:function(data) {
			var d = $.parseJSON(data);
			tip(d.msg);
		}
	});
}
</script>
<div id="realNameSearchColums" style="display: none;">
	<div name="searchColumsRealName">
		<t:userSelect hasLabel="true" selectedNamesInputId="realName" windowWidth="1000px" windowHeight="600px" title="用户名称"></t:userSelect>
	</div>
</div>