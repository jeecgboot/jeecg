package org.jeecgframework.web.system.util;

public class OrgConstants {
	
	/**供应商组织机构根节点编码**/
	public static final String SUPPLIER_ORG_CODE = "Z999";
	
	/**企业组织机构根节点编码**/
	public static final String CORP_ORG_CODE = "A001";
	
	/**企业组织机构类型**/
	public static final String CORP_ORG_TYPE = "1";
	
	/**供应商组织机构类型**/
	public static final String SUPPLIER_ORG_TYPE = "4";
	
	/**部门组织机构类型**/
	public static final String DEPT_ORG_TYPE = "2";
	
	/**岗位组织机构类型**/
	public static final String POST_ORG_TYPE = "3";
	
	/**
	  * 区分部门管理员组与部门角色管理,查询菜单根据不同表
	  */
	 public static final String GROUP_DEPART_ROLE = "1";	//部门角色管理
	 public static final String GROUP_DEPART_ROLE_AUTH = "0";	//部门管理员组
	 
	 /**
	  * 角色管理与部门角色管理区分系统角色,部门角色
	  */
	 public static final String SYSTEM_ROLE_TYPE = "0"; //系统角色
	 public static final String DEPART_ROLE_TYPE = "1";	//部门角色
	
}
