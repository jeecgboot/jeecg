package org.jeecgframework.core.extend.hqlsearch.parse.impl;

import java.math.BigDecimal;

import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil;
import org.jeecgframework.core.extend.hqlsearch.parse.IHqlParse;

public class BigDecimalParseImpl implements IHqlParse {

	
	public void addCriteria(CriteriaQuery cq, String name, Object value) {
		if (HqlGenerateUtil.isNotEmpty(value))
			cq.eq(name, value);

	}

	
	public void addCriteria(CriteriaQuery cq, String name, Object value,
			String beginValue, String endValue) {
		if (HqlGenerateUtil.isNotEmpty(beginValue)) {
			cq.ge(name,
					beginValue.contains(".") ? BigDecimal
							.valueOf(Double.parseDouble(beginValue))
							: BigDecimal.valueOf(Long
									.parseLong(beginValue)));
		}
		if (HqlGenerateUtil.isNotEmpty(endValue)) {
			cq.le(name,
					beginValue.contains(".") ? BigDecimal
							.valueOf(Double.parseDouble(endValue))
							: BigDecimal.valueOf(Long
									.parseLong(endValue)));
		}
		if (HqlGenerateUtil.isNotEmpty(value)) {
			cq.eq(name, value);
		}
	}

}
