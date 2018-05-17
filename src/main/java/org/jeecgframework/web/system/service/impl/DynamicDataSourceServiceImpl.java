package org.jeecgframework.web.system.service.impl;

import java.util.List;

import org.jeecgframework.core.common.dao.ICommonDao;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.web.system.pojo.base.DynamicDataSourceEntity;
import org.jeecgframework.web.system.service.DynamicDataSourceServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service("dynamicDataSourceService")
public class DynamicDataSourceServiceImpl implements DynamicDataSourceServiceI {
	@Autowired
	public ICommonDao commonDao;
	
	/**初始化数据库信息，TOMCAT启动时直接加入到内存中**/
	@Transactional(readOnly = true)
	public List<DynamicDataSourceEntity> initDynamicDataSource() {
		ResourceUtil.dynamicDataSourceMap.clear();

		List<DynamicDataSourceEntity> dynamicSourceEntityList = this.commonDao.loadAll(DynamicDataSourceEntity.class);

		for (DynamicDataSourceEntity dynamicSourceEntity : dynamicSourceEntityList) {
			ResourceUtil.dynamicDataSourceMap.put(dynamicSourceEntity.getDbKey(), dynamicSourceEntity);
		}
		return dynamicSourceEntityList;
	}

	public static DynamicDataSourceEntity getDbSourceEntityByKey(String dbKey) {
		DynamicDataSourceEntity dynamicDataSourceEntity = ResourceUtil.dynamicDataSourceMap.get(dbKey);

		return dynamicDataSourceEntity;
	}

	public void refleshCache() {
		initDynamicDataSource();
	}

	@Override
	@Transactional(readOnly = true)
	public DynamicDataSourceEntity getDynamicDataSourceEntityForDbKey(String dbKey){
		List<DynamicDataSourceEntity> dynamicDataSourceEntitys = commonDao.findHql("from DynamicDataSourceEntity where dbKey = ?", dbKey);
		if(dynamicDataSourceEntitys.size()>0)
			return dynamicDataSourceEntitys.get(0);
		return null;
	}

}