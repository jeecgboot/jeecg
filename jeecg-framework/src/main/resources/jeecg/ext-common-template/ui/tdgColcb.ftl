<#-- 表单列表当中每一列的处理 -->
<#macro dgcol columns noquery = "">
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
 <#if po.dictTable?if_exists?html!=""><#rt/>
 dictionary="${po.dictTable},${po.dictField?replace(',', '@')},${po.dictText?replace(',', '@')}" <#rt/>
<#if po.showType=='popup'><#rt/>
 popup="true" <#rt/>
</#if><#rt/>
 <#else><#rt/>
<#if po.dictTable?if_exists?html=="" && po.dictField?if_exists?html!=""><#rt/>
 dictionary="${po.dictField}" filterType="combobox" extendParams="editor:'combobox'"<#rt/>
<#else>
 <#if po.type?if_exists?html =='java.util.Date'><#rt/>
 filterType="datebox" extendParams="editor:{type:'datebox',options:{onShowPanel:initDateboxformat}}"<#rt/>
 <#elseif po.type?if_exists?html =='java.lang.Integer'><#rt/>
 filterType="numberbox" extendParams="editor:'numberbox'"<#rt/>
 <#elseif po.type?if_exists?html =='java.math.BigDecimal'><#rt/>
 filterType="numberbox" extendParams="editor:{type:'validatebox',options:{validType:'decimalTwo'}}"<#rt/>
 <#elseif po.type?if_exists?html =='java.lang.Double'><#rt/>
 filterType="numberbox" extendParams="editor:{type:'validatebox',options:{validType:'decimalTwo'}}"<#rt/>
 <#else>
 extendParams="editor:'text'"<#rt/>
 </#if><#rt/>
</#if><#rt/>
 </#if><#rt/>
 <#if po.showType?index_of("image") != -1><#rt/>
 image="true" imageSize="50,50" formatterjs="formatterImg"<#rt/>
 <#elseif po.showType?index_of("file") != -1><#rt/>
 downloadName="附件下载" formatterjs="formatterFile"<#rt/>
 <#elseif po.showType?index_of("tree") != -1><#rt/>
 formatterjs="treeFormater"<#rt/>
 </#if><#rt/>
 width="${po.fieldLength}"></t:dgCol>
 </#list>
</#macro>