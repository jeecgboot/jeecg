<#list subtables as key>

#segment#${subsG['${key}'].entityName?uncap_first}-add.jsp
   <#include "/multitable/onetomany/webapp/webpage/sub_add.ftl"/>
</#list>