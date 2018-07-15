<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	$('#addJformOrderCustomerBtn').linkbutton({   
	    iconCls: 'icon-add'  
	});  
	$('#delJformOrderCustomerBtn').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 
	$('#addJformOrderCustomerBtn').bind('click', function(){   
 		 var tr =  $("#add_jformOrderCustomer_table_template tr").clone();
	 	 $("#add_jformOrderCustomer_table").append(tr);
	 	 resetTrNum('add_jformOrderCustomer_table');
	 	 return false;
    });  
	$('#delJformOrderCustomerBtn').bind('click', function(){   
      	$("#add_jformOrderCustomer_table").find("input[name$='ck']:checked").parent().parent().remove();   
        resetTrNum('add_jformOrderCustomer_table'); 
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
	<a id="addJformOrderCustomerBtn" href="#">添加</a> <a id="delJformOrderCustomerBtn" href="#">删除</a> 
</div>
<table border="0" cellpadding="2" cellspacing="0" id="jformOrderCustomer_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">序号</td>
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">操作</td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						客户名
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						单价
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						性别
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						电话
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						身份证扫描件
				  </td>
	</tr>
	<tbody id="add_jformOrderCustomer_table">
	<c:if test="${fn:length(jformOrderCustomerList)  <= 0 }">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">1</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck"/></td>
					<input name="jformOrderCustomerList[0].id" type="hidden"/>
					<input name="jformOrderCustomerList[0].fkId" type="hidden"/>
				  <td align="left">
					       	<input name="jformOrderCustomerList[0].name" maxlength="100" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  >
					  <label class="Validform_label" style="display: none;">客户名</label>
					</td>
				  <td align="left">
					  	<input name="jformOrderCustomerList[0].money" maxlength="10" type="text" class="inputxt"  style="width:120px;"  datatype="d"  ignore="ignore" >
					  <label class="Validform_label" style="display: none;">单价</label>
					</td>
				  <td align="left">
							<t:dictSelect field="jformOrderCustomerList[0].sex" type="radio"  datatype="*"   typeGroupCode="sex"  defaultVal="${jformOrderCustomerPage.sex}" hasLabel="false"  title="性别"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">性别</label>
					</td>
				  <td align="left">
					  	<input name="jformOrderCustomerList[0].telphone" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore" >
					  <label class="Validform_label" style="display: none;">电话</label>
					</td>
				  <td align="left">
							<input type="hidden" id="jformOrderCustomerList[0].sfPic" name="jformOrderCustomerList[0].sfPic" />
							<input class="ui-button" type="button" value="上传附件" onclick="commonUpload(commonUploadDefaultCallBack,'jformOrderCustomerList\\[0\\]\\.sfPic')"/> 
					  <label class="Validform_label" style="display: none;">身份证扫描件</label>
					</td>
   			</tr>
	</c:if>
	<c:if test="${fn:length(jformOrderCustomerList)  > 0 }">
		<c:forEach items="${jformOrderCustomerList}" var="poVal" varStatus="stuts">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">${stuts.index+1 }</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck" /></td>
						<input name="jformOrderCustomerList[${stuts.index }].id" type="hidden" value="${poVal.id }"/>
						<input name="jformOrderCustomerList[${stuts.index }].fkId" type="hidden" value="${poVal.fkId }"/>
				   <td align="left">
					       	<input name="jformOrderCustomerList[${stuts.index }].name" maxlength="100" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  value="${poVal.name }"/>
					  <label class="Validform_label" style="display: none;">客户名</label>
				   </td>
				   <td align="left">
					  	<input name="jformOrderCustomerList[${stuts.index }].money" maxlength="10" type="text" class="inputxt"  style="width:120px;"  datatype="d"  ignore="ignore"  value="${poVal.money }"/>
					  <label class="Validform_label" style="display: none;">单价</label>
				   </td>
				   <td align="left">
							<t:dictSelect field="jformOrderCustomerList[${stuts.index }].sex" type="radio"  datatype="*"   typeGroupCode="sex"  defaultVal="${poVal.sex }" hasLabel="false"  title="性别"></t:dictSelect>     
					  <label class="Validform_label" style="display: none;">性别</label>
				   </td>
				   <td align="left">
					  	<input name="jformOrderCustomerList[${stuts.index }].telphone" maxlength="32" type="text" class="inputxt"  style="width:120px;"  ignore="ignore"  value="${poVal.telphone }"/>
					  <label class="Validform_label" style="display: none;">电话</label>
				   </td>
				   <td align="left">
					        <input type="hidden" id="jformOrderCustomerList[${stuts.index }].sfPic" name="jformOrderCustomerList[${stuts.index }].sfPic"  value="${poVal.sfPic }"/>
									   <input class="ui-button" type="button" value="上传附件"
													onclick="commonUpload(commonUploadDefaultCallBack,'jformOrderCustomerList\\[${stuts.index }\\]\\.sfPic')"/> 
										<c:if test="${!empty poVal.sfPic}">
											<a  href="${poVal.sfPic}"  target="_blank" id="jformOrderCustomerList[${stuts.index }].sfPic_href">下载</a>
										</c:if>
					  <label class="Validform_label" style="display: none;">身份证扫描件</label>
				   </td>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
