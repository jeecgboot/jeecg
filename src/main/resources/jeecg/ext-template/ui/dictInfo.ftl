<#macro dictInfo dictTable="" dictField="" dictText="">
<#if dictTable?if_exists?html != ''><#rt/>
 dictTable="${dictTable?if_exists?html}" dictField="${dictField?if_exists?html}" dictText="${dictText?if_exists?html}" <#rt/>
<#else><#rt/>
 typeGroupCode="${dictField}" <#rt/>
</#if><#rt/>
</#macro>