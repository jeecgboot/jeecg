package org.jeecgframework.core.enums;

import org.jeecgframework.core.util.StringUtil;

/**
 *
 * 系统数据库默认参数类
 * @author jg_huangxg
 */
public enum SysDatabaseEnum {

	MYSQL("mysql","jdbc:mysql://SERVERADDRESS:PORT/YOURDATABASENAME?useUnicode=true&characterEncoding=UTF-8","com.mysql.jdbc.Driver"),

	SQLSERVER("sqlserver","jdbc:sqlserver://SERVERADDRESS:PORT;DatabaseName=YOURDATABASENAME","com.microsoft.sqlserver.jdbc.SQLServerDriver"),

	ORACLE("oracle","jdbc:oracle:thin:@SERVERADDRESS:PORT:YOURDATABASENAME","oracle.jdbc.driver.OracleDriver");


    /**
     * 数据库类型
     */
    private String dbtype;

	/**
     * 默认连接字符串
     */
    private String url;

    /**
     * 驱动类
     */
    private String driverClass;

    private SysDatabaseEnum(String dbtype, String url, String driverClass) {
        this.dbtype = dbtype;
        this.url = url;
        this.driverClass = driverClass;
    }

    public String getDbtype() {
		return dbtype;
	}

	public void setDbtype(String dbtype) {
		this.dbtype = dbtype;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getDriverClass() {
		return driverClass;
	}

	public void setDriverClass(String driverClass) {
		this.driverClass = driverClass;
	}

	public static SysDatabaseEnum toEnum(String dbtype) {
		if (StringUtil.isEmpty(dbtype)) {
			return null;
        }
		for(SysDatabaseEnum item : SysDatabaseEnum.values()) {
			if(item.getDbtype().equals(dbtype)) {
				return item;
			}
		}
		return null;
	}

    public String toString() {
        return "{dbtype: " + dbtype + ", url: " + url + ", driverClass: " + driverClass +"}";
    }

}
