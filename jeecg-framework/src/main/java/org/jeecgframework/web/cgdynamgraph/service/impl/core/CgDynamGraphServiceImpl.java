package org.jeecgframework.web.cgdynamgraph.service.impl.core;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.jeecgframework.core.common.dao.jdbc.JdbcDao;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.online.def.CgReportConstant;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.cgdynamgraph.dao.core.CgDynamGraphDao;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigHeadEntity;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigParamEntity;
import org.jeecgframework.web.cgdynamgraph.service.core.CgDynamGraphServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
@Service(value="cgDynamGraphService")
@Transactional
public class CgDynamGraphServiceImpl extends CommonServiceImpl implements
	CgDynamGraphServiceI {
		@Autowired
		private JdbcDao jdbcDao;
		@Autowired
		private CgDynamGraphDao cgDynamGraphDao;
		
		
		public Map<String, Object> queryCgDynamGraphConfig(String reportId) {
			Map<String,Object> cgDynamGraphM = new HashMap<String, Object>(0);
			Map<String,Object> mainM = queryCgDynamGraphMainConfig(reportId);
			List<Map<String,Object>> itemsM = queryCgDynamGraphItems(reportId);
			List<String> params =queryCgDynamGraphParam(reportId);
			cgDynamGraphM.put(CgReportConstant.MAIN, mainM);
			cgDynamGraphM.put(CgReportConstant.ITEMS, itemsM);
			cgDynamGraphM.put(CgReportConstant.PARAMS, params);
			return cgDynamGraphM;
		}
		
		public Map<String,Object> queryCgDynamGraphMainConfig(String reportId){
//			String sql = JeecgSqlUtil.getMethodSql(JeecgSqlUtil.getMethodUrl());
//			Map<String,Object> parameters = new LinkedHashMap<String,Object>();
//			parameters.put("id", reportId);
//			Map mainM = jdbcDao.findForMap(sql, parameters);
			
			//采用MiniDao实现方式
			return cgDynamGraphDao.queryCgDynamGraphMainConfig(reportId);
		}
		
		public List<Map<String,Object>> queryCgDynamGraphItems(String reportId){
//			String sql = JeecgSqlUtil.getMethodSql(JeecgSqlUtil.getMethodUrl());
//			Map<String,Object> parameters = new LinkedHashMap<String,Object>();
//			parameters.put("configId", reportId);
//			List<Map<String,Object>> items = jdbcDao.findForListMap(sql, parameters);
			
			//采用MiniDao实现方式
			return cgDynamGraphDao.queryCgDynamGraphItems(reportId);
		}
		
		public List<String> queryCgDynamGraphParam(String reportId){
			List<String> list = null;
			CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead = this.findUniqueByProperty(CgDynamGraphConfigHeadEntity.class, "code", reportId);
	    	String hql0 = "from CgDynamGraphConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
	    	List<CgDynamGraphConfigParamEntity> cgDynamGraphConfigParamList = this.findHql(hql0,cgDynamGraphConfigHead.getId());
	    	if(cgDynamGraphConfigParamList!=null&cgDynamGraphConfigParamList.size()>0){
	    		list = new ArrayList<String>();
	    		for(CgDynamGraphConfigParamEntity cgDynamGraphConfigParam :cgDynamGraphConfigParamList){
	    			list.add(cgDynamGraphConfigParam.getParamName());
	    		}
	    	}
			return list;
		}
		
		@SuppressWarnings("unchecked")
		public List<Map<String, Object>> queryByCgDynamGraphSql(String sql, Map params) {
			String querySql = getFullSql(sql,params);
			List<Map<String,Object>> result = null;
			result = jdbcDao.findForJdbc(querySql);
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
		
		public long countQueryByCgDynamGraphSql(String sql, Map params) {
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
