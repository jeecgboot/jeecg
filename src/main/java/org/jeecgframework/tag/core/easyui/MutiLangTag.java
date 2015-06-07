
package org.jeecgframework.tag.core.easyui;

import java.io.IOException;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.jeecgframework.web.system.service.MutiLangServiceI;
import org.springframework.beans.factory.annotation.Autowired;
import org.jeecgframework.core.util.StringUtil;


/**
 * 类描述：MutiLang标签处理类
 * 
 * @author 高留刚
 * @date： 日期：2012-12-7 时间：上午10:17:45
 * @version 1.0
 */
@SuppressWarnings({ "serial", "rawtypes", "unchecked", "static-access" })
public class MutiLangTag extends TagSupport {
	protected String langKey;
	protected String langArg;

	@Autowired
	private static MutiLangServiceI mutiLangService;
	
	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}

	public int doEndTag() throws JspTagException {
		try {
			JspWriter out = this.pageContext.getOut();
			out.print(end().toString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	public StringBuffer end() {
		if (mutiLangService == null)
		{
			mutiLangService = ApplicationContextUtil.getContext().getBean(MutiLangServiceI.class);	
		}
		
		String lang_context = mutiLangService.getLang(langKey, langArg);
		
		return new StringBuffer(lang_context);
	}

	public void setLangKey(String langKey) {
		this.langKey = langKey;
	}
	
	public void setLangArg(String langArg) {
		this.langArg = langArg;
	}
}
