<#-- bootstrap表单列表当中每一列的处理   TODO-后期可以和上面那个合并 -->
<#macro formControlbt po namepre = "" valuepre = "" tablestyle = "" tpl="">
							<#if po.showType=='textarea'>
			            	<textarea id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> class="form-control input-sm" rows="6" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>></textarea>
			            	<#elseif po.showType=='text'>
							<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> type="text" class="form-control input-sm" maxlength="${po.length?c}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/> />
			            	<#elseif po.showType=='password'>
			            	<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> type="password" maxlength="${po.length?c}" class="form-control input-sm"<@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}"/>/>
			            	<#elseif po.showType=='radio'>
			            	<div style="padding-top:5px">
			            	<t:dictSelect id="${namepre}${po.fieldName}" field="${namepre}${po.fieldName}" <#if valuepre != "">defaultVal = "${'$'}{${valuepre}${po.fieldName}}"</#if> <#if tpl=='1'>extendJson="{class:'i-checks-tpl'}"<#else>extendJson="{class:'i-checks'}"</#if> type="radio" hasLabel="false"  title="${po.content}" <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" />></t:dictSelect>
			            	</div>
			            	<#elseif po.showType=='select' || po.showType=='list'>
			            	<t:dictSelect id="${namepre}${po.fieldName}" field="${namepre}${po.fieldName}" <#if valuepre != "">defaultVal = "${'$'}{${valuepre}${po.fieldName}}"</#if> type="select" hasLabel="false" title="${po.content}" extendJson="{class:'form-control input-sm'}" <@datatype inputCheck="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" />></t:dictSelect>
			            	<#elseif po.showType=='checkbox'>
			            	<div style="padding-top:5px">
			            	<t:dictSelect id="${namepre}${po.fieldName}" field="${namepre}${po.fieldName}" <#if valuepre != "">defaultVal = "${'$'}{${valuepre}${po.fieldName}}"</#if> <#if tpl=='1'>extendJson="{class:'i-checks-tpl'}"<#else>extendJson="{class:'i-checks'}"</#if> type="checkbox" hasLabel="false"  title="${po.content}" <@dictInfo dictTable="${po.dictTable}" dictField="${po.dictField}" dictText="${po.dictText}" />></t:dictSelect>
			            	</div>
			            	<#elseif po.showType=='date'>
			            	<#if tablestyle=='1'>
			            	<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" type="text" class="form-control input-sm laydate-date" value="<fmt:formatDate pattern='yyyy-MM-dd' type='date' value='${'$'}{${valuepre}${po.fieldName}}'/>" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
			            	<#else>
		            		<div class="input-group input-group-sm">
		            			<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" type="text" class="form-control input-sm laydate-date" value="<fmt:formatDate pattern='yyyy-MM-dd' type='date' value='${'$'}{${valuepre}${po.fieldName}}'/>" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
		            			<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		            		</div>
			            	</#if>
							<#elseif po.showType=='datetime'>
			            	<#if tablestyle=='1'>
			            	<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" type="text" class="form-control input-sm laydate-datetime" value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' type='both' value='${'$'}{${valuepre}${po.fieldName}}'/>" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
			            	<#else>
		            		<div class="input-group input-group-sm">
		            			<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" type="text" class="form-control input-sm laydate-datetime" value="<fmt:formatDate pattern='yyyy-MM-dd HH:mm:ss' type='both' value='${'$'}{${valuepre}${po.fieldName}}'/>" <@datatype showType="2" validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" isNull="${po.isNull}"/> />
		            			<span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
		            		</div>
			            	</#if>
			            	<#-- update--begin--author:liushaoqian Date:20180720 for:TASK #2959 【代码生成器模板】新模板Bootstrap 版本等模板，明细不支持上传附件 （统一改造） -->
			            	<#elseif po.showType=='file' || po.showType=='image'>
			            	 <#if tablestyle != "1">
				            	<@webuploadtag po = po defval="${'$'}{${valuepre}${po.fieldName}}"/>
				            	<#else>
				            		<input onclick="onetomanyUpload('${namepre}${po.fieldName}')" class="btn btn-default" type="button" value="上传附件" />	
									<input id="${namepre}${po.fieldName}" type="hidden" name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if>/>
									<#if valuepre != "">
										<a target="_blank" class=".btn-default"<#rt/>
							            <c:if test="${'$'}{not empty ${valuepre}${po.fieldName}}"><#rt/>
							              href="img/server/${'$'}{${valuepre}${po.fieldName}}?down=true">下载<#rt/>
							            </c:if><#rt/>
							            <c:if test="${'$'}{empty ${valuepre}${po.fieldName}}">></c:if><#rt/>
							            </a><#rt/>
									<#else>
										<a target="_blank" class="btn btn-link"></a>
									</#if>
			            	 </#if>
			            	 <#-- update--end--author:liushaoqian Date:20180720 for:TASK #2959 【代码生成器模板】新模板Bootstrap 版本等模板，明细不支持上传附件 （统一改造） -->
			            	<#-- update--begin--author:zhoujf Date:20180827 for:TASK #3064 popup控件实现 -->
			            	<#elseif po.showType=='popup'>
			            	<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> type="text" class="form-control input-sm" maxlength="${po.length?c}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/> <#if po.dictTable?if_exists?html!=""> onclick="popupClick(this,'${po.dictText}','${po.dictField}','${po.dictTable}')"</#if>/>
			            	<#else>
			            	<#-- update--end--author:zhoujf Date:20180827 for:TASK #3064 popup控件实现 -->
							<input id="${namepre}${po.fieldName}" name="${namepre}${po.fieldName}" <#if valuepre != "">value = "${'$'}{${valuepre}${po.fieldName}}"</#if> type="text" class="form-control input-sm" maxlength="${po.length?c}" <@datatype validType="${po.fieldValidType!''}" isNull="${po.isNull}" type="${po.type}" mustInput="${po.fieldMustInput!''}" tableName="${po.table.tableName}" fieldName="${po.oldFieldName}"/> />
			            	</#if>
</#macro>