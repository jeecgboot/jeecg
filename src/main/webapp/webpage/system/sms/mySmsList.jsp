<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="tSSmsList" checkbox="true" fitColumns="false" title="我的消息列表" actionUrl="tSSmsController.do?mydatagrid" idField="id" fit="true" queryMode="group" sortName="createDate" sortOrder="desc">
   <t:dgCol title="common.esId"  field="id"  hidden="true"  queryMode="single" ></t:dgCol>
   <t:dgCol title="common.isRead" field="isRead"  replace="已读_1,未读_0"></t:dgCol>
   <%-- <t:dgCol title="common.messageType"  field="esType"  query="false" queryMode="single" dictionary="msgType"></t:dgCol> --%>
   <t:dgCol title="common.messageHeader"  field="esTitle" query="true" queryMode="single" ></t:dgCol>
   <t:dgCol title="common.sender"  field="esSender"  queryMode="single"></t:dgCol>
   <t:dgCol title="common.content_2"  field="esContent"  queryMode="single" width="260"></t:dgCol>
  <%--  <t:dgCol title="common.dateCreated"  field="createDate" formatter="yyyy-MM-dd hh:mm:ss" query="false" queryMode="group" ></t:dgCol> --%>
   <t:dgCol title="common.sendtime"  field="esSendtime"  formatter="yyyy-MM-dd hh:mm:ss" queryMode="single" ></t:dgCol>
   <t:dgCol title="common.operation" field="opt" width="80"></t:dgCol>
   <t:dgFunOpt funname="doRead(id,isRead)" title="common.read" urlclass="ace_button"  urlfont="fa-trash-o"></t:dgFunOpt>
  </t:datagrid>
  </div>
 </div>
<script type="text/javascript" charset="utf-8">
  $('#tSSmsList').datagrid({   
	    rowStyler:function(index,row){   
	        if (row.isRead!=1){
	            return 'font-weight:bold !important;';   
	        }   
	    }
	});
  
  function doRead(id,isRead){
	  	var addurl = "tSSmsController.do?goSmsDetail&id="+id;
		createdetailwindow("通知详情", addurl, 750, 600);
  }
  
 </script>