package com.jeecg.demo.service;
import java.io.Serializable;

import org.jeecgframework.core.common.service.CommonService;

import com.jeecg.demo.entity.JeecgDemoExcelEntity;

public interface JeecgDemoExcelServiceI extends CommonService{
	
 	public void delete(JeecgDemoExcelEntity entity) throws Exception;
 	
 	public Serializable save(JeecgDemoExcelEntity entity) throws Exception;
 	
 	public void saveOrUpdate(JeecgDemoExcelEntity entity) throws Exception;
 	
}
