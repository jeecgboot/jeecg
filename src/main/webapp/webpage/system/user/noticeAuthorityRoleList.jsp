<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
  <t:datagrid name="noticeAuthorityRoleList" checkbox="true" fitColumns="false" title="common.authority.role" actionUrl="noticeAuthorityRoleController.do?datagrid&noticeId=${noticeId}" idField="id" fit="true" queryMode="group">
   <t:dgCol title="ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="通告ID"  field="noticeId"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="common.role.name"  field="role.roleName"  hidden="false"  queryMode="group"  width="180"></t:dgCol>
   <t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="common.delete" url="noticeAuthorityRoleController.do?doDel&id={id}" />
   <t:dgToolBar title="common.authority.role" icon="icon-add" url="noticeAuthorityRoleController.do?doSave" funname="addAuthorityRole"></t:dgToolBar>
  </t:datagrid>
   <input type="hidden" id="pNoticeId" value="${noticeId}" />
<script>
//授权用户
function addAuthorityRole(title,url, id){
		$.dialog({
			width:600,
			height:400,
	        id: 'LHG1976D',
	        title: "选择通知公告授权角色",
	        max: false,
	        min: false,
	        resize: false,
	        content: 'url:noticeAuthorityRoleController.do?selectRole',
	        lock:true,
	        ok: function(){
		    	iframe = this.iframe.contentWindow;
		    	var roleId = iframe.getRole();
		    	var noticeId = $("#pNoticeId").val();
		    	if(roleId==""){
		    		return false;
		    	}else{
					url += '&role.id='+roleId;
					url += '&noticeId='+noticeId;
					doAjax(url);
		    	}
		    },
	        close: function(){
	        }
	    });
}

function doAjax(url) {
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
				tip(d.msg);
				$('#noticeAuthorityRoleList').datagrid('reload',{});
			}		
		}
	});
}

</script>