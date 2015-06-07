package org.jeecgframework.core.util;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.enums.SysThemesEnum;

/**
 * 
 * 系统样式获取工具类
 * @author Administrator
 *
 */
public class SysThemesUtil {
	
	/**
	 * 获取系统风格
	 * @param request
	 * @return
	 */
	public static SysThemesEnum getSysTheme(HttpServletRequest request){
		String indexStyle = null;
		try {
			Cookie[] cookies = request.getCookies();
			for (Cookie cookie : cookies) {
				if (cookie == null || StringUtils.isEmpty(cookie.getName())) {
					continue;
				}
				if (cookie.getName().equalsIgnoreCase("JEECGINDEXSTYLE")) {
					indexStyle = cookie.getValue();
				}
			}
		} catch (Exception e) {
		}
		return SysThemesEnum.toEnum(indexStyle);
	}

	/**
	 * easyui.css 样式
	 * @param sysThemesEnum
	 * @return
	 */
	public static String getEasyUiTheme(SysThemesEnum sysThemesEnum){
		StringBuffer sb = new StringBuffer("");
		sb.append("<link id=\"easyuiTheme\" rel=\"stylesheet\" href=\"plug-in/easyui/themes/"+sysThemesEnum.getThemes()+"/easyui.css\" type=\"text/css\"></link>");
		return sb.toString();
	}
	
	/**
	 * easyui main.css
	 * @param sysThemesEnum
	 * @return
	 */
	public static String getEasyUiMainTheme(SysThemesEnum sysThemesEnum){
		StringBuffer sb = new StringBuffer("");
		if("metro".equals(sysThemesEnum.getThemes())){
			sb.append("<link id=\"easyuiTheme\" rel=\"stylesheet\" href=\"plug-in/easyui/themes/metro/main.css\" type=\"text/css\"></link>");
		}
		return sb.toString();
	}
	
	/**
	 * tools common.css 样式
	 * @param sysThemesEnum
	 * @return
	 */
	public static String getCommonTheme(SysThemesEnum sysThemesEnum){
		StringBuffer sb = new StringBuffer("");
		if("metro".equals(sysThemesEnum.getThemes())){
			sb.append("<link rel=\"stylesheet\" href=\"plug-in/tools/css/metro/common.css\" type=\"text/css\"></link>");
		}else{
			sb.append("<link rel=\"stylesheet\" href=\"plug-in/tools/css/common.css\" type=\"text/css\"></link>");
		}
		return sb.toString();
	}
	
	/**
	 * lhgdialog 样式
	 * @param sysThemesEnum
	 * @return
	 */
	public static String getLhgdialogTheme(SysThemesEnum sysThemesEnum){
		StringBuffer sb = new StringBuffer("");
		if("metro".equals(sysThemesEnum.getThemes())){
			sb.append("<script type=\"text/javascript\" src=\"plug-in/lhgDialog/lhgdialog.min.js?skin=metro\"></script>");
		}else{
			sb.append("<script type=\"text/javascript\" src=\"plug-in/lhgDialog/lhgdialog.min.js\"></script>");
		}
		return sb.toString();
	}
	
	/**
	 * graphreport report.css 样式
	 * @param sysThemesEnum
	 * @return
	 */
	public static String getReportTheme(SysThemesEnum sysThemesEnum){
		StringBuffer sb = new StringBuffer("");
		if("metro".equals(sysThemesEnum.getThemes())){
			sb.append("<link rel=\"stylesheet\" href=\"plug-in/graphreport/css/metro/report.css\" type=\"text/css\"></link>");
			
		}else{
			sb.append("<link rel=\"stylesheet\" href=\"plug-in/graphreport/css/report.css\" type=\"text/css\"></link>");
		}
		return sb.toString();
	}
	
	/**
	 * Validform divfrom 样式
	 * @param sysThemesEnum
	 * @return
	 */
	public static String getValidformDivfromTheme(SysThemesEnum sysThemesEnum){
		StringBuffer sb = new StringBuffer("");
		if("metro".equals(sysThemesEnum.getThemes())){
			sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/metro/divfrom.css\" type=\"text/css\"/>");
		}else{
			sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/divfrom.css\" type=\"text/css\"/>");
		}
		return sb.toString();
	}
	
	/**
	 * Validform style.css
	 * @param sysThemesEnum
	 * @return
	 */
	public static String getValidformStyleTheme(SysThemesEnum sysThemesEnum){
		StringBuffer sb = new StringBuffer("");
		if("metro".equals(sysThemesEnum.getThemes())){
			sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/metro/style.css\" type=\"text/css\"/>");
		}else{
			sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/style.css\" type=\"text/css\"/>");
		}
		return sb.toString();
	}
	
	/**
	 * Validform tablefrom.css
	 * @param sysThemesEnum
	 * @return
	 */
	public static String getValidformTablefrom(SysThemesEnum sysThemesEnum){
		StringBuffer sb = new StringBuffer("");
		if("metro".equals(sysThemesEnum.getThemes())){
			sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/metro/tablefrom.css\" type=\"text/css\"/>");
		}else{
			sb.append("<link rel=\"stylesheet\" href=\"plug-in/Validform/css/tablefrom.css\" type=\"text/css\"/>");
		}
		return sb.toString();
	}
}
