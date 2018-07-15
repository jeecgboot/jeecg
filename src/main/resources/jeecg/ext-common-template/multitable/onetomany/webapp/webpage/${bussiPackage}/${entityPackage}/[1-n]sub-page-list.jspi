<#list subtables as key>

#segment#page-${subsG['${key}'].entityName?uncap_first}.jsp
	<#if subsG['${key}'].cgFormHead.relationType==1 >
	    <#include "/multitable/onetomany/webapp/webpage/sub_page_list_one2one.ftl"/>
	<#else>
	    <#include "/multitable/onetomany/webapp/webpage/sub_page_list_one2many.ftl"/>
	</#if>
</#list>