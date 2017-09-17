<#list columnDatas as item>
<#if item.columnKey != 'PRI'>
	<#if item.columnType == "datetime" ||item.columnType == "date" || item.columnType == "timestamp">
	    ${"<#if ("} ${lowerName}.${item.domainPropertyName} ${")??>"}
		    /* ${item.columnComment} */
			and ${tablesAsName}.${item.columnName} = :${lowerName}.${item.domainPropertyName}
		${"</#if>"}
	<#else>
		${"<#if ("} ${lowerName}.${item.domainPropertyName} ${")?? &&"} ${lowerName}.${item.domainPropertyName} ${"?length gt 0>"}
		    /* ${item.columnComment} */
			and ${tablesAsName}.${item.columnName} = :${lowerName}.${item.domainPropertyName}
		${"</#if>"}
	</#if>
</#if>
</#list>