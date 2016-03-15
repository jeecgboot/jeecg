<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	$('#addAutoFormParamBtn').linkbutton({   
	    iconCls: 'icon-add'  
	});  
	$('#delAutoFormParamBtn').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 
	$('#addAutoFormParamBtn').bind('click', function(){   
 		 var tr =  $("#add_autoFormParam_table_template tr").clone();
	 	 $("#add_autoFormParam_table").append(tr);
	 	 resetTrNum('add_autoFormParam_table');
	 	 return false;
    });  
	$('#delAutoFormParamBtn').bind('click', function(){   
      	$("#add_autoFormParam_table").find("input:checked").parent().parent().remove();   
        resetTrNum('add_autoFormParam_table'); 
        return false;
    }); 
	
    $(document).ready(function(){
    	$(".datagrid-toolbar").parent().css("width","auto");
    	if(location.href.indexOf("load=detail")!=-1){
			$(":input").attr("disabled","true");
			$(".datagrid-toolbar").hide();
		}
		//将表格的表头固定
	    $("#autoFormParam_table").createhftable({
	    	height:'100px',
			width:'auto',
			fixFooter:false
			});
    });
    
    function deleteOne(obj){
       	var tableId = $(obj).parent().parent().parent().parent().attr("id");
       	$(obj).parent().parent().parent().remove();
       	/*刷新拥有该列的表的序列*/
       	resetTrNum($("input[name='dbType']:checked").val()+"_div #"+tableId);
    }
</script>
<div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
	<a id="addAutoFormParamBtn" href="#"><t:mutiLang langKey="common.add"/></a> <a id="delAutoFormParamBtn" href="#"><t:mutiLang langKey="common.batch.delete"/></a> 
