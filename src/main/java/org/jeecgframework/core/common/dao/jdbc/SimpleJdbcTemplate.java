package org.jeecgframework.core.common.dao.jdbc;

import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.jdbc.core.simple.SimpleJdbcInsert;
import org.springframework.util.Assert;
/**
 * jdbc模板
 * @author  张代浩
 *
 */
@SuppressWarnings("unchecked")
public class SimpleJdbcTemplate {
	
	protected final Log logger = LogFactory.getLog(getClass());

	protected JdbcTemplate  jdbcTemplate;
	protected NamedParameterJdbcTemplate  namedJdbcTemplate;
	
	protected SimpleJdbcInsert simpleJdbcInsert;
	public SimpleJdbcTemplate(DataSource dataSource){
		jdbcTemplate=new JdbcTemplate(dataSource);
		namedJdbcTemplate = new NamedParameterJdbcTemplate(dataSource);
		simpleJdbcInsert=new SimpleJdbcInsert(dataSource);
	}


	/**
	 * 根据sql语句，返回对象集合
	 * @param sql语句(参数用冒号加参数名，例如select * from tb where id=:id)
	 * @param clazz类型
	 * @param parameters参数集合(key为参数名，value为参数值)
	 * @return bean对象集合
	 */
	public List find(final String sql,Class clazz,Map parameters){
		try{
			Assert.hasText(sql,"sql语句不正确!");
			Assert.notNull(clazz,"集合中对象类型不能为空!");
			if(parameters!=null){
				return jdbcTemplate.query(sql, resultBeanMapper(clazz),parameters);
			}else{
				return jdbcTemplate.query(sql, resultBeanMapper(clazz));
			}
		}catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 根据sql语句，返回对象
	 * @param sql语句(参数用冒号加参数名，例如select * from tb where id=:id)
	 * @param clazz类型
	 * @param parameters参数集合(key为参数名，value为参数值)
	 * @return bean对象
	 */
	public Object findForObject(final String sql,Class clazz,Map parameters){
		try{
			Assert.hasText(sql,"sql语句不正确!");
			Assert.notNull(clazz,"集合中对象类型不能为空!");
			if(parameters!=null){
				return jdbcTemplate.queryForObject(sql, resultBeanMapper(clazz), parameters);
			}else{

				return jdbcTemplate.queryForObject(sql, resultBeanMapper(clazz),Long.class);


			}
		}catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 根据sql语句，返回数值型返回结果
	 * @param sql语句(参数用冒号加参数名，例如select count(*) from tb where id=:id)
	 * @param parameters参数集合(key为参数名，value为参数值)
	 * @return bean对象
	 */
	public long findForLong(final String sql,Map parameters){
		try{
			Assert.hasText(sql,"sql语句不正确!");

			if(parameters!=null){
				return namedJdbcTemplate.queryForObject(sql, parameters,Long.class);
			}else{
				return jdbcTemplate.queryForObject(sql,Long.class);
			}

		}catch (Exception e) {
			return 0;
		}
	}
	
	/**
	 * 根据sql语句，返回Map对象,对于某些项目来说，没有准备Bean对象，则可以使用Map代替Key为字段名,value为值
	 * @param sql语句(参数用冒号加参数名，例如select count(*) from tb where id=:id)
	 * @param parameters参数集合(key为参数名，value为参数值)
	 * @return bean对象
	 */
	public Map findForMap(final String sql,Map parameters){
		try{
			Assert.hasText(sql,"sql语句不正确!");
			if(parameters!=null){
				return jdbcTemplate.queryForMap(sql, parameters);
			}else{
				return jdbcTemplate.queryForMap(sql);
			}
		}catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 根据sql语句，返回Map对象集合
	 * @see findForMap
	 * @param sql语句(参数用冒号加参数名，例如select count(*) from tb where id=:id)
	 * @param parameters参数集合(key为参数名，value为参数值)
	 * @return bean对象
	 */
	public List<Map<String,Object>> findForListMap(final String sql,Map parameters){
		try{
			Assert.hasText(sql,"sql语句不正确!");
			if(parameters!=null){
				return jdbcTemplate.queryForList(sql, parameters);
			}else{
				return jdbcTemplate.queryForList(sql);
			}
		}catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * 执行insert，update，delete等操作<br>
	 * 例如insert into users (name,login_name,password) values(:name,:loginName,:password)<br>
	 * 参数用冒号,参数为bean的属性名
	 * @param sql
	 * @param bean
	 */
	public int executeForObject(final String sql,Object bean){
		Assert.hasText(sql,"sql语句不正确!");
		if(bean!=null){
			return jdbcTemplate.update(sql, paramBeanMapper(bean));
		}else{
			return jdbcTemplate.update(sql);
		}
	}

	/**
	 * 执行insert，update，delete等操作<br>
	 * 例如insert into users (name,login_name,password) values(:name,:login_name,:password)<br>
	 * 参数用冒号,参数为Map的key名
	 * @param sql
	 * @param parameters
	 */
	public int executeForMap(final String sql,Map parameters){
		Assert.hasText(sql,"sql语句不正确!");
		if(parameters!=null){
			return jdbcTemplate.update(sql, parameters);
		}else{
			return jdbcTemplate.update(sql);
		}
	}
	
	/*public long executeForObjectReturnPk(final String sql,Object bean){
		Assert.hasText(sql,"sql语句不正确!");
		if(bean!=null){
			return jdbcTemplate.update(sql, paramBeanMapper(bean));
		}else{
			return jdbcTemplate.update(sql);
		}
	}*/
	
	/*
	 * 批量处理操作
	 * 例如：update t_actor set first_name = :firstName, last_name = :lastName where id = :id
	 * 参数用冒号
	 */
	public int[] batchUpdate(final String sql,List<Object[]> batch ){
        int[] updateCounts = jdbcTemplate.batchUpdate(sql,batch);
        return updateCounts;
	}

	protected BeanPropertyRowMapper resultBeanMapper(Class clazz) {
		return BeanPropertyRowMapper.newInstance(clazz);
	}


	protected BeanPropertySqlParameterSource paramBeanMapper(Object object) {
		return new BeanPropertySqlParameterSource(object);
	}
}
