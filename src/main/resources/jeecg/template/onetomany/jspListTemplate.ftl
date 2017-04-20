<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
  <div region="center" style="padding:0px;border:0px">
  <t:datagrid name="${entityName?uncap_first}List" fitColumns="true" title="${ftl_description}" actionUrl="${entityName?uncap_first}Controller.do?datagrid" idField="id" fit="true">
   <t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
  <#list columns as po>
   <t:dgCol title="${po.filedComment}" field="${po.fieldName}" <#if po.fieldType?index_of("time")!=-1>formatter="yyyy-MM-dd hh:mm:ss"<#else><#if po.fieldType?index_of("date")!=-1>formatter="yyyy-MM-dd"</#if></#if>></t:dgCol>
  </#list>
   <t:dgCol title="操作" field="opt" width="100"></t:dgCol>
     <#--//update-begin--Author:zhangjiaqiang  Date:20160925 for：TASK #1344 [链接图标] online功能测试的按钮链接图标修改 -->
   <t:dgDelOpt title="删除" url="${entityName?uncap_first}Controller.do?del&id={id}" urlclass="ace_button" urlfont="fa-trash-o"/>
   <#--//update-end--Author:zhangjiaqiang  Date:20160925 for：TASK #1344 [链接图标] online功能测试的按钮链接图标修改 -->
 	  <t:dgToolBar title="录入" icon="icon-add" url="${entityName?uncap_first}Controller.do?addorupdate" funname="add" width="100%" height="100%"></t:dgToolBar>
   <t:dgToolBar title="编辑" icon="icon-edit" url="${entityName?uncap_first}Controller.do?addorupdate" funname="update" width="100%" height="100%"></t:dgToolBar>
  </t:datagrid>
  </div>
 </div>