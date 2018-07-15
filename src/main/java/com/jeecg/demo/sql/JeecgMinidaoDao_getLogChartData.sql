SELECT
	broswer as name,
	count(1) as 'value',
	CASE
WHEN broswer = 'Firefox' THEN
	'#FF00FF'
WHEN broswer = 'IE' THEN
	'#FFFF00'
ELSE
	'#43CD80'
END as color
FROM
	t_s_log
GROUP BY
	broswer;