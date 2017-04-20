package com.jeecg.demo.service;
import com.jeecg.demo.entity.JeecgDemoEntity;
import org.jeecgframework.core.common.service.CommonService;

import java.io.Serializable;

public interface JeecgDemoServiceI extends CommonService{
	
 	public void delete(JeecgDemoEntity entity) throws Exception;
 	
 	public Serializable save(JeecgDemoEntity entity) throws Exception;
 	
 	public void saveOrUpdate(JeecgDemoEntity entity) throws Exception;
 	
 	
 	
}
