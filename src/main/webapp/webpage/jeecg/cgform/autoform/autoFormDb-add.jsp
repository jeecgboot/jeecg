<%@ page language="java" import="java.util.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<!DOCTYPE html>
<html>
 <head>
  <title>表单数据源</title>
  <t:base type="jquery,easyui,tools,DatePicker"></t:base>
  <script type="text/javascript" src="plug-in/ckfinder/ckfinder.js"></script>
  <script type="text/javascript">
  $(document).ready(function(){
	$('#tt').tabs({
	   onSelect:function(title){
	       $('#tt .panel-body').css('width','auto');
		}
	});
	$(".tabs-wrap").css('width','100%');
  });
  
  $(function(){
	 $("#autoFormDbField").load("autoFormDbController.do?autoFormDbFieldList&id=${autoFormDbPage.id}"); 
	 $("#autoFormParam").load("autoFormDbController.do?autoFormParamList&id=${autoFormDbPage.id}"); 
	 $("#autoFormDbFieldForTable").load("autoFormDbController.do?autoFormDbFieldForTableList&id=${autoFormDbPage.id}"); 
  });
  
  $(function(){
	  hideDataSourceAndDataTable();
	  $("input[name='dbType']").change(function(){
		 $(".formdbdiv").hide();
		 $("#"+$(this).val()+"_div").show();
		  hideDataSourceAndDataTable();
	  });
  });
  <!--update-begin--Author:zzl  Date:20151113 for：数据源类型是数据库表时,隐藏填报数据源和填报数据库表 -->
  function hideDataSourceAndDataTable(){
	  var checkedVal=$("input[name='dbType']:checked").val();
	  if(checkedVal=='table'){
		   $("#dataSourceTr").hide();
	  }else{
		  $("#dataSourceTr").show();
	  }
  }
  <!--update-end--Author:zzl  Date:20151113 for：数据源类型是数据库表时,隐藏填报数据源和填报数据库表 -->
  <!--update-begin--Author:zzl  Date:20151113 for：填报数据源和填报数据库表隐藏时，表单提交需赋值 -->
  function setDataSourceVal(){
	  var checkedVal=$("input[name='dbType']:checked").val();
	  if(checkedVal=='table'){
		  $("#tbDbKey").val($("#dbKey").find("option:selected").val());
		  $("#tbDbTableName").val($("#dbTableName").find("option:selected").val());
	  }
  }
  <!--update-end--Author:zzl  Date:20151113 for：填报数据源和填报数据库表隐藏时，表单提交需赋值 -->

  /*每次只能提交一种数据类型的数据，不能同时提交
  function onlySubmit(){
	  var notCurrentDbTypes = $("input[name='dbType']").not(":checked").val();
	  $.each(notCurrentDbTypes,function(index,e){
		  $("#"+e+"_div").remove();
	  });
  }
  */

 </script>
 </head>
 <body style="overflow-x: hidden;">
	  <t:formvalid formid="formobj" dialog="true"  usePlugin="password" layout="table" tiptype="3"  action="autoFormDbController.do?doAdd"    >
						<input id="id" name="id" type="hidden" value="${autoFormDbPage.id }">
						<input id="createName" name="createName" type="hidden" value="${autoFormDbPage.createName }">
						<input id="createBy" name="createBy" type="hidden" value="${autoFormDbPage.createBy }">
						<input id="updateName" name="updateName" type="hidden" value="${autoFormDbPage.updateName }">
						<input id="updateBy" name="updateBy" type="hidden" value="${autoFormDbPage.updateBy }">
						<input id="sysOrgCode" name="sysOrgCode" type="hidden" value="${autoFormDbPage.sysOrgCode }">
						<input id="sysCompanyCode" name="sysCompanyCode" type="hidden" value="${autoFormDbPage.sysCompanyCode }">
						<input id="createDate" name="createDate" type="hidden" value="${autoFormDbPage.createDate }">
						<input id="updateDate" name="updateDate" type="hidden" value="${autoFormDbPage.updateDate }">
						<input id="autoFormId" name="autoFormId" type="hidden" value="${autoFormDbPage.autoFormId }">
						
		<table cellpadding="0" cellspacing="1" class="formtable">
			<tr>
				<td align="center" width="100px">
					<label class="Validform_label"><t:mutiLang langKey="form.db.name"/>:</label>
				</td>
				<td class="value" >
					 <!--update-begin--Author:luobaoli  Date:20150626 for：增加数据源名称的非空校验 -->
					 <!--update-begin--Author:jg_renjie  Date:20150720 for：增加数据源名称的唯一性校验 -->
			     	 <input id="dbName" name="dbName" type="text" style="width: 150px"   ajaxurl="autoFormDbController.do?checkDbName"  class="inputxt" errorMsg="不能为中文" nullmsg="<t:mutiLang langKey="form.db.name"/>不能为空!"  datatype="/^[A-Za-z\d-._]+$/"  >
			     	 <!--update-end--Author:jg_renjie  Date:20150720 for：增加数据源名称的唯一性校验 -->
			     	 <!--update-end--Author:luobaoli  Date:20150626 for：增加数据源名称的非空校验 -->	
					<span class="Validform_checktip"></span>
				</td>
				<!--update-begin--Author:zzl  Date:20151028 for：增加数据源名称 -->
				<td align="center" width="100px">
					<label class="Validform_label"><t:mutiLang langKey="form.db.chname"/>:</label>
				</td>
				<td class="value"  colspan="2" >
					<input id="dbChName" name="dbChName" type="text" style="width: 150px" class="inputxt" datatype="*" nullmsg="<t:mutiLang langKey="form.db.chname"/>不能为空!"  >
					<span class="Validform_checktip"></span>
				</td>
				<!--update-end--Author:zzl  Date:20151028 for：增加数据源名称 -->
			</tr>
			<!-- 
			<tr>
				<td align="right">
					<label class="Validform_label"><t:mutiLang langKey="form.db.tablename"/>:</label>
				</td>
				<td class="value">
			     	 <input id="dbTableName" name="dbTableName" type="text" style="width: 150px" class="inputxt">
					<span class="Validform_checktip"></span>
				</td>
				<td align="right">
					<label class="Validform_label"><t:mutiLang langKey="form.auto.formid"/>:</label>
				</td>
				<td class="value">
			     	 <input id="autoFormId" name="autoFormId" type="text" style="width: 150px" class="inputxt">
					<span class="Validform_checktip"></span>
				</td>
			</tr>
			 -->
			<tr>
				<td align="center" width="100px">
					<label class="Validform_label"><t:mutiLang langKey="form.db.type"/>:</label>
				</td>
				<td class="value" colspan="4">
						<t:dictSelect field="dbType" type="radio"
							typeGroupCode="formDbType"  hasLabel="false"  title="form.db.type" defaultVal="sql"></t:dictSelect>     
					<span class="Validform_checktip"></span>
				</td>
			</tr>
			<!--update-begin--Author: jg_huangxg  Date:20150723 for：增加填报数据源和填报数据库表显示 -->
			<tr id="dataSourceTr">
				<td align="center">
					<label class="Validform_label"><t:mutiLang langKey="form.tb.db.key"/>:</label>
				</td>
				<td class="value">
					<select id="tbDbKey" name="tbDbKey">
						<option value="" selected="selected">--平台数据源--</option>
						<c:forEach items="${dynamicDataSourceEntitys}" var="dynamicDataSourceEntity">
							<option value="${dynamicDataSourceEntity.dbKey}">${dynamicDataSourceEntity.dbKey}</option>
						</c:forEach>
					</select>
					<span class="Validform_checktip"></span>
				</td>
				<td align="center">
					<label class="Validform_label"><t:mutiLang langKey="form.tb.db.table.name"/>:</label>
				</td>
				<td class="value">
			     	 <select id="tbDbTableName" name="tbDbTableName">
			     	 	<option value="">--请选择--</option>
			     	 	<c:forEach items="${tableNames}" var="tableName">
			     	 		<option value="${tableName}">${tableName}</option>
			     	 	</c:forEach>
			     	 </select>
			     	 <span class="Validform_checktip"></span>
				</td>
				<td class="value">
				</td>
			</tr>
			<!--update-end--Author: jg_huangxg  Date:20150723 for：增加填报数据源和填报数据库表显示 -->
		</table>
		<!--add-begin--Author:luobaoli  Date:20150621 for：新增数据源类型为“table”时的处理逻辑 -->	
		<div style="margin-top: 20px;border: 1px solid #E6E6E6;display: none" id="table_div" class="formdbdiv">
			<table cellpadding="0" cellspacing="1" class="formtable">
				<tr>
					<td align="right">
						<label class="Validform_label"><t:mutiLang langKey="common.dynamic.dbsource"/>:</label>
					</td>
					<td class="value">
						<select id="dbKey" name="dbKey">
							<!--update-begin--Author:luobaoli  Date:20150701 for：表单数据源新增时增加数据源显示逻辑 -->
							<option value="">平台数据源</option>
							<c:forEach items="${dynamicDataSourceEntitys}" var="dynamicDataSourceEntity">
								<option value="${dynamicDataSourceEntity.dbKey}">${dynamicDataSourceEntity.dbKey}</option>
							</c:forEach>
							<!--update-end--Author:luobaoli  Date:20150701 for：表单数据源新增时增加数据源显示逻辑 -->
						</select>
						<span class="Validform_checktip"></span>
					</td>
					<td align="right">
						<label class="Validform_label"><t:mutiLang langKey="form.db.tablename"/>:</label>
					</td>
					<td class="value">
				     	 <select id="dbTableName" name="dbTableName">
				     	 	<!--update-begin--Author:luobaoli  Date:20150701 for：增加初始化数据表显示 -->
				     	 	<c:forEach items="${tableNames}" var="tableName">
				     	 		<option value="${tableName}">${tableName}</option>
				     	 	</c:forEach>
				     	 	<!--update-end--Author:luobaoli  Date:20150701 for：增加初始化数据表显示 -->
				     	 </select>
				     	 <span class="Validform_checktip"></span>
					</td>
					<td class="value">
					</td>
				</tr>
				<tr>
					<td class="value" colspan="5">
						<div style="width:100%;height:100%" title="表单数据表" id="autoFormDbFieldForTable"></div>
					</td>
				</tr>
			</table>
		</div>
		<!--add-end--Author:luobaoli  Date:20150621 for：新增数据源类型为“table”时的处理逻辑 -->
		<div style="margin-top: 5px;border: 1px solid #E6E6E6" id="sql_div" class="formdbdiv">
			<table cellpadding="0" cellspacing="1" style="width: 100%">
				<tr>
					<td align="right" width="95px">
						<label class="Validform_label"><t:mutiLang langKey="form.db.synsql"/>:</label>
					</td>
					<td class="value" colspan="3" align="center">
						<span id="dbDynSqlButton"></span>
					</td>
				</tr>
				<tr>
					<td class="value" colspan="4">
						 <div style="width:100%;border: 1px solid #E6E6E6">
						 	<textarea id="dbDynSql" style="width:99%;border-style: inset;" class="inputxt" rows="10" name="dbDynSql"></textarea><p/>
						 	&nbsp;&nbsp;&nbsp;&nbsp;您可以键入“${abc}”作为一个参数，这里abc是参数的名称。例如：<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;select * from table where id = <%="${abc}"%>。<br/>
							&nbsp;&nbsp;&nbsp;&nbsp;select * from table where id = <%="'${abc}'"%>（如果id字段为字符串类型）<p/>
						 </div>
					</td>
				</tr>
				<tr>
					<td class="value" colspan="4">
						<!--update-begin--Author:luobaoli  Date:20150630 for：新增fieldset标签 -->	
						<fieldset style="border: 1px solid #E6E6E6;">
							<legend><t:mutiLang langKey="form.db.query.param"/></legend>
							<div style="width:100%;height:100%" title="form.db.query.param" id="autoFormParam"></div>
						</fieldset>
						<!--update-end--Author:luobaoli  Date:20150630 for：新增fieldset标签 -->	
					</td>
				</tr>
				<tr>
					<td class="value" colspan="4">
						<!--update-begin--Author:luobaoli  Date:20150630 for：新增fieldset标签 -->	
						<fieldset style="border: 1px solid #E6E6E6;">
							<legend><t:mutiLang langKey="form.db.query.data.column"/></legend>
							<div style="width:100%;height:100%" title="form.db.query.data.column" id="autoFormDbField"></div>
						</fieldset>
						<!--update-end--Author:luobaoli  Date:20150630 for：新增fieldset标签 -->	
					</td>
				</tr>
			</table>
		</div>
		<div style="margin-top: 5px;border: 1px solid #E6E6E6;display: none" id="clazz_div" class="formdbdiv">
			JAVA类配置
		</div>
	</t:formvalid>
	<!-- 添加 附表明细 模版 -->
	<table style="display:none">
	<tbody id="add_autoFormDbField_table_template">
		<tr>
			 <td align="center"><div style="width: 40px;" name="xh"></div></td>
		 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td>
			  <td align="left">
			<input name="autoFormDbFieldList[#index#].fieldName" maxlength="32"
				   type="text" class="inputxt"  style="width:120px;">
		</td>
			<td align="left">
				<input name="autoFormDbFieldList[#index#].fieldText" maxlength="50"
					   type="text" class="inputxt"  style="width:120px;">
			</td>
				  <td align="center">
						<div style="width: 50px;" align="center">[<a name="delAutoFormDbFieldOneBtn" href="javascript:void(0)" onclick="deleteOne(this)"><t:mutiLang langKey="common.delete"/></a>]</div>
					</td>
			</tr>
		 </tbody>
	<tbody id="add_autoFormParam_table_template">
		<tr>
			 <td align="center"><div style="width: 40px;" name="xh"></div></td>
		 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td>
			  <td align="left">
				  	<input name="autoFormParamList[#index#].paramName" maxlength="32" 
				  		type="text" class="inputxt"  style="width:120px;"
				               datatype="*"
				               >
				  <label class="Validform_label" style="display: none;"><t:mutiLang langKey="form.param.name"/></label>
			  </td>
			  <td align="left">
				  	<input name="autoFormParamList[#index#].paramDesc" maxlength="32" 
				  		type="text" class="inputxt"  style="width:120px;"
				               
				               >
				  <label class="Validform_label" style="display: none;"><t:mutiLang langKey="form.param.desc"/></label>
			  </td>
			  <td align="left">
				  	<input name="autoFormParamList[#index#].paramValue" maxlength="32" 
				  		type="text" class="inputxt"  style="width:120px;"
				               
				               >
				  <label class="Validform_label" style="display: none;"><t:mutiLang langKey="form.param.value"/></label>
			  </td>
			  <td align="left">
				  	<input name="autoFormParamList[#index#].seq" maxlength="32" 
				  		type="text" class="inputxt"  style="width:120px;"
				               
				               >
				  <label class="Validform_label" style="display: none;"><t:mutiLang langKey="common.order"/></label>
			  </td>
			  <td align="center">
					<div style="width: 50px;" align="center">[<a class="delAutoFormParamOneBtn" href="javascript:void(0)" onclick="deleteOne(this)"><t:mutiLang langKey="common.delete"/></a>]</div>
				</td>
		</tr>
	 </tbody>
	 <!--add-begin--Author:luobaoli  Date:20150621 for：新增数据源类型为“table”时的属性列表新增模块 -->	
	 <tbody id="add_autoFormDbFieldForTable_table_template">
		<tr>
			 <td align="center"><div style="width: 40px;" name="xh"></div></td>
		 <td align="center"><input style="width:20px;" type="checkbox" name="ck"/></td>
			  <td align="left">
				  	<input name="autoFormDbFieldList[#index#].fieldName" maxlength="32" 
				  		type="text" class="inputxt"  style="width:120px;">
				  </td>
			<td align="left">
				<input name="autoFormDbFieldList[#index#].fieldText" maxlength="50"
					   type="text" class="inputxt"  style="width:120px;">
			</td>
				  <td align="center">
						<div style="width: 50px;" align="center">[<a name="delAutoFormDbFieldForTableOneBtn" href="javascript:void(0)" onclick="deleteOne(this)"><t:mutiLang langKey="common.delete"/></a>]</div>
					</td>
			</tr>
		 </tbody>
	<!--add-begin--Author:luobaoli  Date:20150621 for：新增数据源类型为“table”时的属性列表新增模块 -->	
	</table>
 </body>
 <script src = "webpage/jeecg/cgform/autoform/autoFormDb.js"></script>	