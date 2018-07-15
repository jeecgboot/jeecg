<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jformOrderMain2List" checkbox="true" filterBtn="true" onDblClick="datagridDbclick"  fit="true" fitColumns="true" title="" sortName="orderDate" actionUrl="jformOrderMain2Controller.do?datagrid" idField="id" 
  			  queryMode="group" extendParams="checkOnSelect:false,onSelect:function(index,row){datagridSelect(index,row);}">
   <t:dgCol title="主键"  field="id"  hidden="true" extendParams="editor:'text'" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="订单号"  field="orderCode"  extendParams="editor:'text'"  queryMode="single"  dictionary="user_msg,account,realname"  popup="true"  width="120"></t:dgCol>
   <t:dgCol title="订单日期"  field="orderDate"  formatter="yyyy-MM-dd"  filterType="datebox" extendParams="editor:{type:'datebox',options:{onShowPanel:initDateboxformat}}"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="订单金额"  field="orderMoney"   filterType="numberbox" extendParams="editor:{type:'validatebox',options:{validType:'decimalTwo'}}"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="备注"  field="content"  extendParams="editor:'text'"  queryMode="single"  width="120"></t:dgCol>
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
	  gridname = curd.getGridname();
 });
 
 /**
  * 双击事件开始编辑
  */
 function datagridDbclick(index,field,value){
 	$("#jformOrderMain2List").datagrid('beginEdit', index);
 }
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