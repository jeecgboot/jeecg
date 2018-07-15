package com.jeecg.demo.service.impl;
import com.jeecg.demo.service.JfromOrderServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import com.jeecg.demo.entity.JfromOrderEntity;
import com.jeecg.demo.entity.JfromOrderLineEntity;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import java.util.ArrayList;
import java.util.UUID;
import java.io.Serializable;


@Service("jfromOrderService")
@Transactional
public class JfromOrderServiceImpl extends CommonServiceImpl implements JfromOrderServiceI {
	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((JfromOrderEntity)entity);
 	}
	
	public void addMain(JfromOrderEntity jfromOrder,
	        List<JfromOrderLineEntity> jfromOrderLineList){
			//保存主信息
			this.save(jfromOrder);
		
			/**保存-订单表体*/
			for(JfromOrderLineEntity jfromOrderLine:jfromOrderLineList){
				//外键设置
				jfromOrderLine.setOrderid(jfromOrder.getId());
				this.save(jfromOrderLine);
			}
			//执行新增操作配置的sql增强
 			this.doAddSql(jfromOrder);
	}

	
	public void updateMain(JfromOrderEntity jfromOrder,
	        List<JfromOrderLineEntity> jfromOrderLineList) {
		//保存主表信息
		if(StringUtil.isNotEmpty(jfromOrder.getId())){
			try {
				JfromOrderEntity temp = findUniqueByProperty(JfromOrderEntity.class, "id", jfromOrder.getId());
				MyBeanUtils.copyBeanNotNull2Bean(jfromOrder, temp);
				this.saveOrUpdate(temp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			this.saveOrUpdate(jfromOrder);
		}
		//===================================================================================
		//获取参数
		Object id0 = jfromOrder.getId();
		//===================================================================================
		//1.查询出数据库的明细数据-订单表体
	    String hql0 = "from JfromOrderLineEntity where 1 = 1 AND oRDERID = ? ";
	    List<JfromOrderLineEntity> jfromOrderLineOldList = this.findHql(hql0,id0);
		//2.筛选更新明细数据-订单表体
		if(jfromOrderLineList!=null&&jfromOrderLineList.size()>0){
		for(JfromOrderLineEntity oldE:jfromOrderLineOldList){
			boolean isUpdate = false;
				for(JfromOrderLineEntity sendE:jfromOrderLineList){
					//需要更新的明细数据-订单表体
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
		    		//如果数据库存在的明细，前台没有传递过来则是删除-订单表体
		    		super.delete(oldE);
	    		}
	    		
			}
			//3.持久化新增的数据-订单表体
			for(JfromOrderLineEntity jfromOrderLine:jfromOrderLineList){
				if(oConvertUtils.isEmpty(jfromOrderLine.getId())){
					//外键设置
					jfromOrderLine.setOrderid(jfromOrder.getId());
					this.save(jfromOrderLine);
				}
			}
		}
		//执行更新操作配置的sql增强
 		this.doUpdateSql(jfromOrder);
	}

	
	public void delMain(JfromOrderEntity jfromOrder) {
		//删除主表信息
		this.delete(jfromOrder);
		//===================================================================================
		//获取参数
		Object id0 = jfromOrder.getId();
		//===================================================================================
		//删除-订单表体
	    String hql0 = "from JfromOrderLineEntity where 1 = 1 AND oRDERID = ? ";
	    List<JfromOrderLineEntity> jfromOrderLineOldList = this.findHql(hql0,id0);
		this.deleteAllEntitie(jfromOrderLineOldList);
	}
	
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(JfromOrderEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(JfromOrderEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(JfromOrderEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,JfromOrderEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{create_name}",String.valueOf(t.getCreateName()));
 		sql  = sql.replace("#{create_by}",String.valueOf(t.getCreateBy()));
 		sql  = sql.replace("#{create_date}",String.valueOf(t.getCreateDate()));
 		sql  = sql.replace("#{update_name}",String.valueOf(t.getUpdateName()));
 		sql  = sql.replace("#{update_by}",String.valueOf(t.getUpdateBy()));
 		sql  = sql.replace("#{update_date}",String.valueOf(t.getUpdateDate()));
 		sql  = sql.replace("#{sys_org_code}",String.valueOf(t.getSysOrgCode()));
 		sql  = sql.replace("#{sys_company_code}",String.valueOf(t.getSysCompanyCode()));
 		sql  = sql.replace("#{bpm_status}",String.valueOf(t.getBpmStatus()));
 		sql  = sql.replace("#{receiver_name}",String.valueOf(t.getReceiverName()));
 		sql  = sql.replace("#{receiver_mobile}",String.valueOf(t.getReceiverMobile()));
 		sql  = sql.replace("#{receiver_state}",String.valueOf(t.getReceiverState()));
 		sql  = sql.replace("#{receiver_city}",String.valueOf(t.getReceiverCity()));
 		sql  = sql.replace("#{receiver_district}",String.valueOf(t.getReceiverDistrict()));
 		sql  = sql.replace("#{receiver_address}",String.valueOf(t.getReceiverAddress()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
}