<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:1px;">
  <t:datagrid name="autoFormList" checkbox="true" fitColumns="false" title="自定义表单列表" actionUrl="autoFormController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title=""  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="auto.form.formName"  field="formDesc"    queryMode="single"  width="300"></t:dgCol>
   <t:dgCol title="auto.form.formCode"  field="formName"    queryMode="single"  width="300"></t:dgCol>
   <t:dgCol title=""  field="formStyleId"  dictionary="auto_form_style,id,style_desc" hidden="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.createName"  field="createName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.createby"  field="createBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.createDate"  field="createDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.updateName"  field="updateName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.updateBy"  field="updateBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.updateDate"  field="updateDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.depart.code"  field="sysOrgCode"  hidden="true"   queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.company.code"  field="sysCompanyCode" hidden="true"    queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="common.operation" field="opt" width="400"></t:dgCol>
   <t:dgDelOpt title="common.delete" url="autoFormController.do?doDel&id={id}" />
    <t:dgFunOpt title="表单数据源配置" funname="dbconfig(id)"/>
   <t:dgFunOpt title="autoform.preview" funname="parse(id)"/>
   <t:dgToolBar title="设计新表单" icon="icon-add" onclick="addbytab()"></t:dgToolBar>
   <t:dgToolBar title="编辑表单" icon="icon-edit" onclick="updatebytab()"></t:dgToolBar>
   <t:dgToolBar title="common.batch.delete"  icon="icon-remove" url="autoFormController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <%-- <t:dgToolBar title="common.query" icon="icon-search" url="autoFormController.do?goUpdate" funname="detail" width="100%" height="100%"></t:dgToolBar> --%>
  </t:datagrid>
  </div>
 </div>		
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 			$("#autoFormListtb").find("input[name='createDate']").attr("class","Wdate").attr("style","height:20px;width:90px;").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#autoFormListtb").find("input[name='updateDate']").attr("class","Wdate").attr("style","height:20px;width:90px;").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 });
 
function addbytab() {
	    addOneTab( '<t:mutiLang langKey="auto.form.addorupdate"/>', "autoFormController.do?goAdd");
		//document.location="autoFormController.do?goAdd";
	}
function updatebytab(){
var rows = $("#autoFormList").datagrid("getSelections");
	if(rows==''){
		alert('请选择一行记录');
		return;
	}
	var id=rows[0].id;
	addOneTab( '<t:mutiLang langKey="auto.form.addorupdate"/>', "autoFormController.do?goUpdate&id="+id);
	//document.location="autoFormController.do?goUpdate&id="+id;
}
var parseWindow ;
function parse(id){
	//var targetUrl = 'autoFormController.do?parse&id='+id;
    //window.open(targetUrl,'mywin',"menubar=0,toolbar=0,status=0,resizable=1,left=0,top=0,scrollbars=1,width=" +(screen.availWidth-10) + ",height=" + (screen.availHeight-50) + "\"");
	//createdetailwindow('<t:mutiLang langKey="common.view"/>','autoFormController.do?parse&id='+id,600,400);
	var addurl = 'autoFormController.do?parse&id='+id;
	parseWindow = $.dialog({
		content: 'url:'+addurl,
		lock : true,
		width: 600,
		height: 350,
		title: '<t:mutiLang langKey="common.view"/>',
		opacity : 0.3,
		cache:false
	}).zindex();
}

function dbconfig(id){
	addOneTab( '表单数据源配置', "autoFormDbController.do?autoFormDb&autoFormId="+id);
}

function winclose(){
	parseWindow.close();
	parseWindow = undefined;
}

 </script>