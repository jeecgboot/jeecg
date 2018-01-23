<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jeecgMysearchList" pageSize="500" checkbox="true" pagination="true" fitColumns="false" title="自定义列表查询条件" actionUrl="jeecgListDemoController.do?datagrid" idField="id" fit="true">
    <t:dgCol title="id"  field="id" hidden="true" width="120"></t:dgCol>
    <t:dgCol title="名称"  field="name" autocomplete="true" width="200"></t:dgCol>
    <t:dgCol title="年龄"  field="age"  width="120"></t:dgCol>
    <t:dgCol title="生日"  field="birthday" formatter="yyyy-MM-dd" width="200"></t:dgCol>
    <t:dgCol title="部门"  field="depId" dictionary="t_s_depart,id,departname" width="120"></t:dgCol>
    <t:dgCol title="性别"  field="sex"  dictionary="sex" width="120"></t:dgCol>
    <t:dgCol title="电话"  field="phone"  width="200"></t:dgCol>
    <t:dgCol title="工资"  field="salary"  width="200"></t:dgCol>
  </t:datagrid>
  
	  <div id="jeecgMysearchListtb" style="padding: 3px; height: 25px">
		  	 <div style="float: left;">
				  <a href="#" id="add" class="easyui-linkbutton" plain="true" icon="icon-add" onclick="add('录入','jeecgListDemoController.do?goAdd','jeecgMysearchList')">用户录入</a> 
				  <a href="#" class="easyui-linkbutton" plain="true" icon="icon-edit" onclick="update('编辑','jeecgListDemoController.do?goUpdate','jeecgMysearchList')">用户编辑</a>
			  </div>
	  		  <div align="right" class="searchColums">
	  			  名称：<input class="inuptxt ac_input" type="text" name="name">
	  			  年龄：<input class="easyui-validatebox"  type="text" name="age">
	  			 <a href="#" class="easyui-linkbutton" iconCls="icon-search" onclick="jeecgMysearchListsearch();">查询</a>
				 <a href="#" class="easyui-linkbutton" iconCls="icon-reload" onclick="searchReset('jeecgMysearchList')">重置</a>
	  		 </div>
  	  </div>
 </div> 
</div>
 <script type="text/javascript">
 function testReloadPage(){
		document.location = "http://www.baidu.com"; 
	}
	function szqm(id) {
		createwindow('审核', 'jeecgListDemoController.do?doCheck&id=' + id);
	}
	function addNewPage(id){
		addOneTab("TAB方式添加", jeecgListDemoController.do?addTab&type=table&id="+id);
	}
	
 $(document).ready(function(){
 		//给时间控件加上样式
 			$("#jeecgDemoListtb").find("input[name='birthday_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#jeecgDemoListtb").find("input[name='birthday_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#jeecgDemoListtb").find("input[name='createDate_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#jeecgDemoListtb").find("input[name='createDate_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#jeecgDemoListtb").find("input[name='updateDate_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#jeecgDemoListtb").find("input[name='updateDate_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 });
 
   
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'jeecgListDemoController.do?upload', "jeecgDemoList");
}

//导出
function ExportXls() {
	JeecgExcelExport("jeecgListDemoController.do?exportXls","jeecgDemoList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("jeecgListDemoController.do?exportXlsByT","jeecgDemoList");
}

 </script>