<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<t:base type="jquery,easyui,tools,DatePicker"></t:base>
<div class="easyui-layout" fit="true">
<div region="center" style="padding:0px;border:0px"><t:datagrid name="cgformFtlList" title="表单模板列表" actionUrl="cgformFtlController.do?datagrid&cgformId=${formid}" idField="id" fit="true">
	<t:dgCol title="编号" field="id" hidden="true"></t:dgCol>
	<t:dgCol title="表单ID" field="cgformId" hidden="true"></t:dgCol>
	<t:dgCol title="模板名称" field="cgformName"></t:dgCol>
	<t:dgCol title="版本号" field="ftlVersion"></t:dgCol>
	<t:dgCol title="激活状态" field="ftlStatus" replace="未激活_0,已激活_1"></t:dgCol>
	<t:dgCol title="word路径" field="ftlWordUrl"></t:dgCol>
	<t:dgCol title="操作" field="opt" width="100"></t:dgCol>
	<t:dgDelOpt title="删除" url="cgformFtlController.do?del&id={id}&formId=${formid}" urlclass="ace_button"  urlfont="fa-trash-o" exp="ftlStatus#eq#0" />
	<t:dgConfOpt title="激活" url="cgformFtlController.do?active&id={id}&formId=${formid}" urlclass="ace_button"  urlfont="fa-toggle-on" exp="ftlStatus#eq#0" message="确认激活模板"/>
	<t:dgConfOpt title="取消激活" url="cgformFtlController.do?cancleActive&id={id}&formId=${formid}"  urlclass="ace_button"  urlfont="fa-toggle-off"  exp="ftlStatus#eq#1" message="确认取消激活"/>
	<t:dgFunOpt funname="ftleditor(id,cgformName)" title="模板编辑" urlclass="ace_button"  urlfont="fa-edit"></t:dgFunOpt>
	<t:dgToolBar title="Word模板上传" icon="icon-add" url="cgformFtlController.do?addorupdate&cgformId=${formid}" funname="add"></t:dgToolBar>
</t:datagrid></div>
</div>

<script type="text/javascript">
  	function ftleditor(id,cgformName){
  		$.dialog({
			content: "url:cgformFtlController.do?formEkeditor&id="+id,
			lock : true,
			title:"模板编辑 ["+cgformName+"]",
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

</script>
