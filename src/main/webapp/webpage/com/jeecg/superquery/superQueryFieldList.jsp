<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>

<script type="text/javascript">
</script>
<script type="text/javascript">
	$('#addSuperQueryFieldBtn').linkbutton({   
	    iconCls: 'icon-add'  
	});  
	$('#delSuperQueryFieldBtn').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 
	$('#addSuperQueryFieldBtn').bind('click', function(){   
 		 var tr =  $("#add_superQueryField_table_template tr").clone();
 		$(tr).data("index",$("#add_superQueryField_table tr:last").data("index")+1);
	 	 $("#add_superQueryField_table").append(tr);
	 	 resetTrNum('add_superQueryField_table');
	 	 return false;
    });  
	$('#delSuperQueryFieldBtn').bind('click', function(){   
      	$("#add_superQueryField_table").find("input:checked").parent().parent().remove();   
      	$(tr).data("index",$("#add_superQueryField_table tr:last").data("index")+1);
        resetTrNum('add_superQueryField_table'); 
        return false;
    }); 
    $(document).ready(function(){
    	$(".datagrid-toolbar").parent().css("width","auto");
    	if(location.href.indexOf("load=detail")!=-1){
			$(":input").attr("disabled","true");
			$(".datagrid-toolbar").hide();
		}
    });
</script>
<div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
	<a id="addSuperQueryFieldBtn" href="#">添加</a> <a id="delSuperQueryFieldBtn" href="#">删除</a> 
