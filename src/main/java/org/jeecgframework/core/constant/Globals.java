package org.jeecgframework.core.constant;

import org.jeecgframework.core.util.ResourceUtil;


/**  
* 项目名称：jeecg
* 类名称：Globals   
* 类描述：  全局变量定义
* 创建人： 张代浩      
* @version    
*
 */
public final class Globals {
	/**
	 * 保存用户到SESSION
	 */
	public static final String USER_SESSION="USER_SESSION";
	/**
	 * 人员类型
	 */
	public static final Short User_Normal=1;//正常
	public static final Short User_Forbidden=0;//禁用
	public static final Short User_ADMIN=-1;//超级管理员

	/**
	 * 用户类型：1、系统类型用户
	 */
	public static final String USER_TYPE_SYSTEM = "1";
	/**
	 * 用户类型：2、接口类型用户
	 *
	 */
	public static final String USER_TYPE_INTERFACE = "2";

	
	/**
	 * 逻辑删除标记
	 */
	/**
	 * 删除
	 */
	public static final Short Delete_Forbidden=1;
	/**
	 * 正常
	 */
	public static final Short Delete_Normal=0;
	
	/**
	 *日志级别定义
	 */
	public static final Short Log_Leavel_INFO=1;
	public static final Short Log_Leavel_WARRING=2;
	public static final Short Log_Leavel_ERROR=3;
	 /**
	  * 日志类型
	  */
	 public static final Short Log_Type_LOGIN=1; //登陆
	 public static final Short Log_Type_EXIT=2;  //退出
	 public static final Short Log_Type_INSERT=3; //插入
	 public static final Short Log_Type_DEL=4; //删除
	 public static final Short Log_Type_UPDATE=5; //更新
	 public static final Short Log_Type_UPLOAD=6; //上传
	 public static final Short Log_Type_OTHER=7; //其他
	 
	 
	 /**
	  * 词典分组定义
	  */
	 public static final String TypeGroup_Database="database";//数据表分类
	 
	 /**
	  * 权限等级
	  */
	 public static final Short Function_Leave_ONE=0;//一级权限
	 public static final Short Function_Leave_TWO=1;//二级权限
	 
	 /**
	  * 权限等级前缀
	  */
	 public static final String Function_Order_ONE="ofun";//一级权限
	 public static final String Function_Order_TWO="tfun";//二级权限
	 /**
	  * 权限类型
	  */
	 public static final Short Function_TYPE_PAGE=0;//菜单：菜单类型
	 public static final Short Function_TYPE_FROM=1;//菜单：权限类型(权限使用，不作为菜单首页加载)
	 /**
	  * 没有勾选的操作code
	  */
	 public static final String NOAUTO_OPERATIONCODES ="noauto_operationCodes";
	 /**
	  * 勾选了的操作code
	  */
	 public static final String OPERATIONCODES ="operationCodes";
	 
	 
	 /**
	  * 权限类型
	  */
	 public static final Short OPERATION_TYPE_HIDE = 0;//页面
	 public static final Short OPERATION_TYPE_DISABLED = 1;//表单/或者弹出
	 
	 
	 /**
	  * 数据权限 - 菜单数据规则集合
	  */
	 public static final String MENU_DATA_AUTHOR_RULES ="MENU_DATA_AUTHOR_RULES";
	 /**
	  * 数据权限 - 菜单数据规则sql
	  */
	 public static final String MENU_DATA_AUTHOR_RULE_SQL ="MENU_DATA_AUTHOR_RULE_SQL";
	 /**
	  * 新闻法规
	  */
	 public static final Short Document_NEW=0; //新建
	 public static final Short Document_PUBLICH=0; //发布
	 
	 /**
	  * 内部邮件系统
	  */
	 public static final String MAIL_STATUS_UNSEND ="00"; //草稿
	 public static final String MAIL_STATUS_SEND ="01"; //已发送
	 public static final String MAIL_STATUS_DEL ="02"; //删除   已发送的邮件不能真正删除，不然接收人就看不到邮件了。
	 public static final String MAILRECEIVER_STATUS_UNREAD ="00"; //未读
	 public static final String MAILRECEIVER_STATUS_READ ="01";//已读

	 /**
	  * 配置系统是否开启按钮权限控制
	  */
	 public static boolean BUTTON_AUTHORITY_CHECK = false;
	 static{
		 String button_authority_jeecg = ResourceUtil.getSessionattachmenttitle("button.authority.jeecg");
		 if("true".equals(button_authority_jeecg)){
			 BUTTON_AUTHORITY_CHECK = true;
		 }
	 }

	 /**
	  * rest接口 list最大当前条数
	  */
	 public static Integer MAX_PAGESIZE = 2000;	//条数

}
