<#-- bootstrap表单列表当中每一列的处理   TODO-后期可以和上面那个合并 -->
<#macro formControlbt po namepre = "" valuepre = "" tablestyle = "" tpl="">
							<#if po.showType=='textarea'>
			            	<textarea name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> class="form-control input-sm" rows="6" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>></textarea>
			            	<#elseif po.showType=='text'>
							<input name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> type="text" class="form-control input-sm" maxlength="${po.length?c}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/> />
			            	<#elseif po.showType=='password'>
			            	<input name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> type="password" maxlength="${po.length?c}" class="form-control input-sm"<@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>/>
			            	<#elseif po.showType=='radio'>
			            	<div style="padding-top:5px">
			            	<t:dictSelect field="${namepre}${po.fieldName}" <#if valuepre != "">defaultVal = "${'$'}{${valuepre}${po.fieldName}}"</#if> <#if tpl=='1'>extendJson="{class:'i-checks-tpl'}"<#else>extendJson="{class:'i-checks'}"</#if> type="radio" hasLabel="false"  title="${po.content}" <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" />></t:dictSelect>
			            	</div>
			            	<#elseif po.showType=='select' || po.showType=='list'>
			            	<t:dictSelect field="${namepre}${po.fieldName}" <#if valuepre != "">defaultVal = "${'$'}{${valuepre}${po.fieldName}}"</#if> type="select" hasLabel="false" title="${po.content}" extendJson="{class:'form-control input-sm'}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" />></t:dictSelect>
			            	<#elseif po.showType=='checkbox'>
			            	<div style="padding-top:5px">
			            	<t:dictSelect field="${namepre}${po.fieldName}" <#if valuepre != "">defaultVal = "${'$'}{${valuepre}${po.fieldName}}"</#if> <#if tpl=='1'>extendJson="{class:'i-checks-tpl'}"<#else>extendJson="{class:'i-checks'}"</#if> type="checkbox" hasLabel="false"  title="${po.content}" <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" />></t:dictSelect>
			            	</div>
			            	<#elseif po.showType=='date'>
			            	<#if tablestyle=='1'>
			            	<input name="${namepre}${po.fieldName}" type="text" class="form-control input-sm laydate-date" value="<fmt:formatDate pattern='yyyy-MM-dd' type='date' value='${'$'}{${valuepre}${po.fieldName}}'/>" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
			            	<#else>
		            		<div class="input-group input-group-sm">
		            			<input name="${namepre}${po.fieldName}" type="text" class="form-control input-sm laydate-date" value="<fmt:formatDate pattern='yyyy-MM-dd' type='date' value='${'$'}{${valuepre}${po.fieldName}}'/>" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
		            			<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		            		</div>
			            	</#if>
							<#elseif po.showType=='datetime'>
			            	<#if tablestyle=='1'>
			            	<input name="${namepre}${po.fieldName}" type="text" class="form-control input-sm laydate-datetime" value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' type='both' value='${'$'}{${valuepre}${po.fieldName}}'/>" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
			            	<#else>
		            		<div class="input-group input-group-sm">
		            			<input name="${namepre}${po.fieldName}" type="text" class="form-control input-sm laydate-datetime" value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' type='both' value='${'$'}{${valuepre}${po.fieldName}}'/>" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
		            			<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		            		</div>
			            	</#if>
			            	<#elseif tablestyle != "1" && (po.showType=='file' || po.showType=='image')>
			            	<@webuploadtag po = po defval="${'$'}{${valuepre}${po.fieldName}}"/>
			            	<#else>
							<input name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> type="text" class="form-control input-sm" maxlength="${po.length?c}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/> />
			            	</#if>
</#macro>