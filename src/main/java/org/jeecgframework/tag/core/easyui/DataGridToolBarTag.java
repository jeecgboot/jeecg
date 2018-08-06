package org.jeecgframework.tag.core.easyui;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

import org.jeecgframework.core.util.MutiLangUtil;

/**
 *  @author 张代浩
 * 类描述：列表工具条标签
 */
public class DataGridToolBarTag extends TagSupport {
	protected String url;
	protected String title;
	private String exp;//判断链接是否显示的表达式
	private String funname;//自定义函数名称
	private String icon;//图标
	private String onclick;
	private String width;
	private String height;
	private String operationCode;//按钮的操作Code
	private String langArg;//按钮的操作Code

	private String id;//控件ID

	private boolean inGroup = false;//是否是 更多操作按钮组下面的

	
	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}
	public int doEndTag() throws JspTagException {
		title = MutiLangUtil.doMutiLang(title, langArg);
		
		Tag t = findAncestorWithClass(this, DataGridTag.class);
		DataGridTag parent = (DataGridTag) t;
		parent.setToolbar(url, title, icon, exp,onclick, funname,operationCode,width,height,id,inGroup);
		return EVAL_PAGE;
	}
	
	public void setFunname(String funname) {
		this.funname = funname;
	}
	public void setExp(String exp) {
		this.exp = exp;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public void setOnclick(String onclick) {
		this.onclick = onclick;
	}
	public void setOperationCode(String operationCode) {
		this.operationCode = operationCode;
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
	public void setLangArg(String langArg) {
		this.langArg = langArg;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public boolean isInGroup() {
		return inGroup;
	}
	public void setInGroup(boolean inGroup) {
		this.inGroup = inGroup;
	}
}
