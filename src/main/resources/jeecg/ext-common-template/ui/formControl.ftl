<#-- 表单列表当中每一列的处理 -->
<#macro formControl po namepre = "" valuepre = "" style="">
	<#if po.showType == "text">
			<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> style="width:150px" maxlength="${po.length?c}" type="text" class="form-control"  <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"  tableName="${po.table.tableName}" fieldName="${po.oldFieldName}" idFieldName="${namepre}id"/>/>
	<#rt/>
	<#elseif po.showType=='password'>
			<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> style="width:150px" maxlength="${po.length?c}" type="password" class="form-control"  <@datatype  validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>/>
	<#rt/>
	<#elseif po.showType=='select' || po.showType=='list'>
			<t:dictSelect id="${namepre}${po.fieldName}" field="${namepre}${po.fieldName}" type="${po.showType?if_exists?html}" extendJson="{class:'form-control',style:'width:150px !important'}"  <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> <#if valuepre != ""> defaultVal="${'$'}{${valuepre}${po.fieldName}}" </#if> hasLabel="false"  title="${po.content}"></t:dictSelect>     
	<#rt/>
	<#elseif po.showType=='radio' || po.showType=='checkbox'>
			<t:dictSelect id="${namepre}${po.fieldName}" field="${namepre}${po.fieldName}" type="${po.showType?if_exists?html}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" /> <#if valuepre != ""> defaultVal="${'$'}{${valuepre}${po.fieldName}}" </#if> hasLabel="false"  title="${po.content}"></t:dictSelect>     
	<#rt/>
	<#elseif po.showType=='date'>
			<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" maxlength="${po.length?c}" type="text" class="form-control" onClick="WdatePicker()"  style="width:150px;background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> value='<fmt:formatDate value='${'$'}{${valuepre}${po.fieldName}}' type="date" pattern="yyyy-MM-dd"/>'/>
	<#rt/>
	<#elseif po.showType=='datetime'>
			<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" maxlength="${po.length?c}" type="text"  class="form-control" onClick="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"  style="width:150px;background: url('plug-in/ace/images/datetime.png') no-repeat scroll right center transparent;" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/>  value='<fmt:formatDate value='${'$'}{${valuepre}${po.fieldName}}' type="date" pattern="yyyy-MM-dd hh:mm:ss"/>'/>
	<#rt/>
	<#elseif po.showType=='popup'>
			<input  id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" type="text" class="form-control" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> style="width:150px"   <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" /><#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/> 			 
	<#rt/>
	<#elseif po.showType=='file' || po.showType == 'image'>
		<#if style == "onetomany">
			<input onclick="onetomanyUpload('${namepre}${po.fieldName}')" class="file-upload-btn" type="button" value="上传附件" />	
			<input id="${namepre}${po.fieldName}" type="hidden" name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if>/>
		<#if valuepre != "">
			<a target="_blank" class="file-down-btn"<#rt/>
 <c:if test="${'$'}{not empty ${valuepre}${po.fieldName}}"><#rt/>
 href="img/server/${'$'}{${valuepre}${po.fieldName}}?down=true">下载<#rt/>
 </c:if><#rt/>
 <c:if test="${'$'}{empty ${valuepre}${po.fieldName}}">></c:if><#rt/>
</a><#rt/>
		<#else>
			<a target="_blank" class="file-down-btn"></a>
		</#if>
		<#else>
		<@webuploadtag po = po namepre=namepre defval="${'$'}{${valuepre}${po.fieldName}}"/>
		</#if>
	<#rt/>
	<#else>
			<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> maxlength="${po.length?c}" type="text" class="form-control" style="width:150px" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
	</#if>
</#macro>