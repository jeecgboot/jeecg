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

<div style="margin: 0; background-color: white;overflow: auto;">    
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
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					  	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" style="width:120px;" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					<#elseif po.showType=='password'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="password" style="width:120px;" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<t:dictSelect field="${entityName?uncap_first}List[0].${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'form-control',style:'width:150px'}"  <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="${'$'}{${entityName?uncap_first}Page.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='date'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" class="form-control" onClick="WdatePicker()" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
					     	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					     	<#-- update--begin--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
					     <#elseif po.showType=='file' || po.showType == 'image'>
					     <#-- update--end--author:zhangjiaqiang date:20170531 for:增加图片和文件的支持 -->
										<input type="hidden" id="${entityName?uncap_first}List[0].${po.fieldName}" name="${entityName?uncap_first}List[0].${po.fieldName}" />
									   <#-- update--begin--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
									   <#-- update--begin--author:zhangjiaqiang date:20170614 for:修订上传附件按钮的大小 -->
									   <input class="btn btn-sm btn-success" style="margin-left:10px;" type="button" value="上传附件"
													onclick="commonUpload(${entityName?uncap_first}List0${po.fieldName}Callback)"/> 
										<#-- update--end--author:zhangjiaqiang date:20170614 for:修订上传附件按钮的大小 -->
										<a  target="_blank" id="${entityName?uncap_first}List[0].${po.fieldName}_href">暂时未上传文件</a>
										<#-- update--end--author:zhangjiaqiang date:20171120 for:TASK #2419 【代码生成器模板】一对多情况下，附件样式改造 -->
										<script type="text/javascript">
										function ${entityName?uncap_first}List0${po.fieldName}Callback(url,name){
											$("#${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}_href").attr('href',url).html('下载');
											$("#${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}").val(url);
										}
										</script>
					      <#elseif po.showType=='datetime'>
					      	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					      	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;"  class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" />/>
					       	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					        <#elseif po.showType=='popup'>
							<#-- update--begin--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
							 <input  id="${entityName?uncap_first}List[0].${po.fieldName}" name="${entityName?uncap_first}List[0].${po.fieldName}" type="text" style="width: 150px" class="searchbox-inputtext"   value="${'$'}{poVal.${po.fieldName} }" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!="">  onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/> 			 
							<#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
					       
					       <#else>
					       	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					       	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" style="width:120px;" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> />
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
				  <td class="text-center">
						<b>${po.content}:</b>
					</td>
				  <td>
					<#if po.showType == "text">
					<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					  	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" style="width:120px;" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value="${'$'}{poVal.${po.fieldName} }"/>
						<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='password'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="password" style="width:120px;" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value="${'$'}{poVal.${po.fieldName} }"/>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='radio' || po.showType=='select' || po.showType=='checkbox' || po.showType=='list'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<t:dictSelect field="${entityName?uncap_first}List[0].${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'form-control',style:'width:150px'}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> defaultVal="${'$'}{poVal.${po.fieldName}}" hasLabel="false"  title="${po.content}"></t:dictSelect>     
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
						<#elseif po.showType=='date'>
							<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
							<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" class="form-control" onClick="WdatePicker()" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd"/>"/>
					     	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					       <#elseif po.showType=='datetime'>
					       <#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					      	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" style="background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;width:160px;" class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value="<fmt:formatDate value='${'$'}{poVal.${po.fieldName}}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>"/>
					       <#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					<#elseif po.showType=='popup'>
					        <#-- update--begin--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
					 		<input  id="${entityName?uncap_first}List[0].${po.fieldName}" name="${entityName?uncap_first}List[0].${po.fieldName}" type="text" style="width: 150px" class="searchbox-inputtext"  value="${'$'}{poVal.${po.fieldName} }" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!="">  onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/> 			 
						    <#-- update--end--author:baiyu Date:20171031 for:popupClick支持返回多个字段 -->
					
					       <#elseif po.showType=='file'  || po.showType=='image'>
							 <input type="hidden" id="${entityName?uncap_first}List[0].${po.fieldName}" name="${entityName?uncap_first}List[0].${po.fieldName}" value="${'$'}{poVal.${po.fieldName} }"/>
									   <input class="btn btn-success btn-sm" type="button" value="上传附件"
													onclick="commonUpload(${entityName?uncap_first}List0${po.fieldName}Callback)"/> 
										<c:if test="${'$'}{empty poVal.${po.fieldName}}">
											<a  target="_blank" id="${entityName?uncap_first}List[0].${po.fieldName}_href"></a>
										</c:if>
										<c:if test="${'$'}{!empty poVal.${po.fieldName}}">
											<a  href="${'$'}{poVal.${po.fieldName}}"  target="_blank" id="${entityName?uncap_first}List[0].${po.fieldName}_href">下载</a>
										</c:if>
										<script type="text/javascript">
										function ${entityName?uncap_first}List0${po.fieldName}Callback(url,name){
											$("#${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}_href").attr('href',url).html('下载');
											$("#${entityName?uncap_first}List\\[0\\]\\.${po.fieldName}").val(url);
										}
										</script>
					       <#else>
					       	<#-- update--begin--author:zhangjiaqiang Date:20170509 for:修订生成页面乱 -->
					       	<input name="${entityName?uncap_first}List[0].${po.fieldName}" maxlength="${po.length?c}" type="text" style="width:120px;" class="form-control" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /> value="${'$'}{poVal.${po.fieldName} }"/>
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