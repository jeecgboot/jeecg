<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jeecgMinidaoList"  pageSize="500" pagination="false" fitColumns="false" title="用户操作统计报表" actionUrl="jeecgListDemoController.do?logrpDatagrid" idField="id" fit="true" queryMode="group">
    <t:dgCol title="id"  field="id"   hidden="true"></t:dgCol>
    <t:dgCol title="用户" align="center" field="name" width="120"></t:dgCol>
    <t:dgCol title="登陆次数" align="center" field="loginct" width="120"></t:dgCol>
    <t:dgCol title="退出次数" align="center" field="outct" width="120"></t:dgCol>
    <t:dgCol title="修改次数" align="center" field="xgct" width="120"></t:dgCol>
    <t:dgCol title="操作次数" align="center" field="ct" width="120"></t:dgCol>
  </t:datagrid>
  </div>
 </div>