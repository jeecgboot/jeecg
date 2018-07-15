package org.jeecgframework.web.system.service.impl;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;
import org.jeecgframework.web.system.service.CacheServiceI;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class EhcacheService implements CacheServiceI {
	private static final Logger log = LoggerFactory.getLogger(EhcacheService.class);
	public static CacheManager manager = CacheManager.create();
	
	@Override
	public Object get(String cacheName, Object key) {
		log.debug("  EhcacheService  get cacheName: [{}] , key: [{}]",cacheName,key);
		Cache cache = manager.getCache(cacheName);
		if (cache != null) {
			Element element = cache.get(key);
			if (element != null) {
				return element.getObjectValue();
			}
		}
		return null;
	}

	@Override
	public void put(String cacheName, Object key, Object value) {
		log.debug("  EhcacheService  put cacheName: [{}] , key: [{}]",cacheName,key);
		Cache cache = manager.getCache(cacheName);
		if (cache != null) {
			cache.put(new Element(key, value));
		}
	}

	@Override
	public boolean remove(String cacheName, Object key) {
		log.debug("  EhcacheService  remove cacheName: [{}] , key: [{}]",cacheName,key);
		Cache cache = manager.getCache(cacheName);
		if (cache != null) {
			return cache.remove(key);
		}
		return false;
	}

	@Override
	public void clean() {
		log.debug("  EhcacheService  clean all ");
		Cache eternalCache = manager.getCache(SYSTEM_BASE_CACHE);
		Cache tagCache = manager.getCache(TAG_CACHE);
		if (eternalCache != null) {
			eternalCache.removeAll();
		}
		if (tagCache != null) {
			tagCache.removeAll();
		}
	}

	@Override
	public void clean(String cacheName) {
		log.info("  EhcacheService  clean cacheName：[{}] ",cacheName);
		Cache eCache = manager.getCache(cacheName);
		if (eCache != null) {
			eCache.removeAll();
		}
	}

}
