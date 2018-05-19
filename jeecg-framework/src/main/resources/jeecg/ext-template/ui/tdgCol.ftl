<#-- 表单列表当中每一列的处理 -->
<#macro dgcol columns>
 <#list columns as po><#rt/>
   <t:dgCol title="${po.content}" <#rt/>
 field="${po.fieldName}" <#rt/>
 <#if po.showType?index_of("datetime")!=-1><#rt/>
 formatter="yyyy-MM-dd hh:mm:ss" <#rt/>
 <#else><#rt/>
<#if po.showType?index_of("date")!=-1><#rt/>
 formatter="yyyy-MM-dd" <#rt/>
</#if><#rt/>
 </#if><#rt/>
 <#if po.isShowList?if_exists?html =='N'><#rt/>
 hidden="true" <#rt/>
 <#else><#rt/>
 </#if><#rt/>
 <#if po.isQuery =='Y'><#rt/>
 query="true" <#rt/>
 </#if><#rt/>
 <#if po.queryMode =='single'><#rt/>
 queryMode="single" <#rt/>
 <#elseif po.queryMode =='group'><#rt/>
 queryMode="group" <#rt/>
 </#if><#rt/>
 <#if po.dictTable?if_exists?html!=""><#rt/>
 <#-- update--begin--author:gj_shaojc date:20180313 for:TASK #2526 【问题确认】[Online开发] 3.7.2,popup,当字典Text为多个值时,查询条件的input框值为undefined -->
 <#-- update--begin--author:zhoujf date:20180413 for:TASK #2641 【popup重构问题】popup查询条件多字段回填问题-->
 dictionary="${po.dictTable},${po.dictField?replace(',', '@')},${po.dictText?replace(',', '@')}" <#rt/>
 <#-- update--end--author:zhoujf date:20180413 for:TASK #2641 【popup重构问题】popup查询条件多字段回填问题-->
<#-- update--begin--author:gj_shaojc date:20180313 for:TASK #2526 【问题确认】[Online开发] 3.7.2,popup,当字典Text为多个值时,查询条件的input框值为undefined -->
<#if po.showType=='popup'><#rt/>
 popup="true" <#rt/>
</#if><#rt/>
 <#else><#rt/>
<#if po.dictTable?if_exists?html=="" && po.dictField?if_exists?html!=""><#rt/>
 dictionary="${po.dictField}" <#rt/>
</#if><#rt/>
 </#if><#rt/>
 <#if po.showType?index_of("image") != -1><#rt/>
 image="true" imageSize="50,50" <#rt/>
 <#elseif po.showType?index_of("file") != -1><#rt/>
 downloadName="附件下载" <#rt/>
 <#-- update--begin--author:zhangjiaqiang date:20170815 for:TASK #2274 【online】Online 表单支持树控件 -->
 <#elseif po.showType?index_of("tree") != -1><#rt/>
 formatterjs="treeFormater"<#rt/>
<#-- update--end--author:zhangjiaqiang date:20170815 for:TASK #2274 【online】Online 表单支持树控件 -->
 </#if><#rt/>
 width="${po.fieldLength}"></t:dgCol>
 </#list>
</#macro>