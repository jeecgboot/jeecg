<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tSSmsTemplateList" checkbox="true" fitColumns="false" title="common.msgTemplateTable" actionUrl="tSSmsTemplateController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="common.isId"  field="id"  hidden="true"  queryMode="single"  ></t:dgCol>
   <t:dgCol title="common.templateCode"  field="templateCode"  query="true" queryMode="single"  ></t:dgCol>
   <t:dgCol title="common.templateName"  field="templateName"  query="true" queryMode="single"  ></t:dgCol>
   <t:dgCol title="common.templateType"  field="templateType" query="true" queryMode="single" dictionary="msgTplType" ></t:dgCol>
   <t:dgCol title="common.templateContent"  field="templateContent"  queryMode="single"  ></t:dgCol>
   <t:dgCol title="common.opt" field="opt" width="150"></t:dgCol>
   <t:dgDelOpt title="common.deleteTo" url="tSSmsTemplateController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o" />
   <t:dgFunOpt funname="pushTest(id,templateCode)" title="common.pushTest" urlclass="ace_button" urlfont="fa-upload"></t:dgFunOpt>
   <t:dgToolBar title="common.icon.add" icon="icon-add" url="tSSmsTemplateController.do?goAdd" funname="add" width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="common.icon.edit" icon="icon-edit" url="tSSmsTemplateController.do?goUpdate" funname="update" width="800" height="500"></t:dgToolBar>
   <t:dgToolBar title="common.icon.remove"  icon="icon-remove" url="tSSmsTemplateController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="common.view" icon="icon-search" url="tSSmsTemplateController.do?goUpdate" funname="detail"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 function pushTest(id,code){
	 $.getJSON("tSSmsTemplateController.do?pushTestMsg&templateCode="+code,
		function(result){
		 if (result.success){
			 alert("测试推送成功");
		 }else {
			 alert("测试推送失败:"+result.msg);
	     }
	  });
 }
 </script>