package org.jeecgframework.tag.vo.easyui;

/**
 * 
 * @author  张代浩
 *
 */
public class DataGridUrl {
	private String url;//操作链接地址
	private String title;//按钮名称
	private String icon;//按钮图标
	private String value;//传入参数
	private String width;//弹出窗宽度
	private String height;//弹出窗高度
	private OptTypeDirection type;//按钮类型
	private String isbtn;//是否是操作选项以外的链接
	private String message;//询问链接的提示语
	private String exp;//判断链接是否显示的表达式
	private String funname;//自定义函数名称
	private boolean isRadio;//是否是单选框
	private String onclick;//选项单击事件
	private String urlStyle;//url样式

	private String urlclass;//按钮样式
	private String urlfont;//按钮图标

	public String getOnclick() {
		return onclick;
	}

	public void setOnclick(String onclick) {
		this.onclick = onclick;
	}

	public void setRadio(boolean isRadio) {
		this.isRadio = isRadio;
	}

	public String getFunname() {
		return funname;
	}
	public void setFunname(String funname) {
		this.funname = funname;
	}

	public String getMessage() {
		return message;
	}
	public String getExp() {
		return exp;
	}

	public void setExp(String exp) {
		this.exp = exp;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getIsbtn() {
		return isbtn;
	}

	public void setIsbtn(String isbtn) {
		this.isbtn = isbtn;
	}

	public void setType(OptTypeDirection type) {
		this.type = type;
	}

	public OptTypeDirection getType() {
		return type;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getValue() {
		return value;
	}

	public void setValue(String value) {
		this.value = value;
	}
	public boolean isRadio() {
		return isRadio;
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
	public String getIcon() {
		return icon;
	}
	public void setHeight(String height) {
		this.height = height;
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}

	public void setUrlStyle(String urlStyle) {
		this.urlStyle = urlStyle;
	}

	public String getUrlStyle() {
		return urlStyle;
	}

		public String getUrlclass() {
			return urlclass;
		}
		public void setUrlclass(String urlclass) {
			this.urlclass = urlclass;
		}
		public String getUrlfont() {
			return urlfont;
		}
		public void setUrlfont(String urlfont) {
			this.urlfont = urlfont;
		}


}
