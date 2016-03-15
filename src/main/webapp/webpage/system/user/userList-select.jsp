<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
	<div region="center" style="padding: 1px;">
		<t:datagrid name="userList" title="common.user.select" actionUrl="userController.do?datagrid" fitColumns="true" idField="id" queryMode="group" sortName="createDate" sortOrder="desc">
			<t:dgCol title="common.code" field="id" hidden="true"></t:dgCol>
			<t:dgCol title="common.username" field="userName" query="true" width="100"></t:dgCol>
		</t:datagrid>
	</div>
</div>
<script type="text/javascript">
  	function getUserId(){
  		var rowsData = $("#userList").datagrid("getChecked");
  		var id = "";
  		if(rowsData.length==0){
  			tip('<t:mutiLang langKey="please.select.user"/>');
  			return "";
  		}
  		return rowsData[0].id;
  	}
  </script>
