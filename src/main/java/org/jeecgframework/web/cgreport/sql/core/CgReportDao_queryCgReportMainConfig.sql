select 
ch.id as id,
ch.code as code,
ch.name as name,
ch.cgr_sql as cgreport_sql,
ch.content as content,
ch.db_source,
ch.pop_retype
from jform_cgreport_head ch
where ch.code =:id