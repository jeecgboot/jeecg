package org.jeecgframework.web.cgform.enhance;

import java.sql.Timestamp;

/**
 * 当前时间生成规则实现类
 * @author YanDong
 *
 */
public class CurrentDateFillRule implements IFillRuleHandler {

	@Override
	public Object execute(String paramJson) {
		return new Timestamp(System.currentTimeMillis());
	}

}