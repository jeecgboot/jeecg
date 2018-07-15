package org.jeecgframework.web.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.jeecgframework.core.common.dao.ICommonDao;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.web.system.pojo.base.DynamicDataSourceEntity;
import org.jeecgframework.web.system.service.CacheServiceI;
import org.jeecgframework.web.system.service.DynamicDataSourceServiceI;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service("dynamicDataSourceService")
public class DynamicDataSourceServiceImpl implements DynamicDataSourceServiceI {
	private static final Logger logger = LoggerFactory.getLogger(DynamicDataSourceServiceImpl.class);
	
	@Autowired
	public ICommonDao commonDao;
	@Resource
	private CacheServiceI cacheService;
	
	/**初始化数据库信息，TOMCAT启动时直接加入到内存中**/
	@Transactional(readOnly = true)
	public List<DynamicDataSourceEntity> initDynamicDataSource() {
		Map<String, DynamicDataSourceEntity> dynamicDataSourceMap = new HashMap<String, DynamicDataSourceEntity>();
		List<DynamicDataSourceEntity> dynamicSourceEntityList = this.commonDao.loadAll(DynamicDataSourceEntity.class);

		for (DynamicDataSourceEntity dynamicSourceEntity : dynamicSourceEntityList) {
			dynamicDataSourceMap.put(dynamicSourceEntity.getDbKey(), dynamicSourceEntity);
		}
		//缓存数据
		cacheService.put(CacheServiceI.FOREVER_CACHE,ResourceUtil.DYNAMIC_DB_CONFIGS_FOREVER_CACHE_KEY,dynamicDataSourceMap);
		logger.info("  ------ 初始化动态数据源配置【系统缓存】---------size: [{}] ",dynamicDataSourceMap.size());
		return dynamicSourceEntityList;
	}

	public static DynamicDataSourceEntity getDbSourceEntityByKey(String dbKey) {
		DynamicDataSourceEntity dynamicDataSourceEntity = ResourceUtil.getCacheDynamicDataSourceEntity(dbKey);
		return dynamicDataSourceEntity;
	}

	public void refleshCache() {
		logger.info("  ------ 重置 动态数据源配置 & 数据源连接池缓存【系统缓存】--------- ");
		//1. 还原动态数据源DB配置
		initDynamicDataSource();
		
		//2.清空旧的DB连接池
		ResourceUtil.cleanCacheBasicDataSource();
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