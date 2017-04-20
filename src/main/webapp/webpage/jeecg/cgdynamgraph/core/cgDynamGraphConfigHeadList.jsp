<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px">
<t:datagrid fitColumns="false" checkbox="true" name="cgDynamGraphConfigHeadList" title="dynamic.table.head" 
            actionUrl="cgDynamGraphConfigHeadController.do?datagrid" idField="id" fit="true" queryMode="group" sortName="createDate" sortOrder="desc">
	<t:dgCol title="" field="id" hidden="true" queryMode="single" width="120" ></t:dgCol>
	<t:dgCol title="移动图表名称" field="name" query="true" queryMode="single" width="120"></t:dgCol>
	<t:dgCol title="common.code" field="code" query="true" queryMode="single" width="120"></t:dgCol>
	<t:dgCol title="query.sql" field="cgrSql" query="true" queryMode="single" width="500"></t:dgCol>
    <t:dgCol title="common.dynamic.dbsource" field="dbSource" query="true"  hidden="true" queryMode="single" width="120"></t:dgCol>
	<t:dgCol title="common.createby" field="createBy" hidden="true"></t:dgCol>
	<t:dgCol title="common.createtime" field="createDate" formatter="yyyy-MM-dd" width="120" hidden="false"></t:dgCol>
	<t:dgCol title="common.updateby" field="updateBy" hidden="true"></t:dgCol>
	<t:dgCol title="common.updatetime" field="updateDate" formatter="yyyy-MM-dd" hidden="true"></t:dgCol>
	<t:dgCol title="common.description" field="content" hidden="true" query="true" queryMode="single" width="120"></t:dgCol>
	<t:dgCol title="common.operation" field="opt" width="300"></t:dgCol>
	<t:dgDelOpt title="common.delete" url="cgDynamGraphConfigHeadController.do?doDel&id={id}" urlclass="ace_button"  urlfont="fa-trash-o"/>
	<t:dgFunOpt funname="popMenuLink(code,name)" title="配置地址" urlclass="ace_button"  urlfont="fa-cog"></t:dgFunOpt>
	<t:dgFunOpt  funname="addlisttab(code,name)" title="功能测试" urlclass="ace_button"  urlfont="fa-cog"></t:dgFunOpt>
	<t:dgToolBar title="common.add" icon="icon-add" url="cgDynamGraphConfigHeadController.do?goAdd" funname="add" height="450" width="1200"></t:dgToolBar>
	<t:dgToolBar title="common.edit" icon="icon-edit" url="cgDynamGraphConfigHeadController.do?goUpdate" funname="update" height="450" width="1200"></t:dgToolBar>
	<t:dgToolBar title="common.batch.delete" icon="icon-remove" url="cgDynamGraphConfigHeadController.do?doBatchDel" funname="deleteALLSelect"></t:dgToolBar>
	<t:dgToolBar title="common.view" icon="icon-search" url="cgDynamGraphConfigHeadController.do?goUpdate" funname="detail" height="450" width="1200"></t:dgToolBar>
</t:datagrid></div>
</div>
<script src="plug-in/clipboard/ZeroClipboard.js"></script>
<script type="text/javascript">
  /**
	*	弹出菜单链接
	*/
	function popMenuLink(tableName,content){
		$.dialog({
			content: "url:cgDynamGraphConfigHeadController.do?popmenulink&url=cgDynamGraphController.do?design&title="+tableName,
            drag :false,
            lock : true,
            title:'菜单链接['+content+']',
            opacity : 0.3,
            width:400,
            height:80,drag:false,min:false,max:false
		}).zindex();
	}
  
  
	function addlisttab(tableName,content){
		  addOneTab(content, "cgDynamGraphController.do?design&id="+tableName);
	}
	
 </script>