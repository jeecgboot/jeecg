package org.jeecgframework.web.cgform.service.impl.enhance;
import java.io.Serializable;
import java.util.List;
import java.util.UUID;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.cgform.entity.enhance.CgformEnhanceJavaEntity;
import org.jeecgframework.web.cgform.service.enhance.CgformEnhanceJavaServiceI;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("cgformEnhanceJavaService")
@Transactional
public class CgformEnhanceJavaServiceImpl extends CommonServiceImpl implements CgformEnhanceJavaServiceI {

	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((CgformEnhanceJavaEntity)entity);
 	}
 	
 	public <T> Serializable save(T entity) {
 		Serializable t = super.save(entity);
 		//执行新增操作配置的sql增强
 		this.doAddSql((CgformEnhanceJavaEntity)entity);
 		return t;
 	}
 	
 	public <T> void saveOrUpdate(T entity) {
 		super.saveOrUpdate(entity);
 		//执行更新操作配置的sql增强
 		this.doUpdateSql((CgformEnhanceJavaEntity)entity);
 	}
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param
	 * @return
	 */
 	public boolean doAddSql(CgformEnhanceJavaEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param
	 * @return
	 */
 	public boolean doUpdateSql(CgformEnhanceJavaEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param
	 * @return
	 */
 	public boolean doDelSql(CgformEnhanceJavaEntity t){
	 	return true;
 	}
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,CgformEnhanceJavaEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{cg_java_type}",String.valueOf(t.getCgJavaType()));
 		sql  = sql.replace("#{cg_java_value}",String.valueOf(t.getCgJavaValue()));
 		sql  = sql.replace("#{form_id}",String.valueOf(t.getFormId()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		sql  = sql.replace("#{active_status}", String.valueOf(t.getActiveStatus()));
 		return sql;
 	}
	@Override
	public CgformEnhanceJavaEntity getCgformEnhanceJavaEntityByCodeFormId(
			String buttonCode, String formId) {
		StringBuilder hql = new StringBuilder("");
		hql.append(" from CgformEnhanceJavaEntity t");
		hql.append(" where t.formId='").append(formId).append("'");
		hql.append(" and  t.buttonCode ='").append(buttonCode).append("'");
		List<CgformEnhanceJavaEntity> list = this.findHql(hql.toString());
		if(list!=null&&list.size()>0){
			return list.get(0);
		}
		return null;
	}

	@Override
	public List<CgformEnhanceJavaEntity> checkCgformEnhanceJavaEntity(
			CgformEnhanceJavaEntity cgformEnhanceJavaEntity) {
		StringBuilder hql = new StringBuilder("");
		hql.append(" from CgformEnhanceJavaEntity t");
		hql.append(" where t.formId='").append(cgformEnhanceJavaEntity.getFormId()).append("'");
		hql.append(" and  t.buttonCode ='").append(cgformEnhanceJavaEntity.getButtonCode()).append("'");
		if(cgformEnhanceJavaEntity.getId()!=null){
			hql.append(" and t.id !='").append(cgformEnhanceJavaEntity.getId()).append("'");
		}
		List<CgformEnhanceJavaEntity> list = this.findHql(hql.toString());
		return list;
	}
	
	@Override
	public boolean checkClassOrSpringBeanIsExist(CgformEnhanceJavaEntity cgformEnhanceJavaEntity) {
		String cgJavaType = cgformEnhanceJavaEntity.getCgJavaType();
		String cgJavaValue = cgformEnhanceJavaEntity.getCgJavaValue();

		if(StringUtil.isNotEmpty(cgJavaValue)){
			try {
				if("class".equals(cgJavaType)){
					Class clazz = Class.forName(cgJavaValue);
					if(clazz==null || clazz.newInstance()==null)
						return false;
				}
				
				if("spring".equals(cgJavaType)){
					Object obj = ApplicationContextUtil.getContext().getBean(cgJavaValue);
					if(obj==null)
						return false;
				}
			} catch (Exception e) {
				e.printStackTrace();
				return false;
			}
		}

		return true;
	}
}