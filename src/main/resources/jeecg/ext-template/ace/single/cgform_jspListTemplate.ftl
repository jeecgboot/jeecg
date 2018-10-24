<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加列表页面对于图片和文件的判断 -->
<#include "../../ui/tdgCol.ftl"/>
<#-- update--end--author:zhangjiaqiang date:20170531 for:增加列表页面对于图片和文件的判断 -->
<#assign orderByCreateDate = false />
<#list columns as po>
	<#if po.fieldName=='createDate'>
		<#assign orderByCreateDate = true />
		<#break>
	</#if>
</#list>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="${entityName?uncap_first}List"<#if cgformConfig.cgFormHead.isCheckbox == 'Y'> checkbox="true"<#else> checkbox="false"</#if><#if cgformConfig.cgFormHead.isPagination == 'Y'> pagination="true"<#else> pagination="false"</#if><#if cgformConfig.cgFormHead.isTree == 'Y'> treegrid="true" treeField="${cgformConfig.cgFormHead.treeFieldnamePage}"</#if> fitColumns="true" title="${ftl_description}" actionUrl="${entityName?uncap_first}Controller.do?datagrid" idField="id" <#if orderByCreateDate == true >sortName="createDate"<#else>sortName="id"</#if> fit="true" queryMode="group">
 <#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的列表判断 -->
  <@dgcol columns=columns/>
  <#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的列表判断 -->
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
  <#--//update-begin--Author:zhangjiaqiang  Date:20160925 for：TASK #1344 [链接图标] online功能测试的按钮链接图标修改 -->
   <t:dgDelOpt title="删除" url="${entityName?uncap_first}Controller.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
   <#list buttons as btn>
   <#if btn.buttonStyle =='link' && btn.buttonStatus == '1'>
   <t:dgFunOpt funname="do${btn.buttonCode?cap_first}(id)" title="${btn.buttonName}" urlclass="ace_button"<#rt/>
<#if  btn.buttonName?index_of("下载") gt -1>
 urlfont="fa-download"<#rt/>
<#else>
 urlfont="fa-wrench"<#rt/>
