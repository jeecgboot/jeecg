package org.jeecgframework.web.cgdynamgraph.service.impl.core;

import java.util.List;
import java.util.UUID;

import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigHeadEntity;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigItemEntity;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigParamEntity;
import org.jeecgframework.web.cgdynamgraph.service.core.CgDynamGraphConfigHeadServiceI;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
@Service("cgDynamGraphConfigHeadService")
@Transactional
public class CgDynamGraphConfigHeadServiceImpl extends CommonServiceImpl implements CgDynamGraphConfigHeadServiceI {
		
	 	public <T> void delete(T entity) {
	 		super.delete(entity);
	 		//执行删除操作配置的sql增强
			this.doDelSql((CgDynamGraphConfigHeadEntity)entity);
	 	}
		
	 	public void addMain(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead,
		        List<CgDynamGraphConfigItemEntity> cgDynamGraphConfigItemList,List<CgDynamGraphConfigParamEntity> cgDynamGraphConfigParamList){
				//保存主信息
				this.save(cgDynamGraphConfigHead);
			
				/**保存-动态报表配置明细*/
				for(CgDynamGraphConfigItemEntity cgDynamGraphConfigItem:cgDynamGraphConfigItemList){
					//外键设置
					cgDynamGraphConfigItem.setCgrheadId(cgDynamGraphConfigHead.getId());
					this.save(cgDynamGraphConfigItem);
				}
				
				/**保存-动态报表参数*/
				for(CgDynamGraphConfigParamEntity cgDynamGraphConfigParam:cgDynamGraphConfigParamList){
					//外键设置
					cgDynamGraphConfigParam.setCgrheadId(cgDynamGraphConfigHead.getId());
					this.save(cgDynamGraphConfigParam);
				}
				
				//执行新增操作配置的sql增强
	 			this.doAddSql(cgDynamGraphConfigHead);
		}

		
		public void updateMain(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead,
		        List<CgDynamGraphConfigItemEntity> cgDynamGraphConfigItemList,List<CgDynamGraphConfigParamEntity> cgDynamGraphConfigParamList) {
			//保存主表信息
			this.saveOrUpdate(cgDynamGraphConfigHead);
			//===================================================================================
			//获取参数
			Object id0 = cgDynamGraphConfigHead.getId();
			//===================================================================================
			//1.查询出数据库的明细数据-动态报表配置明细
		    String hql0 = "from CgDynamGraphConfigItemEntity where 1 = 1 AND cgrheadId = ? ";
		    List<CgDynamGraphConfigItemEntity> cgDynamGraphConfigItemOldList = this.findHql(hql0,id0);
			//2.筛选更新明细数据-动态报表配置明细
			for(CgDynamGraphConfigItemEntity oldE:cgDynamGraphConfigItemOldList){
				boolean isUpdate = false;
				for(CgDynamGraphConfigItemEntity sendE:cgDynamGraphConfigItemList){
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
			for(CgDynamGraphConfigItemEntity cgDynamGraphConfigItem:cgDynamGraphConfigItemList){
				if(StringUtil.isEmpty(cgDynamGraphConfigItem.getId())){
					//外键设置
					cgDynamGraphConfigItem.setCgrheadId(cgDynamGraphConfigHead.getId());
					this.save(cgDynamGraphConfigItem);
				}
			}
			
			//===================================================================================
			//1.查询出数据库的报表参数-动态报表参数
		    String hql1 = "from CgDynamGraphConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
		    List<CgDynamGraphConfigParamEntity> cgDynamGraphConfigParamOldList = this.findHql(hql1,id0);
			//2.筛选更新明细数据-动态报表配置明细
			for(CgDynamGraphConfigParamEntity oldE:cgDynamGraphConfigParamOldList){
				boolean isUpdate = false;
				for(CgDynamGraphConfigParamEntity sendE:cgDynamGraphConfigParamList){
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
			for(CgDynamGraphConfigParamEntity cgDynamGraphConfigParam:cgDynamGraphConfigParamList){
				if(StringUtil.isEmpty(cgDynamGraphConfigParam.getId())){
					//外键设置
					cgDynamGraphConfigParam.setCgrheadId(cgDynamGraphConfigHead.getId());
					this.save(cgDynamGraphConfigParam);
				}
			}
			//执行更新操作配置的sql增强
	 		this.doUpdateSql(cgDynamGraphConfigHead);
		}

		
		public void delMain(CgDynamGraphConfigHeadEntity cgDynamGraphConfigHead) {
			//删除主表信息
			this.delete(cgDynamGraphConfigHead);
			//===================================================================================
			//获取参数
			Object id0 = cgDynamGraphConfigHead.getId();
			//===================================================================================
			//删除-动态报表配置明细
		    String hql0 = "from CgDynamGraphConfigItemEntity where 1 = 1 AND cgrheadId = ? ";
		    List<CgDynamGraphConfigItemEntity> cgDynamGraphConfigItemOldList = this.findHql(hql0,id0);
			this.deleteAllEntitie(cgDynamGraphConfigItemOldList);
			//删除-动态报表参数
			String hql1 = "from CgDynamGraphConfigParamEntity where 1 = 1 AND cgrheadId = ? ";
			List<CgDynamGraphConfigParamEntity> cgDynamGraphConfigParamOldList = this.findHql(hql1,id0);
			this.deleteAllEntitie(cgDynamGraphConfigParamOldList);
		}
		
	 	
	 	/**
		 * 默认按钮-sql增强-新增操作
		 * @param id
		 * @return
		 */
	 	public boolean doAddSql(CgDynamGraphConfigHeadEntity t){
		 	return true;
	 	}
	 	/**
		 * 默认按钮-sql增强-更新操作
		 * @param id
		 * @return
		 */
	 	public boolean doUpdateSql(CgDynamGraphConfigHeadEntity t){
		 	return true;
	 	}
	 	/**
		 * 默认按钮-sql增强-删除操作
		 * @param id
		 * @return
		 */
	 	public boolean doDelSql(CgDynamGraphConfigHeadEntity t){
		 	return true;
	 	}
	 	
	 	/**
		 * 替换sql中的变量
		 * @param sql
		 * @return
		 */
	 	public String replaceVal(String sql,CgDynamGraphConfigHeadEntity t){
	 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
	 		sql  = sql.replace("#{code}",String.valueOf(t.getCode()));
	 		sql  = sql.replace("#{name}",String.valueOf(t.getName()));
	 		sql  = sql.replace("#{cgr_sql}",String.valueOf(t.getCgrSql()));
	 		sql  = sql.replace("#{content}",String.valueOf(t.getContent()));
	 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
	 		return sql;
	 	}
	}