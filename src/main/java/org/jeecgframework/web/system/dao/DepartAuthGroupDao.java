package org.jeecgframework.web.system.dao;

import java.util.List;
import java.util.Map;

import org.jeecgframework.minidao.annotation.MiniDao;
import org.jeecgframework.minidao.annotation.Param;
import org.jeecgframework.minidao.annotation.ResultType;
import org.jeecgframework.minidao.annotation.Sql;
import org.jeecgframework.minidao.pojo.MiniDaoPage;
import org.jeecgframework.web.system.pojo.base.TSUser;

/**
 * 二级管理员设置
 * @author ShaoQing
 *
 */

@MiniDao
public interface DepartAuthGroupDao {
	
	/**
	 * 分页查询所有部门管理员组
	 * @param page
	 * @param rows
	 * @return
	 */
	@ResultType(Map.class)
	public MiniDaoPage<Map<String,Object>> getDepartAuthGroupList(@Param("page") int page, @Param("rows") int rows);
	
	/**
	 * 查询已拥有的部门管理员组
	 * @param userId
	 * @return
	 */

	@Sql("select dag.* from t_s_depart_auth_group dag join t_s_depart_authg_manager dam on dam.group_id=dag.id where dam.user_id = :userId")
	public List<Map<String,Object>> chkDepartAuthGroupList(@Param("userId") String userId);

	
	/**
	 * 根据登陆人ID分页查询部门管理员组
	 * @param page
	 * @param rows
	 * @param userId
	 * @return
	 */
	@ResultType(Map.class)
	public MiniDaoPage<Map<String,Object>> getDepartAuthGroupByUserId(@Param("page") int page, @Param("rows") int rows, @Param("userId") String userId);
	
	/**
	 * 根据userId分页加载部门角色
	 * @param page
	 * @param rows
	 * @param userId
	 * @return
	 */
	@ResultType(Map.class)
	public MiniDaoPage<Map<String,Object>> getDepartAuthRole(@Param("page") int page, @Param("rows") int rows, @Param("userId") String userId);
	
	/**
	 * 查询已拥有的部门角色
	 * @return
	 */
	@Sql("select dag.*,r.id,r.rolecode,r.rolename,r.depart_ag_id,r.role_type from t_s_depart_auth_group dag,t_s_role r where dag.id = r.depart_ag_id")
	public List<Map<String,Object>> chkDepartAuthRole();
	
	
	/**
	 * 分页查询部门下(包括无限制下级)的用户
	 * 说明：like 'A01%'
	 * @param page
	 * @param rows
	 * @return
	 */
	@ResultType(TSUser.class)
	public MiniDaoPage<TSUser> getUserByDepartCode(@Param("page") int page, @Param("rows") int rows,@Param("orgCode") String orgCode,@Param("u") TSUser u);
	
	/**
	 * 查询用户所属的部门名称
	 * @param userid
	 * @return
	 */
	@Sql("select departname from t_s_depart where id in (select org_id from t_s_user_org where user_id =:userid)")
	@ResultType(String.class)
	public List<String> getUserDepartNames(@Param("userid") String userid);
}
