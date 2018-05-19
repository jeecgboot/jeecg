package org.jeecgframework.tag.core.easyui;

import java.io.IOException;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import org.jeecgframework.core.common.model.json.ComboBox;


/**
 * 
 * 类描述：下拉选择框标签
 * 
 * @author:  张代浩
 * @date： 日期：2012-12-7 时间：上午10:17:45
 * @version 1.0
 */
public class ComboBoxTag extends TagSupport {
	protected String id;// ID
	protected String text;// 显示文本
	protected String url;//远程数据
	protected String name;//控件名称
	protected Integer width;//宽度
	protected Integer listWidth;//下拉框宽度
	protected Integer listHeight;//下拉框高度
	protected boolean editable;//定义是否可以直接到文本域中键入文本
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
		ComboBox comboBox=new ComboBox();
		comboBox.setText(text);
		comboBox.setId(id);
		sb.append("<script type=\"text/javascript\">"
				+"$(function() {"
				+"$(\'#"+name+"\').combobox({"
				+"url:\'"+url+"&id="+id+"&text="+text+"\',"
				+"editable:\'"+editable+"\',"
				+"valueField:\'id\',"
				+"textField:\'text\'," 
				+"width:\'"+width+"\'," 
				+"listWidth:\'"+listWidth+"\'," 
				+"listHeight:\'"+listWidth+"\'," 
				+"onChange:function(){"
				+"var val = $(\'#"+name+"\').combobox(\'getValues\');"
				+"$(\'#"+name+"hidden\').val(val);"
				+"}"
				+"});"
				+"});"
				+"</script>");
		sb.append("<input type=\"hidden\" name=\""+name+"\" id=\""+name+"hidden\" > "
				+"<input class=\"easyui-combobox\" "
				+"multiple=\"true\" panelHeight=\"auto\" name=\""+name+"name\" id=\""+name+"\" >");
		return sb;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setText(String text) {
		this.text = text;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public void setName(String name) {
		this.name = name;
	}

    public boolean isEditable() {
        return editable;
    }

    public void setEditable(boolean editable) {
        this.editable = editable;
    }
}
