package com.jeecg.demo.service;
import com.jeecg.demo.entity.JformOrderMainEntity;
import com.jeecg.demo.entity.JformOrderCustomerEntity;
import com.jeecg.demo.entity.JformOrderTicketEntity;

import java.util.List;
import org.jeecgframework.core.common.service.CommonService;
import java.io.Serializable;

public interface JformOrderMainServiceI extends CommonService{
	
 	public <T> void delete(T entity);
	/**
	 * 添加一对多
	 * 
	 */
	public void addMain(JformOrderMainEntity jformOrderMain,
	        List<JformOrderCustomerEntity> jformOrderCustomerList,List<JformOrderTicketEntity> jformOrderTicketList) ;
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(JformOrderMainEntity jformOrderMain,
	        List<JformOrderCustomerEntity> jformOrderCustomerList,List<JformOrderTicketEntity> jformOrderTicketList);
	public void delMain (JformOrderMainEntity jformOrderMain);
	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(JformOrderMainEntity t);
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(JformOrderMainEntity t);
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(JformOrderMainEntity t);
 	/**
 	 * 更新客户列表
 	 * @param jformOrderCustomerList
 	 */
	public void updateCustomers(List<JformOrderCustomerEntity> jformOrderCustomerList);
}
