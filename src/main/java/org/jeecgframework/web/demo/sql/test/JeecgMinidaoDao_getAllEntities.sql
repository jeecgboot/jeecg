SELECT * FROM jeecg_minidao WHERE 1=1
<#if jeecgMinidao.userName ?exists && jeecgMinidao.userName ?length gt 0>
	and user_name = :jeecgMinidao.userName
</#if>
<#if jeecgMinidao.mobilePhone ?exists && jeecgMinidao.mobilePhone ?length gt 0>
	and mobile_phone = :jeecgMinidao.mobilePhone
</#if>
<#if jeecgMinidao.officePhone ?exists && jeecgMinidao.officePhone ?length gt 0>
	and office_phone = :jeecgMinidao.officePhone
</#if>
<#if jeecgMinidao.email ?exists && jeecgMinidao.email ?length gt 0>
	and email = :jeecgMinidao.email
</#if>
<#if jeecgMinidao.age ?exists && jeecgMinidao.age ?length gt 0>
	and age = :jeecgMinidao.age
</#if>
<#if jeecgMinidao.salary ?exists && jeecgMinidao.salary ?length gt 0>
	and salary = :jeecgMinidao.salary
</#if>
<#if jeecgMinidao.sex ?exists && jeecgMinidao.sex ?length gt 0>
	and sex = :jeecgMinidao.sex
</#if>
<#if jeecgMinidao.status ?exists && jeecgMinidao.status ?length gt 0>
	and status = :jeecgMinidao.status
</#if>
