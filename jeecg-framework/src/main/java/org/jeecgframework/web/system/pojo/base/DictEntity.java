/**===========================================
 *        Copyright (C) 2014 Tempus
 *           All rights reserved
 *
 *  项 目 名： jeecg-framework
 *  文 件 名： DictEntity.java
 *  版本信息： V1.0.0 
 *  作    者： Administrator
 *  日    期： 2014年5月11日-上午1:57:29
 * 
 ============================================*/

package org.jeecgframework.web.system.pojo.base;

/**
 * 类 名 称： DictEntity
 * 类 描 述： 
 * 创 建 人： yiming.zhang
 * 联系方式： 1374250553@qq.com
 * 创建时间： 2014年5月11日 上午1:57:29
 *
 * 修 改 人： Administrator
 * 操作时间： 2014年5月11日 上午1:57:29
 * 操作原因： 
 * 
 */
public class DictEntity {
	private String typecode;
	private String typename;
	
	public String getTypecode() {
		return typecode;
	}
	public void setTypecode(String typecode) {
		this.typecode = typecode;
	}
	public String getTypename() {
		return typename;
	}
	public void setTypename(String typename) {
		this.typename = typename;
	}
}