</#if>
 />
  	</#if>
   </#list> 
   <#--//update-end--Author:zhangjiaqiang  Date:20160925 for：TASK #1344 [链接图标] online功能测试的按钮链接图标修改 -->
   <t:dgToolBar title="录入" icon="icon-add" url="${entityName?uncap_first}Controller.do?goAdd" funname="add"></t:dgToolBar>
   <#--//update-begin--Author:gj_shaojc  Date:20180402 for：TASK #2606 【代码生成器】树形列表生成，多选处理 -->
   <#if cgformConfig.cgFormHead.isTree == 'Y'>
   <t:dgToolBar title="编辑" icon="icon-edit" url="${entityName?uncap_first}Controller.do?goUpdate" funname="updatetree" width="100%" height="100%"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="${entityName?uncap_first}Controller.do?doBatchDel" funname="deleteALLSelecttree"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="${entityName?uncap_first}Controller.do?goUpdate" funname="detailtree" width="100%" height="100%"></t:dgToolBar>
   <#else>
	<t:dgToolBar title="编辑" icon="icon-edit" url="${entityName?uncap_first}Controller.do?goUpdate" funname="update"></t:dgToolBar>
   <t:dgToolBar title="批量删除"  icon="icon-remove" url="${entityName?uncap_first}Controller.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
   <t:dgToolBar title="查看" icon="icon-search" url="${entityName?uncap_first}Controller.do?goUpdate" funname="detail"></t:dgToolBar>
   </#if>
   <#--//update-end--Author:gj_shaojc  Date:20180402 for：TASK #2606 【代码生成器】树形列表生成，多选处理 -->
   <t:dgToolBar title="导入" icon="icon-put" funname="ImportXls"></t:dgToolBar>
   <t:dgToolBar title="导出" icon="icon-putout" funname="ExportXls"></t:dgToolBar>
   <t:dgToolBar title="模板下载" icon="icon-putout" funname="ExportXlsByT"></t:dgToolBar>
   <#list buttons as btn>
    <#if btn.buttonStyle =='button' && btn.buttonStatus == '1'>
    <#if btn.optType == 'action'>
     	<t:dgToolBar title="${btn.buttonName}" icon="${btn.buttonIcon}" <#if btn.optType=='action'> url="${entityName?uncap_first}Controller.do?do${btn.buttonCode?cap_first}" funname="do${btn.buttonCode?cap_first}"<#else> funname="${btn.buttonCode}"</#if> ></t:dgToolBar>
	<#else>
		<t:dgToolBar title="${btn.buttonName}" icon="${btn.buttonIcon}" funname="do${btn.buttonCode?cap_first}"></t:dgToolBar>
	</#if>
   	</#if>
   </#list> 
  </t:datagrid>
  </div>
 </div>		
 <script type="text/javascript">
 $(document).ready(function(){
		<#if cgformConfig.cgFormHead.isTree == 'Y'>
		$("#${entityName?uncap_first}List").treegrid({
 				 onExpand : function(row){
 					var children = $("#${entityName?uncap_first}List").treegrid('getChildren',row.id);
 					 if(children.length<=0){
 					 	row.leaf=true;
 					 	$("#${entityName?uncap_first}List").treegrid('refresh', row.id);
 					 }
 				}
 		});
 		</#if>
 });
 
 <#list buttons as btn>
    <#if btn.buttonStyle =='button' && btn.buttonStatus == '1'>
    <#if btn.optType == 'action'>
     	//自定义按钮-${btn.buttonName}
	 	function do${btn.buttonCode?cap_first}(title,url,gridname){
	 		var rowData = $('#'+gridname).datagrid('getSelected');
			if (!rowData) {
				tip('请选择${btn.buttonName}项目');
				return;
			}
			url = url+"&id="+rowData['id'];
	 		createdialog('确认 ', '确定'+title+'吗 ?', url,gridname);
	 	}
	<#else>
		//自定义按钮-${btn.buttonName}
	 	function do${btn.buttonCode?cap_first}(title,url,gridname){
	 		${btn.buttonCode}();
	 	}
	</#if>
   	</#if>
   </#list> 
   
   <#list buttons as btn>
   <#if btn.buttonStyle =='link' && btn.buttonStatus == '1'>
     <#if btn.optType == 'action'>
     	//自定义按钮-${btn.buttonName}
	 	function do${btn.buttonCode?cap_first}(id,index){
	 	    var url = "${entityName?uncap_first}Controller.do?do${btn.buttonCode?cap_first}";
			url = url+"&id="+id;
	 		createdialog('确认 ', '确定${btn.buttonName}吗 ?', url,'${entityName?uncap_first}List');
	 	}
	<#else>
		//自定义按钮-${btn.buttonName}
	 	function do${btn.buttonCode?cap_first}(id,index){
	 		${btn.buttonCode}(id);
	 	}
	</#if>
  	</#if>
   </#list> 
 
//导入
function ImportXls() {
	openuploadwin('Excel导入', '${entityName?uncap_first}Controller.do?upload', "${entityName?uncap_first}List");
}

//导出
function ExportXls() {
	JeecgExcelExport("${entityName?uncap_first}Controller.do?exportXls","${entityName?uncap_first}List");
}

//模板下载
function ExportXlsByT() {
	JeecgExcelExport("${entityName?uncap_first}Controller.do?exportXlsByT","${entityName?uncap_first}List");
}

<#if cgformConfig.cgFormHead.isTree == 'Y'>
/**
 * 获取表格对象
 * @return 表格对象
 */
function getDataGrid(){
	var datagrid = $('#'+gridname);
	return datagrid;
}
</#if>
 </script>
<#if (cgformConfig.listJs.cgJsStr)?? && cgformConfig.listJs.cgJsStr!="">
 <script type="text/javascript">
 //JS增强
 ${cgformConfig.listJs.cgJsStr}
 </script>
</#if>