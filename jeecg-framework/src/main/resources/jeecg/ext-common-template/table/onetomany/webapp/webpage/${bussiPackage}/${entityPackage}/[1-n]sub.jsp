<#list subtables as key>

#segment#${subsG['${key}'].entityName?uncap_first}List.jsp
<#if subsG['${key}'].cgFormHead.relationType==1 >
    <#include "/table/onetomany/webapp/webpage/sub_one2one.ftl"/>
    <#else>
    <#include "/table/onetomany/webapp/webpage/sub_one2many.ftl"/>
</#if>
</#list>