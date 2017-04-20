<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker,autocomplete"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jeecgMinidaoList" checkbox="true" pagination="true" fitColumns="false" title="jeecg_minidao" actionUrl="jeecgListDemoController.do?minidaoDatagrid" idField="id" fit="true" queryMode="group">
    <t:dgCol title="id"  field="id"   hidden="true"   queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="名称"  field="name" query="true" autocomplete="true"   width="120"></t:dgCol>
    <t:dgCol title="年龄"  extend="{style:'width:50px;color:red'}" editor="numberbox" field="age"  query="true" width="120"></t:dgCol>
    <t:dgCol title="生日"  field="birthday" formatter="yyyy-MM-dd"   queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="部门"  field="depId" query="true" queryMode="single" dictionary="t_s_depart,id,departname"  width="120"></t:dgCol>
    <t:dgCol title="性别"  field="sex"  query="true" dictionary="sex" width="120"></t:dgCol>
    <t:dgCol title="电话"  field="phone" queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="工资"  field="salary"  queryMode="group"  width="120"></t:dgCol>
     <t:dgCol title="创建日期"  field="createDate" formatter="yyyy-MM-dd" query="false" queryMode="group" editor="datebox" width="120"></t:dgCol>
     <t:dgCol title="邮箱"  field="email"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
     <t:dgCol title="入职状态"  field="status" query="true"   dictionary="sf_yn" width="120"></t:dgCol>
    <t:dgCol title="个人介绍"  field="content"  hidden="true"   queryMode="group"  width="500"></t:dgCol>
  </t:datagrid>
  </div>
 </div>
