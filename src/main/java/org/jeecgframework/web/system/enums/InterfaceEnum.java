package org.jeecgframework.web.system.enums;



public enum InterfaceEnum {
	blacklist_list("blacklist_list", "黑名单列表查询", "/rest/tsBlackListController", "GET", 1),
	blacklist_get("blacklist_get", "黑名单单条数据查询", "/rest/tsBlackListController/{id}", "GET", 2),
	blacklist_add("blacklist_add", "黑名单添加", "/rest/tsBlackListController", "POST", 3),
	blacklist_edit("blacklist_edit", "黑名单编辑", "/rest/tsBlackListController", "PUT", 4),
	blacklist_delete("blacklist_delete", "黑名单删除", "/rest/tsBlackListController/{id}", "DELETE", 5);	
    /**
     * 接口编码
     */
    private String code;
    /**
     * 接口名称
     */
    private String name;
    /**
     * 接口url
     */
    private String url;
    /**
     * 接口请求方式
     */
    private String method;
    /**
     * 接口排序
     */
    private Integer sort;


    private InterfaceEnum(String code, String name, String url, String method, Integer sort) {
       
        this.code = code;
        this.name = name;
        this.url = url;
        this.method = method;
        this.sort = sort;
    }
    
	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}

	public String getMethod() {
		return method;
	}

	public void setMethod(String method) {
		this.method = method;
	}

	public static InterfaceEnum toEnum(String code) {

		for(InterfaceEnum item : InterfaceEnum.values()) {
			if(item.getCode().equals(code)) {
				return item;
			}
		}
		//默认风格
		return null;
	}

    public String toString() {
        return "接口名称: " + name + ", 接口编码: " + code +" ";
    }
}
