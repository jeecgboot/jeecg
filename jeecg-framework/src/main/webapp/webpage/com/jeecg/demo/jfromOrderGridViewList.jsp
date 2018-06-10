<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">  
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jfromOrderList" checkbox="true" fitColumns="true"  title="订单列表" extendParams="view: detailview,detailFormatter:detailFormatterFun,onExpandRow: onExpandRowFun"
  actionUrl="jfromOrderController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人名称"  field="createName"  hidden="true"  queryMode="single" query="true"  width="120"></t:dgCol>
   <t:dgCol title="创建人登录名称"  field="createBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建日期"  field="createDate"  formatter="yyyy-MM-dd"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人名称"  field="updateName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人登录名称"  field="updateBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新日期"  field="updateDate"  formatter="yyyy-MM-dd"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="所属部门"  field="sysOrgCode"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="所属公司"  field="sysCompanyCode"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="流程状态"  field="bpmStatus"  hidden="true"  queryMode="single"  dictionary="bpm_status"  width="120"></t:dgCol>
   <t:dgCol title="收货人"  field="receiverName"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="联系电话"  field="receiverMobile"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="收货省"  field="receiverState"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="收货市"  field="receiverCity"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="收货区"  field="receiverDistrict"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="收货地址"  field="receiverAddress"  queryMode="single"  width="210"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="jfromOrderController.do?doDel&id={id}"  urlclass="ace_button" urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="jfromOrderController.do?goAdd" funname="add" width="100%" height="100%"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="jfromOrderController.do?goUpdate" funname="update" width="100%" height="100%"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="jfromOrderController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="jfromOrderController.do?goUpdate" funname="detail" width="100%" height="100%"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script src = "webpage/com/jeecg/demo/jfromOrderList.js"></script>
 <script src="plug-in/easyui/extends/datagrid-detailview.js"></script>
 <script type="text/javascript">
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'jfromOrderController.do?upload', "jfromOrderList");
}

//导出
function ExportXls() {
	JeecgExcelExport("jfromOrderController.do?exportXls","jfromOrderList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("jfromOrderController.do?exportXlsByT","jfromOrderList");
}
//返回行明细内容的格式化函数。
function detailFormatterFun() {
    var s = '<div class="orderInfoHidden" style="padding:2px;">' 
   		+ '		<div class="easyui-tabs" style="height:230px;width:800px;">' 
   		+ '			<div title="订单明细" style="padding:2px;">' 
   		+ '				<table class="jfrom_order_linetablelines" ></table>' 
   		+ '			</div>' 
   		+ '		</div>' 
   		+ '	</div>';
    return s;
}
//当展开一行时触发 
function onExpandRowFun(index, row) {
	//把加上的子表tabs和datagrid初始化
    var tabs = $(this).datagrid('getRowDetail', index).find('div.easyui-tabs');
    tabs.tabs();
    var jfrom_order_linetablelines = $(this).datagrid('getRowDetail', index).find('table.jfrom_order_linetablelines');
    var jfrom_order_linedurl = 'jfromOrderController.do?jfromOrderLineDatagrid&field=itemName,qty,price,amount&orderid=' + row.id;
    jfrom_order_linetablelines.datagrid({
        singleSelect: true,
        loadMsg: '正在加载',
        fitColumns: true,
        height: '180',
        pageSize: 50,
        pageList: [50, 150, 200, 250, 300],
        border: false,
        url: jfrom_order_linedurl,
        idField: 'id',
        rownumbers: true,
        pagination: true,
        columns: [[{
            title: '商品名称',
            field: 'itemName',
            align: 'left',
            width: 50
        },
        {
            title: '商品数量',
            field: 'qty',
            align: 'left',
            width: 50
        },
        {
            title: '商品价格',
            field: 'price',
            align: 'left',
            width: 50
        },
        {
            title: '金额',
            field: 'amount',
            align: 'left',
            width: 50
        }]]
    });
}
 </script>