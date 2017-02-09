<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center"  style="padding:0px;border:0px">
	<t:datagrid name="customDatagridList" title="DEMO自定义查询List" autoLoadData="true" actionUrl="jeecgDemoController.do?customDatagrid"
		 sortName="age" sortOrder="desc" idField="id" fit="true" queryMode="group" checkbox="true">
		<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
		<t:dgCol title="用户名" field="userName"  frozenColumn="true"  width="120"></t:dgCol>
		<t:dgCol title="电话号码" sortable="false" field="mobilePhone"  width="120"></t:dgCol>
		<t:dgCol title="办公电话" field="officePhone" width="120"></t:dgCol>
		<t:dgCol title="创建日期" field="createDate" formatter="yyyy-MM-dd hh:mm:ss"  width="200"></t:dgCol>
		<t:dgCol title="邮箱" field="email" width="200"></t:dgCol>
		<t:dgCol title="年龄" field="age" width="80"></t:dgCol>
		<t:dgCol title="工资" field="salary" width="120"></t:dgCol>
		<t:dgCol title="生日" field="birthday" formatter="yyyy/MM/dd" hidden="true" width="120"></t:dgCol>
		<t:dgCol title="性别" sortable="true" field="sex" dictionary="sex"  width="60"></t:dgCol>
		<t:dgCol title="状态" field="status" replace="未处理_0,已处理_1" width="60"></t:dgCol>
		<t:dgCol title="操作" field="opt" width="150"></t:dgCol>
		<t:dgDelOpt operationCode="del" title="删除" url="jeecgDemoController.do?del&id={id}" />
		<t:dgToolBar operationCode="add" title="录入" icon="icon-add" url="jeecgDemoController.do?addorupdate" funname="add"></t:dgToolBar> 
	</t:datagrid>
	
	<div id="customDatagridListtd" style="padding:1px;border:1px; height:auto">
		<div name="searchColums" style=" height:45px;line-height:45px;overflow:hidden;border:1px"><input  id="_sqlbuilder" name="sqlbuilder" type="hidden" />
			<form id='customDatagridListForm'>
				<label class="Validform_label">用户名：</label>
				<input type="text" name="userNames" id="userNames" style="margin-left: 10px; margin-top: 10px">
				<label class="Validform_label" style="margin-left: 15px;">性别：</label>
				<select id="sexs" name="sexs" value="" style="margin-top: 10px" class="form-control">
					<option value="" >--请选择--</option>
					<option value="0">男性</option>
					<option value="1">女性</option>
				</select>
				<label class="Validform_label" style="margin-left: 15px;">年龄：</label>
				<input type="text" name="ages" id="ages" style="margin-top: 10px">
			</form>
		</div>
			<div style="height:30px;line-height:30px;overflow:hidden;border:1px" class="datagrid-toolbar">
				<span style="float:right">
					<a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="searchDemo()">查询</a>
					<a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="Refresh('customDatagridList')">重置</a>
				</span>
			</div>
		</div>
	</div>
</div>	 

<script type="text/javascript">
	$(document).ready(function(){
		$("input[name='createDate_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("input[name='createDate_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("input[name='birthday']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
		$("*[name='status']").val("${status}");
	});
	function addMobile(title,addurl,gname,width,height){
		window.open(addurl);
	}
	
	function updateMobile(title,url, id,width,height){
		gridname=id;
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('请选择编辑项目');
			return;
		}
		if (rowsData.length>1) {
			tip('请选择一条记录再编辑');
			return;
		}
		
		url += '&id='+rowsData[0].id;
		window.open(url);
	} 
	
	function searchDemo(){
	 	var userName = $("#userNames").val();
	 	var sex = $("#sexs").val();
	 	var age = $("#ages").val();
	 		$("#customDatagridList").datagrid('load',{
	 			userName : userName,
	 			sex : sex,
	 			age :age
	     	});
	 	}
	function Refresh(){
		//刷新时将查询条件清空
		$("#userNames").val("");
	 	$("#sexs").val("");
	 	$("#ages").val("");
	 	$("#customDatagridList").datagrid('load',{});
	 }
</script>
<!-- add-end--Author:gengjiajia  Date:20160722 for： TASK #1179 datagrid列表不使用下面查询器组装查询 ，使用hql或者sql查询列表实现一个demo -->