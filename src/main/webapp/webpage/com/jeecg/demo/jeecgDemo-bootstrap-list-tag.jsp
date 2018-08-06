<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>请假表单管理</title>
<meta name="viewport" content="width=device-width" />
<t:base type="jquery,bootstrap,bootstrap-table,layer"></t:base>
<script src="plug-in/themes/bootstrap-ext/js/bootstrap-curdtools.js"></script>
</head>
<body>
<t:datagrid name="jeecgDemoList1" checkbox="true" component="bootstrap-table" sortName="createDate,name" pagination="true" fitColumns="false" title="jeecg_demo" 
  	  superQuery="true" actionUrl="jeecgListDemoController.do?datagrid" idField="id" fit="true" queryMode="group" filter="true">
    <t:dgCol title="id"  field="id"   hidden="true"   queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="名称"  field="name" query="true" showLen="10" autocomplete="true"  width="120"></t:dgCol>
    <!--update-begin-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，年龄区间查询-->
    <t:dgCol title="年龄"  extend="{style:'width:50px'}"  editor="numberbox" field="age"  queryMode="group" query="true" width="120"></t:dgCol>
    <!--update-end-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，年龄区间查询-->
    <t:dgCol title="生日"  hidden="true"  field="birthday" formatter="yyyy-MM-dd"   queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="性别"  field="sex"  query="true" showMode="radio" dictionary="sex" width="120" extendParams="styler:fmtype"></t:dgCol>
    <t:dgCol title="电话"  field="phone" queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="工资"  field="salary" query="true" queryMode="group" width="120"></t:dgCol>
    <t:dgCol title="创建日期"  field="createDate" formatter="yyyy-MM-dd" query="true" queryMode="group" editor="datebox" width="120"></t:dgCol>
    <!-- update-begin-Author:LiShaoQing Date:20180802 for:TASK #3017 【Tag-bootstrap】查询区域字段，popup未实现 -->
    <t:dgCol title="邮箱"  field="email" query="true"  popup="true" dictionary="user_msg,name@email,account@realname" width="120"></t:dgCol>
    <!-- update-end-Author:LiShaoQing Date:20180802 for:TASK #3017 【Tag-bootstrap】查询区域字段，popup未实现 -->
    <t:dgCol title="入职状态"  field="status" query="true" extend="{style:{width:'300px';color:'red'};datatype:'*';}" defaultVal='N'  dictionary="sf_yn" width="80"></t:dgCol>
    <t:dgCol title="个人介绍"  field="content"  hidden="true"   queryMode="group"  width="150"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="250"></t:dgCol>
   <t:dgDelOpt title="删除" url="jeecgListDemoController.do?doDel&id={id}" urlclass="btn btn-danger btn-xs"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="jeecgListDemoController.do?goBootStrapTableAdd" funname="add" width="770" height="500"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="jeecgListDemoController.do?goBootStrapTableUpdate" funname="update" width="770"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="jeecgListDemoController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
  </t:datagrid>
</body>
</html>