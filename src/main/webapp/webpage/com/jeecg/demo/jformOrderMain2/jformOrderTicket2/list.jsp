<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jformOrderTicket2List" checkbox="true" pagination="true" fitColumns="true" title="" actionUrl="jformOrderTicket2Controller.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="航班号"  field="ticketCode"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="航班时间"  field="tickectDate"  formatter="yyyy-MM-dd hh:mm:ss"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="外键"  field="fckId"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="jformOrderTicket2Controller.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
  </t:datagrid>
  </div>
   <input type="hidden" id = "jformOrderTicket2ListMainId"/>
 </div>
  <script type="text/javascript" src="plug-in/mutitables/mutitables.urd.js"></script>
  <script type="text/javascript" src="plug-in/mutitables/mutitables.curdInIframe.js"></script>	
 <script type="text/javascript">
 $(document).ready(function(){
	  curd = $.curdInIframe({
		  name:"jformOrderTicket2",
		  describe:"订单机票"
	  });
 });
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'jformOrderTicket2Controller.do?upload', "jformOrderTicket2List");
}

//导出
function ExportXls() {
	JeecgExcelExport("jformOrderTicket2Controller.do?exportXls","jformOrderTicket2List");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("jformOrderTicket2Controller.do?exportXlsByT","jformOrderTicket2List");
}

 </script>