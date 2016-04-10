<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jformInnerMailList" checkbox="true" fitColumns="false" title="收件箱" actionUrl="jformInnerMailController.do?getReceivedMails" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id" hidden="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="邮件ID"  field="mailId" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="主题"  field="title"  query="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="发件人名称" field="senderName"  query="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="发件人账号" field="senderAccount"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="日期"  field="sendTime" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="状态"  field="status"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="jformInnerMailController.do?doDelReceivedMail&id={id}" />
   <t:dgToolBar title="查看" icon="icon-search" url="jformInnerMailController.do?goDetail" funname="goDetail"></t:dgToolBar>
   <t:dgToolBar title="删除" icon="icon-remove" url="jformInnerMailController.do?doDelReceivedMails" funname="deleteALLSelect"></t:dgToolBar>
   
  </t:datagrid>
  </div>
 </div>
 <script src = "webpage/com/buss/core/jformInnerMailList.js"></script>		
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 			$("#jformInnerMailListtb").find("input[name='createDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#jformInnerMailListtb").find("input[name='updateDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 });
 function goDetail(title,url,id){
	    var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('请选择编辑项目');
			return;
		}
		if (rowsData.length>1) {
			tip('请选择一条记录再编辑');
			return;
		}
		debugger;
		url = url +'&id='+rowsData[0].mailId;
		createdetailwindow("写信", url)
 }
 function goAddOrUpdate(title,url, id){
		var rowsData = $('#'+id).datagrid('getSelections');
		if (!rowsData || rowsData.length==0) {
			tip('请选择编辑项目');
			return;
		}
		if (rowsData.length>1) {
			tip('请选择一条记录再编辑');
			return;
		}
		debugger;
		url = url +'&id='+rowsData[0].id;
		addOneTab("写信", url)
	}
 </script>