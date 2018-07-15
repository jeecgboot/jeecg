package org.jeecgframework.core.online.util;

import java.io.StringWriter;
import java.util.Map;

import org.jeecgframework.core.util.ApplicationContextUtil;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateDirectiveModel;
/**
 * 
 * @Title:FreemarkerHelper
 * @description:Freemarker引擎协助类
 * @author 赵俊夫
 * @date Jul 5, 2013 2:58:29 PM
 * @version V1.0
 */
public class FreemarkerHelper {
	private static Configuration _tplConfig = new Configuration();
	static{
		_tplConfig.setSharedVariable("DictData", (TemplateDirectiveModel)ApplicationContextUtil.getContext().getBean("dictDataTag"));
		_tplConfig.setSharedVariable("mutiLang", (TemplateDirectiveModel)ApplicationContextUtil.getContext().getBean("mutiLangTag"));

		_tplConfig.setSharedVariable("exp", (TemplateDirectiveModel)ApplicationContextUtil.getContext().getBean("expTag"));

		_tplConfig.setClassForTemplateLoading(FreemarkerHelper.class, "/");
		_tplConfig.setDateTimeFormat("yyyy-MM-dd HH:mm:ss");
		_tplConfig.setDateFormat("yyyy-MM-dd");
		_tplConfig.setTimeFormat("HH:mm:ss");
		 //classic_compatible设置，解决报空指针错误
		_tplConfig.setClassicCompatible(true);
	}

	/**
	 * 解析ftl
	 * @param tplName 模板名
	 * @param encoding 编码
	 * @param paras 参数
	 * @return
	 */
	public String parseTemplate(String tplName, String encoding,
			Map<String, Object> paras) {
		try {
			StringWriter swriter = new StringWriter();
			Template mytpl = null;
			mytpl = _tplConfig.getTemplate(tplName, encoding);
			mytpl.setDateTimeFormat("yyyy-MM-dd HH:mm:ss");  
			mytpl.setDateFormat("yyyy-MM-dd");
			mytpl.setTimeFormat("HH:mm:ss"); 
			mytpl.process(paras, swriter);
			return swriter.toString();
		} catch (Exception e) {
			e.printStackTrace();
			return e.toString();
		}

	}
	public String parseTemplate(String tplName, Map<String, Object> paras) {
		return this.parseTemplate(tplName, "utf-8", paras);
	}
}