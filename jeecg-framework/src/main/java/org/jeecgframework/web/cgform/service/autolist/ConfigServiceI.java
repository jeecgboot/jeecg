package org.jeecgframework.web.cgform.service.autolist;

import java.util.Map;
/**
 * 
 * @Title:ConfigServiceI
 * @description:动态配置服务接口
 * @author 赵俊夫
 * @date Jul 5, 2013 3:02:11 PM
 * @version V1.0
 */
public interface ConfigServiceI {
	/**
	 * 读取动态表配置
	 * @param configId 标示配置的id
	 * @return
	 */
	public Map<String,Object> queryConfigs(String configId,String jversion);
}
