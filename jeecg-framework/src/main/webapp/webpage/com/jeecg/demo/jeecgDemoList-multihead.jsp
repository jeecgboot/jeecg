<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker,autocomplete"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jeecgDemoList" checkbox="true" sortName="birthday,name" pagination="true" fitColumns="true"
   title="多表头列表" actionUrl="jeecgListDemoController.do?datagrid" idField="id" fit="true" queryMode="group">
    <t:dgCol title="id"  field="id"   hidden="true"    width="120"></t:dgCol>
    <t:dgCol title="列表标签" colspan="10" newColumn="true"></t:dgCol>
    <t:dgCol title="人员信息" colspan="4"></t:dgCol>
    <t:dgCol title="部门信息" colspan="2"></t:dgCol>
    <t:dgCol title="工资"  field="salary" rowspan="2"  width="120"></t:dgCol>
     <t:dgCol title="入职状态"  field="status" rowspan="2"   defaultVal='N'  dictionary="sf_yn" width="80"></t:dgCol>
     <t:dgCol title="创建日期"  field="createDate" rowspan="2" formatter="yyyy-MM-dd"  queryMode="group" editor="datebox" width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="150"  newColumn="true" rowspan="2"></t:dgCol>
    
    <t:dgCol title="名称"  field="name"  autocomplete="true"   width="120"></t:dgCol>
    <t:dgCol title="年龄"  extend="{style:'width:50px'}"  style="background-color:#3a87ad_50,background-color:#f89406_100" editor="numberbox" field="age"  query="true" width="120"></t:dgCol>
    <t:dgCol title="性别"  field="sex"  query="true" showMode="radio" dictionary="sex" width="120"></t:dgCol>
    <t:dgCol title="电话"  field="phone" queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="部门"  field="depId" queryMode="single" dictionary="t_s_depart,id,departname"  width="120"></t:dgCol>
   	<t:dgCol title="部门code" field="extField"></t:dgCol>
   
   <t:dgDelOpt title="删除" url="jeecgListDemoController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgFunOpt exp="status#eq#N" title="审核" funname="szqm(id)" urlclass="ace_button"  urlfont="fa-check" />
   <t:dgToolBar title="录入" icon="icon-add" url="jeecgListDemoController.do?goAdd" funname="add" width="770" height="500"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="jeecgListDemoController.do?goUpdate" funname="update" width="770"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="jeecgListDemoController.do?goUpdate" funname="detail" width="770"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 function testReloadPage(){
		document.location = "http://www.baidu.com"; 
	}
	function szqm(id) {
		createwindow('审核入职', 'jeecgListDemoController.do?goCheck&id=' + id,400,200);
	}
	function addNewPage(id){
		addOneTab("TAB方式添加", "jeecgListDemoController.do?addTab&type=table&id="+id);
	}
	

 </script>