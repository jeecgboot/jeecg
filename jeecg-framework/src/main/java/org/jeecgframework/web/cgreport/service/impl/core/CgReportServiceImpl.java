package org.jeecgframework.web.cgreport.service.impl.core;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.web.cgreport.dao.core.CgReportDao;
import org.jeecgframework.web.cgreport.entity.core.CgreportConfigHeadEntity;
import org.jeecgframework.web.cgreport.entity.core.CgreportConfigParamEntity;
import org.jeecgframework.web.cgreport.service.core.CgReportServiceI;
import org.jeecgframework.web.system.pojo.base.TSType;
import org.jeecgframework.core.common.dao.jdbc.JdbcDao;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.online.def.CgReportConstant;
import org.jeecgframework.core.util.DynamicDBUtil;
import org.jeecgframework.core.util.MutiLangUtil;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.SqlUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service(value="cgReportService")
@Transactional
public class CgReportServiceImpl extends CommonServiceImpl implements
		CgReportServiceI {
	@Autowired
	private JdbcDao jdbcDao;
	@Autowired
	private CgReportDao cgReportDao;
	
	
	public Map<String, Object> queryCgReportConfig(String reportId) {
		Map<String,Object> cgReportM = new HashMap<String, Object>(0);
		Map<String,Object> mainM = queryCgReportMainConfig(reportId);
		List<Map<String,Object>> itemsM = queryCgReportItems(reportId);
		List<String> params =queryCgReportParam(reportId);
		cgReportM.put(CgReportConstant.MAIN, mainM);
		cgReportM.put(CgReportConstant.ITEMS, itemsM);
		cgReportM.put(CgReportConstant.PARAMS, params);
		return cgReportM;
	}
	
	public Map<String,Object> queryCgReportMainConfig(String reportId){
//		String sql = JeecgSqlUtil.getMethodSql(JeecgSqlUtil.getMethodUrl());
//		Map<String,Object> parameters = new LinkedHashMap<String,Object>();
//		parameters.put("id", reportId);
//		Map mainM = jdbcDao.findForMap(sql, parameters);
		
		//采用MiniDao实现方式
		return cgReportDao.queryCgReportMainConfig(reportId);
	}
	
	public List<Map<String,Object>> queryCgReportItems(String reportId){
//		String sql = JeecgSqlUtil.getMethodSql(JeecgSqlUtil.getMethodUrl());
//		Map<String,Object> parameters = new LinkedHashMap<String,Object>();
//		parameters.put("configId", reportId);
//		List<Map<String,Object>> items = jdbcDao.findForListMap(sql, parameters);
		
		//采用MiniDao实现方式
		return cgReportDao.queryCgReportItems(reportId);
	}
	
	public List<String> queryCgReportParam(String reportId){
		List<String> list = null;
		CgreportConfigHeadEntity cgreportConfigHead = this.findUniqueByProperty(CgreportConfigHeadEntity.class, "code", reportId);
    	String hql0 = "from CgreportConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
    	List<CgreportConfigParamEntity> cgreportConfigParamList = this.findHql(hql0,cgreportConfigHead.getId());
    	if(cgreportConfigParamList!=null&cgreportConfigParamList.size()>0){
    		list = new ArrayList<String>();
    		for(CgreportConfigParamEntity cgreportConfigParam :cgreportConfigParamList){
    			list.add(cgreportConfigParam.getParamName());
    		}
    	}
		return list;
	}
	
	@SuppressWarnings("unchecked")
	
	public List<Map<String, Object>> queryByCgReportSql(String sql, Map params,
			int page, int rows) {
		String querySql = getFullSql(sql,params);
		List<Map<String,Object>> result = null;
		if(page==-1 && rows==-1){
			result = jdbcDao.findForJdbc(querySql);
		}else{
			result = jdbcDao.findForJdbc(querySql, page, rows);
		}
		return result;
	}
	/**
	 * 获取拼装查询条件之后的sql
	 * @param sql
	 * @param params
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private String getFullSql(String sql,Map params){
		StringBuilder sqlB =  new StringBuilder();
		sqlB.append("SELECT t.* FROM ( ");
		sqlB.append(sql+" ");
		sqlB.append(") t ");
		if (params.size() >= 1) {
			sqlB.append("WHERE 1=1  ");
			Iterator it = params.keySet().iterator();
			while (it.hasNext()) {
				String key = String.valueOf(it.next());
				String value = String.valueOf(params.get(key));
				if (!StringUtil.isEmpty(value) && !"null".equals(value)) {
						sqlB.append(" AND ");
						sqlB.append(" " + key +  value );
				}
			}
		}
		return sqlB.toString();
	}
	@SuppressWarnings("unchecked")
	
	public long countQueryByCgReportSql(String sql, Map params) {
		String querySql = getFullSql(sql,params);
		querySql = "SELECT COUNT(*) FROM ("+querySql+") t2";
		long result = jdbcDao.findForLong(querySql,new HashMap(0));
		return result;
	}
	@SuppressWarnings( "unchecked" )
	
	public List<String> getSqlFields(String sql) {
		if(oConvertUtils.isEmpty(sql)){
			return null;
		}
		List<Map<String, Object>> result = jdbcDao.findForJdbc(sql, 1, 1);
		if(result.size()<1){
			throw new BusinessException("该报表sql没有数据");
		}
		Set fieldsSet= result.get(0).keySet();
		List<String> fileds = new ArrayList<String>(fieldsSet);
		return fileds;
	}
	
	//------------------------------------------------------------------------------------------------------------
	/**
	 * 动态数据源： 获取SQL解析的字段
	 */
	public List<String> getFields(String sql,String dbKey){
		List<String> fields = null;
		sql = getSql(sql);
		if(StringUtils.isNotBlank(dbKey)){
			List<Map<String,Object>> dataList=DynamicDBUtil.findList(dbKey,SqlUtil.jeecgCreatePageSql(dbKey,sql,null,1,1),null);
			if(dataList.size()<1){
				throw new BusinessException("该报表sql没有数据");
			}
			Set fieldsSet= dataList.get(0).keySet();
			fields = new ArrayList<String>(fieldsSet);
		}else{
			fields = this.getSqlFields(sql);
		}
		return fields;
	}
	
	/**
	 * 过滤非法sql规则，降低sql注入风险
	 * @param sql
	 * @return
	 */
	private String getSql(String sql){
		String regex = "\\$\\{\\w+\\}";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(sql);
		while(m.find()){
			String whereParam = m.group();
			//System.out.println(whereParam);
			sql = sql.replace(whereParam, "'' or 1=1 or 1=''");
			sql = sql.replace("'''", "''");
			//System.out.println(sql);
		}
		//兼容图表
		regex = "\\{\\w+\\}";
		p = Pattern.compile(regex);
		m = p.matcher(sql);
		while(m.find()){
			String whereParam = m.group();
			//System.out.println(whereParam);
			sql = sql.replace(whereParam, " 1=1 ");
			//System.out.println(sql);
		}
		return sql;
	}
	
	/**
	 * 解析SQL参数
	 */
	public List<String> getSqlParams(String sql) {
		if(oConvertUtils.isEmpty(sql)){
			return null;
		}
		List<String> params = new ArrayList<String>();
		String regex = "\\$\\{\\w+\\}";
		
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(sql);
		while(m.find()){
			String whereParam = m.group();
			params.add(whereParam.substring(whereParam.indexOf("{")+1,whereParam.indexOf("}")));
		}
		return params;
	}
	
	
	/**
	 * 装载数据字典
	 * @param m	要放入freemarker的数据
	 * @param bean 读取出来的动态配置数据
	 */
	public void loadDic(Map<String, Object> m) {
		String dict_code = (String) m.get("dict_code");
		if(StringUtil.isEmpty(dict_code)){
			m.put(CgReportConstant.FIELD_DICTLIST, new ArrayList(0));
			return;
		}
		List<Map<String, Object>> dicDatas = queryDicBySQL(dict_code);
		m.put(CgReportConstant.FIELD_DICTLIST, dicDatas);
	}
	
	/**
	 * 查询数据字典，扩展了对SQL的支持
	 * @param dictCodeOrSQL 字典编码或SQL
	 * @author bit 2014-4-19
	 */
	private List<Map<String, Object>> queryDicBySQL(String dictCodeOrSQL) {
		List<Map<String, Object>> dicDatas = null;
		dictCodeOrSQL = dictCodeOrSQL.trim();
		if(dictCodeOrSQL.toLowerCase().startsWith("select ")) {

			dictCodeOrSQL = dictCodeOrSQL.replaceAll("'[kK][eE][yY]'", "typecode").replaceAll("'[vV][aA][lL][uU][eE]'", "typename");

			dicDatas = this.findForJdbc(dictCodeOrSQL);
		}else {
			dicDatas = queryDic(dictCodeOrSQL);
		}
		return dicDatas;
	}
	
	
	/**
	 * 查询数据字典
	 * @param diccode 字典编码
	 * @return
	 */
	private List<Map<String, Object>> queryDic(String diccode) {

		List<Map<String, Object>> dicDatas = new ArrayList<Map<String, Object>>();
		List<TSType> tstypes = ResourceUtil.allTypes.get(diccode.toLowerCase());
		for(TSType t:tstypes){
			Map<String,Object> mp = new HashMap<String,Object>();
			mp.put("typecode",t.getTypecode());
			mp.put("typename",MutiLangUtil.doMutiLang(t.getTypename(), null));
			dicDatas.add(mp);
		}
//		StringBuilder dicSql = new StringBuilder();
//		dicSql.append(" SELECT TYPECODE,TYPENAME FROM");
//		dicSql.append(" "+CgReportConstant.SYS_DIC);
//		dicSql.append(" "+"WHERE TYPEGROUPID = ");
//		dicSql.append(" "+"(SELECT ID FROM "+CgReportConstant.SYS_DICGROUP+" WHERE TYPEGROUPCODE = ? )");
//		List<Map<String, Object>> dicDatas = cgReportService.findForJdbc(dicSql.toString(),diccode);

		return dicDatas;
	}
	
	/**
	 * 处理取值表达式
	 * @param result
	 * @param beans
	 */
	@SuppressWarnings("unchecked")
	public void dealReplace(List<Map<String, Object>> result,List<Map<String,Object>> beans){
		for(Map<String,Object> bean:beans){
			try{
				//获取取值表达式
				String replace = (String) bean.get(CgReportConstant.ITEM_REPLACE);
				if(StringUtil.isEmpty(replace)){
					continue;
				}
				String[] groups = replace.split(",");
				for(String g:groups){
					String[] items = g.split("_");
					String v = items[0];//逻辑判断值
					String txt = items[1];//要转换的文本
					for(Map r:result){
						String value = String.valueOf(r.get(bean.get(CgReportConstant.ITEM_FIELDNAME)));
						if(value.equalsIgnoreCase(v)){
							r.put(bean.get(CgReportConstant.ITEM_FIELDNAME),txt);
						}
					}
				}
			}catch (Exception e) {
				//这里出现异常原因是因为取值表达式不正确
				e.printStackTrace();
				throw new BusinessException("取值表达式不正确");
			}
		}
	}
	
	/**
	 * 装载数据字典
	 * @param result 查询的结果集
	 * @param beans 字段配置
	 */
	@SuppressWarnings("unchecked")
	public void dealDic(List<Map<String, Object>> result,List<Map<String,Object>> beans) {
		for(Map<String,Object> bean:beans){
			String dict_code = (String) bean.get(CgReportConstant.ITEM_DICCODE);
			String field_name=bean.get(CgReportConstant.ITEM_FIELDNAME).toString();
			if(StringUtil.isEmpty(dict_code)){
				//不需要处理字典
				continue;
			}else{

				List<Map<String, Object>> dicDatas = queryDicBySQL(dict_code);
				for(Map r:result){
					String value = String.valueOf(r.get(field_name));
					for(Map m:dicDatas){
						String typecode = String.valueOf(m.get("typecode"));
						String typename = String.valueOf(m.get("typename"));
						if(value.equalsIgnoreCase(typecode)){
							r.put(bean.get(CgReportConstant.ITEM_FIELDNAME),typename);
						}
					}
				}

			}
		}
	}
	//------------------------------------------------------------------------------------------------------------
}
