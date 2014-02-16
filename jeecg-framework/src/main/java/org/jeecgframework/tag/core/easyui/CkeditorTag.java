package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.jeecgframework.core.util.PropertiesUtil;
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
	protected boolean isfinder;// 是否加载ckfinder(默认true)
	protected String type;// 其它属性(用法:height:400,uiColor:'#9AB8F3' 用,分割)

	public boolean isIsfinder() {
		return isfinder;
	}

	public void setIsfinder(boolean isfinder) {
		this.isfinder = isfinder;
	}

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
		StringBuffer sb = new StringBuffer();

		sb.append("<textarea id=\"" + name + "_text\" name=\"" + name + "\">"
				+ value + "</textarea>");
		sb.append("<script type=\"text/javascript\">var ckeditor_" + name
				+ "=CKEDITOR.replace(\"" + name + "_text\",{");
		if (isfinder) {
			PropertiesUtil util = new PropertiesUtil("sysConfig.properties");
			sb.append("filebrowserBrowseUrl:"
					+ util.readProperty("filebrowserBrowseUrl") + ",");
			sb.append("filebrowserImageBrowseUrl:"
					+ util.readProperty("filebrowserImageBrowseUrl") + ",");
			sb.append("filebrowserFlashBrowseUrl:"
					+ util.readProperty("filebrowserFlashBrowseUrl") + ",");
			sb.append("filebrowserUploadUrl:"
					+ util.readProperty("filebrowserUploadUrl") + ",");
			sb.append("filebrowserImageUploadUrl:"
					+ util.readProperty("filebrowserImageUploadUrl") + ",");
			sb.append("filebrowserFlashUploadUrl:"
					+ util.readProperty("filebrowserFlashUploadUrl") + "");
		}
		if (isfinder && StringUtil.isNotEmpty(type))
			sb.append(",");
		if (StringUtil.isNotEmpty(type))
			sb.append(type);
		sb.append("});");
		if (isfinder) {
			sb.append("CKFinder.SetupCKEditor(ckeditor_" + name + ");");
		}
		sb.append("</script>");
		return sb;
	}
}