</div>
<table border="0" cellpadding="2" cellspacing="0" id="superQueryField_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">序号</td>
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">操作</td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 60px;">
						序号
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 180px;">
						表名
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						字段名
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						字段文本
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						字段类型
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						控件类型
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						字典Table
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						字典Code
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						字典Text
				  </td>
	</tr>
	<tbody id="add_superQueryField_table">
	<c:if test="${fn:length(superQueryFieldList)  <= 0 }">
			<tr data-index="0">
				<td align="center"><div style="width: 25px;" name="xh">1</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck"/></td>
					<input name="superQueryFieldList[0].id" type="hidden"/>
					<input name="superQueryFieldList[0].createName" type="hidden"/>
					<input name="superQueryFieldList[0].createBy" type="hidden"/>
					<input name="superQueryFieldList[0].createDate" type="hidden"/>
					<input name="superQueryFieldList[0].updateName" type="hidden"/>
					<input name="superQueryFieldList[0].updateBy" type="hidden"/>
					<input name="superQueryFieldList[0].updateDate" type="hidden"/>
					<input name="superQueryFieldList[0].sysOrgCode" type="hidden"/>
					<input name="superQueryFieldList[0].sysCompanyCode" type="hidden"/>
					<input name="superQueryFieldList[0].mainId" type="hidden"/>
				  <td align="left">
					  	<input name="superQueryFieldList[0].seq" maxlength="32" type="text" class="inputxt" datatype="*"  style="width:60px;"    >
					  <label class="Validform_label" style="display: none;">序号</label>
					</td>
				  <td align="left">
							<%-- <t:dictSelect field="superQueryFieldList[0].tableName" type="list"   typeGroupCode=""  defaultVal="${superQueryFieldPage.tableName}" hasLabel="false"  title="表名"></t:dictSelect> --%>     
							<select  name="superQueryFieldList[0].tableName" class="fieldTableList4" datatype="*" style="width:180px" >  
							<option value="">---请选择---</option>
                            </select> 
					  <label class="Validform_label" style="display: none;">表名</label>
					</td>
				  <td align="left">
					  	<input name="superQueryFieldList[0].name" maxlength="32" type="text" class="inputxt"  style="width:120px;"   datatype="*">
					  <label class="Validform_label" style="display: none;">字段名</label>
					</td>
				  <td align="left">
					  	<input name="superQueryFieldList[0].txt" maxlength="32" type="text" class="inputxt"  style="width:120px;"   datatype="*" >
					  <label class="Validform_label" style="display: none;">字段文本</label>
					</td>
				  <td align="left">
							<t:dictSelect field="superQueryFieldList[0].ctype" type="list"   typeGroupCode="field_type"  defaultVal="${superQueryFieldPage.ctype}" hasLabel="false"  datatype="*" title="字段类型"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">字段类型</label>
					</td>
				  <td align="left">
							<t:dictSelect field="superQueryFieldList[0].stype" type="list"   typeGroupCode="s_type"  defaultVal="${superQueryFieldPage.stype}" hasLabel="false" datatype="*" title="控件类型"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">控件类型</label>
					</td>
				  <td align="left">
					  	<input name="superQueryFieldList[0].dictTable" maxlength="32" type="text" class="inputxt"  style="width:120px;"    >
					  <label class="Validform_label" style="display: none;">字典Table</label>
					</td>
				  <td align="left">
					  	<input name="superQueryFieldList[0].dictCode" maxlength="32" type="text" class="inputxt"  style="width:120px;"   >
					  <label class="Validform_label" style="display: none;">字典Code</label>
					</td>
				  <td align="left">
					  	<input name="superQueryFieldList[0].dictText" maxlength="32" type="text" class="inputxt"  style="width:120px;"    >
					  <label class="Validform_label" style="display: none;">字典Text</label>
					</td>
   			</tr>
	</c:if>
	<c:if test="${fn:length(superQueryFieldList)  > 0 }">
		<c:forEach items="${superQueryFieldList}" var="poVal" varStatus="stuts">
			<tr data-index="${stuts.index }">
				<td align="center"><div style="width: 25px;" name="xh">${stuts.index+1 }</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck" /></td>
						<input name="superQueryFieldList[${stuts.index }].id" type="hidden" value="${poVal.id }"/>
						<input name="superQueryFieldList[${stuts.index }].createName" type="hidden" value="${poVal.createName }"/>
						<input name="superQueryFieldList[${stuts.index }].createBy" type="hidden" value="${poVal.createBy }"/>
						<input name="superQueryFieldList[${stuts.index }].createDate" type="hidden" value="${poVal.createDate }"/>
						<input name="superQueryFieldList[${stuts.index }].updateName" type="hidden" value="${poVal.updateName }"/>
						<input name="superQueryFieldList[${stuts.index }].updateBy" type="hidden" value="${poVal.updateBy }"/>
						<input name="superQueryFieldList[${stuts.index }].updateDate" type="hidden" value="${poVal.updateDate }"/>
						<input name="superQueryFieldList[${stuts.index }].sysOrgCode" type="hidden" value="${poVal.sysOrgCode }"/>
						<input name="superQueryFieldList[${stuts.index }].sysCompanyCode" type="hidden" value="${poVal.sysCompanyCode }"/>
						<input name="superQueryFieldList[${stuts.index }].mainId" type="hidden" value="${poVal.mainId }"/>
				   <td align="left">
					  	<input name="superQueryFieldList[${stuts.index }].seq" maxlength="32" type="text" class="inputxt"  style="width:60px;"  ignore="ignore"  value="${poVal.seq }"/>
					  <label class="Validform_label" style="display: none;">序号</label>
				   </td>
				   <td align="left">
							  <%-- <t:dictSelect field="superQueryFieldList[${stuts.index }].tableName" type="list"   typeGroupCode=""  defaultVal="${poVal.tableName }" hasLabel="false"  title="表名"></t:dictSelect>   --%>     
							  <select id="fieldTableList[${stuts.index }]"  name="superQueryFieldList[${stuts.index}].tableName" class="fieldTableList4" style="width:180px" >  <!--onclick="sss()"  -->
							  <c:if test="${not empty poVal.tableName}">
							  	<option>${poVal.tableName}</option> 
							  </c:if>
							  <c:if test="${empty poVal.tableName}">
							  	<option value="">---请选择---</option>
							  </c:if>
							  
                            </select> 
							  
					  <label class="Validform_label" style="display: none;">表名</label>
				   </td>
				   <td align="left">
					  	<input name="superQueryFieldList[${stuts.index }].name" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  value="${poVal.name }"/>
					  <label class="Validform_label" style="display: none;">字段名</label>
				   </td>
				   <td align="left">
					  	<input name="superQueryFieldList[${stuts.index }].txt" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  value="${poVal.txt }"/>
					  <label class="Validform_label" style="display: none;">字段文本</label>
				   </td>
				   <td align="left">
							<t:dictSelect field="superQueryFieldList[${stuts.index }].ctype" type="list"   typeGroupCode="field_type"  defaultVal="${poVal.ctype }" hasLabel="false"  title="字段类型"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">字段类型</label>
				   </td>
				   <td align="left">
							<t:dictSelect field="superQueryFieldList[${stuts.index }].stype" type="list"   typeGroupCode="s_type"  defaultVal="${poVal.stype }" hasLabel="false"  title="控件类型"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">控件类型</label>
				   </td>
				   <td align="left">
					  	<input name="superQueryFieldList[${stuts.index }].dictTable" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  value="${poVal.dictTable }"/>
					  <label class="Validform_label" style="display: none;">字典Table</label>
				   </td>
				   <td align="left">
					  	<input name="superQueryFieldList[${stuts.index }].dictCode" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  value="${poVal.dictCode }"/>
					  <label class="Validform_label" style="display: none;">字典Code</label>
				   </td>
				   <td align="left">
					  	<input name="superQueryFieldList[${stuts.index }].dictText" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  value="${poVal.dictText }"/>
					  <label class="Validform_label" style="display: none;">字典Text</label>
				   </td>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>  
<script  src="webpage/com/jeecg/superquery/superQueryMain.js"></script>
