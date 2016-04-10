<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tSSmsSqlList" checkbox="true" fitColumns="false" title="common.businessSqlTable" actionUrl="tSSmsSqlController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="common.esId"  field="id"  hidden="true"  queryMode="single"  ></t:dgCol>
<%--   <t:dgCol title="创建人名称"  field="createName"  hidden="true"  queryMode="single"  ></t:dgCol>--%>
<%--   <t:dgCol title="创建人登录名称"  field="createBy"  hidden="true"  queryMode="single"  ></t:dgCol>--%>
<%--   <t:dgCol title="创建日期"  field="createDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  ></t:dgCol>--%>
<%--   <t:dgCol title="更新人名称"  field="updateName"  hidden="true"  queryMode="single"  ></t:dgCol>--%>
<%--   <t:dgCol title="更新人登录名称"  field="updateBy"  hidden="true"  queryMode="single"  ></t:dgCol>--%>
<%--   <t:dgCol title="更新日期"  field="updateDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  ></t:dgCol>--%>
   <t:dgCol title="common.sqlName"  query="true" field="sqlName"  queryMode="single"  ></t:dgCol>
   <t:dgCol title="common.sqlContent"  query="true" field="sqlContent"  queryMode="single"  ></t:dgCol>
   <t:dgCol title="common.operate" field="opt"></t:dgCol>
   <t:dgDelOpt title="common.delete_2" url="tSSmsSqlController.do?doDel&id={id}" />
   <t:dgToolBar title="common.add_2" icon="icon-add" url="tSSmsSqlController.do?goAdd" funname="add"></t:dgToolBar>
   <t:dgToolBar title="common.edit_2" icon="icon-edit" url="tSSmsSqlController.do?goUpdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="common.batchDelete"  icon="icon-remove" url="tSSmsSqlController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="common.search" icon="icon-search" url="tSSmsSqlController.do?goUpdate" funname="detail"></t:dgToolBar>
<%--   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>--%>
<%--   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>--%>
<%--   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>--%>
  </t:datagrid>
  </div>
 </div>
 <script src = "webpage/system/sms/tSSmsSqlList.js"></script>		
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 			$("#tSSmsSqlListtb").find("input[name='createDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#tSSmsSqlListtb").find("input[name='updateDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 });
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tSSmsSqlController.do?upload', "tSSmsSqlList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tSSmsSqlController.do?exportXls","tSSmsSqlList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tSSmsSqlController.do?exportXlsByT","tSSmsSqlList");
}
 </script>