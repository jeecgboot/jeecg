<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
   <t:datagrid name="autoFormDbList" checkbox="true" fitColumns="false" title="表单数据源配置" actionUrl="autoFormDbController.do?datagrid&autoFormId=${autoFormId}" idField="id" fit="true" queryMode="group">
   <t:dgCol title=""  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.createName"  field="createName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.createby"  field="createBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.updateName"  field="updateName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.updateBy"  field="updateBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <!--update-end--Author:luobaoli  Date:20150617 for：调整国际化编码-->
   <t:dgCol title="common.depart.code"  field="sysOrgCode"  hidden="true"  queryMode="single" dictionary="t_s_depart,id,departname"  width="120"></t:dgCol>
   <!--update-end--Author:luobaoli  Date:20150617 for：调整国际化编码-->
   <t:dgCol title="common.company.code"  field="sysCompanyCode"  hidden="true"  queryMode="single" dictionary="t_s_depart,id,departname"  width="120"></t:dgCol>
   <t:dgCol title="common.createDate"  field="createDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.updateDate"  field="updateDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="form.db.name"  field="dbName"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="form.db.chname"  field="dbChName"    queryMode="single"  width="120"></t:dgCol>
   <!--update-end--Author:luobaoli  Date:20150701 for：显示中文数据源类型-->
   <t:dgCol title="form.db.type"  field="dbType"    queryMode="single" dictionary="formDbType" width="120"></t:dgCol>
   <!--update-end--Author:luobaoli  Date:20150701 for：显示中文数据源类型-->
   <t:dgCol title="form.db.tablename"  field="dbTableName"    queryMode="single"  width="120"></t:dgCol>
   <!--add-start--Author: jg_huangxg  Date:20150723 for：新增填报数据源和填报数据库表显示-->
   <t:dgCol title="form.tb.db.key"  field="tbDbKey"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="form.tb.db.table.name"  field="tbDbTableName"    queryMode="single"  width="120"></t:dgCol>
   <!--add-end--Author: jg_huangxg  Date:20150723 for：新增填报数据源和填报数据库表显示-->
   <t:dgCol title="form.db.synsql"  field="dbDynSql"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.dynamic.dbsource"  field="dbKey"   hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.operation" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="common.delete" url="autoFormDbController.do?doDel&id={id}" />
   <!--add-start--Author:luobaoli  Date:20150626 for：新增表单数据源预览操作-->
   <t:dgFunOpt title="form.db.preview" funname="goView(id)"></t:dgFunOpt>
   <!--add-end--Author:luobaoli  Date:20150626 for：新增表单数据源预览操作-->
   <%-- <t:dgToolBar title="common.add" icon="icon-add" url="autoFormDbController.do?goAdd" funname="add" height="600"></t:dgToolBar> --%>
   <t:dgToolBar title="common.edit" icon="icon-edit" url="autoFormDbController.do?goUpdate" funname="update" height="600"></t:dgToolBar>
   <t:dgToolBar title="common.query" icon="icon-search" url="autoFormDbController.do?goUpdate" funname="detail"></t:dgToolBar>
   <t:dgToolBar title="common.batch.delete"  icon="icon-remove" url="autoFormDbController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script src = "webpage/jeecg/cgform/autoform/autoFormDbList.js"></script>		
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 			$("#autoFormDbListtb").find("input[name='createDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#autoFormDbListtb").find("input[name='updateDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 });
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'autoFormDbController.do?upload', "autoFormDbList");
}

//导出
function ExportXls() {
	JeecgExcelExport("autoFormDbController.do?exportXls","autoFormDbList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("autoFormDbController.do?exportXlsByT","autoFormDbList");
}

//--add-start--Author:luobaoli  Date:20150626 for：新增表单数据源预览操作
//数据源预览
function goView(id){
	openwindow('<t:mutiLang langKey="common.view"/>','autoFormDbController.do?goView&id='+id,'',600,500);
}
//--add-end--Author:luobaoli  Date:20150626 for：新增表单数据源预览操作
 </script>