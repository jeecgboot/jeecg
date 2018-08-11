<#-- 实体属性@Excel注解  -->
<#macro excel po>
	@Excel(name="${po.content}",width=15<#rt/>
<#if po.type == "java.util.Date">
<#if po.showType=='date'>
,format = "yyyy-MM-dd"<#rt/>
<#else>
,format = "yyyy-MM-dd HH:mm:ss"<#rt/>
</#if>
</#if>
<#if po.dictTable?if_exists?html!="" && po.showType?if_exists?html!='popup'>
,dictTable ="${po.dictTable}",dicCode ="${po.dictField}",dicText ="${po.dictText}"<#rt/>
</#if>
<#if po.dictTable?if_exists?html=="" && po.dictField?if_exists?html!="">
,dicCode="${po.dictField}"<#rt/>
</#if>)
</#macro>