select DISTINCT TYPECODE as TYPECODE,  TYPENAME  as TYPENAME 
from t_s_type t,t_s_typegroup  g 
where  g.typegroupcode = :dicCode 
and t.typegroupid =  g.id