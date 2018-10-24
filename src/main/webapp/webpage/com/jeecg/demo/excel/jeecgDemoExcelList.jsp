<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jeecgDemoExcelList" checkbox="true" pagination="true" fitColumns="true" title="excel导入导出测试表" actionUrl="jeecgDemoExcelController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="姓名"  field="name"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="性别"  field="sex"  queryMode="single"  dictionary="sex"  width="120"></t:dgCol>
   <t:dgCol title="生日"  field="birthday"  formatter="yyyy-MM-dd"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="关联部门"  field="depart"  queryMode="single"  dictionary="t_s_depart,id,departname"  width="120"></t:dgCol>
   <t:dgCol title="测试替换"  field="fdReplace"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="测试转换"  field="fdConvert"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="jeecgDemoExcelController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="jeecgDemoExcelController.do?goAdd" funname="add"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="jeecgDemoExcelController.do?goUpdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="jeecgDemoExcelController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="jeecgDemoExcelController.do?goUpdate" funname="detail"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
   <t:dgToolBar title="ftl模板导出word" icon="icon-putout" funname="ftlExportWord"></t:dgToolBar>
   <t:dgToolBar title="jxls模板导出excel" icon="icon-putout" funname="jxlsExportXls"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
 });
 
//ftl模板导出word
 function jxlsExportXls(){
 	location.href = "jeecgDemoExcelController/jxlsExportXls.do";
 }
 
//ftl模板导出word
function ftlExportWord(){
	var rowsData = $('#jeecgDemoExcelList').datagrid('getSelections');
	if (!rowsData || rowsData.length==0) {
		tip('请选择一条记录');
		return;
	}
	if (rowsData.length>1) {
		tip('请选择一条记录');
		return;
	}
	location.href = "jeecgDemoExcelController/ftl2word.do?id="+rowsData[0].id;
}
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'jeecgDemoExcelController.do?upload', "jeecgDemoExcelList");
}

//导出
function ExportXls() {
	JeecgExcelExport("jeecgDemoExcelController.do?exportXls","jeecgDemoExcelList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("jeecgDemoExcelController.do?exportXlsByT","jeecgDemoExcelList");
}

 </script>