<#if cgformConfig.cgFormHead.relationType==1 >
    <#include "cgform_jspSubTemplate_one2one.ftl">
    <#else>
    <#include "cgform_jspSubTemplate_one2many.ftl">
</#if>