</div>
<table border="0" cellpadding="2" cellspacing="0" id="autoFormParam_table">
	<!--update-begin--Author:luobaoli  Date:20150621 for：将表头列宽设置为固定值-->
	<tr bgcolor="#E6E6E6">
		<td align="center" width="40px" bgcolor="#EEEEEE"><t:mutiLang langKey="common.code"/></td>
		<td align="center" width="40px" bgcolor="#EEEEEE">选择</td>
				  <td align="left" width="120px" bgcolor="#EEEEEE">
						<t:mutiLang langKey="form.param.name"/>
				  </td>
				  <td align="left" width="120px" bgcolor="#EEEEEE">
						<t:mutiLang langKey="form.param.desc"/>
				  </td>
				  <td align="left" width="120px" bgcolor="#EEEEEE">
						<t:mutiLang langKey="form.param.value"/>
				  </td>
				  <td align="left" width="120px" bgcolor="#EEEEEE">
						<t:mutiLang langKey="common.order"/>
				  </td>
				  <td align="center" width="50px" bgcolor="#EEEEEE">
				  		<t:mutiLang langKey="common.operation"/>
				  </td>
	</tr>
	<!--update-end--Author:luobaoli  Date:20150621 for：将表头列宽设置为固定值-->
	<tbody id="add_autoFormParam_table">
	<!-- 
	<c:if test="${fn:length(autoFormParamList)  <= 0 }">
			<tr>
				<td align="center"><div style="width: 40px;" name="xh">1</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck"/></td>
					<input name="autoFormParamList[0].id" type="hidden"/>
					<input name="autoFormParamList[0].createName" type="hidden"/>
					<input name="autoFormParamList[0].createBy" type="hidden"/>
					<input name="autoFormParamList[0].createDate" type="hidden"/>
					<input name="autoFormParamList[0].updateName" type="hidden"/>
					<input name="autoFormParamList[0].updateBy" type="hidden"/>
					<input name="autoFormParamList[0].updateDate" type="hidden"/>
					<input name="autoFormParamList[0].sysOrgCode" type="hidden"/>
					<input name="autoFormParamList[0].sysCompanyCode" type="hidden"/>
					<input name="autoFormParamList[0].autoFormDbId" type="hidden""/>
				  <td align="left">
					  	<input name="autoFormParamList[0].paramName" maxlength="32" 
					  		type="text" class="inputxt"  style="width:120px;"
					               datatype="*"
					               >
					  <label class="Validform_label" style="display: none;"><t:mutiLang langKey="form.param.name"/></label>
					</td>
				  <td align="left">
					  	<input name="autoFormParamList[0].paramDesc" maxlength="32" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					               >
					  <label class="Validform_label" style="display: none;"><t:mutiLang langKey="form.param.desc"/></label>
					</td>
				  <td align="left">
					  	<input name="autoFormParamList[0].paramValue" maxlength="32" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					               >
					  <label class="Validform_label" style="display: none;"><t:mutiLang langKey="form.param.value"/></label>
					</td>
				  <td align="left">
					  	<input name="autoFormParamList[0].seq" maxlength="32" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					               >
					  <label class="Validform_label" style="display: none;"><t:mutiLang langKey="common.order"/></label>
					</td>
					 <td align="center">
					  	<div style="width: 50px;" align="center">[<a class="delAutoFormParamOneBtn" href="javascript:void(0)" onclick="deleteOne(this)"><t:mutiLang langKey="common.delete"/></a>]</div>
					</td>
   			</tr>
	</c:if>
	 -->
	<c:if test="${fn:length(autoFormParamList)  > 0 }">
		<c:forEach items="${autoFormParamList}" var="poVal" varStatus="stuts">
			<tr>
				<td align="center"><div style="width: 40px;" name="xh">${stuts.index+1 }</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck" /></td>
					<input name="autoFormParamList[${stuts.index }].id" type="hidden" value="${poVal.id }"/>
					<input name="autoFormParamList[${stuts.index }].createName" type="hidden" value="${poVal.createName }"/>
					<input name="autoFormParamList[${stuts.index }].createBy" type="hidden" value="${poVal.createBy }"/>
					<input name="autoFormParamList[${stuts.index }].createDate" type="hidden" value="${poVal.createDate }"/>
					<input name="autoFormParamList[${stuts.index }].updateName" type="hidden" value="${poVal.updateName }"/>
					<input name="autoFormParamList[${stuts.index }].updateBy" type="hidden" value="${poVal.updateBy }"/>
					<input name="autoFormParamList[${stuts.index }].updateDate" type="hidden" value="${poVal.updateDate }"/>
					<input name="autoFormParamList[${stuts.index }].sysOrgCode" type="hidden" value="${poVal.sysOrgCode }"/>
					<input name="autoFormParamList[${stuts.index }].sysCompanyCode" type="hidden" value="${poVal.sysCompanyCode }"/>
					<input name="autoFormParamList[${stuts.index }].autoFormDbId" type="hidden" value="${poVal.autoFormDbId }"/>
				   <td align="left">
					  	<input name="autoFormParamList[${stuts.index }].paramName" maxlength="32" 
					  		type="text" class="inputxt"  style="width:120px;"
					               datatype="*"
					                value="${poVal.paramName }">
					  <label class="Validform_label" style="display: none;"><t:mutiLang langKey="form.param.name"/></label>
				   </td>
				   <td align="left">
					  	<input name="autoFormParamList[${stuts.index }].paramDesc" maxlength="32" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					                value="${poVal.paramDesc }">
					  <label class="Validform_label" style="display: none;"><t:mutiLang langKey="form.param.desc"/></label>
				   </td>
				   <td align="left">
					  	<input name="autoFormParamList[${stuts.index }].paramValue" maxlength="32" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					                value="${poVal.paramValue }">
					  <label class="Validform_label" style="display: none;"><t:mutiLang langKey="form.param.value"/></label>
				   </td>
				   <td align="left">
					  	<input name="autoFormParamList[${stuts.index }].seq" maxlength="32" 
					  		type="text" class="inputxt"  style="width:120px;"
					               
					                value="${poVal.seq }">
					  <label class="Validform_label" style="display: none;"><t:mutiLang langKey="common.order"/></label>
				   </td>
				   <td align="center">
						<div style="width: 50px;" align="center">[<a class="delAutoFormParamOneBtn" href="javascript:void(0)" onclick="deleteOne(this)"><t:mutiLang langKey="common.delete"/></a>]</div>
					</td>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>