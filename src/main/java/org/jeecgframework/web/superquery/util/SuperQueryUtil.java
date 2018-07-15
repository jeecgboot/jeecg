package org.jeecgframework.web.superquery.util;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.log4j.Logger;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.system.service.SystemService;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;

/**
 * @Title: 高级查询构造器通用方法
 * @Description: 高级查询构造器
 * @date 2017-12-29 10:00:00
 * @version V1.0 
 * @author LiShaoQing
 *
 */
public class SuperQueryUtil {
	
private static final Logger logger = Logger.getLogger(SuperQueryUtil.class);
	
	/**
	 * 根据SqlBuilder的JSON数据拼装SQL语句
	 * @param request
	 * @param dataGrid
	 * @return
	 */
	public static String getComplxSuperQuerySQL(HttpServletRequest request) {
		SystemService systemService = ApplicationContextUtil.getContext().getBean(SystemService.class);
		StringBuffer superQuerySQL = new StringBuffer("");
		//step.1 获取DataGrid中SqlBuilder的JSON串
		String complexSqlbuilder = request.getParameter("complexSqlbuilder");
		if (oConvertUtils.isNotEmpty(complexSqlbuilder)) {
			JSONArray array = JSON.parseArray(complexSqlbuilder);
			JSONObject parseObject = array.getJSONObject(0);
			//step.2遍历获取JSON里的数据拿到主表编码
			String queryCode = parseObject.get("queryCode").toString();
			//获取relation条件是AND还是OR
			String relation = parseObject.get("relation").toString();
			//step.3根据queryCode查询数据返回主表
			String sql = "select sqt.table_name from super_query_table sqt where sqt.is_main = 'Y' and sqt.main_id = (select sqm.id from super_query_main sqm where sqm.query_code = ?)";
			List<Map<String,Object>> tableName = systemService.findForJdbc(sql, queryCode);
			//根据queryCode查询数据库返回从表
			String sql1 = "select sqt.table_name,sqt.fk_field from super_query_table sqt where sqt.is_main = 'N' and sqt.main_id = (select sqm.id from super_query_main sqm where sqm.query_code = ?)";
			List<Map<String,Object>> fromName = systemService.findForJdbc(sql1, queryCode);
			//queryRules为所查询的所有信息。
			JSONArray queryRules = (JSONArray) parseObject.get("children");
			logger.info("------" + queryRules.toString() + "------");
			//step.4 拼接主从表
			String mainTable = "";//主表
			List<String> fromTable = new ArrayList<String>();//从表
			if(tableName.size() > 0) {
				if(oConvertUtils.isNotEmpty(tableName.get(0).get("table_name").toString())) {
					mainTable = tableName.get(0).get("table_name").toString();
				}
			}
			if(fromName.size() > 0) {
				for (int i = 0; i < fromName.size(); i++) {
					if(oConvertUtils.isNotEmpty(fromName.get(i).get("table_name").toString())) {
						fromTable.add(fromName.get(i).get("table_name").toString());
					}
				}
			}
			if(queryRules != null && queryRules.size()>0) {
				//step.5 拼接前段SELECT语句
				superQuerySQL.append("SELECT " + mainTable + ".id FROM " + mainTable + " ");
				//flag用来区分单条记录还是多条记录
				boolean flag = false;
				//遍历从表追加
				if(fromTable.size() > 0) {
					flag = true;
					for (String s : fromTable) {
						superQuerySQL.append("," + s);
					}
					superQuerySQL.append(" WHERE");
					//遍历取得主从表关联关系
					for (int i = 0; i < fromTable.size(); i++) {
						if(fromName.size() > 0) {
							if(i == 0) {
								superQuerySQL.append(" " + mainTable + ".id = " + fromTable.get(i) + "." + fromName.get(0).get("fk_field").toString());
							} else {
								superQuerySQL.append(" AND " + mainTable + ".id = " + fromTable.get(i) + "." + fromName.get(i).get("fk_field").toString());
							}
						}
					}
				}

				boolean queryFlag = false;
				for (int i = 0; i < queryRules.size(); i++) {
					// 遍历 JSONArray数组，把每一个对象转成JSON对象
					JSONObject rule = queryRules.getJSONObject(i);
					if(rule.getString("field")!=null && !"".equals(rule.getString("field"))){
						queryFlag=true;
					}
				}
				
				if(queryFlag){
					//step.6 拼接高级查询构造器中的条件
					for (int i = 0; i < queryRules.size(); i++) {
						// 遍历 JSONArray数组，把每一个对象转成JSON对象
						JSONObject rule = queryRules.getJSONObject(i);
						String table = rule.getString("table");	//表名
						String field = rule.getString("field");	//字段
						String condition = rule.getString("condition");	//条件
						String value = rule.getString("value");	//值
						if(i == 0) {
							if(flag) {
								superQuerySQL.append(" AND(");
							} else {
								superQuerySQL.append(" WHERE");
							}
							superQuerySQL.append(" " + table + "." + field + " " + condition + " '" + value + "' ");
						} else {
							superQuerySQL.append(" " + relation + " " + table + "." + field + " " + condition + " '" + value + "' ");
						}
					}
					if(flag) {
						superQuerySQL.append(")");
					}
				}

			}
		}
		return superQuerySQL.toString();
	}
}
