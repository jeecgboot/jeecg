package org.jeecgframework.core.enums;

import org.jeecgframework.core.util.StringUtil;

/**
 * 系统样式类型
 *
 * @author zhoujf
 */
public enum SysThemesEnum {
	
	DEFAULT_STYLE("default","main/main","default", "经典风格"),
	SHORTCUT_STYLE("shortcut","main/shortcut_main","default", "ShortCut风格"),
	SLIDING_STYLE("sliding","main/sliding_main","default", "Sliding云桌面"),
	ACE_STYLE("ace","main/ace_main","metro", "ACE平面风格"),
	ACE_LE_STYLE("acele","main/ace_main","metrole", "ACE2风格"),
	DIY("diy","main/diy","default","diy风格"),
	HPLUS("hplus","main/hplus_main","metrole","H+风格"),
	FINEUI_STYLE("fineui","main/fineui_main","metrole", "fineUI风格");

    /**
     * 风格
     */
    private String style;
    
    /**
     * 首页路径
     */
    private String indexPath;
    
    /**
     * 样式
     */
    private String themes;
    /**
     * 描述
     */
    private String desc;

    private SysThemesEnum(String style, String indexPath, String themes, String desc) {
        this.style = style;
        this.indexPath = indexPath;
        this.themes = themes;
        this.desc = desc;
    }
    
	public String getStyle() {
		return style;
	}

	public void setStyle(String style) {
		this.style = style;
	}

	public String getThemes() {
		return themes;
	}

	public void setThemes(String themes) {
		this.themes = themes;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getIndexPath() {
		return indexPath;
	}

	public void setIndexPath(String indexPath) {
		this.indexPath = indexPath;
	}

	public static SysThemesEnum toEnum(String style) {
		if (StringUtil.isEmpty(style)) {
			//默认风格
			return FINEUI_STYLE;
        }
		for(SysThemesEnum item : SysThemesEnum.values()) {
			if(item.getStyle().equals(style)) {
				return item;
			}
		}
		//默认风格
		return FINEUI_STYLE;
	}

    public String toString() {
        return "{style: " + style + ", indexPath: " + indexPath + ", themes: " + themes + ", desc: " + desc +"}";
    }
}
