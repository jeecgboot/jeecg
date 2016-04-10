<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tSSmsList" checkbox="true" fitColumns="false" title="common.messageSend.record" actionUrl="tSSmsController.do?datagrid" idField="id" fit="true" queryMode="group" sortName="createDate" sortOrder="desc">
   <t:dgCol title="common.esId"  field="id"  hidden="true"  queryMode="single" ></t:dgCol>
<%--   <t:dgCol title="创建人名称"  field="createName"  hidden="true"  queryMode="single" ></t:dgCol>--%>
<%--   <t:dgCol title="创建人登录名称"  field="createBy"  hidden="true"  queryMode="single" ></t:dgCol>--%>
   
<%--   <t:dgCol title="更新人名称"  field="updateName"  hidden="true"  queryMode="single" ></t:dgCol>--%>
<%--   <t:dgCol title="更新人登录名称"  field="updateBy"  hidden="true"  queryMode="single" ></t:dgCol>--%>
<%--   <t:dgCol title="更新日期"  field="updateDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single" ></t:dgCol>--%>
   <t:dgCol title="common.messageHeader"  field="esTitle" query="true" queryMode="single" ></t:dgCol>
   <t:dgCol title="common.messageType"  field="esType"  query="true" queryMode="single" dictionary="msgType"></t:dgCol>
   <t:dgCol title="common.sender"  field="esSender"  queryMode="single" query="true"></t:dgCol>
   <t:dgCol title="common.receiver"  field="esReceiver"  queryMode="single"></t:dgCol>
   <t:dgCol title="common.content_2"  field="esContent"  queryMode="single" ></t:dgCol>
   <t:dgCol title="common.dateCreated"  field="createDate" formatter="yyyy-MM-dd hh:mm:ss" query="true" queryMode="group" ></t:dgCol>
   <t:dgCol title="common.sendtime"  field="esSendtime"  formatter="yyyy-MM-dd hh:mm:ss" queryMode="single" ></t:dgCol>
   <t:dgCol title="common.sendState"  field="esStatus" query="true"  queryMode="single" dictionary="msgStatus"  ></t:dgCol>
   <t:dgCol title="common.remark"  field="remark"  queryMode="single" ></t:dgCol>
<%--   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>--%>
<%--   <t:dgDelOpt title="删除" url="tSSmsController.do?doDel&id={id}" />--%>
<%--   <t:dgToolBar title="录入" icon="icon-add" url="tSSmsController.do?goAdd" funname="add"></t:dgToolBar>--%>
   <t:dgToolBar title="common.iconEdit" icon="icon-edit" url="tSSmsController.do?goUpdate" funname="update"></t:dgToolBar>
<%--   <t:dgToolBar title="批量删除"  icon="icon-remove" url="tSSmsController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>--%>
<%--   <t:dgToolBar title="查看" icon="icon-search" url="tSSmsController.do?goUpdate" funname="detail"></t:dgToolBar>--%>
<%--   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>--%>
<%--   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>--%>
<%--   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>--%>
  </t:datagrid>
  </div>
 </div>
 <script src = "webpage/system/sms/tSSmsList.js"></script>		
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 			$("#tSSmsListtb").find("input[name='createDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#tSSmsListtb").find("input[name='updateDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			
 			$("#tSSmsList").find("input[name='createDate_begin']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#tSSmsList").find("input[name='updateDate_end']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 });
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'tSSmsController.do?upload', "tSSmsList");
}

//导出
function ExportXls() {
	JeecgExcelExport("tSSmsController.do?exportXls","tSSmsList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("tSSmsController.do?exportXlsByT","tSSmsList");
}
 </script>