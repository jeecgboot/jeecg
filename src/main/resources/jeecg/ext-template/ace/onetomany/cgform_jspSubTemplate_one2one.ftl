<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<script type="text/javascript">
$(document).ready(function(){
    	if(location.href.indexOf("load=detail")!=-1){
			$(":input").attr("disabled","true");
		}
    });
</script>

<div style="margin: 0 15px; background-color: white;">    
	    <!-- Table -->
<table id="${entityName?uncap_first}_table" class="table table-bordered table-hover" style="margin-bottom: 0;">
		
	<tbody id="add_${entityName?uncap_first}_table" >	
	<c:if test="${"$"}{fn:length(${entityName?uncap_first}List)  <= 0 }">
			<tr>
				<#list columns as po>
				<#if po.isShow=="N">
					<input name="${entityName?uncap_first}List[0].${po.fieldName}" type="hidden"  value="${'$'}{poVal.${po.fieldName}}"/>
				</#if>
				</#list>
			</tr>
			<#list pageColumns as po>
			  <#assign check = 0 >
			  <#list foreignKeys as key>
			  <#if fieldMeta[po.fieldName]==key?uncap_first>
			  <#assign check = 1 >
			  <#break>
			  </#if>
			  </#list>
			 <#if check==0>
			<#if po_index%2==0>
				<tr>
			</#if>
				    <td class="text-center">
						<b>${po.content}:</b>
					</td>
				  <td>
					<#if po.showType == "text">
					  	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="text" style="width:120px;" class="form-control" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else><#if po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#else><#if po.isNull != 'Y'>datatype="*"</#if></#if></#if>>
						<#elseif po.showType=='password'>
							<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="password" style="width:120px;" class="form-control" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else><#if po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if></#if>>
						<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
							<t:dictSelect field="${entityName?uncap_first}List[0].${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'form-control',style:'width:150px'}" <#if po.isNull != 'Y'>datatype="*"</#if> 
										<#if po.dictTable?if_exists?html != ''>dictTable="po.dictTable" dictField="${po.dictField?if_exists?html}" dictText="${po.dictText?if_exists?html}"<#else>typeGroupCode="${po.dictField}"</#if> defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
						<#elseif po.showType=='date'>
							<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="text" style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" class="form-control" onClick="WdatePicker()" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if>>
					      <#elseif po.showType=='file'>
										<input type="hidden" id="${entityName?uncap_first}List[0].${po.fieldName}" name="${entityName?uncap_first}List[0].${po.fieldName}" />
										<a  target="_blank" id="${entityName?uncap_first}List[0].${po.fieldName}_href">暂时未上传文件</a>
									   <input class="form-control" type="button" value="上传附件"
													onclick="commonUpload(${entityName?uncap_first}List0${po.fieldName}Callback)"/> 
										<script type="text/javascript">
										function ${entityName?uncap_first}List0${po.fieldName}Callback(url,name){
											$("#${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}_href").attr('href',url).html('下载');
											$("#${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}").val(url);
										}
										</script>
					      <#elseif po.showType=='datetime'>
					      	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
						  		type="text" style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;"  class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if>>
					       <#else>
					       	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
						  		type="text" style="width:120px;" class="form-control" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else><#if po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if></#if> >
					  </#if>
					  <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
					</td>
				<#if (po_index+1)%2==0>
				</tr>
				<#else>
				<#if !po_has_next>
				</tr>
				</#if>
				</#if>
			  </#if>
            </#list>
	</c:if>
	<c:if test="${"$"}{fn:length(${entityName?uncap_first}List)  > 0 }">
		<c:forEach items="${"$"}{${entityName?uncap_first}List}" var="poVal" varStatus="stuts" begin="0" end="0">
			<tr>
				<#list columns as po>
				<#if po.isShow=="N">
					<input name="${entityName?uncap_first}List[0].${po.fieldName}" type="hidden" value="${'$'}{poVal.${po.fieldName}}"/>
				</#if>
				</#list>
			</tr>
			<#list pageColumns as po>
			  <#assign check = 0 >
			  <#list foreignKeys as key>
			  <#if fieldMeta[po.fieldName]==key?uncap_first>
			  <#assign check = 1 >
			  <#break>
			  </#if>
			  </#list>
			  <#if check==0>
			 <#if po_index%2==0>
			<tr>
			</#if>
				  <td class="text-center">
						<b>${po.content}:</b>
					</td>
				  <td>
					<#if po.showType == "text">
					  	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="text" style="width:120px;" class="form-control" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else><#if po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#else><#if po.isNull != 'Y'>datatype="*"</#if></#if></#if> value="${'$'}{poVal.${po.fieldName} }">
						<#elseif po.showType=='password'>
							<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="password" style="width:120px;" class="form-control" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else><#if po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if></#if> value="${'$'}{poVal.${po.fieldName} }">
						<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
							<t:dictSelect field="${entityName?uncap_first}List[0].${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'form-control',style:'width:150px'}" <#if po.isNull != 'Y'>datatype="*"</#if> 
										<#if po.dictTable?if_exists?html != ''>dictTable="${po.dictTable?if_exists?html}" dictField="${po.dictField?if_exists?html}" dictText="${po.dictText?if_exists?html}"<#else>typeGroupCode="${po.dictField}"</#if> defaultVal="${'$'}{poVal.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
						<#elseif po.showType=='date'>
							<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
					  		type="text" style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" class="form-control" onClick="WdatePicker()" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd"/>">
					      <#elseif po.showType=='datetime'>
					      	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
						  		type="text" style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>">
					       <#elseif po.showType=='file'>
							 <input type="hidden" id="${entityName?uncap_first}List[0].${po.fieldName}" name="${entityName?uncap_first}List[0].${po.fieldName}" value="${'$'}{poVal.${po.fieldName} }"/>
										<c:if test="${'$'}{empty poVal.${po.fieldName}}">
											<a  target="_blank" id="${entityName?uncap_first}List[0].${po.fieldName}_href">暂时未上传文件</a>
										</c:if>
										<c:if test="${'$'}{!empty poVal.${po.fieldName}}">
											<a  href="${'$'}{poVal.${po.fieldName}}"  target="_blank" id="${entityName?uncap_first}List[0].${po.fieldName}_href">下载</a>
										</c:if>
									   <input class="form-control" type="button" value="上传附件"
													onclick="commonUpload(${entityName?uncap_first}List0${po.fieldName}Callback)"/> 
										<script type="text/javascript">
										function ${entityName?uncap_first}List0${po.fieldName}Callback(url,name){
											$("#${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}_href").attr('href',url).html('下载');
											$("#${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}").val(url);
										}
										</script>
					       <#else>
					       	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" 
						  		type="text" style="width:120px;" class="form-control" <#if po.fieldValidType?if_exists?html != ''> datatype="${po.fieldValidType?if_exists?html}"<#else><#if po.type == 'int'> datatype="n"<#elseif po.type=='double'> datatype="/^(-?\d+)(\.\d+)?$/"<#else> <#if po.isNull != 'Y'>datatype="*"</#if></#if></#if> value="${'$'}{poVal.${po.fieldName} }">
					  </#if>
					  <label class="Validform_label" style="display: none;">${po.content?if_exists?html}</label>
					</td>
				<#if (po_index+1)%2==0>
				</tr>
				<#else>
				<#if !po_has_next>
				</tr>
				</#if>
				</#if>
			  </#if>
            </#list>
		</c:forEach>
	</c:if>	
	</tbody>
</table>
</div>