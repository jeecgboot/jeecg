package org.jeecgframework.web.cgform.dao.config;

import java.util.List;
import java.util.Map;

import org.jeecgframework.minidao.annotation.Arguments;
import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.Sql;
import org.springframework.stereotype.Repository;

/**
 * 
 * @Title:CgFormFieldDao
 * @description:
 * @author 张代浩
 * @date Aug 24, 2013 11:33:33 AM
 * @version V1.0
 */
@Repository("cgFormFieldDao")
public interface CgFormFieldDao {
	
	@Arguments("tableName")
	public List<Map<String, Object>> getCgFormFieldByTableName(String tableName);
	
	@Arguments("tableName")
	public List<Map<String, Object>> getCgFormHiddenFieldByTableName(String tableName);
	
	@Arguments("id")
	@Sql("select count(1) from cgform_head where physice_id=:id ")
	public int getByphysiceId(String id);
	@Arguments("ids")
	@Sql("select count(1) as hasPeizhi,physice_id id from cgform_head where 1=1 and physice_id in (${ids}) group by physice_id")
	public List<Map<String, Object>> getPeizhiCountByIds(String ids);
	
}
