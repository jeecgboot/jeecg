<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true" id="lywidth_demo">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jformOrderMainList" checkbox="false" fitColumns="true" title="订单主信息" actionUrl="jformOrderMainController.do?datagrid" 
  		idField="id" fit="true" collapsible="true" queryMode="group" superQuery="true" filter="true">
   <t:dgCol title="主键"  field="id" hidden="true" queryMode="single" width="120"></t:dgCol>
   <t:dgCol title="订单号"  field="orderCode"  queryMode="single" query="true"  width="120"></t:dgCol>
   <t:dgCol title="订单日期"  field="orderDate" formatter="yyyy-MM-dd" queryMode="single" query="true" width="120"></t:dgCol>
   <t:dgCol title="订单金额"  field="orderMoney"  queryMode="single" query="true" width="120"></t:dgCol>
   <t:dgCol title="备注"  field="content"  hidden="true"  queryMode="single" downloadName="附件下载"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="jformOrderMainController.do?doDel&id={id}"  urlclass="ace_button" urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="jformOrderMainController.do?goAdd" funname="add" width="100%" height="100%"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="jformOrderMainController.do?goUpdate" funname="update" width="100%" height="100%"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="jformOrderMainController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="导入数据" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出数据" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
$(document).ready(function (){

	var abc = $("#lywidth_demo").width()+17;
	$("#lywidth_demo").css("min-width", abc).css("padding-right","17px").css("box-sizing","border-box");

	$("#jformOrderMainList").datagrid({
		onClickRow: function (index, row) {
			getCustomerList(row.id);
		}
	});
});
function getCustomerList(id){
	parent.getCustomerList(id);
}
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'jformOrderMainController.do?upload', "jformOrderMainList");
}

//导出
function ExportXls() {
	JeecgExcelExport("jformOrderMainController.do?exportXls","jformOrderMainList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("jformOrderMainController.do?exportXlsByT","jformOrderMainList");
}
 </script>