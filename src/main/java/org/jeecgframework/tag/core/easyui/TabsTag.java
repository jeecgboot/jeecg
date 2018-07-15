package org.jeecgframework.tag.core.easyui;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.SysThemesUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.tag.core.JeecgTag;
import org.jeecgframework.tag.vo.easyui.Tab;


/**
 * 
 * 类描述：选项卡标签
 * 
 * 张代浩
 * @date： 日期：2012-12-7 时间：上午10:17:45
 * @version 1.0
 */
public class TabsTag extends JeecgTag {
	private static final long serialVersionUID = 1L;
	private String id;// 容器ID
	private String width;// 宽度
	private String heigth;// 高度
	private boolean plain;// 简洁模式
	private boolean fit = true;// 铺满浏览器
	private boolean border;// 边框
	private String scrollIncrement;// 滚动增量
	private String scrollDuration;// 滚动时间
	private boolean tools;// 工具栏
	private boolean tabs = true;// 是否创建父容器
	private boolean iframe = true;// 是否是iframe方式
	private String tabPosition = "top";// 选项卡位置

	public void setIframe(boolean iframe) {
		this.iframe = iframe;
	}

	public void setTabs(boolean tabs) {
		this.tabs = tabs;
	}

	public void setId(String id) {
		this.id = id;
	}

	public void setWidth(String width) {
		this.width = width;
	}

	public void setHeigth(String heigth) {
		this.heigth = heigth;
	}

	public void setPlain(boolean plain) {
		this.plain = plain;
	}

	public void setFit(boolean fit) {
		this.fit = fit;
	}

	public void setBorder(boolean border) {
		this.border = border;
	}

	public void setScrollIncrement(String scrollIncrement) {
		this.scrollIncrement = scrollIncrement;
	}

	public void setScrollDuration(String scrollDuration) {
		this.scrollDuration = scrollDuration;
	}

	public void setTools(boolean tools) {
		this.tools = tools;
	}

	public void setTabPosition(String tabPosition) {
		this.tabPosition = tabPosition;
	}

	public void setTabList(List<Tab> tabList) {
		this.tabList = tabList;
	}

	private List<Tab> tabList = new ArrayList<Tab>();

