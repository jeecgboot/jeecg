<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	$('#addJformOrderTicketBtn').linkbutton({   
	    iconCls: 'icon-add'  
	});  
	$('#delJformOrderTicketBtn').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 
	$('#addJformOrderTicketBtn').bind('click', function(){   
 		 var tr =  $("#add_jformOrderTicket_table_template tr").clone();
	 	 $("#add_jformOrderTicket_table").append(tr);
	 	 resetTrNum('add_jformOrderTicket_table');
	 	 return false;
    });  
	$('#delJformOrderTicketBtn').bind('click', function(){   
      	$("#add_jformOrderTicket_table").find("input[name$='ck']:checked").parent().parent().remove();   
        resetTrNum('add_jformOrderTicket_table'); 
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
	<a id="addJformOrderTicketBtn" href="#">添加</a> <a id="delJformOrderTicketBtn" href="#">删除</a> 
</div>
<table border="0" cellpadding="2" cellspacing="0" id="jformOrderTicket_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">序号</td>
		<td align="center" bgcolor="#EEEEEE" style="width: 25px;">操作</td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						航班号
				  </td>
				  <td align="left" bgcolor="#EEEEEE" style="width: 126px;">
						航班时间
				  </td>
	</tr>
	<tbody id="add_jformOrderTicket_table">
	<c:if test="${fn:length(jformOrderTicketList)  <= 0 }">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">1</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck"/></td>
					<input name="jformOrderTicketList[0].id" type="hidden"/>
					<input name="jformOrderTicketList[0].fckId" type="hidden"/>
				  <td align="left">
					  	<input name="jformOrderTicketList[0].ticketCode" maxlength="100" type="text" class="inputxt"  style="width:120px;"  datatype="*"  ignore="checked" >
					  <label class="Validform_label" style="display: none;">航班号</label>
					</td>
				  <td align="left">
					      	<input name="jformOrderTicketList[0].tickectDate" maxlength="10" type="text"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="width:140px;"  ignore="ignore" >
					  <label class="Validform_label" style="display: none;">航班时间</label>
					</td>
   			</tr>
	</c:if>
	<c:if test="${fn:length(jformOrderTicketList)  > 0 }">
		<c:forEach items="${jformOrderTicketList}" var="poVal" varStatus="stuts">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">${stuts.index+1 }</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck" /></td>
						<input name="jformOrderTicketList[${stuts.index }].id" type="hidden" value="${poVal.id }"/>
						<input name="jformOrderTicketList[${stuts.index }].fckId" type="hidden" value="${poVal.fckId }"/>
				   <td align="left">
					  	<input name="jformOrderTicketList[${stuts.index }].ticketCode" maxlength="100" type="text" class="inputxt"  style="width:120px;"  datatype="*"  ignore="checked"  value="${poVal.ticketCode }"/>
					  <label class="Validform_label" style="display: none;">航班号</label>
				   </td>
				   <td align="left">
					      	<input name="jformOrderTicketList[${stuts.index }].tickectDate" maxlength="10" type="text"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="width:140px;"  ignore="ignore"  value="<fmt:formatDate value='${poVal.tickectDate}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"/>
					  <label class="Validform_label" style="display: none;">航班时间</label>
				   </td>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
