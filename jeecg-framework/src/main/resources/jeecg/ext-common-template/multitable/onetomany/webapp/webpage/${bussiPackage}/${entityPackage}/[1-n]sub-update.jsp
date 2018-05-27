<#list subtables as key>

#segment#${subsG['${key}'].entityName?uncap_first}-update.jsp
   <#include "/multitable/onetomany/webapp/webpage/sub_update.ftl"/>
</#list>