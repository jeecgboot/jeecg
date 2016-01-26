package org.jeecgframework.web.cgform.service.impl.autoform;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.jeecgframework.core.common.dao.jdbc.JdbcDao;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.cgform.entity.autoform.AutoFormDbEntity;
import org.jeecgframework.web.cgform.entity.autoform.AutoFormDbFieldEntity;
import org.jeecgframework.web.cgform.entity.autoform.AutoFormParamEntity;
import org.jeecgframework.web.cgform.service.autoform.AutoFormDbServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service("autoFormDbService")
@Transactional
public class AutoFormDbServiceImpl extends CommonServiceImpl implements AutoFormDbServiceI {
	
	@Autowired
	private JdbcDao jdbcDao;
	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((AutoFormDbEntity)entity);
 	}
	
	public void addMain(AutoFormDbEntity autoFormDb,
	        List<AutoFormDbFieldEntity> autoFormDbFieldList,List<AutoFormParamEntity> autoFormParamList){
			//保存主信息
			this.save(autoFormDb);
		
			/**保存-表单数据源属性*/
			for(AutoFormDbFieldEntity autoFormDbField:autoFormDbFieldList){
				//外键设置
				autoFormDbField.setAutoFormDbId(autoFormDb.getId());
				this.save(autoFormDbField);
			}
			/**保存-表单参数*/
			for(AutoFormParamEntity autoFormParam:autoFormParamList){
				//外键设置
				autoFormParam.setAutoFormDbId(autoFormDb.getId());
				this.save(autoFormParam);
			}
			//执行新增操作配置的sql增强
 			this.doAddSql(autoFormDb);
	}

	
	public void updateMain(AutoFormDbEntity autoFormDb,
	        List<AutoFormDbFieldEntity> autoFormDbFieldList,List<AutoFormParamEntity> autoFormParamList) {
		//保存主表信息
		this.saveOrUpdate(autoFormDb);
		//===================================================================================
		//获取参数
		Object id0 = autoFormDb.getId();
		Object id1 = autoFormDb.getId();
		//===================================================================================
		//1.查询出数据库的明细数据-表单数据源属性
	    String hql0 = "from AutoFormDbFieldEntity where 1 = 1 AND aUTO_FORM_DB_ID = ? ";
	    List<AutoFormDbFieldEntity> autoFormDbFieldOldList = this.findHql(hql0,id0);
		//2.筛选更新明细数据-表单数据源属性
		for(AutoFormDbFieldEntity oldE:autoFormDbFieldOldList){
			boolean isUpdate = false;
				for(AutoFormDbFieldEntity sendE:autoFormDbFieldList){
					//需要更新的明细数据-表单数据源属性
					if(oldE.getId().equals(sendE.getId())){
		    			try {
							MyBeanUtils.copyBeanNotNull2Bean(sendE,oldE);
							this.saveOrUpdate(oldE);
						} catch (Exception e) {
							e.printStackTrace();
							throw new BusinessException(e.getMessage());
						}
						isUpdate= true;
		    			break;
		    		}
		    	}
	    		if(!isUpdate){
		    		//如果数据库存在的明细，前台没有传递过来则是删除-表单数据源属性
		    		super.delete(oldE);
	    		}
	    		
			}
			//3.持久化新增的数据-表单数据源属性
			for(AutoFormDbFieldEntity autoFormDbField:autoFormDbFieldList){
				if(oConvertUtils.isEmpty(autoFormDbField.getId())){
					//外键设置
					autoFormDbField.setAutoFormDbId(autoFormDb.getId());
					this.save(autoFormDbField);
				}
			}
		//===================================================================================
		//1.查询出数据库的明细数据-表单参数
	    String hql1 = "from AutoFormParamEntity where 1 = 1 AND aUTO_FORM_DB_ID = ? ";
	    List<AutoFormParamEntity> autoFormParamOldList = this.findHql(hql1,id1);
		//2.筛选更新明细数据-表单参数
		for(AutoFormParamEntity oldE:autoFormParamOldList){
			boolean isUpdate = false;
				for(AutoFormParamEntity sendE:autoFormParamList){
					//需要更新的明细数据-表单参数
					if(oldE.getId().equals(sendE.getId())){
		    			try {
							MyBeanUtils.copyBeanNotNull2Bean(sendE,oldE);
							this.saveOrUpdate(oldE);
						} catch (Exception e) {
							e.printStackTrace();
							throw new BusinessException(e.getMessage());
						}
						isUpdate= true;
		    			break;
		    		}
		    	}
	    		if(!isUpdate){
		    		//如果数据库存在的明细，前台没有传递过来则是删除-表单参数
		    		super.delete(oldE);
	    		}
	    		
			}
			//3.持久化新增的数据-表单参数
			for(AutoFormParamEntity autoFormParam:autoFormParamList){
				if(oConvertUtils.isEmpty(autoFormParam.getId())){
					//外键设置
					autoFormParam.setAutoFormDbId(autoFormDb.getId());
					this.save(autoFormParam);
				}
			}
		//执行更新操作配置的sql增强
 		this.doUpdateSql(autoFormDb);
	}

	
	public void delMain(AutoFormDbEntity autoFormDb) {
		//删除主表信息
		this.delete(autoFormDb);
		//===================================================================================
		//获取参数
		Object id0 = autoFormDb.getId();
		Object id1 = autoFormDb.getId();
		//===================================================================================
		//删除-表单数据源属性
	    String hql0 = "from AutoFormDbFieldEntity where 1 = 1 AND aUTO_FORM_DB_ID = ? ";
	    List<AutoFormDbFieldEntity> autoFormDbFieldOldList = this.findHql(hql0,id0);
		this.deleteAllEntitie(autoFormDbFieldOldList);
		//===================================================================================
		//删除-表单参数
	    String hql1 = "from AutoFormParamEntity where 1 = 1 AND aUTO_FORM_DB_ID = ? ";
	    List<AutoFormParamEntity> autoFormParamOldList = this.findHql(hql1,id1);
		this.deleteAllEntitie(autoFormParamOldList);
	}
	
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(AutoFormDbEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(AutoFormDbEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(AutoFormDbEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,AutoFormDbEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{create_name}",String.valueOf(t.getCreateName()));
 		sql  = sql.replace("#{create_by}",String.valueOf(t.getCreateBy()));
 		sql  = sql.replace("#{update_name}",String.valueOf(t.getUpdateName()));
 		sql  = sql.replace("#{update_by}",String.valueOf(t.getUpdateBy()));
 		sql  = sql.replace("#{sys_org_code}",String.valueOf(t.getSysOrgCode()));
 		sql  = sql.replace("#{sys_company_code}",String.valueOf(t.getSysCompanyCode()));
 		sql  = sql.replace("#{create_date}",String.valueOf(t.getCreateDate()));
 		sql  = sql.replace("#{update_date}",String.valueOf(t.getUpdateDate()));
 		sql  = sql.replace("#{db_name}",String.valueOf(t.getDbName()));
 		sql  = sql.replace("#{db_type}",String.valueOf(t.getDbType()));
 		sql  = sql.replace("#{db_table_name}",String.valueOf(t.getDbTableName()));
 		sql  = sql.replace("#{db_dyn_sql}",String.valueOf(t.getDbDynSql()));
 		sql  = sql.replace("#{db_dyn_sql}",String.valueOf(t.getDbDynSql()));
 		sql  = sql.replace("#{auto_form_id}",String.valueOf(t.getAutoFormId()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
 	
 	/**
 	 * 获取动态sql属性部分
 	 * @param sql
 	 * @return
 	 */
 	public List<String> getSqlFields(String sql) {
		if(oConvertUtils.isEmpty(sql)){
			return null;
		}
		sql = getSql(sql);
//		if(sql.indexOf("where")!=-1){
//			sql = sql.substring(0,sql.indexOf("where"));
//		}
		List<Map<String, Object>> result = jdbcDao.findForJdbc(sql, 1, 1);
		if(result.size()<1){
			throw new BusinessException("该报表sql没有数据");
		}
		Set fieldsSet= result.get(0).keySet();
		List<String> fileds = new ArrayList<String>(fieldsSet);
		return fileds;
	}
 	
 	private String getSql(String sql){
		String regex = "\\$\\{\\w+\\}";
		Pattern p = Pattern.compile(regex);
		Matcher m = p.matcher(sql);
		while(m.find()){
			String whereParam = m.group();
			System.out.println(whereParam);
			sql = sql.replace(whereParam, "'' or 1=1 or 1=''");
			sql = sql.replace("'''", "''");
			System.out.println(sql);
		}
		return sql;
	}

 	/**
 	 * 获取动态sql参数部分
 	 * @param sql
 	 * @return
 	 */
	@Override
	public List<String> getSqlParams(String sql) {
		if(oConvertUtils.isEmpty(sql)){
			return null;
		}
//		if(sql.indexOf("where")!=-1){
//			sql = sql.substring(sql.indexOf("where")+5);
//		}
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
}