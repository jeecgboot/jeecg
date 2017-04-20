SELECT 
a.userid as id,
b.username as name,
	count(*) as ct,
	sum(
		CASE
		WHEN RIGHT (logcontent, 4) IN ('登录成功', 'cess') THEN
			1
		ELSE
			0
		END
	) as loginct,
	sum(
		CASE
		WHEN RIGHT (logcontent, 2) = '退出' THEN
			1
		ELSE
			0
		END
	) as outct,
	sum(
		CASE
		WHEN RIGHT (logcontent, 4) IN ('删除成功', '更新成功','录入成功') THEN
			1
		ELSE
			0
		END
	) as xgct
FROM
	t_s_log a join t_s_base_user b on b.id=a.userid 
GROUP BY
	a.userid
ORDER BY
	ct DESC
