<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tYdServiceScoreList" checkbox="true" fitColumns="false" title="艺都餐厅客户服务评价" actionUrl="tYdServiceScoreController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="false"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人名称"  field="createName"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人登录名称"  field="createBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建日期"  field="createDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人名称"  field="updateName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人登录名称"  field="updateBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新日期"  field="updateDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="所属部门"  field="sysOrgCode"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="所属公司"  field="sysCompanyCode"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="饭菜口味"  field="foodScore"    queryMode="single" dictionary="five_score" width="120"></t:dgCol>
   <t:dgCol title="送餐速度"  field="speedScore"    queryMode="single" dictionary="five_score" width="120"></t:dgCol>
   <t:dgCol title="评价详情"  field="detail"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="餐厅反馈"  field="response"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="是否有效"  field="isValid"    queryMode="single" dictionary="is_valid" width="120"></t:dgCol>
   <t:dgToolBar title="服务评价" icon="icon-add" url="tYdServiceScoreController.do?goAdd" funname="add" operationCode="add"></t:dgToolBar>
   <t:dgToolBar title="评价反馈" icon="icon-edit" url="tYdServiceScoreController.do?goUpdate" funname="update" operationCode="update"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tYdServiceScoreController.do?doBatchDel" funname="deleteALLSelect" operationCode="delete"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tYdServiceScoreController.do?goUpdate" funname="detail"></t:dgToolBar>
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script src = "webpage/com/buss/yd/tYdServiceScoreList.js"></script>		
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 			$("#tYdServiceScoreListtb").find("input[name='createDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#tYdServiceScoreListtb").find("input[name='updateDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 });
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tYdServiceScoreController.do?upload', "tYdServiceScoreList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tYdServiceScoreController.do?exportXls","tYdServiceScoreList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tYdServiceScoreController.do?exportXlsByT","tYdServiceScoreList");
}
 </script>