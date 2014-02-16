package org.jeecgframework.core.util;

import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.apache.commons.lang.StringUtils;

import org.jeecgframework.web.system.pojo.base.TSFunction;

/**
 * 动态菜单栏生成
 * 
 * @author 张代浩
 * 
 */
public class ListtoMenu {
	/**
	 * 拼装easyui菜单JSON方式
	 * 
	 * @param set
	 * @param set1
	 * @return
	 */
	public static String getMenu(List<TSFunction> set, List<TSFunction> set1) {
		StringBuffer buffer = new StringBuffer();
		buffer.append("{\"menus\":[");
		for (TSFunction node : set) {
			String iconClas = "default";// 权限图标样式
			if (node.getTSIcon() != null) {
				iconClas = node.getTSIcon().getIconClas();
			}
			buffer.append("{\"menuid\":\"" + node.getId() + "\",\"icon\":\""
					+ iconClas + "\"," + "\"menuname\":\""
					+ node.getFunctionName() + "\",\"menus\":[");
			iterGet(set1, node.getId(), buffer);
			buffer.append("]},");
		}
		buffer.append("]}");

		// 将,\n]替换成\n]

		String tmp = buffer.toString();

		tmp = tmp.replaceAll(",\n]", "\n]");
		tmp = tmp.replaceAll(",]}", "]}");
		return tmp;

	}

	static int count = 0;

	/**
	 * @param args
	 */

	static void iterGet(List<TSFunction> set1, String pid, StringBuffer buffer) {

		for (TSFunction node : set1) {

			// 查找所有父节点为pid的所有对象，然后拼接为json格式的数据
			count++;
			if (node.getTSFunction().getId().equals(pid))

			{
				buffer.append("{\"menuid\":\"" + node.getId()
						+ " \",\"icon\":\"" + node.getTSIcon().getIconClas()
						+ "\"," + "\"menuname\":\"" + node.getFunctionName()
						+ "\",\"url\":\"" + node.getFunctionUrl() + "\"");
				if (count == set1.size()) {
					buffer.append("}\n");
				}
				buffer.append("},\n");

			}
		}

	}

	/**
	 * 拼装Bootstarp菜单
	 * 
	 * @param pFunctions
	 * @param functions
	 * @return
	 */
	public static String getBootMenu(List<TSFunction> pFunctions,
			List<TSFunction> functions) {
		StringBuffer menuString = new StringBuffer();
		menuString.append("<ul>");
		for (TSFunction pFunction : pFunctions) {
			menuString
					.append("<li><a href=\"#\"><span class=\"icon16 icomoon-icon-stats-up\"></span><b>"
							+ pFunction.getFunctionName() + "</b></a>");
			int submenusize = pFunction.getTSFunctions().size();
			if (submenusize == 0) {
				menuString.append("</li>");
			}
			if (submenusize > 0) {
				menuString.append("<ul class=\"sub\">");
			}
			for (TSFunction function : functions) {

				if (function.getTSFunction().getId().equals(pFunction.getId())) {
					menuString
							.append("<li><a href=\""
									+ function.getFunctionUrl()
									+ "\" target=\"contentiframe\"><span class=\"icon16 icomoon-icon-file\"></span>"
									+ function.getFunctionName() + "</a></li>");
				}
			}
			if (submenusize > 0) {
				menuString.append("</ul></li>");
			}
		}
		menuString.append("</ul>");
		return menuString.toString();

	}

	/**
	 * 拼装EASYUI菜单
	 * 
	 * @param pFunctions
	 * @param functions
	 * @return
	 */
	public static String getEasyuiMenu(List<TSFunction> pFunctions,
			List<TSFunction> functions) {
		StringBuffer menuString = new StringBuffer();
		for (TSFunction pFunction : pFunctions) {
			menuString.append("<div  title=\"" + pFunction.getFunctionName()
					+ "\" iconCls=\"" + pFunction.getTSIcon().getIconClas()
					+ "\">");
			int submenusize = pFunction.getTSFunctions().size();
			if (submenusize == 0) {
				menuString.append("</div>");
			}
			if (submenusize > 0) {
				menuString.append("<ul>");
			}
			for (TSFunction function : functions) {

				if (function.getTSFunction().getId().equals(pFunction.getId())) {
					String icon = "folder";
					if (function.getTSIcon() != null) {
						icon = function.getTSIcon().getIconClas();
					}
					// menuString.append("<li><div> <a class=\""+function.getFunctionName()+"\" iconCls=\""+icon+"\" target=\"tabiframe\"  href=\""+function.getFunctionUrl()+"\"> <span class=\"icon "+icon+"\" >&nbsp;</span> <span class=\"nav\">"+function.getFunctionName()+"</span></a></div></li>");
					menuString.append("<li><div onclick=\"addTab(\'"
							+ function.getFunctionName() + "\',\'"
							+ function.getFunctionUrl() + "&clickFunctionId="
							+ function.getId() + "\',\'" + icon
							+ "\')\"  title=\"" + function.getFunctionName()
							+ "\" url=\"" + function.getFunctionUrl()
							+ "\" iconCls=\"" + icon + "\"> <a class=\""
							+ function.getFunctionName()
							+ "\" href=\"#\" > <span class=\"icon " + icon
							+ "\" >&nbsp;</span> <span class=\"nav\" >"
							+ function.getFunctionName()
							+ "</span></a></div></li>");
				}
			}
			if (submenusize > 0) {
				menuString.append("</ul></div>");
			}
		}
		return menuString.toString();

	}

