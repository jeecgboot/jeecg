SELECT * FROM jeecg_demo WHERE 1=1
<#if jeecgDemo.name ?exists && jeecgDemo.name ?length gt 0>
	and name = :jeecgDemo.name
</#if>
<#if jeecgDemo.age ?exists && jeecgDemo.age ?length gt 0>
	and age = :jeecgDemo.age
</#if>
<#if jeecgDemo.depId ?exists && jeecgDemo.depId ?length gt 0>
	and dep_id = :jeecgDemo.depId
</#if>
<#if jeecgDemo.email ?exists && jeecgDemo.email ?length gt 0>
	and email = :jeecgDemo.email
</#if>
<#if jeecgDemo.phone ?exists && jeecgDemo.phone ?length gt 0>
	and phone = :jeecgDemo.phone
</#if>
<#if jeecgDemo.salary ?exists && jeecgDemo.salary ?length gt 0>
	and salary = :jeecgDemo.salary
</#if>
<#if jeecgDemo.sex ?exists && jeecgDemo.sex ?length gt 0>
	and sex = :jeecgDemo.sex
</#if>
<#if jeecgDemo.status ?exists && jeecgDemo.status ?length gt 0>
	and status = :jeecgDemo.status
</#if>
<#if authSql ?exists && authSql ?length gt 0>
	${authSql}
</#if>
