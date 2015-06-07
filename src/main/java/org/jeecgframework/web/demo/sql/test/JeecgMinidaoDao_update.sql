UPDATE jeecg_minidao 
SET
<#if jeecgMinidao.age ?exists && jeecgMinidao.age ?length gt 0>
	age=:jeecgMinidao.age,
</#if>
<#if jeecgMinidao.userName ?exists && jeecgMinidao.userName ?length gt 0>
	 userName=:jeecgMinidao.userName
</#if>
WHERE id=:jeecgMinidao.id