<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<t:datagrid name="jeecgDemoList" title="事务回滚示例"  actionUrl="transactionTestController.do?getDataCount">
	<t:dgCol title="订单客户信息表(数据量)" field="hibernate"  ></t:dgCol>
	<t:dgCol title="JeecgDemo测试表(数据量)" field="jdbc" ></t:dgCol>
	<t:dgCol title="Minidao例子(数据量)"  field="minidao" ></t:dgCol>
	<t:dgToolBar operationCode="add" title="录入" icon="icon-add" url="transactionTestController.do?add" funname="add"></t:dgToolBar>
</t:datagrid>


