select 
ci.id as id,
ci.field_name as field_name,
ci.field_txt as field_txt,
ci.field_href as field_href,
ci.is_show as is_show,
ci.field_type as field_type,
ci.replace_va as replace_value,
ci.dict_code as dict_code,
ci.s_flag  as search_flag,
ci.s_mode as search_mode,
ci.cgrhead_id as cgreport_head_id
from jform_cgreport_item ci,jform_cgreport_head ch 
where 1=1
and ci.cgrhead_id = ch.id
and ch.code =:configId
order by ci.order_num asc