UPDATE ${tableName}
SET 
<#list columnDatas as item>
<#if item.columnKey !='PRI' >
	<#if item.columnType == "datetime" ||item.columnType == "date" || item.columnType == "timestamp">
	    ${"<#if"} ${lowerName}.${item.domainPropertyName} ${"?exists>"}
		   ${item.columnName} = :${lowerName}.${item.domainPropertyName},
		${"</#if>"}
	<#else>
	   ${"<#if"} ${lowerName}.${item.domainPropertyName} ${"?exists>"}
		   ${item.columnName} = :${lowerName}.${item.domainPropertyName},
		${"</#if>"}
	</#if>
</#if>
</#list>
WHERE id = ${":"}${lowerName}.id