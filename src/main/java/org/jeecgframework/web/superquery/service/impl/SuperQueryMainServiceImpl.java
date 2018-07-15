package org.jeecgframework.web.superquery.service.impl;
import org.jeecgframework.web.superquery.service.SuperQueryMainServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;

import org.jeecgframework.web.superquery.entity.SuperQueryFieldEntity;
import org.jeecgframework.web.superquery.entity.SuperQueryMainEntity;
import org.jeecgframework.web.superquery.entity.SuperQueryTableEntity;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import java.util.UUID;


@Service("superQueryMainService")
@Transactional
public class SuperQueryMainServiceImpl extends CommonServiceImpl implements SuperQueryMainServiceI {
	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((SuperQueryMainEntity)entity);
 	}
	
	public void addMain(SuperQueryMainEntity superQueryMain,
	        List<SuperQueryTableEntity> superQueryTableList,List<SuperQueryFieldEntity> superQueryFieldList){
			//保存主信息
			this.save(superQueryMain);
		
			/**保存-表集合*/
			for(SuperQueryTableEntity superQueryTable:superQueryTableList){
				//外键设置
				superQueryTable.setMainId(superQueryMain.getId());
				this.save(superQueryTable);
			}
			/**保存-字段配置*/
			for(SuperQueryFieldEntity superQueryField:superQueryFieldList){
				//外键设置
				superQueryField.setMainId(superQueryMain.getId());
				this.save(superQueryField);
			}
			//执行新增操作配置的sql增强
 			this.doAddSql(superQueryMain);
	}

	
	public void updateMain(SuperQueryMainEntity superQueryMain,
	        List<SuperQueryTableEntity> superQueryTableList,List<SuperQueryFieldEntity> superQueryFieldList) {
		//保存主表信息
		if(StringUtil.isNotEmpty(superQueryMain.getId())){
			try {
				SuperQueryMainEntity temp = findUniqueByProperty(SuperQueryMainEntity.class, "id", superQueryMain.getId());
				MyBeanUtils.copyBeanNotNull2Bean(superQueryMain, temp);
				this.saveOrUpdate(temp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			this.saveOrUpdate(superQueryMain);
		}
		//===================================================================================
		//获取参数
		Object id0 = superQueryMain.getId();
		Object id1 = superQueryMain.getId();
		//===================================================================================
		//1.查询出数据库的明细数据-表集合
	    String hql0 = "from SuperQueryTableEntity where 1 = 1 AND mAIN_ID = ? ";
	    List<SuperQueryTableEntity> superQueryTableOldList = this.findHql(hql0,id0);
		//2.筛选更新明细数据-表集合
		if(superQueryTableList!=null&&superQueryTableList.size()>0){
		for(SuperQueryTableEntity oldE:superQueryTableOldList){
			boolean isUpdate = false;
				for(SuperQueryTableEntity sendE:superQueryTableList){
					//需要更新的明细数据-表集合
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
		    		//如果数据库存在的明细，前台没有传递过来则是删除-表集合
		    		super.delete(oldE);
	    		}
	    		
			}
			//3.持久化新增的数据-表集合
			for(SuperQueryTableEntity superQueryTable:superQueryTableList){
				if(oConvertUtils.isEmpty(superQueryTable.getId())){
					//外键设置
					superQueryTable.setMainId(superQueryMain.getId());
					this.save(superQueryTable);
				}
			}
		}
		//===================================================================================
		//1.查询出数据库的明细数据-字段配置
	    String hql1 = "from SuperQueryFieldEntity where 1 = 1 AND mAIN_ID = ? ";
	    List<SuperQueryFieldEntity> superQueryFieldOldList = this.findHql(hql1,id1);
		//2.筛选更新明细数据-字段配置
		if(superQueryFieldList!=null&&superQueryFieldList.size()>0){
		for(SuperQueryFieldEntity oldE:superQueryFieldOldList){
			boolean isUpdate = false;
				for(SuperQueryFieldEntity sendE:superQueryFieldList){
					//需要更新的明细数据-字段配置
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
		    		//如果数据库存在的明细，前台没有传递过来则是删除-字段配置
		    		super.delete(oldE);
	    		}
	    		
			}
			//3.持久化新增的数据-字段配置
			for(SuperQueryFieldEntity superQueryField:superQueryFieldList){
				if(oConvertUtils.isEmpty(superQueryField.getId())){
					//外键设置
					superQueryField.setMainId(superQueryMain.getId());
					this.save(superQueryField);
				}
			}
		}
		//执行更新操作配置的sql增强
 		this.doUpdateSql(superQueryMain);
	}

	
	public void delMain(SuperQueryMainEntity superQueryMain) {
		//删除主表信息
		this.delete(superQueryMain);
		//===================================================================================
		//获取参数
		Object id0 = superQueryMain.getId();
		Object id1 = superQueryMain.getId();
		//===================================================================================
		//删除-表集合
	    String hql0 = "from SuperQueryTableEntity where 1 = 1 AND mAIN_ID = ? ";
	    List<SuperQueryTableEntity> superQueryTableOldList = this.findHql(hql0,id0);
		this.deleteAllEntitie(superQueryTableOldList);
		//===================================================================================
		//删除-字段配置
	    String hql1 = "from SuperQueryFieldEntity where 1 = 1 AND mAIN_ID = ? ";
	    List<SuperQueryFieldEntity> superQueryFieldOldList = this.findHql(hql1,id1);
		this.deleteAllEntitie(superQueryFieldOldList);
	}
	
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(SuperQueryMainEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(SuperQueryMainEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(SuperQueryMainEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,SuperQueryMainEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{create_name}",String.valueOf(t.getCreateName()));
 		sql  = sql.replace("#{create_by}",String.valueOf(t.getCreateBy()));
 		sql  = sql.replace("#{create_date}",String.valueOf(t.getCreateDate()));
 		sql  = sql.replace("#{update_name}",String.valueOf(t.getUpdateName()));
 		sql  = sql.replace("#{update_by}",String.valueOf(t.getUpdateBy()));
 		sql  = sql.replace("#{update_date}",String.valueOf(t.getUpdateDate()));
 		sql  = sql.replace("#{sys_org_code}",String.valueOf(t.getSysOrgCode()));
 		sql  = sql.replace("#{sys_company_code}",String.valueOf(t.getSysCompanyCode()));
 		sql  = sql.replace("#{query_name}",String.valueOf(t.getQueryName()));
 		sql  = sql.replace("#{query_code}",String.valueOf(t.getQueryCode()));
 		sql  = sql.replace("#{query_type}",String.valueOf(t.getQueryType()));
 		sql  = sql.replace("#{content}",String.valueOf(t.getContent()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
}