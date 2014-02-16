package org.jeecgframework.core.extend.hqlsearch.parse.impl;

import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.extend.hqlsearch.parse.IHqlParse;

public class StringParseImpl implements IHqlParse {

	private static final String SUFFIX_COMMA = ",";
	private static final String SUFFIX_KG = " ";
	/** 模糊查询符号 */
	private static final String SUFFIX_ASTERISK = "*";
	private static final String SUFFIX_ASTERISK_VAGUE = "%";
	/** 不等于查询符号 */
	private static final String SUFFIX_NOT_EQUAL = "!";
	private static final String SUFFIX_NOT_EQUAL_NULL = "!NULL";

	
	public void addCriteria(CriteriaQuery cq, String name, Object value) {
		String searchValue = null;
		if (value != null && (searchValue = value.toString().trim()) != "") {
			// [1].In 多个条件查询{逗号隔开参数}
			if (searchValue.indexOf(SUFFIX_COMMA) >= 0) {
				// 页面输入查询条件，情况（取消字段的默认条件）
				if (searchValue.indexOf(SUFFIX_KG) >= 0) {
					String val = searchValue.substring(searchValue
							.indexOf(SUFFIX_KG));
					cq.eq(name, val);
				} else {
					String[] vs = searchValue.split(SUFFIX_COMMA);
					cq.in(name, vs);
				}
			}
			// [2].模糊查询{带有* 星号的参数}
			else if (searchValue.indexOf(SUFFIX_ASTERISK) >= 0) {
				cq.like(name, searchValue.replace(SUFFIX_ASTERISK,
						SUFFIX_ASTERISK_VAGUE));
			}
			// [3].不匹配查询{等于！叹号}
			// (1).不为空字符串
			else if (searchValue.equals(SUFFIX_NOT_EQUAL)) {
				cq.isNotNull(name);
			}
			// (2).不为NULL
			else if (searchValue.toUpperCase().equals(SUFFIX_NOT_EQUAL_NULL)) {
				cq.isNotNull(name);
			}
			// (3).正常不匹配
			else if (searchValue.indexOf(SUFFIX_NOT_EQUAL) >= 0) {
				cq.notEq(name, searchValue.replace(SUFFIX_NOT_EQUAL, ""));
			}
			// [4].全匹配查询{没有特殊符号的参数}
			else {
				cq.eq(name, searchValue);
			}
		}

	}

	
	public void addCriteria(CriteriaQuery cq, String name, Object value,
			String beginValue, String endValue) {
		addCriteria(cq,name,value);
	}

}
