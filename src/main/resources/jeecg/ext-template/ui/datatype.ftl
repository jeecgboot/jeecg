<#-- 
	showType: 作废
	inputCheck： 1/生成ignore，2:不生成ignore
  -->
<#macro datatype  showType="1" type="" validType="" isNull="" mustInput="" inputCheck="1">
<#-- validType逻辑 -->
 <#if validType?if_exists?html != ''><#rt/>
 datatype="${validType?if_exists?html}" <#rt/>
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