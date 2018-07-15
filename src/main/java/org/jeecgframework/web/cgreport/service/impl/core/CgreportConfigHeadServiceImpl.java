package org.jeecgframework.web.cgreport.service.impl.core;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.web.cgreport.service.core.CgreportConfigHeadServiceI;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import java.util.ArrayList;
import java.util.UUID;
import java.io.Serializable;

import org.jeecgframework.web.cgreport.entity.core.CgreportConfigHeadEntity;
import org.jeecgframework.web.cgreport.entity.core.CgreportConfigItemEntity;
import org.jeecgframework.web.cgreport.entity.core.CgreportConfigParamEntity;
@Service("cgreportConfigHeadService")
@Transactional
public class CgreportConfigHeadServiceImpl extends CommonServiceImpl implements CgreportConfigHeadServiceI {
	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((CgreportConfigHeadEntity)entity);
 	}
	
	public void addMain(CgreportConfigHeadEntity cgreportConfigHead,
	        List<CgreportConfigItemEntity> cgreportConfigItemList,List<CgreportConfigParamEntity> cgreportConfigParamList){
			//保存主信息
			this.save(cgreportConfigHead);
		
			/**保存-动态报表配置明细*/
			for(CgreportConfigItemEntity cgreportConfigItem:cgreportConfigItemList){
				//外键设置
				cgreportConfigItem.setCgrheadId(cgreportConfigHead.getId());
				this.save(cgreportConfigItem);
			}
			
			/**保存-动态报表参数*/
			for(CgreportConfigParamEntity cgreportConfigParam:cgreportConfigParamList){
				//外键设置
				cgreportConfigParam.setCgrheadId(cgreportConfigHead.getId());
				this.save(cgreportConfigParam);
			}
			
			//执行新增操作配置的sql增强
 			this.doAddSql(cgreportConfigHead);
	}

	
	public void updateMain(CgreportConfigHeadEntity cgreportConfigHead,
	        List<CgreportConfigItemEntity> cgreportConfigItemList,List<CgreportConfigParamEntity> cgreportConfigParamList) {
		//保存主表信息
		this.saveOrUpdate(cgreportConfigHead);
		//===================================================================================
		//获取参数
		Object id0 = cgreportConfigHead.getId();
		//===================================================================================
		//1.查询出数据库的明细数据-动态报表配置明细
	    String hql0 = "from CgreportConfigItemEntity where 1 = 1 AND cgrheadId = ? ";
	    List<CgreportConfigItemEntity> cgreportConfigItemOldList = this.findHql(hql0,id0);
		//2.筛选更新明细数据-动态报表配置明细
		for(CgreportConfigItemEntity oldE:cgreportConfigItemOldList){
			boolean isUpdate = false;
			for(CgreportConfigItemEntity sendE:cgreportConfigItemList){
				//需要更新的明细数据-动态报表配置明细
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
	    		//如果数据库存在的明细，前台没有传递过来则是删除-动态报表配置明细
	    		super.delete(oldE);
    		}
    		
		}
		//3.持久化新增的数据-动态报表配置明细
		for(CgreportConfigItemEntity cgreportConfigItem:cgreportConfigItemList){
			if(StringUtil.isEmpty(cgreportConfigItem.getId())){
				//外键设置
				cgreportConfigItem.setCgrheadId(cgreportConfigHead.getId());
				this.save(cgreportConfigItem);
			}
		}
		
		//===================================================================================
		//1.查询出数据库的报表参数-动态报表参数
	    String hql1 = "from CgreportConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
	    List<CgreportConfigParamEntity> cgreportConfigParamOldList = this.findHql(hql1,id0);
		//2.筛选更新明细数据-动态报表配置明细
		for(CgreportConfigParamEntity oldE:cgreportConfigParamOldList){
			boolean isUpdate = false;
			for(CgreportConfigParamEntity sendE:cgreportConfigParamList){
				//需要更新的明细数据-动态报表配置明细
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
	    		//如果数据库存在的明细，前台没有传递过来则是删除-动态报表配置明细
	    		super.delete(oldE);
    		}
    		
		}
		//3.持久化新增的数据-动态报表配置明细
		for(CgreportConfigParamEntity cgreportConfigParam:cgreportConfigParamList){
			if(StringUtil.isEmpty(cgreportConfigParam.getId())){
				//外键设置
				cgreportConfigParam.setCgrheadId(cgreportConfigHead.getId());
				this.save(cgreportConfigParam);
			}
		}
		//执行更新操作配置的sql增强
 		this.doUpdateSql(cgreportConfigHead);
	}

	
	public void delMain(CgreportConfigHeadEntity cgreportConfigHead) {
		//删除主表信息
		this.delete(cgreportConfigHead);
		//===================================================================================
		//获取参数
		Object id0 = cgreportConfigHead.getId();
		//===================================================================================
		//删除-动态报表配置明细
	    String hql0 = "from CgreportConfigItemEntity where 1 = 1 AND cgrheadId = ? ";
	    List<CgreportConfigItemEntity> cgreportConfigItemOldList = this.findHql(hql0,id0);
		this.deleteAllEntitie(cgreportConfigItemOldList);
		//删除-动态报表参数
		String hql1 = "from CgreportConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
		List<CgreportConfigParamEntity> cgreportConfigParamOldList = this.findHql(hql1,id0);
		this.deleteAllEntitie(cgreportConfigParamOldList);
	}
	
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(CgreportConfigHeadEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(CgreportConfigHeadEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(CgreportConfigHeadEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,CgreportConfigHeadEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{code}",String.valueOf(t.getCode()));
 		sql  = sql.replace("#{name}",String.valueOf(t.getName()));
 		sql  = sql.replace("#{cgr_sql}",String.valueOf(t.getCgrSql()));
 		sql  = sql.replace("#{content}",String.valueOf(t.getContent()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
}