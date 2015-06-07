<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<t:datagrid name="dictParameterList" title="SQL分离代码写法" actionUrl="jeecgJdbcController.do?listAllDictParaByJdbc" idField="id" fit="true">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="真实名字" field="realname"></t:dgCol>
	<t:dgCol title="账号" field="username"></t:dgCol>
	<t:dgCol title="状态" field="status"></t:dgCol>
</t:datagrid>
