package org.jeecgframework.web.graphreport.service.impl.core;

import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.graphreport.entity.core.JformGraphreportHeadEntity;
import org.jeecgframework.web.graphreport.entity.core.JformGraphreportItemEntity;
import org.jeecgframework.web.graphreport.service.core.JformGraphreportHeadServiceI;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.UUID;


@Service("jformGraphreportHeadService")
@Transactional
public class JformGraphreportHeadServiceImpl extends CommonServiceImpl implements JformGraphreportHeadServiceI {
	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((JformGraphreportHeadEntity)entity);
 	}
	
	public void addMain(JformGraphreportHeadEntity jformGraphreportHead,
	        List<JformGraphreportItemEntity> jformGraphreportItemList){
			//保存主信息
			this.save(jformGraphreportHead);
		
			/**保存-子表*/
			for(JformGraphreportItemEntity jformGraphreportItem:jformGraphreportItemList){
				//外键设置
				jformGraphreportItem.setCgreportHeadId(jformGraphreportHead.getId());
				this.save(jformGraphreportItem);
			}
			//执行新增操作配置的sql增强
 			this.doAddSql(jformGraphreportHead);
	}

	
	public void updateMain(JformGraphreportHeadEntity jformGraphreportHead,
	        List<JformGraphreportItemEntity> jformGraphreportItemList) {
		//保存主表信息
		this.saveOrUpdate(jformGraphreportHead);
		//===================================================================================
		//获取参数
		Object id0 = jformGraphreportHead.getId();
		//===================================================================================
		//1.查询出数据库的明细数据-子表
	    String hql0 = "from JformGraphreportItemEntity where 1 = 1 AND cGREPORT_HEAD_ID = ? ";
	    List<JformGraphreportItemEntity> jformGraphreportItemOldList = this.findHql(hql0,id0);
		//2.筛选更新明细数据-子表
		for(JformGraphreportItemEntity oldE:jformGraphreportItemOldList){
			boolean isUpdate = false;
				for(JformGraphreportItemEntity sendE:jformGraphreportItemList){
					//需要更新的明细数据-子表
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
		    		//如果数据库存在的明细，前台没有传递过来则是删除-子表
		    		super.delete(oldE);
	    		}
	    		
			}
			//3.持久化新增的数据-子表
			for(JformGraphreportItemEntity jformGraphreportItem:jformGraphreportItemList){
				if(oConvertUtils.isEmpty(jformGraphreportItem.getId())){
					//外键设置
					jformGraphreportItem.setCgreportHeadId(jformGraphreportHead.getId());
					this.save(jformGraphreportItem);
				}
			}
		//执行更新操作配置的sql增强
 		this.doUpdateSql(jformGraphreportHead);
	}

	
	public void delMain(JformGraphreportHeadEntity jformGraphreportHead) {
		//删除主表信息
		this.delete(jformGraphreportHead);
		//===================================================================================
		//获取参数
		Object id0 = jformGraphreportHead.getId();
		//===================================================================================
		//删除-子表
	    String hql0 = "from JformGraphreportItemEntity where 1 = 1 AND cGREPORT_HEAD_ID = ? ";
	    List<JformGraphreportItemEntity> jformGraphreportItemOldList = this.findHql(hql0,id0);
		this.deleteAllEntitie(jformGraphreportItemOldList);
	}
	
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param
	 * @return
	 */
 	public boolean doAddSql(JformGraphreportHeadEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param
	 * @return
	 */
 	public boolean doUpdateSql(JformGraphreportHeadEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param
	 * @return
	 */
 	public boolean doDelSql(JformGraphreportHeadEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,JformGraphreportHeadEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{name}",String.valueOf(t.getName()));
 		sql  = sql.replace("#{code}",String.valueOf(t.getCode()));
 		sql  = sql.replace("#{cgr_sql}",String.valueOf(t.getCgrSql()));
 		sql  = sql.replace("#{content}",String.valueOf(t.getContent()));
 		sql  = sql.replace("#{ytext}",String.valueOf(t.getYtext()));
 		sql  = sql.replace("#{categories}",String.valueOf(t.getCategories()));
 		sql  = sql.replace("#{is_show_list}",String.valueOf(t.getIsShowList()));
 		sql  = sql.replace("#{x_page_js}",String.valueOf(t.getXpageJs()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
}