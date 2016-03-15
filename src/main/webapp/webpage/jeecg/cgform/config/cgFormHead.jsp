<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.jeecgframework.web.cgform.common.CgAutoListConstant"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<%
String lang = (String)request.getSession().getAttribute("lang");
String langurl = basePath + "/plug-in/mutiLang/" + lang +".js";
%>
<html>
<head>
<title><t:mutiLang langKey="smark.form.form.maintain"/></title>
<script src=<%=langurl%> type="text/javascript"></script>
<t:base type="jquery,easyui,jqueryui-sortable,tools"></t:base>
<script type="text/javascript" src="plug-in/cgform/js/cgformField.js"></script>


<style type="text/css">
.table-list {
	margin: 0;
	width: auto;
	margin-left: 0px;
	margin-right: 0px;
	overflow: hidden;
}

.table-list td,.table-list th {
	text-align: center;
}

.t_table {
	overflow: auto; /*让内容表格外面的div自动有滚动条*/
	margin-left: 0px;
	margin-right: 0px;
	width: auto;
}

#tab_div_database tr {
	border-bottom: 1px solid #e6e6e6;
	cursor: n-resize;
}
/*update-end--Author:liuht  Date:20131207 for[333]：OL模块，增加一个特效 调整字段顺序（上下挪动）*/
</style>
</head>
<body style="overflow-y: hidden; overflow-x: hidden;" scroll="no">
<!-- 增加beforeSubmit页面逻辑删除-->
<t:formvalid formid="formobj" dialog="true" usePlugin="password" beforeSubmit="deleteUnUsedFiled();" layout="table" tiptype="1" action="cgFormHeadController.do?save">
	<!-- tiptype="1" -->
	<input id="id" name="id" type="hidden" value="${cgFormHeadPage.id}">
	<input id="langurl" name="langurl" type="hidden" value="<%=langurl%>">
	<table cellpadding="0" cellspacing="1" class="formtable">
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="table.name"/>: </label></td>
			<td class="value">
			  <input class="inputxt" id="tableName" name="tableName" value="${cgFormHeadPage.tableName}"
				prefixName="" <c:if test="${not empty cgFormHeadPage.tableName}">readonly="readonly"</c:if> datatype="*" validType="cgform_head,table_Name,id" nullmsg=<t:mutiLang langKey="please.input.table.name"/>> 
				<span class="Validform_checktip"></span>
			</td>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="table.description"/>: </label></td>
			<td class="value"><input class="inputxt" id="content" name="content" value="${cgFormHeadPage.content}" datatype="s2-100"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="pk.strategies"/>:</label></td>
			<td class="value" id="jformPkTypeTd" <c:if test="${cgFormHeadPage.jformPkType ne 'SEQUENCE'}">colspan="3"</c:if>>
				<select id="jformPkType" name="jformPkType" onchange="jformPkTypeChange();">
					<option value="UUID" <c:if test="${cgFormHeadPage.jformPkType eq 'UUID'}"> selected='selected'</c:if>><t:mutiLang langKey="common.uuid36bit"/></option>
					<option value="NATIVE" <c:if test="${cgFormHeadPage.jformPkType eq 'NATIVE'}"> selected='selected'</c:if>><t:mutiLang langKey="common.native.auto.increment"/></option>
					<option value="SEQUENCE" <c:if test="${cgFormHeadPage.jformPkType eq 'SEQUENCE'}"> selected='selected'</c:if>><t:mutiLang langKey="common.sequence"/></option>
				</select>
			</td>
			<td align="right" id="jformPkSequenceN" <c:if test="${cgFormHeadPage.jformPkType ne 'SEQUENCE'}">style="display: none;"</c:if>><label class="Validform_label"> <t:mutiLang langKey="sequence.name"/>:</label></td>
			<td class="value" id="jformPkSequenceV" <c:if test="${cgFormHeadPage.jformPkType ne 'SEQUENCE'}">style="display: none;"</c:if>><input id="jformPkSequence" name="jformPkSequence" type="text"
																																				  class="inputxt" value="${cgFormHeadPage.jformPkSequence}" /> <span class="Validform_checktip"></span> <label class="Validform_label" style="display: none;"> <t:mutiLang langKey="sequence.name"/>:</label></td>
		</tr>
			<tr>
			<!--add-start--Author:luobaoli  Date:20150607 for：增加表单分类下拉列表-->
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="form.category"/>:</label></td>
			<td class="value"><select id="jformCategory" name="jformCategory">
				<c:forEach items="${typeList}" var="type">
					<option value="${type.typecode}" <c:if test="${type.typecode==cgFormHeadPage.jformCategory}">selected="selected"</c:if>>${type.typename}</option>
				</c:forEach>
			</select></td>
			<!--add-end--Author:luobaoli  Date:20150607 for：增加表单分类下拉列表-->

				<td align="right"><label class="Validform_label"> <t:mutiLang langKey="table.type"/>: </label></td>
				<td class="value"><select id="jformType" name="jformType" onchange="formTypeChange();">
					<option value="1" <c:if test="${cgFormHeadPage.jformType eq '1'}"> selected='selected'</c:if>><t:mutiLang langKey="single.table"/></option>
					<option value="2" <c:if test="${cgFormHeadPage.jformType eq '2'}"> selected="selected"</c:if>><t:mutiLang langKey="master.table"/></option>
					<option value="3" <c:if test="${cgFormHeadPage.jformType eq '3'}"> selected="selected"</c:if>><t:mutiLang langKey="slave.table"/></option>
				</select>
					<div id="relation_type_div" style="display: none;">
						<input type="radio" name="relationType"
							   <c:if test="${cgFormHeadPage.relationType eq '0' || cgFormHeadPage.relationType ==null }">
								   checked="checked"
							   </c:if> value="0">
							<t:mutiLang langKey="common.one.to.many"/>
						</input>
						<input type="radio" name="relationType"
							<c:if test="${cgFormHeadPage.relationType eq '1' }">
								checked="checked"
							</c:if> value="1">
							<t:mutiLang langKey="comon.one.to.one"/>
						</input> &nbsp;
						<t:mutiLang langKey="sequence.name"/>:<input class="inputxt" style="width: 30px" id="tabOrder" name="tabOrder" value="${cgFormHeadPage.tabOrder}" datatype="n" ignore="ignore"></div>
				</td>
		</tr>
		<tr>
			<!--add-start--Author:张忠亮  Date:20150618 for：增加表单模板选择-->
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="form.template.style_pc" />:</label></td>
			<td class="value"><select id="formTemplate" name="formTemplate" temVal="${cgFormHeadPage.formTemplate}"></select></td>
			<!--add-end--Author:张忠亮  Date:20150618 for：增加表单模板选择-->
			
			<!--add-start--Author:scott Date:20160301 for：online表单移动样式单独配置-->
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="form.template.style_mobile" />:</label></td>
			<td class="value"><select id="formTemplateMobile" name="formTemplateMobile" temVal="${cgFormHeadPage.formTemplateMobile}"></select></td>
			<!--add-start--Author:scott  Date:20160301 for：online表单移动样式单独配置-->
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="show.checkbox"/>: </label></td>
			<td class="value"><select id="isCheckbox" name="isCheckbox">
				<option value="N" <c:if test="${cgFormHeadPage.isCheckbox eq 'N'}"> selected="selected"</c:if>><t:mutiLang langKey="common.no"/></option>
				<option value="Y" <c:if test="${cgFormHeadPage.isCheckbox eq 'Y'}"> selected="selected"</c:if>><t:mutiLang langKey="common.yes"/></option>
			</select></td>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="is.page"/>:</label></td>
			<td class="value"><select id="isPagination" name="isPagination">
				<option value="Y" <c:if test="${cgFormHeadPage.isPagination eq 'Y'}"> selected='selected'</c:if>><t:mutiLang langKey="common.yes"/></option>
				<option value="N" <c:if test="${cgFormHeadPage.isPagination eq 'N'}"> selected="selected"</c:if>><t:mutiLang langKey="common.no"/></option>
			</select></td>
		</tr>
		<tr>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="is.tree"/>: </label></td>
			<td class="value"><select id="isTree" name="isTree">
				<option value="N" <c:if test="${cgFormHeadPage.isTree eq 'N'}"> selected='selected'</c:if>><t:mutiLang langKey="common.no"/></option>
				<option value="Y" <c:if test="${cgFormHeadPage.isTree eq 'Y'}"> selected='selected'</c:if>><t:mutiLang langKey="common.yes"/></option>
			</select></td>
			<td align="right"><label class="Validform_label"> <t:mutiLang langKey="common.query.module"/>: </label></td>
			<td class="value"><select id="querymode" name="querymode">
				<option value="single" <c:if test="${cgFormHeadPage.querymode eq 'single'}"> selected="selected"</c:if>><t:mutiLang langKey="single.query"/></option>
				<option value="group" <c:if test="${cgFormHeadPage.querymode eq 'group'}"> selected="selected"</c:if>><t:mutiLang langKey="combine.query"/></option>
			</select></td>
		</tr>
		<c:if test="${cgFormHeadPage.jformType eq '2'}">
			<tr id="fb_tb">
				<td align="right"><label class="Validform_label"><t:mutiLang langKey="slave.table"/></label></td>
				<td class="value" colspan="3"><input class="inputxt" style="width: 440px" disabled="disabled" value="${cgFormHeadPage.subTableStr}"></td>
			</tr>
		</c:if>
		<tr class="tree">
			<td align="right"><label class="Validform_label"> 树形表单父id: </label></td>
			<td class="value"><input class="inputxt" id="treeParentIdFieldName" name="treeParentIdFieldName" value="${cgFormHeadPage.treeParentIdFieldName}" datatype="s2-100"> <span class="Validform_checktip"></span></td>
			<td align="right"><label class="Validform_label"> 树开表单列: </label></td>
			<td class="value"><input class="inputxt" id="treeFieldname" name="treeFieldname" value="${cgFormHeadPage.treeFieldname}" datatype="s2-100"> <span class="Validform_checktip"></span></td>
		</tr>
		<tr style="display:none;">
			<td align="right"><label class="Validform_label"> idField: </label></td>
			<td class="value"><input class="inputxt" id="treeIdFieldname" name="treeIdFieldname" value="id" datatype="s2-100"> <span class="Validform_checktip"></span></td>
		
		</tr>
	</table>
  <div id="tabs" class="easyui-tabs" tabPosition="top" fit="false" style="margin: 0px; padding: 0px; overflow: hidden; width: auto;">
    <div title= '<t:mutiLang langKey="database.property"/>' width="auto" style="width: auto; margin: 0px; padding: 0px; overflow: hidden;">
      <div style="height: 25px;" class="datagrid-toolbar"><a id="addColumnBtn" class="easyui-linkbutton" data-options="iconCls:'icon-add'" onclick="addColumnBtnClick();" href="#"><t:mutiLang langKey="common.add.to"/></a> <a
		id="delColumnBtn" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="delColumnBtnClick();" href="#"><t:mutiLang langKey="common.delete"/></a></div>
      <table id="tab_div_database_title" class="table-list" style="height: 25px;">
      </table>
      <div class="t_table" id="t_table_database">
        <table id="tab_div_database" class="table-list">
        </table>
        <br><br><br>
      </div>
    </div>
    <div title='<t:mutiLang langKey="page.property"/>' style="overflow: hidden;">
      <table id="tab_div_page_title" class="table-list" style="height: 25px;">
      </table>
      <div class="t_table" id="t_table_page">
        <table id="tab_div_page" class="table-list">
        </table>
        <br><br><br>
      </div>
    </div>
    <div title='<t:mutiLang langKey="validate.dict"/>' style="overflow: hidden;">
      <table id="tab_div_check_title" class="table-list" style="height: 25px;">
      </table>
      <div class="t_table" id="t_table_check">
        <table id="tab_div_check" class="table-list">
        </table>
        <br><br><br>
      </div>
    </div>
    <div title='<t:mutiLang langKey="common.fk"/>' style="overflow: hidden;">
      <table id="tab_div_key_title" class="table-list" style="height: 25px;">
      </table>
      <div class="t_table" id="t_table_key">
        <table id="tab_div_key" class="table-list">
        </table>
        <br><br><br>
      </div>
    </div>
  </div>