	public int doStartTag() throws JspTagException {
		tabList.clear();
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
				end().setLength(0);
			} catch (Exception e2) {
			}
		}
		return EVAL_PAGE;
	}

	public StringBuffer end() {

		StringBuffer sb = this.getTagCache();
		if(sb != null){
			return sb;
		}
		sb = new StringBuffer();

		if (iframe) {
			sb.append("<script type=\"text/javascript\">");
			sb.append("$(function(){");
			if (tabList.size() > 0) {
				for (Tab tab : tabList) {
					sb.append("add" + id + "(\'" + tab.getTitle() + "\',\'" + tab.getHref() + "\',\'" + tab.getId() + "\',\'" + tab.getIcon() + "\',\'" + tab.isClosable() + "\');");
				}
			}
			sb.append("function add" + id + "(title,url,id,icon,closable) {");
			sb.append("$(\'#" + id + "\').tabs(\'add\',{");
			sb.append("id:id,");
			sb.append("title:title,");
			if (iframe) {
				sb.append("content:createFrame" + id + "(id),");
			} else {
				sb.append("href:url,");
			}
			sb.append("closable:closable=(closable =='false')?false : true,");
			sb.append("icon:icon");
			sb.append("});");
			sb.append("}");
			sb.append("$(\'#" + id + "\').tabs(");
			sb.append("{");
			sb.append("onSelect : function(title) {");
			sb.append("var p = $(this).tabs(\'getTab\', title);");
			if (tabList.size() > 0) {
				for (Tab tab : tabList) {
					sb.append("if (title == \'" + tab.getTitle() + "\') {");
					sb.append("p.find(\'iframe\').attr(\'src\',");
					sb.append("\'" + tab.getHref() + "\');}");
				}
			}
			sb.append("}");
			sb.append("});");

			sb.append("function createFrame" + id + "(id)");
			sb.append("{");

			sb.append("var s = \'<iframe id=\"+id+\" scrolling=\"no\" frameborder=\"0\"  src=\"about:blank\" width=\""+oConvertUtils.getString(width, "100%")+"\" height=\""+oConvertUtils.getString(heigth, "99.5%")+"\"></iframe>\';");

			sb.append("return s;");
			sb.append("}");
			sb.append("});");
			sb.append("</script>");
		}
		if (tabs) {
				//增加width属性，fit属性之前写死，改为由页面设定，不填默认true
			sb.append("<div id=\"" + id + "\" tabPosition=\"" + tabPosition + "\" border=flase style=\"margin:0px;padding:0px;overflow-x:hidden;width:"+oConvertUtils.getString(width, "auto")+";\" class=\"easyui-tabs\" fit=\""+fit+"\">");
			if (!iframe) {
				for (Tab tab : tabList) {
					if (tab.getHref() != null) {
						sb.append("<div title=\"" + tab.getTitle() + "\" " + (tab.getIcon() != null ? ("iconCls=\"" + tab.getIcon() + "\" ") : "") + " href=\"" + tab.getHref() + "\" style=\"margin:0px;padding:0px;overflow-x:hidden;overflow-y:auto;width=auto;\"></div>");
					} else {
						sb.append("<div " + (tab.getIcon() != null ? ("iconCls=\"" + tab.getIcon() + "\" ") : "") + " title=\"" + tab.getTitle() + "\"  style=\"margin:0px;padding:0px;overflow-x:hidden;overflow-y:auto;width=auto;\">");

						sb.append("<iframe id=\""+tab.getId()+"\" scrolling=\"no\" frameborder=\"0\"  src=\""+tab.getIframe()+"\" width=\""+oConvertUtils.getString(tab.getWidth(), "100%")+"\" height=\""+oConvertUtils.getString(tab.getHeigth(), "99.5%")+"\"></iframe>");

						sb.append("</div>");
					}

				}
			}
			sb.append("</div>");
		}

		this.putTagCache(sb);

		return sb;
	}

	public void setTab(String id, String title,String iframe, String href, String iconCls, boolean cache, String content, String width, String heigth, boolean closable) {
		Tab tab = new Tab();
		tab.setId(id);
		tab.setTitle(title);
		tab.setHref(href);
		tab.setCache(cache);
		tab.setIframe(iframe);
		tab.setContent(content);
		tab.setHeigth(heigth);
		tab.setIcon(iconCls);
		tab.setWidth(width);
		tab.setClosable(closable);
		tabList.add(tab);
	}

	@Override
	public String toString() {
		StringBuilder builder = new StringBuilder();
		builder.append("TabsTag [id=").append(id).append(", width=")
				.append(width).append(", heigth=").append(heigth)
				.append(", plain=").append(plain).append(", fit=").append(fit)
				.append(", border=").append(border)
				.append(", scrollIncrement=").append(scrollIncrement)
				.append(", scrollDuration=").append(scrollDuration)
				.append(", tools=").append(tools).append(", tabs=")
				.append(tabs).append(", iframe=").append(iframe)
				.append(", tabPosition=").append(tabPosition);
		builder.append(",tabList=[");
		for(Tab tab : tabList){
			builder.append(tab.getId()+",");
			builder.append(tab.getIframe()+",");
			builder.append(tab.getTitle()+",");
			builder.append(tab.getHeigth()+",");
			builder.append(tab.getWidth()+",");
			builder.append(tab.getIcon()+",");
			builder.append(tab.getContent()+",");
			builder.append(tab.isCache()+",");
			builder.append(tab.isClosable()+",");
			builder.append(tab.getHref()+";");
		}
		builder.append("]");
		builder.append(",sysTheme=").append(SysThemesUtil.getSysTheme(ContextHolderUtils.getRequest()).getStyle())
				.append(",brower_type=").append(ContextHolderUtils.getSession().getAttribute("brower_type"))
				.append("]");
		return builder.toString();
	}


}
