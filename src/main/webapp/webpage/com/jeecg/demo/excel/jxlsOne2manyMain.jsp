<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true" id="lywidth_demo">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jformOrderMainList" checkbox="false" fitColumns="true" title="订单主信息" actionUrl="jformOrderMainController.do?datagrid" 
  		idField="id" fit="true" collapsible="true" queryMode="group" filter="true">
   <t:dgCol title="主键"  field="id" hidden="true" queryMode="single" width="120"></t:dgCol>
   <t:dgCol title="订单号"  field="orderCode"  queryMode="single" query="true"  width="120"></t:dgCol>
   <t:dgCol title="订单日期"  field="orderDate" formatter="yyyy-MM-dd" queryMode="group" width="120"></t:dgCol>
   <t:dgCol title="订单金额"  field="orderMoney"  queryMode="single" width="120"></t:dgCol>
   <t:dgCol title="备注"  field="content"  hidden="true"  queryMode="single" downloadName="附件下载"  width="120"></t:dgCol>
   <t:dgToolBar title="导出数据-横向展开" icon="icon-putout" funname="ExportXlsH"></t:dgToolBar>
   <t:dgToolBar title="导出数据-纵向展开" icon="icon-putout" funname="ExportXlsV"></t:dgToolBar>
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

//导出
function ExportXlsV() {
	JeecgExcelExport("jeecgDemoExcelController.do?jxlsExportXlsOne2Many&repeat=v","jformOrderMainList");
}
function ExportXlsH() {
	JeecgExcelExport("jeecgDemoExcelController.do?jxlsExportXlsOne2Many&repeat=h","jformOrderMainList");
}
 </script>