<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools"></t:base>
<script type=text/javascript src="plug-in/clipboard/ZeroClipboard.js"></script>
<script>
	function popDataContent(id){
    	$.dialog({
			content: "url:systemController.do?popDataContent&id="+id,
			drag :false,
			lock : true,
			title:'复制数据',
			opacity : 0.3,
			width:400,
			drag:false,
			min:false,
			max:false
		}).zindex();
	}
	var dataDiffWindow ;
	function dataDiff(){
		var rowsData = $('#datalogList').datagrid('getSelections');
		if (rowsData.length!=2) {
			tip('<t:mutiLang langKey="common.please.select.two.item"/>');
			return;
		}
		var tableName = rowsData[0].tableName;
		var dataId = rowsData[0].dataId;
		var versionNumber1 = rowsData[0].versionNumber;
		var versionNumber2 = rowsData[1].versionNumber;
		var id1 = rowsData[0].id;
		var id2 = rowsData[1].id;
		dataDiffWindow = $.dialog({
			content: "url:systemController.do?dataDiff&tableName="+tableName+"&dataId="+dataId+"&versionNumber1="+versionNumber1+"&versionNumber2="+versionNumber2+"&id1="+id1+"&id2="+id2,
			drag :false,
			lock : true,
			title:'数据比较',
			opacity : 0.3,
			width:600,
			drag:false,
			min:false,
			max:false
		}).zindex();
    }

	function diffDataVersion(url){
		dataDiffWindow.close();
		dataDiffWindow = undefined;

		openwindow("数据比较",url,"diffDataVersion",600,500);
	}
</script>
<div class="easyui-layout" fit="true">
	<div region="center" style="padding:0px;border:0px">
		<t:datagrid name="datalogList" checkbox="true" fitColumns="false" title="数据日志" actionUrl="systemController.do?datagridDataLog" idField="id" fit="true" queryMode="group">
			<t:dgCol title="主键" field="id" hidden="true" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="创建人名称" field="createName" hidden="false" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="创建人登录名称" field="createBy" hidden="false" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="创建日期" field="createDate" formatter="yyyy-MM-dd" hidden="true" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="更新人名称" field="updateName" hidden="true" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="更新人登录名称" field="updateBy" hidden="true" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="更新日期" field="updateDate" formatter="yyyy-MM-dd" hidden="true" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="所属部门" field="sysOrgCode" hidden="ture" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="所属公司" field="sysCompanyCode" hidden="false" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="表名" field="tableName" colspan="2" query="true" queryMode="single" width="100"></t:dgCol>
			<t:dgCol title="数据ID" field="dataId" queryMode="single" query="true" width="230"></t:dgCol>
			<t:dgCol title="版本号" field="versionNumber" queryMode="single" width="45"></t:dgCol>
			<t:dgCol title="数据内容" field="dataContent" queryMode="single" width="400"></t:dgCol>
			<t:dgCol title="操作" field="opt" width="80"></t:dgCol>
			<t:dgFunOpt funname="popDataContent(id)" title="复制数据" ></t:dgFunOpt>
			<t:dgToolBar title="数据比较" funname="dataDiff" icon="icon-search"></t:dgToolBar>
		</t:datagrid>
	</div>
 </div>