	/**
	 * 拼装EASYUI 多级 菜单
	 * 
	 * @param pFunctions
	 * @param functions
	 * @return
	 */
	public static String getEasyuiMultistageMenu(
			Map<Integer, List<TSFunction>> map) {
		StringBuffer menuString = new StringBuffer();
		List<TSFunction> list = map.get(0);
		for (TSFunction function : list) {
			menuString.append("<div   title=\"" + function.getFunctionName()
					+ "\" iconCls=\"" + function.getTSIcon().getIconClas()
					+ "\">");
			int submenusize = function.getTSFunctions().size();
			if (submenusize == 0) {
				menuString.append("</div>");
			}
			if (submenusize > 0) {
				menuString.append("<ul>");
			}
			menuString.append(getChild(function,1,map));
			if (submenusize > 0) {
				menuString.append("</ul></div>");
			}
		}
		return menuString.toString();
	}
	/**
	 * 拼装EASYUI 多级 菜单  下级菜单为树形
	 * 
	 * @param pFunctions
	 * @param functions
	 * @return
	 */
	public static String getEasyuiMultistageTree(
			Map<Integer, List<TSFunction>> map) {
		if(map==null||map.size()==0||!map.containsKey(0)){return "不具有任何权限,\n请找管理员分配权限";}
		StringBuffer menuString = new StringBuffer();
		List<TSFunction> list = map.get(0);
		for (TSFunction function : list) {
			menuString.append("<div   title=\"" + function.getFunctionName()
					+ "\" iconCls=\"" + function.getTSIcon().getIconClas()
					+ "\">");
			int submenusize = function.getTSFunctions().size();
			if (submenusize == 0) {
				menuString.append("</div>");
			}
			if (submenusize > 0) {
				menuString.append("<ul class=\"easyui-tree\"  fit=\"false\" border=\"false\">");
			}
			menuString.append(getChildOfTree(function,1,map));
			if (submenusize > 0) {
				menuString.append("</ul></div>");
			}
		}
		return menuString.toString();
	}
	/**
	 * 获取顶级菜单的下级菜单-----面板式菜单
	 * @param parent
	 * @param level
	 * @param map
	 * @return
	 */
	private static String getChild(TSFunction parent,int level,Map<Integer, List<TSFunction>> map){
		StringBuffer menuString = new StringBuffer();
		List<TSFunction> list = map.get(level);
		for (TSFunction function : list) {
			if (function.getTSFunction().getId().equals(parent.getId())){
				if(function.getTSFunctions().size()==0||!map.containsKey(level+1)){
					menuString.append(getLeaf(function));
				}else if(map.containsKey(level+1)){
					menuString.append("<div  class=\"easyui-accordion\"  fit=\"false\" border=\"false\">");
					menuString.append("<div></div>");//easy ui 默认展开第一级,所以这里设置一个控制,就不展开了
					menuString.append("<div title=\"" + function.getFunctionName()
							+ "\" iconCls=\"" + function.getTSIcon().getIconClas()
							+ "\"><ul>");
					menuString.append(getChild(function,level+1,map));
					menuString.append("</ul></div>");
					menuString.append("</div>");
				}
			}
		}
		return menuString.toString();
	}
	/**
	 * 获取树形菜单
	 * @param parent
	 * @param level
	 * @param map
	 * @return
	 */
	private static String getChildOfTree(TSFunction parent,int level,Map<Integer, List<TSFunction>> map){
		StringBuffer menuString = new StringBuffer();
		List<TSFunction> list = map.get(level);
		for (TSFunction function : list) {
			if (function.getTSFunction().getId().equals(parent.getId())){
				if(function.getTSFunctions().size()==0||!map.containsKey(level+1)){
					menuString.append(getLeafOfTree(function));
				}else if(map.containsKey(level+1)){
					menuString.append("<li state=\"closed\" iconCls=\"" + function.getTSIcon().getIconClas()+"\" ><span>"+function.getFunctionName()+"</span>");
					menuString.append("<ul >");
					menuString.append(getChildOfTree(function,level+1,map));
					menuString.append("</ul></li>");
				}
			}
		}
		return menuString.toString();
	}
	/**
	 * 获取叶子节点
	 * @param function
	 * @return
	 */
	private static String getLeaf(TSFunction function){
		StringBuffer menuString = new StringBuffer();
		String icon = "folder";
		if (function.getTSIcon() != null) {
			icon = function.getTSIcon().getIconClas();
		}
		menuString.append("<li><div onclick=\"addTab(\'");
		menuString.append(function.getFunctionName());
		menuString.append("\',\'");
		menuString.append(function.getFunctionUrl());
		menuString.append("&clickFunctionId=");
		menuString.append(function.getId());
		menuString.append("\',\'");
		menuString.append(icon);
		menuString.append("\')\"  title=\"");
		menuString.append(function.getFunctionName());
		menuString.append("\" url=\"");
		menuString.append(function.getFunctionUrl());
		menuString.append("\" iconCls=\"");
		menuString.append(icon);
		menuString.append("\"> <a class=\"");
		menuString.append(function.getFunctionName());
		menuString.append("\" href=\"#\" > <span class=\"icon ");
		menuString.append(icon);
		menuString.append("\" >&nbsp;</span> <span class=\"nav\" >");
		menuString.append(function.getFunctionName());
		menuString.append("</span></a></div></li>");
		return menuString.toString();
	}
	/**
	 * 获取叶子节点  ------树形菜单的叶子节点
	 * @param function
	 * @return
	 */
	private static String getLeafOfTree(TSFunction function){
		StringBuffer menuString = new StringBuffer();
		String icon = "folder";
		if (function.getTSIcon() != null) {
			icon = function.getTSIcon().getIconClas();
		}
		menuString.append("<li iconCls=\"");
		menuString.append(icon);
		menuString.append("\"> <a onclick=\"addTab(\'");
		menuString.append(function.getFunctionName());
		menuString.append("\',\'");
		menuString.append(function.getFunctionUrl());
		menuString.append("&clickFunctionId=");
		menuString.append(function.getId());
		menuString.append("\',\'");
		menuString.append(icon);
		menuString.append("\')\"  title=\"");
		menuString.append(function.getFunctionName());
		menuString.append("\" url=\"");
		menuString.append(function.getFunctionUrl());
		menuString.append("\" href=\"#\" ><span class=\"nav\" >");
		menuString.append(function.getFunctionName());
		menuString.append("</span></a></li>");
		return menuString.toString();
	}
	/**
	 * 拼装bootstrap头部菜单
	 * @param pFunctions
	 * @param functions
	 * @return
	 */
	public static String getBootstrapMenu(Map<Integer, List<TSFunction>> map) {
		StringBuffer menuString = new StringBuffer();
		menuString.append("<ul class=\"nav\">");
		List<TSFunction> pFunctions = (List<TSFunction>) map.get(0);
		if(pFunctions==null || pFunctions.size()==0){
			return "";
		}
		for (TSFunction pFunction : pFunctions) {
			//是否有子菜单
			boolean hasSub = pFunction.getTSFunctions().size()==0?false:true;
			
			//绘制一级菜单
			menuString.append("	<li class=\"dropdown\"> ");
			menuString.append("		<a href=\"javascript:;\" class=\"dropdown-toggle\" data-toggle=\"dropdown\"> ");
			menuString.append("			<span class=\"bootstrap-icon\" style=\"background-image: url('"+pFunction.getTSIcon().getIconPath()+"')\"></span> "+pFunction.getFunctionName()+" ");
			if(hasSub){
				menuString.append("			<b class=\"caret\"></b> ");
			}
			menuString.append("		</a> ");
			//绘制二级菜单
			if(hasSub){
				menuString.append(getBootStrapChild(pFunction, 1, map));
			}
			menuString.append("	</li> ");
		}
		menuString.append("</ul>");
		return menuString.toString();
	}
	/**
	* @Title: getBootStrapChild
	* @Description: 递归获取bootstrap的子菜单
	*  @param parent
	*  @param level
	*  @param map
	* @return String    
	* @throws
	 */
	private static String getBootStrapChild(TSFunction parent,int level,Map<Integer, List<TSFunction>> map){
		StringBuffer menuString = new StringBuffer();
		List<TSFunction> list = map.get(level);
		if(list==null || list.size()==0){
			return "";
		}
		menuString.append("		<ul class=\"dropdown-menu\"> ");
		for (TSFunction function : list) {
			if (function.getTSFunction().getId().equals(parent.getId())){
				boolean hasSub = function.getTSFunctions().size()!=0 && map.containsKey(level+1);
				String menu_url = function.getFunctionUrl();
				if(StringUtils.isNotEmpty(menu_url)){
					menu_url += "&clickFunctionId="+function.getId();
				}
				menuString.append("		<li onclick=\"showContent(\'"+function.getFunctionName()+"\',\'"+menu_url+"\')\"  title=\""+function.getFunctionName()+"\" url=\""+function.getFunctionUrl()+"\" ");
				if(hasSub){
					menuString.append(" class=\"dropdown-submenu\"");
				}
				menuString.append(" > ");
				menuString.append("			<a href=\"javascript:;\"> ");
				menuString.append("				<span class=\"bootstrap-icon\" style=\"background-image: url('"+function.getTSIcon().getIconPath()+"')\"></span>		 ");
				menuString.append(function.getFunctionName());
				menuString.append("			</a> ");
				if(hasSub){
					menuString.append(getBootStrapChild(function,level+1,map));
				}
				menuString.append("		</li> ");
			}
		}
		menuString.append("		</ul> ");
		return menuString.toString();
	}
	
}
