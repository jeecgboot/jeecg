<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
<head>
<title>请假表单管理</title>
<meta name="viewport" content="width=device-width" />
<t:base type="bootstrap,bootstrap-table,layer"></t:base>
</head>
<body>
<!-- 自定义查询条件 -->
<!-- <div class="panel-body" style="padding-bottom:0px;">
		<div class="accordion-group">
			<div id="collapse_search" class="accordion-body collapse">
				<div class="accordion-inner">
					<div class="panel panel-default" style="margin-bottom: 0px;">
            				<div class="panel-body" >
			                <form id="searchForm" class="form form-horizontal" action="" method="post">
								<div class="col-xs-12 col-sm-6 col-md-4">
					    			<label for="name">名称：</label>
					    			<div class="input-group" style="width:100%">
					    				<input type="text" class="form-control input-sm" id="name" name="name">
					    			</div>
					    		</div>
			                    <div class="col-xs-12 col-sm-6 col-md-4">
			                         <div  class="input-group col-md-12" style="margin-top:20px">
			                         <a type="button" onclick="searchList();" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-search" aria-hidden="true"></span> 查询</a>
			                         <a type="button" onclick="searchRest();" class="btn btn-primary btn-rounded  btn-bordered btn-sm"><span class="glyphicon glyphicon-repeat" aria-hidden="true"></span> 重置</a>
			                         </div>
			                    </div>
			                </form>
			                </div>
			             </div>
			       </div>
			</div>
		</div>
</div> -->
<t:datagrid name="jeecgDemoList" checkbox="true" query="true" component="bootstrap-table" sortName="birthday,name" pagination="true" fitColumns="false" title="jeecg_demo" 
  	  superQuery="true" actionUrl="jeecgListDemoController.do?datagrid" idField="id" fit="true" queryMode="group" filter="true">
    <t:dgCol title="id"  field="id"   hidden="true"   queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="名称"  field="name" query="true" showLen="10"  autocomplete="true"  width="120"></t:dgCol>
    <!--update-begin-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，年龄区间查询-->
    <t:dgCol title="年龄"  extend="{style:'width:50px'}"  editor="numberbox" field="age" queryMode="group" query="true" width="120"></t:dgCol>
    <!--update-end-Author:zhangweijian Date: 20180710 for：TASK #2941 【bug】常用示例，小问题，年龄区间查询-->
    <t:dgCol title="生日"  hidden="true"  field="birthday" formatter="yyyy-MM-dd"   queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="性别"  field="sex"  query="true" showMode="radio" replace="女_1,男_0" dictionary="sex" width="120" extendParams="styler:fmtype"></t:dgCol>
    <t:dgCol title="电话"  field="phone" queryMode="group"  width="120"></t:dgCol>
    <t:dgCol title="工资"  field="salary" query="true" queryMode="group" width="120"></t:dgCol>
    <t:dgCol title="创建日期"  field="createDate" formatter="yyyy-MM-dd" query="true" queryMode="group" editor="datebox" width="120"></t:dgCol>
    <t:dgCol title="邮箱"  field="email" query="true"  popup="true" dictionary="user_msg,email,realname" width="120"></t:dgCol>
    <t:dgCol title="入职状态"  field="status" query="true" extend="{style:{width:'300px';color:'red'};datatype:'*';}" defaultVal='N'  dictionary="t_s_base_user,username,realname" width="80"></t:dgCol>
    <t:dgCol title="个人介绍"  field="content"  hidden="true"   queryMode="group"  width="150"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="250"></t:dgCol>
   <t:dgDelOpt title="删除" url="jeecgListDemoController.do?doDel&id={id}" urlclass="btn btn-danger btn-xs"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="jeecgListDemoController.do?goBootStrapTableAdd2" funname="add" width="750" height="500"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="jeecgListDemoController.do?goBootStrapTableUpdate2" funname="update" width="750" height="500"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="jeecgListDemoController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
  </t:datagrid>
</body>
</html>