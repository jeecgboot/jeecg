package org.jeecgframework.web.system.service.impl;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.jeecgframework.core.common.dao.ICommonDao;
import org.jeecgframework.core.util.BrowserUtils;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.system.pojo.base.MutiLangEntity;
import org.jeecgframework.web.system.service.MutiLangServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("mutiLangService")

public class MutiLangServiceImpl implements MutiLangServiceI {
	@Autowired
	public ICommonDao commonDao;
	
	/**初始化语言信息，TOMCAT启动时直接加入到内存中**/
	@Transactional(readOnly = true)
	public void initAllMutiLang() {
		List<MutiLangEntity> mutiLang = this.commonDao.loadAll(MutiLangEntity.class);
		
		for (MutiLangEntity mutiLangEntity : mutiLang) {
			ResourceUtil.mutiLangMap.put(mutiLangEntity.getLangKey() + "_" + mutiLangEntity.getLangCode(), mutiLangEntity.getLangContext());
		}
	}
	
	/**
	 * 更新缓存，插入缓存
	 */
	public void putMutiLang(String langKey,String langCode,String langContext) {
		ResourceUtil.mutiLangMap.put(langKey + "_" + langCode, langContext);
	}
	
	/**
	 * 更新缓存，插入缓存
	 */
	public void putMutiLang(MutiLangEntity mutiLangEntity) {
		ResourceUtil.mutiLangMap.put(mutiLangEntity.getLangKey() + "_" + mutiLangEntity.getLangCode(), mutiLangEntity.getLangContext());
	}
	
	
	/**取 o_muti_lang.lang_key 的值返回当前语言的值**/
	public String getLang(String langKey)
	{
		//如果为空，返回空串，防止返回null
		if(langKey==null){
			return "";
		}
		HttpServletRequest request = ContextHolderUtils.getRequest();
		String language = oConvertUtils.getString(request.getSession().getAttribute("lang"));
		if(oConvertUtils.isEmpty(language)){
			language = BrowserUtils.getBrowserLanguage(request);
		}
		
		String langContext = ResourceUtil.mutiLangMap.get(langKey + "_" + language); 
		if(StringUtil.isEmpty(langContext))
		{
			langContext = ResourceUtil.mutiLangMap.get("common.notfind.langkey" + "_" + language);
			if("null".equals(langContext)||langContext==null ||langKey.startsWith("?")){
				langContext = "";
			}
			langContext = langContext  + langKey;
		}
		return langContext;
	}

	public String getLang(String lanKey, String langArg) {
		String langContext = "";
		if(StringUtil.isEmpty(langArg))
		{
			langContext = getLang(lanKey);
		} else
		{
			String[] argArray = langArg.split(",");
			langContext = getLang(lanKey);
			
			for(int i=0; i< argArray.length; i++)
			{
				String langKeyArg = argArray[i].trim();
				String langKeyContext = getLang(langKeyArg);
				langContext = StringUtil.replace(langContext, "{" + i + "}", langKeyContext);
			}
		}
		return langContext;
	}

	/** 刷新多语言cach **/
	public void refleshMutiLangCach() {
		ResourceUtil.mutiLangMap.clear();
		initAllMutiLang();
	}
	
}