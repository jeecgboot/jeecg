package org.jeecgframework.web.cgform.util;

import java.util.ArrayList;
import java.util.List;

import org.jeecgframework.core.enums.OnlineGenerateEnum;

/**
 * 代码生成公共方法
 * 
 * @author	jiaqiankun
 */
public class GenerateUtil {
	
	public static List<OnlineGenerateEnum> getOnlineGenerateEnum(String type){
		List<OnlineGenerateEnum> list = new ArrayList<OnlineGenerateEnum>();
		for(OnlineGenerateEnum item : OnlineGenerateEnum.values()) {
			if(item.getFormType().equals(type)) {
				list.add(item);
			}
		}
		return list;
	}

	public static List<OnlineGenerateEnum> getOnlineGenerateEnum(String type,String version){
		List<OnlineGenerateEnum> list = new ArrayList<OnlineGenerateEnum>();
		for(OnlineGenerateEnum item : OnlineGenerateEnum.values()) {
			if(item.getFormType().equals(type)&&item.getVersion().equals(version)) {
				list.add(item);
			}
		}
		return list;
	}

	public static List<OnlineGenerateEnum> getOnlineGenerateEnum(String type,String version,boolean isTree){
		List<OnlineGenerateEnum> list = new ArrayList<OnlineGenerateEnum>();
		for(OnlineGenerateEnum item : OnlineGenerateEnum.values()) {
			if(item.getFormType().equals(type)&&item.getVersion().equals(version)&&(item.isSupportTreegrid()||!isTree)) {
				list.add(item);
			}
		}
		return list;
	}

	
}
