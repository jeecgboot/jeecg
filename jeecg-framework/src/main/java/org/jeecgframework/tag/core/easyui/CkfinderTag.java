package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.jeecgframework.core.util.StringUtil;

/**
 * ckfinder标签
 * 
 * @author Alexander
 * 
 */
public class CkfinderTag extends TagSupport {

	private static final long serialVersionUID = 1L;
	protected String name;// 属性名称
	protected String value;// 默认值
	protected String width;// 显示图片宽(上传类型为Images时)
	protected String height;// 显示图片高(上传类型为Images时)
	protected String buttonClass;// 按钮样式
	protected String buttonValue;// 按钮名称
	protected String uploadType;// 上传类型(Images,Files,Flash)

	public String getButtonValue() {
		return buttonValue;
	}

	public void setButtonValue(String buttonValue) {
		this.buttonValue = buttonValue;
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

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeight() {
		return height;
	}

	public void setHeight(String height) {
		this.height = height;
	}

	public String getButtonClass() {
		return buttonClass;
	}

	public void setButtonClass(String buttonClass) {
		this.buttonClass = buttonClass;
	}

	public String getUploadType() {
		return uploadType;
	}

	public void setUploadType(String uploadType) {
		this.uploadType = uploadType;
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
		if ("Images".equals(uploadType)) {
			sb.append("<img src=\"" + value + "\" width=\"" + width
					+ "\" height=\"" + height + "\" id=\"" + name + "_herf\" ");
			if (StringUtil.isEmpty(value))
				sb.append("hidden=\"hidden\"");
			sb.append(" />");
		} else {
			sb.append("<a href=\"" + value + "\" id=\"" + name + "_herf\"></a>");
			sb.append("<script type=\"text/javascript\">decode(\"" + value
					+ "\", \"" + name + "_herf\")</script>");
		}
		sb.append("<input type=\"hidden\" id=\"" + name + "_input\" name=\""
				+ name + "\" value=\"" + value + "\">");
		sb.append("<input class=\"" + buttonClass
				+ "\" type=\"button\" value=\"" + buttonValue
				+ "\" onclick=\"browse('" + name + "_input','" + name
				+ "_herf','" + uploadType + "')\">");
		return sb;
	}
}
