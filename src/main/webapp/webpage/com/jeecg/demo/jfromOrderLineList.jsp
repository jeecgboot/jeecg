<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	$('#addJfromOrderLineBtn').linkbutton({   
	    iconCls: 'icon-add'  
	});   
	$('#delJfromOrderLineBtn').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 
	$('#addJfromOrderLineBtn').bind('click', function(){   
 		 var tr =  $("#add_jfromOrderLine_table_template tr").clone();
	 	 $("#add_jfromOrderLine_table").append(tr);
	 	 resetTrNum('add_jfromOrderLine_table');
	 	 return false;
    });  
	$('#delJfromOrderLineBtn').bind('click', function(){   
      	$("#add_jfromOrderLine_table").find("input:checked").parent().parent().remove();   
        resetTrNum('add_jfromOrderLine_table'); 
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
	<a id="addJfromOrderLineBtn" href="#">添加</a> <a id="delJfromOrderLineBtn" href="#">删除</a> 
</div>
<table border="0" cellpadding="2" cellspacing="0" id="jfromOrderLine_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">序号</td>
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">操作</td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						商品名称
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						商品数量
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						商品价格
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						金额
				  </td>
	</tr>
	<tbody id="add_jfromOrderLine_table">
	<c:if test="${fn:length(jfromOrderLineList)  <= 0 }">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">1</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck"/></td>
					<input name="jfromOrderLineList[0].id" type="hidden"/>
					<input name="jfromOrderLineList[0].createName" type="hidden"/>
					<input name="jfromOrderLineList[0].createBy" type="hidden"/>
					<input name="jfromOrderLineList[0].createDate" type="hidden"/>
					<input name="jfromOrderLineList[0].updateName" type="hidden"/>
					<input name="jfromOrderLineList[0].updateBy" type="hidden"/>
					<input name="jfromOrderLineList[0].updateDate" type="hidden"/>
					<input name="jfromOrderLineList[0].sysOrgCode" type="hidden"/>
					<input name="jfromOrderLineList[0].sysCompanyCode" type="hidden"/>
					<input name="jfromOrderLineList[0].bpmStatus" type="hidden"/>
					<input name="jfromOrderLineList[0].orderid" type="hidden"/>
				  <td align="left">
					  	<input name="jfromOrderLineList[0].itemName" maxlength="128" type="text" class="inputxt"  style="width:120px;"  ignore="ignore" >
					  <label class="Validform_label" style="display: none;">商品名称</label>
					</td>
				  <td align="left">
					  	<input name="jfromOrderLineList[0].qty" maxlength="32" type="text" class="inputxt"  style="width:120px;"  datatype="n"  ignore="ignore" >
					  <label class="Validform_label" style="display: none;">商品数量</label>
					</td>
				  <td align="left">
					  	<input name="jfromOrderLineList[0].price" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore" >
					  <label class="Validform_label" style="display: none;">商品价格</label>
					</td>
				  <td align="left">
					  	<input name="jfromOrderLineList[0].amount" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore" >
					  <label class="Validform_label" style="display: none;">金额</label>
					</td>
   			</tr>
	</c:if>
	<c:if test="${fn:length(jfromOrderLineList)  > 0 }">
		<c:forEach items="${jfromOrderLineList}" var="poVal" varStatus="stuts">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">${stuts.index+1 }</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck" /></td>
						<input name="jfromOrderLineList[${stuts.index }].id" type="hidden" value="${poVal.id }"/>
						<input name="jfromOrderLineList[${stuts.index }].createName" type="hidden" value="${poVal.createName }"/>
						<input name="jfromOrderLineList[${stuts.index }].createBy" type="hidden" value="${poVal.createBy }"/>
						<input name="jfromOrderLineList[${stuts.index }].createDate" type="hidden" value="${poVal.createDate }"/>
						<input name="jfromOrderLineList[${stuts.index }].updateName" type="hidden" value="${poVal.updateName }"/>
						<input name="jfromOrderLineList[${stuts.index }].updateBy" type="hidden" value="${poVal.updateBy }"/>
						<input name="jfromOrderLineList[${stuts.index }].updateDate" type="hidden" value="${poVal.updateDate }"/>
						<input name="jfromOrderLineList[${stuts.index }].sysOrgCode" type="hidden" value="${poVal.sysOrgCode }"/>
						<input name="jfromOrderLineList[${stuts.index }].sysCompanyCode" type="hidden" value="${poVal.sysCompanyCode }"/>
						<input name="jfromOrderLineList[${stuts.index }].bpmStatus" type="hidden" value="${poVal.bpmStatus }"/>
						<input name="jfromOrderLineList[${stuts.index }].orderid" type="hidden" value="${poVal.orderid }"/>
				   <td align="left">
					  	<input name="jfromOrderLineList[${stuts.index }].itemName" maxlength="128" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  value="${poVal.itemName }"/>
					  <label class="Validform_label" style="display: none;">商品名称</label>
				   </td>
				   <td align="left">
					  	<input name="jfromOrderLineList[${stuts.index }].qty" maxlength="32" type="text" class="inputxt"  style="width:120px;"  datatype="n"  ignore="ignore"  value="${poVal.qty }"/>
					  <label class="Validform_label" style="display: none;">商品数量</label>
				   </td>
				   <td align="left">
					  	<input name="jfromOrderLineList[${stuts.index }].price" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  value="${poVal.price }"/>
					  <label class="Validform_label" style="display: none;">商品价格</label>
				   </td>
				   <td align="left">
					  	<input name="jfromOrderLineList[${stuts.index }].amount" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  value="${poVal.amount }"/>
					  <label class="Validform_label" style="display: none;">金额</label>
				   </td>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
