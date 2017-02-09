<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px">
    <t:datagrid name="iconList" title="icon.list" actionUrl="iconController.do?datagrid" fit="true" fitColumns="true" idField="id">
        <t:dgCol title="common.id" field="id" hidden="true"></t:dgCol>
        <t:dgCol title="common.icon.name" query="true" field="iconName"></t:dgCol>
        <t:dgCol title="common.icon.style" field="iconClas"></t:dgCol>
        <t:dgCol title="common.icon.type" field="iconType" replace="system.icon_1,menu.icon_2,desktop.icon_3"></t:dgCol>
        <t:dgCol title="common.icon" field="iconPath" image="true" style="width:20px; height:20px;"></t:dgCol>
        <t:dgCol title="common.icon.type" field="extend"></t:dgCol>
        <t:dgCol title="common.operation" field="opt"></t:dgCol>
        <t:dgDelOpt url="iconController.do?del&id={id}" title="common.delete" urlclass="ace_button" urlfont="fa-trash-o"></t:dgDelOpt>
        <t:dgToolBar title="common.add.param" langArg="common.icon" icon="icon-add" url="iconController.do?addorupdate" funname="add"></t:dgToolBar>
        <t:dgToolBar title="common.edit.param" langArg="common.icon" icon="icon-edit" url="iconController.do?addorupdate" funname="update"></t:dgToolBar>
        <t:dgToolBar title="batch.generate.style" icon="icon-edit" url="iconController.do?repair" funname="doSubmit"></t:dgToolBar>
        <t:dgToolBar title="UI标签链接按钮样式" icon="icon-add" url="webpage/common/functionIconStyleList.jsp?style=urlfont" funname="add"></t:dgToolBar>
    </t:datagrid>
</div>
</div>
