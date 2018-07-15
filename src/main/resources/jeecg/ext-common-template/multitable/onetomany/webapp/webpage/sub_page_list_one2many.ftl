<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#include "/ui/datatype.ftl"/>
<#include "/ui/dictInfo.ftl"/>
<#include "/ui/formControl.ftl"/>
<#include "/ui/tag.ftl"/>
<!-- <h4>分类标题</h4> -->
	    <div class="row">
	      <div class="col-md-12 layout-header">
	        <button id="addBtn_${subsG['${key}'].entityName}" type="button" class="btn btn-default">添加</button>
	        <button id="delBtn_${subsG['${key}'].entityName}" type="button" class="btn btn-default">删除</button>
	       
	        <script type="text/javascript"> 
			$('#addBtn_${subsG['${key}'].entityName}').bind('click', function(){   
		 		 var tr =  $("#add_${subsG['${key}'].entityName?uncap_first}_table_template>tr").clone();
			 	 $("#add_${subsG['${key}'].entityName?uncap_first}_table").append(tr);
			 	 resetTrNum('add_${subsG['${key}'].entityName?uncap_first}_table');
			 	 return false;
		    });  
			$('#delBtn_${subsG['${key}'].entityName}').bind('click', function(){   
		       $("#add_${subsG['${key}'].entityName?uncap_first}_table").find("input[name$='ck']:checked").parent().parent().remove();   
		        resetTrNum('add_${subsG['${key}'].entityName?uncap_first}_table');
		        return false;
		    });
		    $(document).ready(function(){
		    	if(location.href.indexOf("load=detail")!=-1){
					$(":input").attr("disabled","true");
					$(".datagrid-toolbar").hide();
				}
		    	resetTrNum('add_${subsG['${key}'].entityName?uncap_first}_table');
		    });
		   </script>
	      </div>
	    </div>
	    
	    
<div style="margin: 0; background-color: white;overflow: auto;">    
	    <!-- Table -->
      <table id="${subsG['${key}'].entityName?uncap_first}_table" class="table table-bordered table-hover" style="margin-bottom: 0;">
		<thead>
	      <tr>
	        <th style="white-space:nowrap;width:50px;">操作</th>
	        <th style="width:40px;">序号</th>
	        <#assign index = 0 >
			<#list subColumnsMap['${key}'] as po>
				<#if po.isShow=="Y">
				<#assign check = 0 >
				<#list subsG['${key}'].foreignKeys as key>
				<#if subFieldMeta[po.fieldName]==key?uncap_first>
					<#assign check = 1 >
				<#break>
				</#if>
				</#list>
				<#if check==0>
			<th>
			${po.content}
			</th>
				</#if>
				</#if>
		      </#list>
	      </tr>
	    </thead>
        
	<tbody id="add_${subsG['${key}'].entityName?uncap_first}_table">	
	<c:if test="${"$"}{fn:length(${subsG['${key}'].entityName?uncap_first}List)  <= 0 }">
	<tr>
		<td><input style="width:20px;" type="checkbox" name="ck"/></td>
			<#list subColumnsMap['${key}'] as po>
			<#if po.isShow=="N">
			<input name="${subsG['${key}'].entityName?uncap_first}List[0].${po.fieldName}" type="hidden"/>
			</#if>
			</#list>
		<th scope="row"><div name="xh"></div></th>
		<#assign index = 0 >
		<#list subColumnsMap['${key}'] as po>
		<#if po.isShow=="Y">
		  <#assign check = 0 >
		  <#list subsG['${key}'].foreignKeys as key>
		  <#if subFieldMeta[po.fieldName]==key?uncap_first>
		  <#assign check = 1 >
		  <#break>
		  </#if>
		  </#list>
		 
	   <#if check==0>
		<td>
		<@formControl po = po namepre="${subsG['${key}'].entityName?uncap_first}List[0]." style="onetomany"/>
		</td>
		</#if>
		</#if>
	    </#list>
   	</tr>
	</c:if>
	<c:if test="${"$"}{fn:length(${subsG['${key}'].entityName?uncap_first}List)  > 0 }">
	<c:forEach items="${"$"}{${subsG['${key}'].entityName?uncap_first}List}" var="poVal" varStatus="stuts">
	<tr>
		<td><input style="width:20px;" type="checkbox" name="ck"/></td>
		<#list subColumnsMap['${key}'] as po>
		<#if po.isShow=="N">
			<input name="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" type="hidden" value="${'$'}{poVal.${po.fieldName} }"/>
		</#if>
		</#list>
		<th scope="row"><div name="xh">${'$'}{stuts.index+1 }</div></th>
				
		<#assign index = 0 >
		<#list subColumnsMap['${key}'] as po>
		<#if po.isShow=="Y">
		  <#assign check = 0 >
		  <#list subsG['${key}'].foreignKeys as key>
		  <#if subFieldMeta[po.fieldName]==key?uncap_first>
		  <#assign check = 1 >
		  <#break>
		  </#if>
		  </#list>
		  <#if check==0>
		  <td>
			<@formControl po = po namepre="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index}]." valuepre = "poVal." style="onetomany"/>
		  </td>
		  </#if>
		  </#if>
	 	</#list>
	</tr>
	</c:forEach>
	</c:if>	
	</tbody>
</table>
