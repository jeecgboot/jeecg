package org.jeecgframework.core.enums;

import org.jeecgframework.core.util.StringUtil;


/**
 * 代码生成模板风格配置
 *
 * @author zhoujf
 */
public enum OnlineGenerateEnum {
	
	//
	ONLINE_03("03","Table风格(form)","onetomany", "system"),
	ONLINE_06("06","bootstrap风格(form)","onetomany","system"),
	
	ONLINE_01("01","Table风格(form)","single", "system"),
	ONLINE_02("02","Div风格(form)","single", "system"),
	ONLINE_04("04","自定义word(form)","single", "system"),
	ONLINE_05("05","bootstrap风格(form)","single", "system"),
	/*ONLINE_07("07","nopopform风格","single","system"),*/
	ONLINE_NOPOP_SINGLE("nopop.single","nopopform风格","single","ext"),
	
	ONLINE_DEFAULT_SINGLE("default.single","用户扩展风格示例","single","ext"),
	ONLINE_DEFAULT_ONETOMANY("default.onetomany","用户扩展风格示例","onetomany","ext");


    /**
     * 风格
     */
    private String code;
    /**
     * 描述
     */
    private String desc;
    
    /**
     * 表单类型  single 单表 ，onetomany 一对多
     */
    private String formType;
    /**
     * 版本 system 系统, ext 用户扩展
     */
    private String version;
    

    private OnlineGenerateEnum(String code, String desc, String formType, String version) {
        this.code = code;
        this.desc = desc;
        this.formType = formType;
        this.version = version;
    }

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getFormType() {
		return formType;
	}

	public void setFormType(String formType) {
		this.formType = formType;
	}

	public String getVersion() {
		return version;
	}

	public void setVersion(String version) {
		this.version = version;
	}

	public static OnlineGenerateEnum toEnum(String code) {
		if(StringUtil.isEmpty(code)){
			return null;
		}
		for(OnlineGenerateEnum item : OnlineGenerateEnum.values()) {
			if(item.getCode().equals(code)) {
				return item;
			}
		}
		return null;
	}

}
