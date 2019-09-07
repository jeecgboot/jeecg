package org.jeecgframework.tag.core.easyui;

import org.jeecgframework.core.util.MutiLangUtil;

import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.tagext.Tag;
import javax.servlet.jsp.tagext.TagSupport;

/**
 * 
 * 类描述：选项卡选项标签
 * 
 * 张代浩
 * @date： 日期：2012-12-7 时间：上午10:17:45
 * @version 1.0
 */
public class TabTag extends TagSupport {
	private String href;//选项卡请求地址
	private String iframe;//选项卡iframe方法请求地址
	private String id;//选项卡唯一ID
	private String title;//标题
	private String icon="icon-default";//图标
	private String width;//宽度
	private String heigth;//高度
	private boolean cache;//是否打开缓冲如为TRUE则切换选项卡会再次发送请求
	private String content;
	private boolean closable=false;//是否带关闭按钮
	private String langArg;
	
	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}
	public int doEndTag() throws JspTagException {
		Tag t = findAncestorWithClass(this, TabsTag.class);
		TabsTag parent = (TabsTag) t;
		parent.setTab( id, title,iframe, href, icon, cache, content, width, heigth,closable);
		return EVAL_PAGE;
	}
	public void setHref(String href) {
		this.href = href;
	}
	public void setId(String id) {
		this.id = id;
	}
	public void setTitle(String title) {
		String lang_context = MutiLangUtil.getLang(title, langArg);
		
		this.title = lang_context;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}
	public void setWidth(String width) {
		this.width = width;
	}
	public void setHeigth(String heigth) {
		this.heigth = heigth;
	}
	public void setCache(boolean cache) {
		this.cache = cache;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public void setClosable(boolean closable) {
		this.closable = closable;
	}
	public void setIframe(String iframe) {
		this.iframe = iframe;
	}
	
}
