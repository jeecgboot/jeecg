package org.jeecgframework.web.system.service;

import java.util.List;

import org.jeecgframework.web.system.pojo.base.DynamicDataSourceEntity;

public interface DynamicDataSourceServiceI{

	public List<DynamicDataSourceEntity> initDynamicDataSource();

	public void refleshCache();


	public DynamicDataSourceEntity getDynamicDataSourceEntityForDbKey(String dbKey);


}
