INSERT  INTO
	${tableName}
      ( 
<#list columnDatas as item>
	<#assign x="${item.columnName?length}" /> 
	<#if item_index==0>
${"      "}${item.columnName}${"                              "?substring(item.columnName?length)}
	<#elseif item_index gt 0>
${"      "},${item.columnName}${"                              "?substring(item.columnName?length)} 
	</#if>
</#list> 
      ) 
values
      (
<#list columnDatas as item>
	<#if item_index==0>
${"      "}${":"}${lowerName}.${item.domainPropertyName}${"                              "?substring(item.domainPropertyName?length)}
	<#elseif item_index gt 0>
${"      "},${":"}${lowerName}.${item.domainPropertyName}${"                              "?substring(item.domainPropertyName?length)}
	</#if>
</#list>
      )