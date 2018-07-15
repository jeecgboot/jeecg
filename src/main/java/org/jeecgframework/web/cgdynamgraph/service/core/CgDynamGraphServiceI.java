package org.jeecgframework.web.cgdynamgraph.service.core;

import java.util.List;
import java.util.Map;

import org.jeecgframework.core.common.service.CommonService;

/**
 * 
 * @Title:CgDynamGraphServiceI
 * @description:动态报表服务接口
 * @author 赵俊夫
 * @date Jul 30, 2013 8:43:01 AM
 * @version V1.0
 */
public interface CgDynamGraphServiceI extends CommonService{
	/**
	 * 根据报表的ID获得报表的抬头配置以及明细配置
	 * @param reportId
	 * @return
	 */
	public Map<String,Object> queryCgDynamGraphConfig(String reportId);
	/**
	 * 根据报表id获得报表抬头配置
	 * @param reportId
	 * @return
	 */
	public Map<String,Object> queryCgDynamGraphMainConfig(String reportId);
	/**
	 * 根据报表id获得报表明细配置
	 * @param reportId
	 * @return
	 */
	public List<Map<String,Object>> queryCgDynamGraphItems(String reportId);
	/**
	 * 执行报表SQL获取结果集
	 * @param sql 报表SQL
	 * @param params 查询条件
	 * @param page 页面数
	 * @param rows 要获取的条目总数
	 * @return
	 */

	public List<Map<String,Object>> queryByCgDynamGraphSql(String sql,Map params,Map<String,Object> paramData);

	/**
	 * 获取报表sql结果集大小
	 * @param sql 报表SQL
	 * @param params 查询条件
	 * @return
	 */

	public long countQueryByCgDynamGraphSql(String sql,Map params,Map<String,Object> paramData);

	/**
	 * 通过执行sql获得该sql语句中的字段集合
	 * @param sql 报表sql
	 * @return
	 */
	public List<String> getSqlFields(String sql);
}