</t:formvalid>
<script type="text/javascript">
$(function() {
	//显示/隐藏树形表单输入项
	isTreeHandle();
	$("#isTree").change(function() {
		isTreeHandle();
	});
	getFormTemplateName();
	<!--add-start--Author:scott Date:20160301 for：online表单移动样式单独配置-->
	getFormTemplateName2();
	<!--add-end--Author:scott Date:20160301 for：online表单移动样式单独配置-->
}); 
//根据是否为树形菜单隐藏或显示tree输入框
function isTreeHandle() {
	if($("#isTree").val() == "Y") {
		//树形表单设置默认值
		if(!$("#treeFieldname").val()) {
			$("#treeFieldname").val($(":text[name='columns[1].fieldName']").val());
		}
		$("tr.tree").find(":input").attr("disabled", false).attr("datatype", "s2-100").end().show();
	}else {
		$("tr.tree").find(":input").attr("disabled", true).removeAttr("datatype").end().hide();
	}
}
<!--add-start--Author:张忠亮  Date:20150714 for：根据表单类型获取风格-->
//获取表单风格模板名称
function getFormTemplateName(){
 var type=$("#jformType").val();
	$.ajax({
		url:"${pageContext.request.contextPath}/cgformTemplateController.do?getTemplate",
		type:"post",
		data:{type:type},
		dataType:"json",
		success:function(data){
			if(data.success){
				$("#formTemplate").empty();
				$("#formTemplate").append("<option value='' ><t:mutiLang langKey="common.please.select"/></option>");
				$.each(data.obj,function(i,tem){
					$("#formTemplate").append("<option value='"+tem.templateCode+"' >"+tem.templateName+"</option>");
				});
				var temVal=$("#formTemplate").attr("temVal");
				if(temVal.length>0){
					var len=$("#formTemplate").find("[value='"+temVal+"']").attr("selected","selected");
				}
			}
		}
	});
}

