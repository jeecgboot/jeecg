<#-- 
	showType: 作废
	inputCheck： 1/生成ignore，2:不生成ignore
	tableName:DB表名
	fieldName：DB列名
	idFieldName：DB表中ID列名
  -->
<#macro datatype  showType="1" type="" validType="" isNull="" mustInput="" inputCheck="1" tableName="" fieldName="" idFieldName="id">
<#-- validType逻辑 -->
 <#if validType?if_exists?html != ''><#rt/>
 	<#-- update--begin--author:Yandong Date:20180226 for:TASK #2513 【bug】代码生成器，新添加的online唯一校验生成代码问题-->
 	<#if validType?if_exists?html=='only'><#rt/>
 validType="${tableName},${fieldName},${idFieldName}" datatype="*"<#rt/>
	<#else><#rt/>
 datatype="${validType?if_exists?html}"<#rt/>
	</#if><#rt/>
	<#-- update--end--author:Yandong Date:20180226 for:TASK #2513 【bug】代码生成器，新添加的online唯一校验生成代码问题 -->
 <#elseif type == 'java.lang.Integer'><#rt/>
 datatype="n" <#rt/>
 <#elseif type=='java.lang.Double'><#rt/>
 datatype="/^(-?\d+)(\.\d+)?$/" <#rt/>
 <#elseif isNull != 'Y'><#rt/>
 datatype="*" <#rt/>
 </#if>
<#-- ignore逻辑 -->
<#if inputCheck == "1"><#rt/>
 <#if mustInput??><#rt/>
  <#if mustInput == 'Y' || isNull != 'Y'><#rt/>
 ignore="checked" <#rt/>
  <#else><#rt/>
 ignore="ignore" <#rt/>
  </#if><#rt/>
  <#else><#rt/>
 ignore="ignore" <#rt/>
 </#if><#rt/>
</#if><#rt/>
</#macro>