package org.jeecgframework.web.cgform.service.config;

import org.springframework.jdbc.core.JdbcTemplate;

import org.jeecgframework.web.cgform.entity.config.CgFormFieldEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;


/**
 * 表的操作
 * @author jueyue
 *
 */
public interface DbTableServiceI {
	
	/**
	 * 创建表
	 * @param tableProperty
	 * @return SQL
	 */
	String createTableSQL(CgFormHeadEntity tableProperty);
	
	/**
	 * 删除表
	 * @param tableProperty
	 * @return SQL
	 */
	String dropTableSQL(CgFormHeadEntity tableProperty);
	/**
	 * 判断表格是否存在
	 * @param tableName
	 * @return SQL
	 */
	String createIsExitSql(String tableName);
	/**
	 * 更新表
	 * @param cgFormHead
	 * @param jdbcTemplate 
	 * @return SQL
	 */
	String updateTableSQL(CgFormHeadEntity cgFormHead, JdbcTemplate jdbcTemplate);

}
