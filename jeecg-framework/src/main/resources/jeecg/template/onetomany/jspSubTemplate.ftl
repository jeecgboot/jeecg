<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
	$('#add${entityName}Btn').linkbutton({   
	    iconCls: 'icon-add'  
	});  
	$('#del${entityName}Btn').linkbutton({   
	    iconCls: 'icon-remove'  
	}); 
	$('#add${entityName}Btn').bind('click', function(){   
 		 var tr =  $("#add_${entityName?uncap_first}_table_template tr").clone();
	 	 $("#add_${entityName?uncap_first}_table").append(tr);
	 	 resetTrNum('add_${entityName?uncap_first}_table');
    });  
	$('#del${entityName}Btn').bind('click', function(){   
      	$("#add_${entityName?uncap_first}_table").find("input:checked").parent().parent().remove();   
        resetTrNum('add_${entityName?uncap_first}_table'); 
    }); 
    $(document).ready(function(){
    	$(".datagrid-toolbar").parent().css("width","auto");
    });
</script>
<div style="padding: 3px; height: 25px;width:auto;" class="datagrid-toolbar">
	<a id="add${entityName}Btn" href="#">添加</a> <a id="del${entityName}Btn" href="#">删除</a> 
</div>
<div style="width: auto;height: 300px;overflow-y:auto;overflow-x:scroll;">
<table border="0" cellpadding="2" cellspacing="0" id="${entityName?uncap_first}_table">
	<tr bgcolor="#E6E6E6">
		<td align="center" bgcolor="#EEEEEE">序号</td>
		<td align="center" bgcolor="#EEEEEE">操作</td>
		 <#list columns as po>
				 <#assign check = 0 >
				  <#list foreignKeys as key>
				  <#if po.fieldName==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				  <td align="left" bgcolor="#EEEEEE"><#if po.filedComment?length lt 7 >${po.filedComment}<#else>${po.filedComment[0..6]}</#if></td>
				  </#if>
	      </#list>
	</tr>
	<tbody id="add_${entityName?uncap_first}_table">	
	<c:if test="${"$"}{fn:length(${entityName?uncap_first}List)  <= 0 }">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">1</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck"/></td>
				<#list columns as po>
				  <#assign check = 0 >
				  <#list foreignKeys as key>
				  <#if po.fieldName==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				  <td align="left"><input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.charmaxLength}" type="text" style="width:120px;" ></td>
				  </#if>
	            </#list>
   			</tr>
	</c:if>
	<c:if test="${"$"}{fn:length(${entityName?uncap_first}List)  > 0 }">
		<c:forEach items="${"$"}{${entityName?uncap_first}List}" var="poVal" varStatus="stuts">
			<tr>
				<td align="center"><div style="width: 25px;" name="xh">${'$'}{stuts.index+1 }</div></td>
				<td align="center"><input style="width:20px;"  type="checkbox" name="ck" /></td>
				<input name="${entityName?uncap_first}List[${'$'}{stuts.index }].id"  value="${'$'}{poVal.id }" type="hidden" >
				<#list columns as po>
				  <#assign check = 0 >
				  <#list foreignKeys as key>
				  <#if po.fieldName==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				   <td align="left"><input name="${entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" maxlength="${po.charmaxLength}" value="${'$'}{poVal.${po.fieldName} }" type="text" style="width:120px;"></td>
				  </#if>
   			 	</#list>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
</div>