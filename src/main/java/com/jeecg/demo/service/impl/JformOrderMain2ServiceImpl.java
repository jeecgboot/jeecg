package com.jeecg.demo.service.impl;
import java.util.List;
import java.util.UUID;

import org.jeecgframework.core.common.exception.BusinessException;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeecg.demo.entity.JformOrderCustomer2Entity;
import com.jeecg.demo.entity.JformOrderMain2Entity;
import com.jeecg.demo.entity.JformOrderTicket2Entity;
import com.jeecg.demo.service.JformOrderMain2ServiceI;


@Service("jformOrderMain2Service")
@Transactional
public class JformOrderMain2ServiceImpl extends CommonServiceImpl implements JformOrderMain2ServiceI {
	
 	public <T> void delete(T entity) {
 		super.delete(entity);
 	}
	
	public void addMain(JformOrderMain2Entity jformOrderMain2,
	        List<JformOrderTicket2Entity> jformOrderTicket2List,List<JformOrderCustomer2Entity> jformOrderCustomer2List){
			//保存主信息
			this.save(jformOrderMain2);
		
			/**保存-订单机票信息*/
			for(JformOrderTicket2Entity jformOrderTicket2:jformOrderTicket2List){
				//外键设置
				jformOrderTicket2.setFckId(jformOrderMain2.getId());
				this.save(jformOrderTicket2);
			}
			/**保存-订单客户信息*/
			for(JformOrderCustomer2Entity jformOrderCustomer2:jformOrderCustomer2List){
				//外键设置
				jformOrderCustomer2.setFkId(jformOrderMain2.getId());
				this.save(jformOrderCustomer2);
			}
			//执行新增操作配置的sql增强
 			this.doAddSql(jformOrderMain2);
	}

	
	public void updateMain(JformOrderMain2Entity jformOrderMain2,
	        List<JformOrderTicket2Entity> jformOrderTicket2List,List<JformOrderCustomer2Entity> jformOrderCustomer2List) {
		//保存主表信息
		if(StringUtil.isNotEmpty(jformOrderMain2.getId())){
			try {
				JformOrderMain2Entity temp = findUniqueByProperty(JformOrderMain2Entity.class, "id", jformOrderMain2.getId());
				MyBeanUtils.copyBeanNotNull2Bean(jformOrderMain2, temp);
				this.saveOrUpdate(temp);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			this.saveOrUpdate(jformOrderMain2);
		}
		//===================================================================================
		//获取参数
		Object id0 = jformOrderMain2.getId();
		Object id1 = jformOrderMain2.getId();
		//===================================================================================
		//1.查询出数据库的明细数据-订单机票信息
	    String hql0 = "from JformOrderTicket2Entity where 1 = 1 AND fCK_ID = ? ";
	    List<JformOrderTicket2Entity> jformOrderTicket2OldList = this.findHql(hql0,id0);
		//2.筛选更新明细数据-订单机票信息
		if(jformOrderTicket2List!=null&&jformOrderTicket2List.size()>0){
		for(JformOrderTicket2Entity oldE:jformOrderTicket2OldList){
			boolean isUpdate = false;
				for(JformOrderTicket2Entity sendE:jformOrderTicket2List){
					//需要更新的明细数据-订单机票信息
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
		    		//如果数据库存在的明细，前台没有传递过来则是删除-订单机票信息
		    		super.delete(oldE);
	    		}
	    		
			}
			//3.持久化新增的数据-订单机票信息
			for(JformOrderTicket2Entity jformOrderTicket2:jformOrderTicket2List){
				if(oConvertUtils.isEmpty(jformOrderTicket2.getId())){
					//外键设置
					jformOrderTicket2.setFckId(jformOrderMain2.getId());
					this.save(jformOrderTicket2);
				}
			}
		}
		//===================================================================================
		//1.查询出数据库的明细数据-订单客户信息
	    String hql1 = "from JformOrderCustomer2Entity where 1 = 1 AND fK_ID = ? ";
	    List<JformOrderCustomer2Entity> jformOrderCustomer2OldList = this.findHql(hql1,id1);
		//2.筛选更新明细数据-订单客户信息
		if(jformOrderCustomer2List!=null&&jformOrderCustomer2List.size()>0){
		for(JformOrderCustomer2Entity oldE:jformOrderCustomer2OldList){
			boolean isUpdate = false;
				for(JformOrderCustomer2Entity sendE:jformOrderCustomer2List){
					//需要更新的明细数据-订单客户信息
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
		    		//如果数据库存在的明细，前台没有传递过来则是删除-订单客户信息
		    		super.delete(oldE);
	    		}
	    		
			}
			//3.持久化新增的数据-订单客户信息
			for(JformOrderCustomer2Entity jformOrderCustomer2:jformOrderCustomer2List){
				if(oConvertUtils.isEmpty(jformOrderCustomer2.getId())){
					//外键设置
					jformOrderCustomer2.setFkId(jformOrderMain2.getId());
					this.save(jformOrderCustomer2);
				}
			}
		}
		//执行更新操作配置的sql增强
 		this.doUpdateSql(jformOrderMain2);
	}

	
	public void delMain(JformOrderMain2Entity jformOrderMain2) {
		//删除主表信息
		this.delete(jformOrderMain2);
		//===================================================================================
		//获取参数
		Object id0 = jformOrderMain2.getId();
		Object id1 = jformOrderMain2.getId();
		//===================================================================================
		//删除-订单机票信息
	    String hql0 = "from JformOrderTicket2Entity where 1 = 1 AND fCK_ID = ? ";
	    List<JformOrderTicket2Entity> jformOrderTicket2OldList = this.findHql(hql0,id0);
		this.deleteAllEntitie(jformOrderTicket2OldList);
		//===================================================================================
		//删除-订单客户信息
	    String hql1 = "from JformOrderCustomer2Entity where 1 = 1 AND fK_ID = ? ";
	    List<JformOrderCustomer2Entity> jformOrderCustomer2OldList = this.findHql(hql1,id1);
		this.deleteAllEntitie(jformOrderCustomer2OldList);
	}
	
 	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(JformOrderMain2Entity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(JformOrderMain2Entity t){
	 	return true;
 	}
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(JformOrderMain2Entity t){
	 	return true;
 	}
 	
 	/**
	 * 替换sql中的变量
	 * @param sql
	 * @return
	 */
 	public String replaceVal(String sql,JformOrderMain2Entity t){
 		sql  = sql.replace("#{id}",String.valueOf(t.getId()));
 		sql  = sql.replace("#{order_code}",String.valueOf(t.getOrderCode()));
 		sql  = sql.replace("#{order_date}",String.valueOf(t.getOrderDate()));
 		sql  = sql.replace("#{order_money}",String.valueOf(t.getOrderMoney()));
 		sql  = sql.replace("#{content}",String.valueOf(t.getContent()));
 		sql  = sql.replace("#{UUID}",UUID.randomUUID().toString());
 		return sql;
 	}
}