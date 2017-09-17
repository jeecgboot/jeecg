<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="cgformTemplateList" checkbox="true" fitColumns="true" title="Online表单风格列表" actionUrl="cgformTemplateController.do?datagrid" idField="id" fit="true" queryMode="group">
   <t:dgCol title="主键"  field="id"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人名称"  field="createName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建人登录名称"  field="createBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="创建日期"  field="createDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人名称"  field="updateName"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新人登录名称"  field="updateBy"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="更新日期"  field="updateDate" formatter="yyyy-MM-dd" hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="所属部门"  field="sysOrgCode"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="所属公司"  field="sysCompanyCode"  hidden="true"  queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="表单风格名"  field="templateName"   query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="风格编码"  field="templateCode"   query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="类型"   field="templateType"   query="true" queryMode="single" replace="单表_1,主子表_2,通用模板_3" width="120"></t:dgCol>
   <!-- update-begin author:taoYan date:20170727 for:该字段似乎没有用 暂取消作为查询条件 -->
   <t:dgCol title="是否共享" hidden="true"  field="templateShare" query="false" queryMode="single" dictionary="sf_yn" width="120"></t:dgCol>
   <!-- update-end author:taoYan date:20170727 for:该字段似乎没有用 暂取消作为查询条件 -->
    <!-- update--begin--author:zhangjiaqiang date:20170305 for:TASK #1749 【新功能】自定义样式表加个字段 【是否激活】 -->
    <t:dgCol title="是否激活"   field="status" replace="有效_1,无效_0"  query="true" queryMode="single"  width="120"></t:dgCol>
 <!-- update--end--author:zhangjiaqiang date:20170305 for:TASK #1749 【新功能】自定义样式表加个字段 【是否激活】 -->
   <t:dgCol title="预览图"  field="templatePic"   image="true"  imageSize="40,40" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="风格描述"  field="templateComment"   query="true" queryMode="single"  width="120"></t:dgCol>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
   <t:dgDelOpt title="删除" url="cgformTemplateController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <t:dgToolBar title="录入" icon="icon-add" url="cgformTemplateController.do?goAdd" funname="add" width="900" height="500"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="cgformTemplateController.do?goUpdate" funname="update" width="900" height="500"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="cgformTemplateController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="cgformTemplateController.do?goUpdate" funname="detail"  width="900" height="500"></t:dgToolBar>
   <%-- 
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
    --%>
   <t:dgToolBar title="模板下载" icon="icon-putout"   funname="downloadTemplate"></t:dgToolBar>
  
  </t:datagrid>
  </div>
 </div>
 <script type="text/javascript">
 $(document).ready(function(){
 		//给时间控件加上样式
 			$("#cgformTemplateListtb").find("input[name='createDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 			$("#cgformTemplateListtb").find("input[name='updateDate']").attr("class","Wdate").click(function(){WdatePicker({dateFmt:'yyyy-MM-dd'});});
 });
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', 'cgformTemplateController.do?upload', "cgformTemplateList");
}

//导出
function ExportXls() {
	JeecgExcelExport("cgformTemplateController.do?exportXls","cgformTemplateList");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("cgformTemplateController.do?exportXlsByT","cgformTemplateList");
}
 //下载模板
function downloadTemplate(){
 var rowsData = $('#cgformTemplateList').datagrid('getSelections');
 if (!rowsData || rowsData.length==0) {
  tip('请选择要下载的条目');
  return;
 }
 if (rowsData.length>1) {
  tip('请选择一条记录');
  return;
 }
 $.ajax({
  url:"${pageContext.request.contextPath}/cgformTemplateController.do?checkTemplate&id="+rowsData[0].id,
  dataType:"json",
  success:function(data){
   if(!data){
    tip("模板不存在！");
    return ;
   }else{
    var url="${pageContext.request.contextPath}/cgformTemplateController.do?downloadTemplate";
    window.location.href = url+ encodeURI("&id="+rowsData[0].id);
   }
  }
 });
}
 //重写方法
 function saveObj(){
  iframe.uploadZip();
 }
 </script>