<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tSCompanyPositionList" checkbox="true" pagination="true" fitColumns="true" title="职务管理" actionUrl="tSCompanyPositionController.do?datagrid&companyId=${companyId }" idField="id" fit="true" queryMode="group">
   <t:dgCol title="序号"  field="id"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="公司ID"  field="companyId"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="职务编码"  field="positionCode"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="职务名称"  field="positionName"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="职务英文名"  field="positionNameEn"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="职务缩写"  field="positionNameAbbr"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="职务级别"  field="positionLevel"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="备注"  field="memo"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="逻辑删除状态"  field="delFlag"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建人名称"  field="createName"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建人账号"  field="createBy"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="创建日期"  field="createDate"  formatter="yyyy-MM-dd"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="更新人名称"  field="updateName"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="更新人账号"  field="updateBy"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="更新日期"  field="updateDate"  formatter="yyyy-MM-dd"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="数据所属公司"  field="sysCompanyCode"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="数据所属部门"  field="sysOrgCode"  hidden="true"  queryMode="group"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="tSCompanyPositionController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="tSCompanyPositionController.do?goAdd&companyId=${companyId }" funname="add"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="tSCompanyPositionController.do?goUpdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tSCompanyPositionController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="tSCompanyPositionController.do?goUpdate" funname="detail"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script src = "webpage/system/position/tSCompanyPositionList.js"></script>		
 <script type="text/javascript">
 $(document).ready(function(){
 });
 
   
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tSCompanyPositionController.do?upload', "tSCompanyPositionList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tSCompanyPositionController.do?exportXls","tSCompanyPositionList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tSCompanyPositionController.do?exportXlsByT","tSCompanyPositionList");
}


 </script>