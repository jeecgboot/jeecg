<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/context/mytags.jsp"%>
<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<#include "../../ui/datatype.ftl"/>
<#include "../../ui/dictInfo.ftl"/>
<#-- update--end--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
<script type="text/javascript">
$(document).ready(function(){
    	if(location.href.indexOf("load=detail")!=-1){
			$(":input").attr("disabled","true");
		}
    });
</script>
<div style="width: auto;height: 300px;overflow-y:auto;overflow-x:auto;">
<table cellpadding="0" cellspacing="1" class="formtable" id="${entityName?uncap_first}_table" >
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
				  <td align="right">
					<label class="Validform_label">
										${po.content}:
									</label>
					</td>
				  <td class="value">
					<#if po.showType == "text">
					<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					  	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
					<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->	
					<#elseif po.showType=='password'>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="password" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<t:dictSelect field="${entityName?uncap_first}List[0].${po.fieldName}" type="${po.showType?if_exists?html}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					<#elseif po.showType=='date'>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="Wdate" onClick="WdatePicker()" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
					<#elseif po.showType=='file' || po.showType == 'image'>
					<#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
										<input type="hidden" id="${entityName?uncap_first}List[0].${po.fieldName}" name="${entityName?uncap_first}List[0].${po.fieldName}" />
										<a  target="_blank" id="${entityName?uncap_first}List[0].${po.fieldName}_href">暂时未上传文件</a>
									   <input class="ui-button" type="button" value="上传附件"
													onclick="commonUpload(${entityName?uncap_first}List0${po.fieldName}Callback)"/> 
										<script type="text/javascript">
										function ${entityName?uncap_first}List0${po.fieldName}Callback(url,name){
											$("#${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}_href").attr('href',url).html('下载');
											$("#${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}").val(url);
										}
										</script>
					      <#elseif po.showType=='datetime'>
					      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					      	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
					       <#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					       <#else>
					       <#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					       	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}"type="text" class="inputxt" <@datatype  validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
					  		<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
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
				  <td align="right">
					<label class="Validform_label">
										${po.content}:
									</label>
					</td>
				  <td class="value">
					<#if po.showType == "text">
					<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					  	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value="${'$'}{poVal.${po.fieldName} }"/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='password'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="password" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value="${'$'}{poVal.${po.fieldName} }"/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<t:dictSelect field="${entityName?uncap_first}List[0].${po.fieldName}" type="${po.showType?if_exists?html}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/><@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='date'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="Wdate" onClick="WdatePicker()" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd"/>"/>
					      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					      <#elseif po.showType=='datetime'>
					      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					      	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text"  class="Wdate" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"/>
					     	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					     <#elseif po.showType=='file'>
							 <input type="hidden" id="${entityName?uncap_first}List[0].${po.fieldName}" name="${entityName?uncap_first}List[0].${po.fieldName}" value="${'$'}{poVal.${po.fieldName} }"/>
										<c:if test="${'$'}{empty poVal.${po.fieldName}}">
											<a  target="_blank" id="${entityName?uncap_first}List[0].${po.fieldName}_href">暂时未上传文件</a>
										</c:if>
										<c:if test="${'$'}{!empty poVal.${po.fieldName}}">
											<a  href="${'$'}{poVal.${po.fieldName}}"  target="_blank" id="${entityName?uncap_first}List[0].${po.fieldName}_href">下载</a>
										</c:if>
									   <input class="ui-button" type="button" value="上传附件"
													onclick="commonUpload(${entityName?uncap_first}List0${po.fieldName}Callback)"/> 
										<script type="text/javascript">
										function ${entityName?uncap_first}List0${po.fieldName}Callback(url,name){
											$("#${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}_href").attr('href',url).html('下载');
											$("#${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}").val(url);
										}
										</script>
					       <#else>
					       	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					       	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" class="inputxt" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value="${'$'}{poVal.${po.fieldName} }"/>
					 		<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
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