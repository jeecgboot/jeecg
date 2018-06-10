package org.jeecgframework.web.cgreport.service.core;

import java.util.List;
import java.util.Map;

import org.jeecgframework.core.common.service.CommonService;

/**
 * 
 * @Title:CgReportServiceI
 * @description:动态报表服务接口
 * @author 赵俊夫
 * @date Jul 30, 2013 8:43:01 AM
 * @version V1.0
 */
public interface CgReportServiceI extends CommonService{
	/**
	 * 根据报表的ID获得报表的抬头配置以及明细配置
	 * @param reportId
	 * @return
	 */
	public Map<String,Object> queryCgReportConfig(String reportId);
	/**
	 * 根据报表id获得报表抬头配置
	 * @param reportId
	 * @return
	 */
	public Map<String,Object> queryCgReportMainConfig(String reportId);
	/**
	 * 根据报表id获得报表明细配置
	 * @param reportId
	 * @return
	 */
	public List<Map<String,Object>> queryCgReportItems(String reportId);
	/**
	 * 执行报表SQL获取结果集
	 * @param sql 报表SQL
	 * @param params 查询条件
	 * @param page 页面数
	 * @param rows 要获取的条目总数
	 * @return
	 */
	public List<Map<String,Object>> queryByCgReportSql(String sql,Map params,int page,int rows);
	/**
	 * 获取报表sql结果集大小
	 * @param sql 报表SQL
	 * @param params 查询条件
	 * @return
	 */
	public long countQueryByCgReportSql(String sql,Map params);
	/**
	 * 通过执行sql获得该sql语句中的字段集合
	 * @param sql 报表sql
	 * @return
	 */
	public List<String> getSqlFields(String sql);
	/**
	 * 解析sql字段，支持多数据源
	 * @param sql
	 * @param dbKey
	 * @return
	 */
	public List<String> getFields(String sql, String dbKey);
	/**
	 * 解析sql参数
	 * @param sql
	 * @return
	 */
	public List<String> getSqlParams(String sql);
	
	/**
	 * 加载字典
	 * @param fl
	 * @param fl2
	 */
	public void loadDic(Map<String, Object> fl);
	public void dealDic(List<Map<String, Object>> result, List<Map<String, Object>> items);
	public void dealReplace(List<Map<String, Object>> result, List<Map<String, Object>> items);
}
