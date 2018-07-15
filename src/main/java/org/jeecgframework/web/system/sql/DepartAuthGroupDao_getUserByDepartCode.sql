SELECT
	t.id,
	t.email,
	t.mobilePhone,
	t.officePhone,
	t.signatureFile,
	t.update_name,
	t.update_date,
	t.update_by,
	t.create_name,
	t.create_date,
	t.create_by,
	t.portrait,
	t.imsign,
	t.dev_flag,
	t.user_type,
	t.person_type,
	t.sex,
	t.emp_no,
	t.citizen_no,
	t.fax,
	t.address,
	t.post,
	t.memo,
	c.activitiSync,
	c.browser,
	c.password,
	c.realname,
	c.signature,
	c.status,
	c.userkey,
	c.username,
	c.departid,
	c.user_name_en,
	c.delete_flag
FROM
	t_s_user t,
	t_s_base_user c
WHERE
    c.delete_flag = 0
AND t.user_type = '1'
AND t.id = c.id
AND t.id IN (
	SELECT
		user_id
	FROM
		t_s_user_org
	WHERE
		org_id IN (
			SELECT
				id
			FROM
				t_s_depart
				<#if orgCode?? && orgCode?length gt 0>
				WHERE org_code LIKE CONCAT(:orgCode , '%')
				</#if>
			
		)
)
<#if ( u.userName )?? && u.userName ?length gt 0>
	and c.username  like  :u.userName 
</#if>
<#if ( u.realName )?? && u.realName ?length gt 0>
	and c.realname  like  :u.realName 
</#if>

