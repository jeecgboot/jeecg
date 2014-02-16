package org.jeecgframework.core.extend.hqlsearch.parse;

import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;

/**
 * 解析拼装
 * 
 * @author JueYue
 * @date 2014年1月17日
 * @version 1.0
 */
public interface IHqlParse {
	/**
	 * 单值组装
	 * 
	 * @date 2014年1月17日
	 * @param name
	 * @param value
	 */
	public void addCriteria(CriteriaQuery cq, String name, Object value);

	/**
	 * 范围组装
	 * 
	 * @date 2014年1月17日
	 * @param name
	 * @param value
	 * @param beginValue
	 * @param endValue
	 */
	public void addCriteria(CriteriaQuery cq, String name, Object value,
			String beginValue, String endValue);

}
