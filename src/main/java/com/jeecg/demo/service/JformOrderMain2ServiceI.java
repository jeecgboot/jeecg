package com.jeecg.demo.service;
import com.jeecg.demo.entity.JformOrderMain2Entity;
import com.jeecg.demo.entity.JformOrderTicket2Entity;
import com.jeecg.demo.entity.JformOrderCustomer2Entity;

import java.util.List;
import org.jeecgframework.core.common.service.CommonService;
import java.io.Serializable;

public interface JformOrderMain2ServiceI extends CommonService{
	
 	public <T> void delete(T entity);
 	
 	/*public <T> void add(T entity);
 	
 	public <T> void addOrUpdate(T entity);*/
	/**
	 * 添加一对多
	 * 
	 */
	public void addMain(JformOrderMain2Entity jformOrderMain2,
	        List<JformOrderTicket2Entity> jformOrderTicket2List,List<JformOrderCustomer2Entity> jformOrderCustomer2List) ;
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(JformOrderMain2Entity jformOrderMain2,
	        List<JformOrderTicket2Entity> jformOrderTicket2List,List<JformOrderCustomer2Entity> jformOrderCustomer2List);
	public void delMain (JformOrderMain2Entity jformOrderMain2);
	
 	/**
	 * 默认按钮-sql增强-新增操作
	 * @param id
	 * @return
	 */
 	public boolean doAddSql(JformOrderMain2Entity t);
 	/**
	 * 默认按钮-sql增强-更新操作
	 * @param id
	 * @return
	 */
 	public boolean doUpdateSql(JformOrderMain2Entity t);
 	/**
	 * 默认按钮-sql增强-删除操作
	 * @param id
	 * @return
	 */
 	public boolean doDelSql(JformOrderMain2Entity t);
}
