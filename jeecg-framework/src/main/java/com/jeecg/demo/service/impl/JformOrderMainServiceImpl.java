package com.jeecg.demo.service.impl;
import com.jeecg.demo.service.JformOrderMainServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import com.jeecg.demo.entity.JformOrderMainEntity;
import com.jeecg.demo.entity.JformOrderCustomerEntity;
import com.jeecg.demo.entity.JformOrderTicketEntity;

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


@Service("jformOrderMainService")
@Transactional
public class JformOrderMainServiceImpl extends CommonServiceImpl implements JformOrderMainServiceI {
	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 		//执行删除操作配置的sql增强
		this.doDelSql((JformOrderMainEntity)entity);
 	}
	
	public void addMain(JformOrderMainEntity jformOrderMain,
	        List<JformOrderCustomerEntity> jformOrderCustomerList,List<JformOrderTicketEntity> jformOrderTicketList){
			//保存主信息
			this.save(jformOrderMain);
		
			/**保存-JformOrderMain子表*/
			for(JformOrderCustomerEntity jformOrderCustomer:jformOrderCustomerList){
				//外键设置
				jformOrderCustomer.setFkId(jformOrderMain.getId());
				this.save(jformOrderCustomer);
			}
			/**保存-JformOrderMain子表*/
			for(JformOrderTicketEntity jformOrderTicket:jformOrderTicketList){
				//外键设置
				jformOrderTicket.setFckId(jformOrderMain.getId());
				this.save(jformOrderTicket);
			}
			//执行新增操作配置的sql增强
 			this.doAddSql(jformOrderMain);
	}

	
	public void updateMain(JformOrderMainEntity jformOrderMain,
	        List<JformOrderCustomerEntity> jformOrderCustomerList,List<JformOrderTicketEntity> jformOrderTicketList) {
		//保存主表信息
		if(StringUtil.isNotEmpty(jformOrderMain.getId())){
			try {
				JformOrderMainEntity temp = findUniqueByProperty(JformOrderMainEntity.class, "id", jformOrderMain.getId());
				MyBeanUtils.copyBeanNotNull2Bean(jformOrderMain, temp);
				this.saveOrUpdate(temp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			this.saveOrUpdate(jformOrderMain);
		}
		//===================================================================================
		//获取参数
		Object id0 = jformOrderMain.getId();
		Object id1 = jformOrderMain.getId();
		//===================================================================================
		//1.查询出数据库的明细数据-JformOrderMain子表
	    String hql0 = "from JformOrderCustomerEntity where 1 = 1 AND fK_ID = ? ";
	    List<JformOrderCustomerEntity> jformOrderCustomerOldList = this.findHql(hql0,id0);
		//2.筛选更新明细数据-JformOrderMain子表

	    //TODO author：XueLin  for: 客户数据全删完size == 0
		if(jformOrderCustomerList != null){// && jformOrderCustomerList.size() > 0 

			for(JformOrderCustomerEntity oldE : jformOrderCustomerOldList){
				boolean isUpdate = false;
				for(JformOrderCustomerEntity sendE : jformOrderCustomerList){
					//需要更新的明细数据-JformOrderMain子表
					if(oldE.getId().equals(sendE.getId())){
		    			try {
							MyBeanUtils.copyBeanNotNull2Bean(sendE,oldE);
							this.saveOrUpdate(oldE);
						} catch (Exception e) {
							e.printStackTrace();
							throw new BusinessException(e.getMessage());
						}
						isUpdate = true;
		    			break;
		    		}
		    	}
	    		if(!isUpdate){
		    		//如果数据库存在的明细，前台没有传递过来则是删除-JformOrderMain子表
		    		super.delete(oldE);
	    		}	    		
			}
			//3.持久化新增的数据-JformOrderMain子表
			for(JformOrderCustomerEntity jformOrderCustomer:jformOrderCustomerList){
				if(oConvertUtils.isEmpty(jformOrderCustomer.getId())){
					//外键设置
					jformOrderCustomer.setFkId(jformOrderMain.getId());
					this.save(jformOrderCustomer);
				}
			}
		}
		//===================================================================================
		//1.查询出数据库的明细数据-JformOrderMain子表
	    String hql1 = "from JformOrderTicketEntity where 1 = 1 AND fCK_ID = ? ";
	    List<JformOrderTicketEntity> jformOrderTicketOldList = this.findHql(hql1,id1);
		//2.筛选更新明细数据-JformOrderMain子表

	    //TODO author：XueLin  for: 机票信息全删完 size == 0
		if(jformOrderTicketList != null){// && jformOrderTicketList.size() > 0 

			for(JformOrderTicketEntity oldE : jformOrderTicketOldList){
				boolean isUpdate = false;
				for(JformOrderTicketEntity sendE : jformOrderTicketList){
					//需要更新的明细数据-JformOrderMain子表
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
		    		//如果数据库存在的明细，前台没有传递过来则是删除-JformOrderMain子表
		    		super.delete(oldE);
	    		}
	    		
			}
			//3.持久化新增的数据-JformOrderMain子表
			for(JformOrderTicketEntity jformOrderTicket:jformOrderTicketList){
				if(oConvertUtils.isEmpty(jformOrderTicket.getId())){
					//外键设置
					jformOrderTicket.setFckId(jformOrderMain.getId());
					this.save(jformOrderTicket);
				}
			}
		}
		//执行更新操作配置的sql增强
 		this.doUpdateSql(jformOrderMain);
	}

	
	public void delMain(JformOrderMainEntity jformOrderMain) {
		//删除主表信息
		this.delete(jformOrderMain);
		//===================================================================================
		//获取参数
		Object id0 = jformOrderMain.getId();
		Object id1 = jformOrderMain.getId();
		//===================================================================================
		//删除-JformOrderMain子表
	    String hql0 = "from JformOrderCustomerEntity where 1 = 1 AND fK_ID = ? ";
	    List<JformOrderCustomerEntity> jformOrderCustomerOldList = this.findHql(hql0,id0);
		this.deleteAllEntitie(jformOrderCustomerOldList);
		//===================================================================================
		//删除-JformOrderMain子表
	    String hql1 = "from JformOrderTicketEntity where 1 = 1 AND fCK_ID = ? ";
	    List<JformOrderTicketEntity> jformOrderTicketOldList = this.findHql(hql1,id1);
		this.deleteAllEntitie(jformOrderTicketOldList);
	}
	
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(JformOrderMainEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(JformOrderMainEntity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(JformOrderMainEntity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,JformOrderMainEntity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{order_code}",String.valueOf(t.getOrderCode()));
 		sql  = sql.replace("#{order_date}",String.valueOf(t.getOrderDate()));
 		sql  = sql.replace("#{order_money}",String.valueOf(t.getOrderMoney()));
 		sql  = sql.replace("#{content}",String.valueOf(t.getContent()));
 		sql  = sql.replace("#{ctype}",String.valueOf(t.getCtype()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
 	
 	/**
 	 * 更新用户数据
 	 * @param jformOrderCustomerList
 	 */
	public void updateCustomers(List<JformOrderCustomerEntity> jformOrderCustomerList){
		for(JformOrderCustomerEntity jformOrderCustomer:jformOrderCustomerList){
			this.saveOrUpdate(jformOrderCustomer);
		}
	}
}