<!--add-start--Author:scott Date:20160301 for：online表单移动样式单独配置-->
//获取表单风格模板名称
function getFormTemplateName2(){
 var type=$("#jformType").val();
	$.ajax({
		url:"${pageContext.request.contextPath}/cgformTemplateController.do?getTemplate",
		type:"post",
		data:{type:type},
		dataType:"json",
		success:function(data){
			if(data.success){
				$("#formTemplateMobile").empty();
				$("#formTemplateMobile").append("<option value='' ><t:mutiLang langKey="common.please.select"/></option>");
				$.each(data.obj,function(i,tem){
					$("#formTemplateMobile").append("<option value='"+tem.templateCode+"' >"+tem.templateName+"</option>");
				});
				var temVal=$("#formTemplateMobile").attr("temVal");
				if(temVal.length>0){
					var len=$("#formTemplateMobile").find("[value='"+temVal+"']").attr("selected","selected");
				}
			}
		}
	});
}
<!--add-end--Author:scott Date:20160301 for：online表单移动样式单独配置-->

//表单类型改变 调用
	function formTypeChange(){
		jformTypeChange();
		getFormTemplateName();
		<!--add-start--Author:scott Date:20160301 for：online表单移动样式单独配置-->
		getFormTemplateName2();
		<!--add-end--Author:scott Date:20160301 for：online表单移动样式单独配置-->
	}
<!--add-end--Author:张忠亮  Date:20150714 for：根据表单类型获取风格-->
</script>
<iframe id="iframe_check" name="iframe_check" src="plug-in/cgform/fields/cgformOfCheck.html" style="display: none"></iframe>
<iframe id="iframe_database" src="plug-in/cgform/fields/cgformOfDatabase.html" style="display: none"></iframe>
<iframe id="iframe_key" src="plug-in/cgform/fields/cgformOfForeignKey.html" style="display: none"></iframe>
<iframe id="iframe_page" src="plug-in/cgform/fields/cgformOfPage.html" style="display: none"></iframe>
</body>
