package org.jeecgframework.web.cgform.service.impl.config;
import java.io.Serializable;
import java.util.List;
import java.util.UUID;

import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormIndexEntity;
import org.jeecgframework.web.cgform.service.config.CgFormIndexServiceI;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("cgFormIndexService")
@Transactional
public class CgFormIndexServiceImpl extends CommonServiceImpl implements CgFormIndexServiceI {
	private static final Logger logger = Logger.getLogger(CgFormIndexServiceImpl.class);
	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((CgFormIndexEntity)entity);
 	}
 	
 	public <T> Serializable save(T entity) {
 		Serializable t = super.save(entity);
 		//执行新增操作配置的sql增强
 		this.doAddSql((CgFormIndexEntity)entity);
 		return t;
 	}
 	
 	public <T> void saveOrUpdate(T entity) {
 		super.saveOrUpdate(entity);
 		//执行更新操作配置的sql增强
 		this.doUpdateSql((CgFormIndexEntity)entity);
 	}
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(CgFormIndexEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(CgFormIndexEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(CgFormIndexEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,CgFormIndexEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{create_name}",String.valueOf(t.getCreateName()));
 		sql  = sql.replace("#{create_by}",String.valueOf(t.getCreateBy()));
 		sql  = sql.replace("#{create_date}",String.valueOf(t.getCreateDate()));
 		sql  = sql.replace("#{update_name}",String.valueOf(t.getUpdateName()));
 		sql  = sql.replace("#{update_by}",String.valueOf(t.getUpdateBy()));
 		sql  = sql.replace("#{update_date}",String.valueOf(t.getUpdateDate()));
 		sql  = sql.replace("#{index_name}",String.valueOf(t.getIndexName()));
 		sql  = sql.replace("#{index_field}",String.valueOf(t.getIndexField()));
 		sql  = sql.replace("#{index_type}",String.valueOf(t.getIndexType()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}

	@Override
	public boolean updateIndexes(CgFormHeadEntity cgFormHead) {
		boolean isChange = false;
		List<CgFormIndexEntity> indexes = cgFormHead.getIndexes();
		//判断新的indexes和旧的indexes的差异,如果有差异，就设置cgFormHead的数据库同步字段为N
		List<CgFormIndexEntity> oldindexes = this.getSession().createSQLQuery("select * from cgform_index where table_id = '" + cgFormHead.getId() + "'").addEntity(CgFormIndexEntity.class).list();
		if(oldindexes.size()!=0 && indexes!=null){
			if(oldindexes.size()!=indexes.size()){
				isChange = true;
			}else{
				for(int i=0;i<indexes.size();i++){
					CgFormIndexEntity oldindex = oldindexes.get(i);
					CgFormIndexEntity newindex = indexes.get(i);
					if(oldindex.getIndexField().equals(newindex.getIndexField())&&oldindex.getIndexName().equals(newindex.getIndexName())&&oldindex.getIndexType().equals(newindex.getIndexType())){
						
					}else{
						isChange = true;
					}
				}
			}
		}else if(oldindexes.size()==0&&indexes==null){
			isChange = false;
		}else{
			isChange = true;
		}
		cgFormHead.setIsDbSynch(isChange ? "N" : cgFormHead.getIsDbSynch());
		String id = cgFormHead.getId();
		CgFormHeadEntity formhead = this.getEntity(CgFormHeadEntity.class, cgFormHead.getId());
		//根据名称先删除索引
		/*List<CgFormIndexEntity> oldindexes = this.getSession().
				createSQLQuery("select * from cgform_index where table_id = '" + cgFormHead.getId() + "'").addEntity(CgFormIndexEntity.class).list();*/
		
		if(isChange){
			//删除表的索引
			try {
				if(oldindexes!=null){
					for(CgFormIndexEntity cgform : oldindexes){
						//TODO 索引的创建和删除，需要兼容多数据库
						String sql = "DROP INDEX " + cgform.getIndexName() + " ON " + formhead.getTableName();
						this.getSession().createSQLQuery(sql).executeUpdate();
					}
				}
			} catch (HibernateException e) {
				//e.printStackTrace();
				logger.error(e.toString());
			}
			
			//删除索引后重新保存 【物理表】
			this.getSession().createSQLQuery("delete from cgform_index where table_id = '" + id + "'").executeUpdate();
			if(indexes!=null){
				for(CgFormIndexEntity cgform : indexes){
					cgform.setTable(cgFormHead);
					this.save(cgform);
				}
			}
		}
		return isChange;
	}

	@Override
	public void createIndexes(CgFormHeadEntity cgFormHead) {
		CgFormHeadEntity formhead = this.getEntity(CgFormHeadEntity.class, cgFormHead.getId());
		List<CgFormIndexEntity> indexes = this.getSession().createSQLQuery("select * from cgform_index where table_id = '" + cgFormHead.getId() + "'").addEntity(CgFormIndexEntity.class).list();
		if(indexes.size()!=0){
			for(CgFormIndexEntity cgform : indexes){
				String sql = "";
				if(cgform.getIndexType().equals("normal")){
					sql = "create index " + cgform.getIndexName() + " on " + formhead.getTableName() + "(" + cgform.getIndexField() + ")";
				}else{
					sql = "create " + cgform.getIndexType() + " index " + cgform.getIndexName() + " on " + formhead.getTableName() + "(" + cgform.getIndexField() + ")";
				}
				this.getSession().createSQLQuery(sql).executeUpdate();
			}
		}
	}
}