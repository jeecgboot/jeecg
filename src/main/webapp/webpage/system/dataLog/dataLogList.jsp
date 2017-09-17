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

		openwindow("数据比较",url,"diffDataVersion",900,600);
	}
</script>
<div class="easyui-layout" fit="true">
	<div region="center" style="padding:0px;border:0px">
		<t:datagrid name="datalogList" checkbox="true" fitColumns="true" title="数据日志" actionUrl="systemController.do?datagridDataLog" idField="id" fit="true" queryMode="group">
			<t:dgCol title="主键" field="id" hidden="true" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="表名" field="tableName" colspan="2" query="true" queryMode="single" width="100" extend="{style:{width:'150px'}}"></t:dgCol>
			<t:dgCol title="数据ID" field="dataId" queryMode="single" query="true" width="230" extend="{style:{width:'300px'}}"></t:dgCol>
			<t:dgCol title="版本号" field="versionNumber" queryMode="single" width="45"></t:dgCol>
			<t:dgCol title="数据内容" field="dataContent" queryMode="single" width="400"></t:dgCol>
			<t:dgCol title="创建人" field="createName" hidden="true" queryMode="single" width="100"></t:dgCol>
			<t:dgCol title="创建人" field="createBy" hidden="false" queryMode="single" width="100"></t:dgCol>
			<t:dgCol title="创建日期" field="createDate" formatter="yyyy-MM-dd" hidden="true" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="更新人名称" field="updateName" hidden="true" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="更新人登录名称" field="updateBy" hidden="true" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="更新日期" field="updateDate" formatter="yyyy-MM-dd" hidden="true" queryMode="single" width="120"></t:dgCol>
			<!-- update-begin--Author:zhuxm  Date:20170313 for：[1772]部门、公司编码修改成显示名称 -->
			<t:dgCol title="所属部门" dictionary="t_s_depart,org_code,departname" field="sysOrgCode" hidden="ture" queryMode="single" width="120"></t:dgCol>
			<t:dgCol title="所属公司" dictionary="t_s_depart,org_code,departname" field="sysCompanyCode" hidden="false" queryMode="single" width="120"></t:dgCol>
			<!-- update-end--Author:zhuxm  Date:20170313 for：[1772]部门、公司编码显示修改成名称 -->
			<t:dgCol title="操作" field="opt" width="150"></t:dgCol>
			<!-- update-begin--Author:zhangjq  Date:20160904 for：[1342]【系统图标统一调整】讲{消息中间件}{系统监控}的链接按钮，改成ace风格的-->
			<t:dgFunOpt funname="popDataContent(id)" title="复制数据" urlclass="ace_button"  urlfont="fa-copy"></t:dgFunOpt>
			<!-- update-end--Author:zhangjq  Date:20160904 for：[1342]【系统图标统一调整】讲{消息中间件}{系统监控}的链接按钮，改成ace风格的-->
			<t:dgToolBar title="数据比较" funname="dataDiff" icon="icon-search"></t:dgToolBar>
		</t:datagrid>
	</div>
 </div>
