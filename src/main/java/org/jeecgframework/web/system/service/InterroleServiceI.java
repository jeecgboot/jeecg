package org.jeecgframework.web.system.service;
import java.io.Serializable;
import java.util.Set;

import org.jeecgframework.core.common.service.CommonService;
import org.jeecgframework.web.system.pojo.base.InterroleEntity;

public interface InterroleServiceI extends CommonService{
	
 	public void delete(InterroleEntity entity) throws Exception;
 	
 	public Serializable save(InterroleEntity entity) throws Exception;
 	
 	public void saveOrUpdate(InterroleEntity entity) throws Exception;
 	
 	/**
	 * 判断这个角色是不是还有用户使用
	 *@Author  
	 *@date    
	 *@param id
	 *@return
	 */
	public int getUsersOfThisRole(String id);
	

	/**
	 *
	  * getOperationCodesByRoleIdAndruleDataId
	  * 根据角色id 和 菜单Id 获取 具有操作权限的数据规则
	  *
	  * @Title: getOperationCodesByRoleIdAndruleDataId
	  * @Description: TODO
	  * @param @param roleId
	  * @param @param functionId
	  * @param @return    设定文件
	  * @return Set<String>    返回类型
	  * @throws
	 */

	public  Set<String> getOperationCodesByRoleIdAndruleDataId(String roleId,String interfaceId);

	 
	
	
}
