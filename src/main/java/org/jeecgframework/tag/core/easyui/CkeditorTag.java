package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.jeecgframework.core.util.StringUtil;

/**
 * 
 * @author  张代浩
 *
 */
public class CkeditorTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	protected String name;// 属性名称
	protected String value;// 默认值
	protected String type;// 其它属性(用法:height:400,uiColor:'#9AB8F3' 用,分割)

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

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

	public StringBuffer end() {
		StringBuffer sb = new StringBuffer();

		sb.append("<textarea id=\"" + name + "_text\" name=\"" + name + "\">"
				+ value + "</textarea>");
		sb.append("<script type=\"text/javascript\">var ckeditor_" + name
				+ "=CKEDITOR.replace(\"" + name + "_text\",{");
		if (StringUtil.isNotEmpty(type))
			sb.append(type);
		sb.append("});");
		sb.append("</script>");
		return sb;
	}
}
