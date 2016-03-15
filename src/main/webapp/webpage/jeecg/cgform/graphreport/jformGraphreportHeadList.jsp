<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jformGraphreportHeadList" checkbox="true" fitColumns="false" title="图表配置" actionUrl="jformGraphreportHeadController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="id"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="名称"  field="name"   query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="编码"  field="code"   query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="查询数据SQL"  field="cgrSql"   query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="描述"  field="content"    queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="y轴文字"  field="ytext"    queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="x轴数据"  field="categories"    queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="是否显示明细"  field="isShowList"   query="true" queryMode="single" dictionary="sf_yn" width="120"></t:dgCol>
   <t:dgCol title="扩展JS"  field="xpageJs"    queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="200"></t:dgCol>
   <t:dgDelOpt title="删除" url="jformGraphreportHeadController.do?doDel&id={id}" />
   <t:dgFunOpt  funname="addlisttab(code,content)" title="function.test"></t:dgFunOpt>
   <t:dgFunOpt  funname="popMenuLinkGraph(code,content)" title="config.place"></t:dgFunOpt>

   <t:dgToolBar title="录入" icon="icon-add" url="jformGraphreportHeadController.do?goAdd" funname="add" width="100%" height="100%"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="jformGraphreportHeadController.do?goUpdate" funname="update" width="100%" height="100%"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="jformGraphreportHeadController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="jformGraphreportHeadController.do?goUpdate" funname="detail"></t:dgToolBar>
   <t:dgToolBar title="EXCEL导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="EXCEL导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
    </t:datagrid>
  </div>
 </div>
 <script src = "webpage/jeecg/cgform/graphreport/jformGraphreportHeadList.js"></script>
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 });
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'jformGraphreportHeadController.do?goImportExcel', "jformGraphreportHeadList");
}

//导出
function ExportXls() {
	JeecgExcelExport("jformGraphreportHeadController.do?exportXls","jformGraphreportHeadList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("jformGraphreportHeadController.do?exportXlsByT","jformGraphreportHeadList");
}
 function addlisttab(tableName,content){
  addOneTab( '<t:mutiLang langKey="form.datalist"/>' + "["+content+"]", "graphReportController.do?list&id="+tableName);
 }

 </script>
