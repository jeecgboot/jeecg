package org.jeecgframework.web.cgform.engine.tag;

import freemarker.core.Environment;
import freemarker.template.*;
import org.jeecgframework.core.util.MutiLangUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;

import java.io.IOException;
import java.io.Writer;
import java.util.Map;

/**
 * 自定义多语言标签
 * 使用方法 ：<@mutiLang langKey="${po.content}"/>
 * @author Zhoujf
 * 
 */
@Component("mutiLangTag")
public class MutiLangTag implements TemplateDirectiveModel {

	private static final Logger LOG = LoggerFactory.getLogger(MutiLangTag.class);

	public void execute(Environment env, Map params, TemplateModel[] loopVars,
			TemplateDirectiveBody body) throws TemplateException, IOException {

		// 多语言key
		String langKey = getAttribute(params, "langKey");
		if (langKey == null) {
			throw new TemplateException(
					"Can not find attribute 'name' in data tag", env);
		}
		
		String langArg = getAttribute(params, "langArg");

		String lang_context = MutiLangUtil.getLang(langKey, langArg);
		
		
		Writer out = env.getOut();
		out.append(lang_context);
	}

	/**
	 * 取得标签参数
	 * 
	 * @param params
	 * @param name
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private String getAttribute(Map params, String name) {
		String value = null;
		if (params.containsKey(name)) {
			TemplateModel paramValue = (TemplateModel) params.get(name);
			try {
				value = ((TemplateScalarModel) paramValue).getAsString();
			} catch (TemplateModelException e) {
				LOG.error("get attribute '{}' error", name, e);
			}
		}
		return value;
	}
}
