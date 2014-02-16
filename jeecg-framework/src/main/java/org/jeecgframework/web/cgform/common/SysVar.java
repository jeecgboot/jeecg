package org.jeecgframework.web.cgform.common;

import java.text.SimpleDateFormat;
import java.util.Date;

import org.jeecgframework.web.system.pojo.base.TSUser;

import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;

/**
 * 
 * @Title:SysVar
 * @description:智能表单系统变量枚举
 * @author 赵俊夫
 * @date Aug 17, 2013 5:34:33 PM
 * @version V1.0
 */
public enum SysVar {
	userid,
	userkey,
	username,
	userrealname,
	department_id,
	department_name,
	sysdate,
	systime,
	;
	/**
	 * 获得系统变量值
	 * @return
	 */
	public String getSysValue(){
		String sysValue = "";
		TSUser currentUser = null;
		try {
			currentUser = ResourceUtil.getSessionUserName();
		} catch (RuntimeException e1) {
			currentUser = new TSUser();
			e1.printStackTrace();
		}
		switch (this) {
		case userid:
			sysValue = currentUser.getId();
			break;
		case userkey:
			sysValue = currentUser.getUserKey();
			break;
		case username:
			sysValue = currentUser.getUserName();
			break;
		case userrealname:
			sysValue = currentUser.getRealName();
			break;
		case department_id:
			sysValue = currentUser.getTSDepart().getId();
			break;
		case department_name:
			sysValue = currentUser.getTSDepart().getDepartname();
			break;
		case sysdate:
			sysValue = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
			break;
		case systime:
			sysValue = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date());
			break;
		default:
			sysValue ="";
			break;
		}
		if(StringUtil.isEmpty(sysValue)){
			sysValue ="";
		}
		return sysValue;
	}
	/**
	 * 根据系统变量名来获取枚举
	 * @param sysVarName {sys.username}
	 * @return
	 */
	public static SysVar createSysVar(String sysVarName){
		sysVarName = sysVarName.replaceAll("\\{", "");
		sysVarName = sysVarName.replaceAll("\\}", "");
		sysVarName =sysVarName.replace("sys.", "");
		return SysVar.valueOf(sysVarName.toLowerCase());
	}
	/**
	 * 判断是否是枚举
	 * @param sysVarName
	 * @return
	 */
	public static boolean isSysVar(String sysVarName){
		if(StringUtil.isEmpty(sysVarName)){
			return false;
		}
		if(sysVarName.contains("{") && sysVarName.contains("}")){
			return true;
		}else{
			return false;
		}
	}
	/**
	 * 直接根据传入的系统变量来获取值
	 * @param sysVarName 系统变量名，例如：{sys.username}
	 * @return 系统变量值，如果传入的不是系统变量，则返回原值。
	 */
	public static String getSysVar(String sysVarName){
		if(!isSysVar(sysVarName)){
			return sysVarName;
		}else{
			SysVar sysvar = createSysVar(sysVarName);
			return sysvar.getSysValue();
		}
	}
}
