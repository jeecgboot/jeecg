<#list subtables as key>

#segment#${subsG['${key}'].entityName?uncap_first}-list.jsp
   <#include "/multitable/onetomany/webapp/webpage/sub_list.ftl"/>
</#list>