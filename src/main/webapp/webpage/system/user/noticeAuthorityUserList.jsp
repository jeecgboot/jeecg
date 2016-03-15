<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
  <t:datagrid name="noticeAuthorityUserList" checkbox="true" fitColumns="false" title="common.authority.user" actionUrl="noticeAuthorityUserController.do?datagrid&noticeId=${noticeId}" idField="id" fit="true" queryMode="group">
   <t:dgCol title="ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="通告ID"  field="noticeId"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="common.username"  field="user.userName"  hidden="false"  queryMode="group"  width="180"></t:dgCol>
   <t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="common.delete" url="noticeAuthorityUserController.do?doDel&id={id}" />
   <t:dgToolBar title="common.authority.user" icon="icon-add" url="noticeAuthorityUserController.do?doSave" funname="addAuthorityUser"></t:dgToolBar>
  </t:datagrid>
   <input type="hidden" id="pNoticeId" value="${noticeId}" />
<script>
//授权用户
function addAuthorityUser(title,url, id){
		$.dialog({
			width:600,
			height:400,
	        id: 'LHG1976D',
	        title: "选择通知公告授权用户",
	        max: false,
	        min: false,
	        resize: false,
	        content: 'url:noticeAuthorityUserController.do?selectUser',
	        lock:true,
	        ok: function(){
		    	iframe = this.iframe.contentWindow;
		    	var userId = iframe.getUserId();
		    	var noticeId = $("#pNoticeId").val();
		    	if(userId==""){
		    		return false;
		    	}else{
					url += '&user.id='+userId;
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
				$('#noticeAuthorityUserList').datagrid('reload',{});
			}		
		}
	});
}

</script>

