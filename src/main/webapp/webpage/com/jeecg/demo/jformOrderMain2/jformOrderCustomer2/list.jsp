<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jformOrderCustomer2List" checkbox="true" pagination="true" fitColumns="true" title="" actionUrl="jformOrderCustomer2Controller.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="客户名"  field="name"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="单价"  field="money"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="性别"  field="sex"  queryMode="single"  dictionary="sex"  width="120"></t:dgCol>
   <t:dgCol title="电话"  field="telphone"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="外键"  field="fkId"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="jformOrderCustomer2Controller.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
  </t:datagrid>
  </div>
   <input type="hidden" id = "jformOrderCustomer2ListMainId"/>
 </div>
  <script type="text/javascript" src="plug-in/mutitables/mutitables.urd.js"></script>
  <script type="text/javascript" src="plug-in/mutitables/mutitables.curdInIframe.js"></script>	
 <script type="text/javascript">
 $(document).ready(function(){
	  curd = $.curdInIframe({
		  name:"jformOrderCustomer2",
		  describe:"订单客户"
	  });
 });

//导入
function ImportXls() {
	openuploadwin('Excel导入', 'jformOrderCustomer2Controller.do?upload', "jformOrderCustomer2List");
}

//导出
function ExportXls() {
	JeecgExcelExport("jformOrderCustomer2Controller.do?exportXls","jformOrderCustomer2List");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("jformOrderCustomer2Controller.do?exportXlsByT","jformOrderCustomer2List");
}

 </script>