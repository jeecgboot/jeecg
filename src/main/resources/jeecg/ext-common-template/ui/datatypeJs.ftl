<#-- 
	showType: 作废
	tableName:DB表名
	fieldName：DB列名
	idFieldName：DB表中ID列名
	descrip:描述
  -->
<#macro datatypeJs po descriptb="" idFieldName="id">
<#-- validType逻辑 -->
 <#local descrip="请填写【${descriptb}】-[${po.content}]"/>
 <#local ref=po.fieldName/>
 <#local validType="${po.fieldValidType!''}"/>
 <#local isNull="${po.isNull}"/>
 <#local type="${po.type}"/>
 <#local mustInput="${po.fieldMustInput!''}"/>
 <#local tableName=po.table.tableName/>
 <#local fieldName=po.oldFieldName/>
 <#if validType?if_exists?html != ''><#rt/>
 	<#if validType?if_exists?html=='only'><#rt/>
	 				$("input[name='${ref}']").each(function(){
	 					if(!$(this).attr("datatype")){
	 						$(this).attr("datatype","*").attr("validType","${tableName},${fieldName},${idFieldName}");
	 					}
	 				});
	<#else><#rt/>
			<#if validType?if_exists?html == "*">
				$("input[name='${ref}']").each(function(){
 					if(!$(this).attr("datatype")){
 						$(this).attr("datatype","*").attr("nullmsg","${descrip}");
 					}
 				});
			<#else><#rt/>
				$("input[name='${ref}']").each(function(){
 					if(!$(this).attr("datatype")){
 						$(this).attr("datatype","${validType?if_exists?html}").attr("ignore","ignore");
 					}
 				});
			</#if><#rt/>
	</#if><#rt/>
 <#elseif type == 'java.lang.Integer'><#rt/>
 				$("input[name='${ref}']").each(function(){
 					if(!$(this).attr("datatype")){
 						$(this).attr("datatype","n").attr("ignore","ignore");
 					}
 				});
 <#elseif type=='java.lang.Double'><#rt/>
 				$("input[name='${ref}']").each(function(){
 					if(!$(this).attr("datatype")){
 						$(this).attr("datatype","/^(-?\d+)(\.\d+)?$/").attr("ignore","ignore");
 					}
 				});
 <#elseif isNull != 'Y'><#rt/>
 				$("input[name='${ref}']").each(function(){
 					if(!$(this).attr("datatype")){
 						$(this).attr("datatype","*").attr("nullmsg","${descrip}");
 					}
 				});
 </#if>
</#macro>