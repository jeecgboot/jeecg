UPDATE jeecg_p3demo
SET 
	   <#if jeecgP3demo.createName ?exists>
		   create_name = :jeecgP3demo.createName,
		</#if>
	   <#if jeecgP3demo.createBy ?exists>
		   create_by = :jeecgP3demo.createBy,
		</#if>
	    <#if jeecgP3demo.createDate ?exists>
		   create_date = :jeecgP3demo.createDate,
		</#if>
	   <#if jeecgP3demo.updateName ?exists>
		   update_name = :jeecgP3demo.updateName,
		</#if>
	   <#if jeecgP3demo.updateBy ?exists>
		   update_by = :jeecgP3demo.updateBy,
		</#if>
	    <#if jeecgP3demo.updateDate ?exists>
		   update_date = :jeecgP3demo.updateDate,
		</#if>
	   <#if jeecgP3demo.sysOrgCode ?exists>
		   sys_org_code = :jeecgP3demo.sysOrgCode,
		</#if>
	   <#if jeecgP3demo.sysCompanyCode ?exists>
		   sys_company_code = :jeecgP3demo.sysCompanyCode,
		</#if>
	   <#if jeecgP3demo.bpmStatus ?exists>
		   bpm_status = :jeecgP3demo.bpmStatus,
		</#if>
	   <#if jeecgP3demo.name ?exists>
		   name = :jeecgP3demo.name,
		</#if>
	   <#if jeecgP3demo.sex ?exists>
		   sex = :jeecgP3demo.sex,
		</#if>
	   <#if jeecgP3demo.age ?exists>
		   age = :jeecgP3demo.age,
		</#if>
	   <#if jeecgP3demo.address ?exists>
		   address = :jeecgP3demo.address,
		</#if>
	   <#if jeecgP3demo.phone ?exists>
		   phone = :jeecgP3demo.phone,
		</#if>
	   <#if jeecgP3demo.memo ?exists>
		   memo = :jeecgP3demo.memo,
		</#if>
WHERE id = :jeecgP3demo.id