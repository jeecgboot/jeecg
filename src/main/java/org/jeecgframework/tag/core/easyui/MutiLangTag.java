
package org.jeecgframework.tag.core.easyui;

import org.jeecgframework.core.util.MutiLangUtil;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;
import java.io.IOException;


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
	
	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}

	public int doEndTag() throws JspTagException {
		JspWriter out = null;
		try {
			out = this.pageContext.getOut();
			out.print(end().toString());
			out.flush();
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			try {
				out.clear();
				out.close();
			} catch (Exception e2) {
			}
		}
		return EVAL_PAGE;
	}

	public String end() {
		return MutiLangUtil.getLang(langKey, langArg);
	}

	public void setLangKey(String langKey) {
		this.langKey = langKey;
	}
	
	public void setLangArg(String langArg) {
		this.langArg = langArg;
	}
}
