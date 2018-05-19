package org.jeecgframework.web.cgreport.service.impl.core;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.jeecgframework.web.cgreport.dao.core.CgReportDao;
import org.jeecgframework.web.cgreport.entity.core.CgreportConfigHeadEntity;
import org.jeecgframework.web.cgreport.entity.core.CgreportConfigParamEntity;
import org.jeecgframework.web.cgreport.service.core.CgReportServiceI;

import org.jeecgframework.core.common.dao.jdbc.JdbcDao;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.online.def.CgReportConstant;
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
}
