<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div id="main_depart_list" class="easyui-layout" fit="true">
  <div region="center" style="padding:1px;">
  <t:datagrid name="tSNoticeList" checkbox="true" fitColumns="true" title="common.notice" actionUrl="noticeController.do?datagrid2" idField="id" fit="true" queryMode="group">
   <t:dgCol title="ID"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="通知标题"  field="noticeTitle"  hidden="false"  queryMode="group"  width="320"></t:dgCol>
   <%-- <t:dgCol title="通知公告内容"  field="noticeContent"  hidden="true"  queryMode="group"  width="120"></t:dgCol> --%>
   <t:dgCol title="common.type.name"  field="noticeType"  hidden="false"  queryMode="group"  width="60" replace="通知_1,公告_2"></t:dgCol>
   <t:dgCol title="授权级别"  field="noticeLevel"  hidden="false"  queryMode="group"  width="100" replace="全员_1,角色授权_2,用户授权_3"></t:dgCol>
   <t:dgCol title="阅读期限"  field="noticeTerm" formatter="yyyy-MM-dd" hidden="false"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="common.operation" field="opt" width="120"></t:dgCol>
   <!-- 	//update-begin--Author:zhangjq  Date:20160904 for：1332 【系统图标统一调整】讲{系统管理模块}{在线开发}的链接按钮，改成ace风格 -->
   <t:dgDelOpt title="common.delete" url="noticeController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <!-- 	//update-end--Author:zhangjq  Date:20160904 for：1332 【系统图标统一调整】讲{系统管理模块}{在线开发}的链接按钮，改成ace风格 -->
   <t:dgToolBar title="common.add" icon="icon-add" url="noticeController.do?goAdd" funname="add" width="800" height="600"></t:dgToolBar>
   <t:dgToolBar title="common.edit" icon="icon-edit" url="noticeController.do?goUpdate" funname="update" width="800" height="600"></t:dgToolBar>
   <t:dgToolBar title="common.batchDelete"  icon="icon-remove" url="noticeController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
  <!-- 	//update-begin--Author:zhangjq  Date:20160904 for：1332 【系统图标统一调整】讲{系统管理模块}{在线开发}的链接按钮，改成ace风格 -->
  <%-- <t:dgFunOpt exp="noticeLevel#eq#2" funname="queryRoles(id)" title="common.authority" urlclass="ace_button"  urlfont="fa-toggle-on"></t:dgFunOpt>
   <t:dgFunOpt exp="noticeLevel#eq#3" funname="queryUsers(id)" title="common.authority" urlclass="ace_button"  urlfont="fa-toggle-on"></t:dgFunOpt>--%>
 <!-- 	//update-end--Author:zhangjq  Date:20160904 for：1332 【系统图标统一调整】讲{系统管理模块}{在线开发}的链接按钮，改成ace风格 -->
  </t:datagrid>
  </div>
 </div>
 <div data-options="region:'east',
	title:'通知公告授权管理',
	collapsed:true,
	split:true,
	border:false,
	onExpand : function(){
		li_east = 1;
	},
	onCollapse : function() {
	    li_east = 0;
	}"
	style="width: 500px; overflow: hidden;">
<div class="easyui-panel" style="padding: 1px;" fit="true" border="false" id="subListpanel"></div>
</div>

 <script type="text/javascript">
 function queryRoles(id){
		if(li_east == 0){
			   $('#main_depart_list').layout('expand','east'); 
			}
			$('#subListpanel').panel("refresh", "noticeAuthorityRoleController.do?noticeAuthorityRole&noticeId=" + id);
	}
 function queryUsers(id){
		if(li_east == 0){
			   $('#main_depart_list').layout('expand','east'); 
			}
			$('#subListpanel').panel("refresh", "noticeAuthorityUserController.do?noticeAuthorityUser&noticeId=" + id);
	}
 </script>
