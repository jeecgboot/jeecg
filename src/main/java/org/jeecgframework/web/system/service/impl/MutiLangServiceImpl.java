package org.jeecgframework.web.system.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.jeecgframework.core.common.dao.ICommonDao;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.BrowserUtils;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.system.pojo.base.MutiLangEntity;
import org.jeecgframework.web.system.service.CacheServiceI;
import org.jeecgframework.web.system.service.MutiLangServiceI;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("mutiLangService")
public class MutiLangServiceImpl extends CommonServiceImpl implements MutiLangServiceI {
	private static final Logger logger = LoggerFactory.getLogger(MutiLangServiceImpl.class);
	@Autowired
	private CacheServiceI cacheService;
	
	
	/**初始化语言信息，TOMCAT启动时直接加入到内存中**/
	public void initAllMutiLang() {
		Map<String, String> ls = new HashMap<String, String>();
		List<MutiLangEntity> mutiLang = this.commonDao.loadAll(MutiLangEntity.class);
		for (MutiLangEntity mutiLangEntity : mutiLang) {
			ls.put(mutiLangEntity.getLangKey() + "_" + mutiLangEntity.getLangCode(), mutiLangEntity.getLangContext());
		}
		cacheService.put(CacheServiceI.FOREVER_CACHE,ResourceUtil.MUTI_LANG_FOREVER_CACHE_KEY,ls);
		logger.info("  ------ 初始化国际化语言【系统缓存】  ------ size: [{}] ",ls.size());
	}
	
	/**
	 * 更新缓存，插入缓存
	 */
	public void putMutiLang(String langKey,String langCode,String langContext) {
		Map<String, String> ls ;
		Object obj = cacheService.get(CacheServiceI.FOREVER_CACHE,ResourceUtil.MUTI_LANG_FOREVER_CACHE_KEY);
		if(obj!=null){
			ls = (Map<String, String>) obj;
		}else{
			ls = new HashMap<String, String>();
		}
		ls.put(langKey + "_" + langCode, langContext);
		
		cacheService.put(CacheServiceI.FOREVER_CACHE,ResourceUtil.MUTI_LANG_FOREVER_CACHE_KEY,ls);
	}
	
	/**
	 * 更新缓存，插入缓存
	 */
	public void putMutiLang(MutiLangEntity mutiLangEntity) {
		Map<String, String> ls ;
		Object obj = cacheService.get(CacheServiceI.FOREVER_CACHE,ResourceUtil.MUTI_LANG_FOREVER_CACHE_KEY);
		if(obj!=null){
			ls = (Map<String, String>) obj;
		}else{
			ls = new HashMap<String, String>();
		}
		ls.put(mutiLangEntity.getLangKey() + "_" + mutiLangEntity.getLangCode(), mutiLangEntity.getLangContext());
		cacheService.put(CacheServiceI.FOREVER_CACHE,ResourceUtil.MUTI_LANG_FOREVER_CACHE_KEY,ls);
	}
	
	

	/** 刷新多语言cach **/
	public void refleshMutiLangCach() {
		logger.info("  ------ 重置国际化语言【系统缓存】  ------  ");
		initAllMutiLang();
	}
	
}