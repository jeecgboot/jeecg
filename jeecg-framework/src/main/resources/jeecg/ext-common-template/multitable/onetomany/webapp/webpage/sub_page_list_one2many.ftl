<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#include "/ui/datatype.ftl"/>
<#include "/ui/dictInfo.ftl"/>
<#include "/ui/formControl.ftl"/>
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
		       $("#add_${subsG['${key}'].entityName?uncap_first}_table").find("input:checked").parent().parent().remove();   
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
					<@formControl po = po namepre="${subsG['${key}'].entityName?uncap_first}List[0]."/>
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
				<#-- update--begin--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				<#list subColumnsMap['${key}'] as po>
				<#if po.isShow=="Y">
				<#-- update--end--author:zhoujf Date:20180404 for:TASK #2600 【代码生成器一对多问题】一对多 子表 多行文本 和 UE编辑器控件字段 没有生成 -->
				  <#assign check = 0 >
				  <#list subsG['${key}'].foreignKeys as key>
				  <#if subFieldMeta[po.fieldName]==key?uncap_first>
				  <#assign check = 1 >
				  <#break>
				  </#if>
				  </#list>
				  <#if check==0>
				   <td>
					<#if po.showType=='file' || po.showType == 'image'>
					   <input type="hidden" id="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}" name="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}"  value="${'$'}{poVal.${po.fieldName} }"/>
					   <input  class="btn btn-sm btn-success" style="margin-left:10px;" type="button" value="上传附件" onclick="commonUpload(commonUploadDefaultCallBack,'${subsG['${key}'].entityName?uncap_first}List\\[${'$'}{stuts.index }\\]\\.${po.fieldName}')"/> 
				   		<c:if test="${'$'}{empty poVal.${po.fieldName}}">
							<a  target="_blank" id="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}_href"></a>
						</c:if>
						<c:if test="${'$'}{!empty poVal.${po.fieldName}}">
							<a  href="${'$'}{poVal.${po.fieldName}}"  target="_blank" id="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index }].${po.fieldName}_href">下载</a>
						</c:if>
				     <#else>
				    	 <@formControl po = po namepre="${subsG['${key}'].entityName?uncap_first}List[${'$'}{stuts.index}]." valuepre = "poVal."/>
				  	</#if>
				   </td>
				  </#if>
				  </#if>
   			 	</#list>
   			</tr>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
