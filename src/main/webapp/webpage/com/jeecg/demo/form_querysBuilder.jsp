<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
	<div region="center" style="padding: 1px;">
		<t:datagrid name="jeecgDemoListquery" title="高级查询示例"
			actionUrl="jeecgListDemoController.do?datagrid" idField="id"
			queryMode="group" checkbox="true" superQuery="true"
			extendParams="headerContextMenu: [
                { text: '保存列定义', iconCls: 'icon-save', disabled: false, handler: function () { saveHeader(); } },
                { text: '自定义菜单', iconCls: 'icon-reload', disabled: false, handler: function (e, field) { alert($.string.format('您点击了{0}', field)); } }
            ],">
			<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
			<t:dgCol title="用户名" popup="true" dictionary="user_msg,name,realname" field="name" query="true"></t:dgCol>
			<t:dgCol title="个人介绍" field="content"></t:dgCol>
			<t:dgCol title="办公电话" field="phone" query="true"></t:dgCol>
			<t:dgCol title="创建日期" field="createDate" formatter="yyyy-MM-dd"></t:dgCol>
			<t:dgCol title="邮箱" field="email"></t:dgCol>
			<t:dgCol title="年龄" sortable="true" field="age"></t:dgCol>
			<t:dgCol title="工资" field="salary" query="true"></t:dgCol>
			<t:dgCol title="生日" field="birthday" formatter="yyyy-MM-dd" query="true" ></t:dgCol>
			<%-- <t:dgToolBar operationCode="add" title="高级查询" icon="icon-search" funname="queryBuilder"></t:dgToolBar> --%>
		</t:datagrid>
	</div>
</div>