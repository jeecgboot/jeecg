<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px"><t:datagrid name="cgformFtlList" title="表单模板列表" actionUrl="cgformFtlController.do?datagrid&cgformId=${formid}" idField="id" fit="true">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="表单ID" field="cgformId" hidden="true"></t:dgCol>
	<t:dgCol title="模板编号" field="ftlVersion"></t:dgCol>
	<t:dgCol title="模板名称" field="cgformName"></t:dgCol>
	<t:dgCol title="激活状态" field="ftlStatus" replace="未激活_0,已激活_1"></t:dgCol>
	<t:dgCol title="word路径" field="ftlWordUrl"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
	<t:dgDelOpt title="删除" exp="ftlStatus#eq#0" url="cgformFtlController.do?del&id={id}&formId=${formid}" />
	<t:dgConfOpt title="激活" url="cgformFtlController.do?active&id={id}&formId=${formid}" message="确认激活模板" exp="ftlStatus#eq#0"/>
	<t:dgConfOpt title="取消激活" url="cgformFtlController.do?cancleActive&id={id}&formId=${formid}" message="确认取消激活" exp="ftlStatus#eq#1"/>
	<t:dgFunOpt funname="preview(id,cgformName)" title="模板预览"></t:dgFunOpt>
	<t:dgToolBar title="创建模板" icon="icon-add" funname="add" width="100%" url="cgformFtlController.do?addorupdate&cgformId=${formid}" height="100%"></t:dgToolBar>
	<%-- 
	<t:dgToolBar title="自定义布局模板" icon="icon-add" funname="add" url="cgformFtlController.do?addorupdate&editorType=02&cgformId=${formid}" width="100%" height="100%"></t:dgToolBar>
	--%>
	<t:dgToolBar title="模板编辑" icon="icon-edit" funname="update" url="cgformFtlController.do?addorupdate&cgformId=${formid}" width="100%" height="100%"></t:dgToolBar>
	<t:dgToolBar title="上传Word模板" icon="icon-add" funname="add" url="cgformFtlController.do?addorupdate&editorType=03&cgformId=${formid}"></t:dgToolBar>
</t:datagrid></div>
</div><script type="text/javascript">
  	function preview(id,cgformName){
  		$.dialog({
			content: "url:cgformFtlController.do?formEkeditor&editorType=preview&id="+id,
			lock : true,
			title:"模板预览 ["+cgformName+"]",
			opacity : 0.3,
			width:900,
			height:500,
			cache:false,
		    ok: function(){
		    	iframe = this.iframe.contentWindow;
		    	iframe.goForm();
				return false;
		    },
		    cancelVal: '关闭',
		    cancel: true /*为true等价于function(){}*/
		});
	}
function updateOneTab(title,url, id,width,height) {
		gridname=id;
	var rowsData = $('#'+id).datagrid('getSelections');
	if (!rowsData || rowsData.length==0) {
		tip('Please select edit item');
		return;
	}
	if (rowsData.length>1) {
		tip('Please one item to edit');
		return;
	}
	
	url += '&id='+rowsData[0].id;
	addOneTab(title, url);
}

</script>
