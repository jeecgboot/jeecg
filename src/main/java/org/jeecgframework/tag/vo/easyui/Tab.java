package org.jeecgframework.tag.vo.easyui;

/**
 * TAB模型
 * 
 * @author 张代浩
 * 
 */
public class Tab {
	private String href;
	private String iframe;
	private String id;
	private String title;
	private String icon = "'icon-default'";
	private String width;// 宽度
	private String heigth;// 高度
	private boolean cache;
	private String content;
	private boolean closable=true;
	/**
	 * @return the closable
	 */
	public boolean isClosable() {
		return closable;
	}

	/**
	 * @param closable
	 *            the closable to set
	 */
	public void setClosable(boolean closable) {
		this.closable = closable;
	}

	public String getHref() {
		return href;
	}

	public void setHref(String href) {
		this.href = href;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public String getWidth() {
		return width;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public String getHeigth() {
		return heigth;
	}

	public void setHeigth(String heigth) {
		this.heigth = heigth;
	}

	public boolean isCache() {
		return cache;
	}

	public void setCache(boolean cache) {
		this.cache = cache;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	public String getIframe() {
		return iframe;
	}

	public void setIframe(String iframe) {
		this.iframe = iframe;
	}


}
