package org.jeecgframework.web.system.service.impl;
import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.annotation.Ehcache;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.system.pojo.base.TSDictTableConfigEntity;
import org.jeecgframework.web.system.service.TSDictTableConfigServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

/**
 * 字典表授权配置
 * @author zhoujf
 *
 */
@Service("tSDictTableConfigService")
@Transactional
public class TSDictTableConfigServiceImpl extends CommonServiceImpl implements TSDictTableConfigServiceI {

	@Autowired
	private NamedParameterJdbcTemplate namedParameterJdbcTemplate;
	
 	public void delete(TSDictTableConfigEntity entity) throws Exception{
 		super.delete(entity);
 	}
 	
 	public Serializable save(TSDictTableConfigEntity entity) throws Exception{
 		Serializable t = super.save(entity);
 		return t;
 	}
 	
 	public void saveOrUpdate(TSDictTableConfigEntity entity) throws Exception{
 		super.saveOrUpdate(entity);
 	}

	@Override
	@Ehcache(cacheName="dictTableConfigCache")
	public boolean checkDictAuth(String dictionary, String dictCondition) {
		String[] dic = dictionary.split(",");
		//根据自定义字典信息查询授权配置信息
		String hql = "from TSDictTableConfigEntity where tableName = ? and valueCol = ? and textCol = ? and isvalid = 'Y'";
		List<TSDictTableConfigEntity> list = this.findHql(hql, dic[0],dic[1],dic[2]);
		/*String dictConditionPram = dictCondition;
		if(dictConditionPram!=null){
			dictConditionPram = StringUtils.deleteWhitespace(dictConditionPram);
		}else{
			dictConditionPram = "";
		}
		String dicString = "";
		for(TSDictTableConfigEntity config:list){
			dicString = config.getDictCondition();
			if(dicString!=null){
				dicString = StringUtils.deleteWhitespace(dicString);
			}else{
				dicString = "";
			}
			if(dicString.equals(dictConditionPram)){
				return true;
			}
		}*/
		if(list!=null&&list.size()>0){
			return true;
		}
		return false;
	}

	@Override
	public Object getDictText(String dictionary, String dictCondition,String value) {

		Object text = "--";

		try {
			//自定义字典处理
			String[] dic = dictionary.split(",");
			String sql = "select " + dic[1] + " as field," + dic[2]+ " as text from " + dic[0];
			if(!StringUtil.isEmpty(dictCondition)){
				filterContent(dictCondition);
				sql += " "+dictCondition;
				sql += " and "+dic[1]+" = ? ";
			}else{
				sql += " where "+dic[1]+" = ? ";
			}
			List<Map<String, Object>> list = this.findForJdbc(sql,value);
			if(list!=null&&list.size()>0){
				text = list.get(0).get("text");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return text;
	}
	
	
	/**
     * sql注入过滤处理，遇到注入关键字抛异常
     * @param value
     * @return
     */
    private void filterContent(String value)  {  
        if(value == null || "".equals(value)){  
            return ;  
        }  
        value = value.toLowerCase();//统一转为小写  
        String xssStr = "exec |insert |delete |update |drop |truncate |declare |;";
        String[] xssArr = xssStr.split("\\|");  
        for(int i=0;i<xssArr.length;i++){  
            if(value.indexOf(xssArr[i])>-1){  
                throw new RuntimeException("请注意,值可能存在SQL注入风险!--->"+value); 
            }  
        }  
        return ;  
    }  
 	
}