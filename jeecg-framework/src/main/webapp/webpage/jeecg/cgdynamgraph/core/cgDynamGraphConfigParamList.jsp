<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	$('#addCgreportConfigParamBtn').linkbutton({   
	    iconCls: 'icon-add'  
	});  
	$('#delCgreportConfigParamBtn').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 

	$('#addCgreportConfigParamBtn').bind('click', function(){   
 		 var tr =  $("#add_cgDynamGraphConfigParam_table_template tr").clone();
	 	 $("#add_cgreportConfigParam_table").append(tr);
	 	 resetTrNum('add_cgreportConfigParam_table');
    });  
	$('#delCgreportConfigParamBtn').bind('click', function(){   
      	$("#add_cgreportConfigParam_table").find("input:checked").parent().parent().remove();   
        resetTrNum('add_cgreportConfigParam_table'); 
    }); 
	
    $(document).ready(function(){
    	$(".datagrid-toolbar").parent().css("width","auto");
    	if(location.href.indexOf("load=detail")!=-1){
			$(":input").attr("disabled","true");
			$(".datagrid-toolbar").hide();
		}
    });
</script>
<div style="padding: 3px; height: 25px; width: auto;" class="datagrid-toolbar"><a id="addCgreportConfigParamBtn" href="javascript:void(0);">添加</a> <a id="delCgreportConfigParamBtn" href="javascript:void(0);">删除</a></div>
<div style="width: auto; height: 150px; overflow-y: auto; overflow-x: scroll;">
<table border="0" cellpadding="2" cellspacing="0" id="cgreportConfigParam_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE"><label class="Validform_label"><t:mutiLang langKey="common.code"/></label></td>
		<td align="left" bgcolor="#EEEEEE" style="width: 120px;"><label class="Validform_label"> <t:mutiLang langKey="form.param.name"/> </label></td>
		<td align="left" bgcolor="#EEEEEE" style="width: 120px;"><label class="Validform_label"> <t:mutiLang langKey="form.param.desc"/> </label></td>
		<td align="left" bgcolor="#EEEEEE" style="width: 120px;"><label class="Validform_label"> <t:mutiLang langKey="form.param.value"/> </label></td>
		<td align="left" bgcolor="#EEEEEE" style="width: 120px;"><label class="Validform_label"> <t:mutiLang langKey="common.order"/> </label></td>
	</tr>
	<tbody id="add_cgreportConfigParam_table">
		<%--
		<c:if test="${fn:length(cgreportConfigParamList)  <= 0 }">
			<tr>
				<td align="center"><input style="width: 20px;" type="checkbox" name="ck" /></td>
				<input name="cgreportConfigParamList[0].id" type="hidden" />
				<input name="cgreportConfigParamList[0].cgrheadId" type="hidden" />
				<td align="left"><input name="cgreportConfigParamList[0].paramName" maxlength="32" type="text" class="inputxt" style="width: 120px;"></td>
				<td align="left"><input name="cgreportConfigParamList[0].paramDesc" maxlength="32" type="text" class="inputxt" style="width: 120px;"></td>
				<td align="left"><input name="cgreportConfigParamList[0].paramValue" maxlength="32" type="text" class="inputxt" style="width: 120px;"></td>
				<td align="left"><input name="cgreportConfigParamList[0].seq" maxlength="32" type="text" class="inputxt"  style="width:120px;"></td>
			</tr>
		</c:if>
		 --%>
		<c:if test="${fn:length(cgDynamGraphConfigParamList)  > 0 }">
			<c:forEach items="${cgDynamGraphConfigParamList}" var="poVal" varStatus="stuts">
				<tr>
					<td align="center"><input style="width: 20px;" type="checkbox" name="ck" /></td>
					<input name="cgDynamGraphConfigParamList[${stuts.index }].id" type="hidden" value="${poVal.id }"/>
					<input name="cgDynamGraphConfigParamList[${stuts.index }].cgrheadId" type="hidden" value="${poVal.cgrheadId }"/>
					<td align="left"><input name="cgDynamGraphConfigParamList[${stuts.index }].paramName" value="${poVal.paramName }" maxlength="32" type="text" class="inputxt" style="width: 120px;"></td>
					<td align="left"><input name="cgDynamGraphConfigParamList[${stuts.index }].paramDesc" value="${poVal.paramDesc }" maxlength="32" type="text" class="inputxt" style="width: 120px;"></td>
					<td align="left"><input name="cgDynamGraphConfigParamList[${stuts.index }].paramValue" value="${poVal.paramValue }" maxlength="32" type="text" class="inputxt" style="width: 120px;"></td>
					<td align="left"><input name="cgDynamGraphConfigParamList[${stuts.index }].seq" value="${poVal.seq }" maxlength="32" type="text" class="inputxt"  style="width:120px;"></td>
				</tr>
			</c:forEach>
		</c:if>
	</tbody>
</table>
</div>