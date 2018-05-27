package org.jeecgframework.core.util;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jeecgframework.core.constant.Globals;
import org.jeecgframework.web.system.pojo.base.TSDataRule;
import org.springframework.util.StringUtils;

/**
 * @ClassName: JeecgDataAutorUtils
 * @Description: 数据权限查询规则容器工具类
 * @author 张代浩
 * @date 2012-12-15 下午11:27:39
 * 
 */
public class JeecgDataAutorUtils {

	/**
	 * 往链接请求里面，传入数据查询条件
	 * 
	 * @param request
	 * @param MENU_DATA_AUTHOR_RULES
	 */
	public static synchronized void installDataSearchConditon(
			HttpServletRequest request, List<TSDataRule> MENU_DATA_AUTHOR_RULES) {
		@SuppressWarnings("unchecked")
		List<TSDataRule> list = (List<TSDataRule>)loadDataSearchConditonSQL();// 1.先从request获取MENU_DATA_AUTHOR_RULES，如果存则获取到LIST
		if (list==null) { // 2.如果不存在，则new一个list
			list = new ArrayList<TSDataRule>();
		}
		for (TSDataRule tsDataRule : MENU_DATA_AUTHOR_RULES) {
			list.add(tsDataRule);
		}
		request.setAttribute(Globals.MENU_DATA_AUTHOR_RULES, list); // 3.往list里面增量存指
	}

	/**
	 * 获取请求对应的数据权限规则
	 * 
	 * @param request
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public static synchronized List<TSDataRule> loadDataSearchConditonSQL() {
		return (List<TSDataRule>) ContextHolderUtils.getRequest().getAttribute(
				Globals.MENU_DATA_AUTHOR_RULES);
	}

	/**
	 * 获取请求对应的数据权限SQL
	 * 
	 * @param request
	 * @return
	 */
	public static synchronized String loadDataSearchConditonSQLString() {
		return (String) ContextHolderUtils.getRequest().getAttribute(
				Globals.MENU_DATA_AUTHOR_RULE_SQL);
	}

	/**
	 * 往链接请求里面，传入数据查询条件
	 * 
	 * @param request
	 * @param MENU_DATA_AUTHOR_RULE_SQL
	 */
	public static synchronized void installDataSearchConditon(
			HttpServletRequest request, String MENU_DATA_AUTHOR_RULE_SQL) {
		// 1.先从request获取MENU_DATA_AUTHOR_RULE_SQL，如果存则获取到sql串
		String ruleSql = (String)loadDataSearchConditonSQLString();
		if (!StringUtils.hasText(ruleSql)) {
			ruleSql += MENU_DATA_AUTHOR_RULE_SQL; // 2.如果不存在，则new一个sql串
		}
		request.setAttribute(Globals.MENU_DATA_AUTHOR_RULE_SQL,
				MENU_DATA_AUTHOR_RULE_SQL);// 3.往sql串里面增量拼新的条件

	}
}
