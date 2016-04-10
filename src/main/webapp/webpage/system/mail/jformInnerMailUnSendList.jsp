<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="jformInnerMailList" checkbox="true" fitColumns="false" title="内部邮件" actionUrl="jformInnerMailController.do?getUnSendMails" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="主题"  field="title" queryMode="single" query="true" width="120"></t:dgCol>
   <t:dgCol title="收件人"  field="receiverNames"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建日期"  field="createTime"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="jformInnerMailController.do?doDelMail&id={id}" />
   <t:dgToolBar title="编辑邮件" icon="icon-edit" url="jformInnerMailController.do?goAddOrUpdate" funname="goAddOrUpdate"></t:dgToolBar>
   <t:dgToolBar title="删除"  icon="icon-remove" url="jformInnerMailController.do?doDelMails" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="jformInnerMailController.do?goDetail" funname="detail"></t:dgToolBar>
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