		<#if ( jeecgP3demo.createName )?? && jeecgP3demo.createName ?length gt 0>
		    /* 创建人名称 */
			and jp.create_name = :jeecgP3demo.createName
		</#if>
		<#if ( jeecgP3demo.createBy )?? && jeecgP3demo.createBy ?length gt 0>
		    /* 创建人登录名称 */
			and jp.create_by = :jeecgP3demo.createBy 
		</#if>
	    <#if ( jeecgP3demo.createDate )??>
		    /* 创建日期 */
			and jp.create_date = :jeecgP3demo.createDate
		</#if>
		<#if ( jeecgP3demo.updateName )?? && jeecgP3demo.updateName ?length gt 0>
		    /* 更新人名称 */
			and jp.update_name = :jeecgP3demo.updateName 
		</#if>
		<#if ( jeecgP3demo.updateBy )?? && jeecgP3demo.updateBy ?length gt 0>
		    /* 更新人登录名称 */
			and jp.update_by = :jeecgP3demo.updateBy 
		</#if>
	    <#if ( jeecgP3demo.updateDate )??>
		    /* 更新日期 */
			and jp.update_date = :jeecgP3demo.updateDate
		</#if>
		<#if ( jeecgP3demo.sysOrgCode )?? && jeecgP3demo.sysOrgCode ?length gt 0>
		    /* 所属部门 */
			and jp.sys_org_code = :jeecgP3demo.sysOrgCode 
		</#if>
		<#if ( jeecgP3demo.sysCompanyCode )?? && jeecgP3demo.sysCompanyCode ?length gt 0>
		    /* 所属公司 */
			and jp.sys_company_code = :jeecgP3demo.sysCompanyCode
		</#if>
		<#if ( jeecgP3demo.bpmStatus )?? && jeecgP3demo.bpmStatus ?length gt 0>
		    /* 流程状态 */
			and jp.bpm_status = :jeecgP3demo.bpmStatus 
		</#if>
		<#if ( jeecgP3demo.name )?? && jeecgP3demo.name ?length gt 0>
		    /* 姓名 */
			and jp.name  = :jeecgP3demo.name 
		</#if>
		<#if ( jeecgP3demo.sex )?? && jeecgP3demo.sex ?length gt 0>
		    /* 性别 */
			and jp.sex = :jeecgP3demo.sex 
		</#if>
		<#if ( jeecgP3demo.age )?? && jeecgP3demo.age ?length gt 0>
		    /* 年龄 */
			and jp.age = :jeecgP3demo.age 
		</#if>
		<#if ( jeecgP3demo.address )?? && jeecgP3demo.address ?length gt 0>
		    /* 地址 */
			and jp.address = :jeecgP3demo.address 
		</#if>
		<#if ( jeecgP3demo.phone )?? && jeecgP3demo.phone ?length gt 0>
		    /* 电话 */
			and jp.phone = :jeecgP3demo.phone
		</#if>
		<#if ( jeecgP3demo.memo )?? && jeecgP3demo.memo ?length gt 0>
		    /* 备注 */
			and jp.memo = :jeecgP3demo.memo
		</#if>
