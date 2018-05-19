<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jformOrderMain2List" checkbox="true"  fit="true" fitColumns="true" title="" actionUrl="jformOrderMain2Controller.do?datagrid" idField="id" queryMode="group" extendParams="checkOnSelect:false,onSelect:function(index,row){datagridSelect(index,row);}">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="订单号"  field="orderCode"    queryMode="single"  dictionary="user_msg,account,realname"  popup="true"  width="120"></t:dgCol>
   <t:dgCol title="订单日期"  field="orderDate"  formatter="yyyy-MM-dd"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="订单金额"  field="orderMoney"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="备注"  field="content"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="jformOrderMain2Controller.do?doDel&id={id}"  urlclass="ace_button" urlfont="fa-trash-o"/>
  </t:datagrid>
  </div>
 </div>
  <script type="text/javascript" src="plug-in/mutitables/mutitables.urd.js"></script>
  <script type="text/javascript" src="plug-in/mutitables/mutitables.curdInIframe.js"></script>
  <script type="text/javascript">
 $(function(){
	  curd = $.curdInIframe({
		  name:"jformOrderMain2",
		  isMain:true,
		  describe:"订单信息",
		  form:{width:'100%',height:'100%'},
	  });
 });
 
 /**
  * 选中事件加载子表数据
  */
 function datagridSelect(index,row){
	$('#jformOrderMain2List').datagrid('unselectAll');
 	parent.initSubList(row.id);
 }
 /**
  * 主页面重置调用方法
  */
 function queryResetit(){
	searchReset('jformOrderMain2List');
	jformOrderMain2Listsearch();
 }
 
 </script>