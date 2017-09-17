package org.jeecgframework.web.cgform.common;

/**
 * 
 * @Title:CgAutoListConstant
 * @description:动态列表常量
 * @author 赵俊夫
 * @date Jul 5, 2013 3:01:27 PM
 * @version V1.0
 */
public class CgAutoListConstant {
	/** 配置的id */
	public static final String CONFIG_ID = "config_id";
	/** 配置的名称 */
	public static final String CONFIG_NAME = "config_name";
	/** 是否为树形 */
	public static final String CONFIG_ISTREE = "config_istree";
	/** 是否分页 */
	public static final String CONFIG_ISPAGINATION = "config_ispagination";
	/** 是否显示复选框 */
	public static final String CONFIG_ISCHECKBOX = "config_ischeckbox";
	/** 查询模式 */
	public static final String CONFIG_QUERYMODE = "config_querymode";
	/** 字段列表 */
	public static final String CONFIG_FIELDLIST = "config_fieldList";
	/** 查询字段 */
	public static final String CONFIG_QUERYLIST = "config_queryList";
	/** 按钮组 */
	public static final String CONFIG_BUTTONLIST = "config_buttons";
	/** 列表JS增强 */
	public static final String CONFIG_JSENHANCE = "config_jsenhance";
	/** 无权限的按钮 */
	public static final String CONFIG_NOLIST = "config_nolist";
	/** 无权限的按钮串 */
	public static final String CONFIG_NOLISTSTR = "config_noliststr";
	/** iframe */
	public static final String CONFIG_IFRAME = "config_iframe";
	/** 表名 */
	public static final String TABLENAME = "tableName";
	/** 字段串 */
	public static final String FILEDS = "fileds";
	public static final String INITQUERY = "initquery";
	/** 字段编码 */
	public static final String FILED_ID = "field_id";
	/** 字段名称 */
	public static final String FIELD_TITLE = "field_title";
	/** 字段是否显示 */
	public static final String FIELD_ISSHOW = "field_isShow";
	/** 字段是否允许为空 */
	public static final String FIELD_IS_NULL = "field_isNull";
	/** 字段是否查询 */
	public static final String FIELD_ISQUERY = "field_isQuery";
	/** 字段查询模式 */
	public static final String FIELD_QUERYMODE = "field_queryMode";
	/** 字段显示模式 */
	public static final String FIELD_SHOWTYPE = "field_showType";
	/** 字段类型 */
	public static final String FIELD_TYPE = "field_type";
	/** 字段长度 */
	public static final String FIELD_LENGTH = "field_length";
	/** 字段href */
	public static final String FIELD_HREF = "field_href";
	/** 字段默认值 */
	public static final String FIELD_VALUE = "field_value";
	/** 字段默认值 */
	public static final String FIELD_VALUE_BEGIN = "field_value_begin";
	/** 字段默认值 */
	public static final String FIELD_VALUE_END = "field_value_end";
	/** 字典table */
	public static final String FIELD_DICTTABLE = "field_dictTable";
	/** 字典code */
	public static final String FIELD_DICTFIELD = "field_dictField";
	/** 字典数据 */
	public static final String FIELD_DICTLIST = "field_dictlist";
	
	/** 树形菜单父ID */
	public static final String TREE_PARENTID_FIELDNAME = "tree_parentid_fieldname";
	/** 树形菜单id */
	public static final String TREE_ID_FIELDNAME = "tree_id_fieldname";
	/** 树形菜单列 */
	public static final String TREE_FIELDNAME = "tree_fieldname";
	
	/** 逻辑true */
	public static final String BOOL_TRUE = "Y";
	/** 逻辑false */
	public static final String BOOL_FALSE = "N";
	/** 显示模式Date */
	public static final String TYPE_DATE = "Date";
	/** 显示模式String */
	public static final String TYPE_STRING = "String";
	/** 显示模式Integer */
	public static final String TYPE_INTEGER = "Integer";
	/** 显示模式Double */
	public static final String TYPE_DOUBLE = "Double";
	/** 查询操作= */
	public static final String OP_EQ = " = ";
	/** 查询操作>= */
	public static final String OP_RQ = " >= ";
	/** 查询操作<= */
	public static final String OP_LQ = " <= ";
	/** 查询操作like */
	public static final String OP_LIKE = " LIKE ";

	/** 系统字典分组表 */
	public static final String SYS_DICGROUP = "t_s_typegroup";
	/** 系统字典表 */
	public static final String SYS_DIC = "t_s_type";

	/** 智能表单生成的表的前缀为jform_ */
	public static final String jform_ = "jform_";

	/** sql增强insert */
	public static final String SQL_INSERT = "insert";
	/** sql增强update */
	public static final String SQL_UPDATE = "update";
	/** 表单版本号 */
	public static final String CONFIG_VERSION = "jformVersion";

	/** 从表 */
	public static final String SUB_TABLES = "subTables";

	/** 表单类型 */
	public static final String TABLE_TYPE = "tableType";

	/** 1-单表,2-主表,3-从表 */
	public static final int JFORM_TYPE_SINGLE_TABLE = 1;
	public static final int JFORM_TYPE_MAIN_TALBE = 2;
	public static final int JFORM_TYPE_SUB_TABLE = 3;

	/**
	 * ===============系统变量约定字段=================
	 */
	/** 系统模式设置key */
	public static final String SYS_MODE_KEY = "sqlReadMode";
	/** 系统模式--开发模式 */
	public static final String SYS_MODE_DEV = "DEV";
	/** 系统模式--发布模式 */
	public static final String SYS_MODE_PUB = "PUB";
	
	
	/**
	 * ===============数据源类型=================
	 */
	/** 数据库表 table */
	public static final String DB_TYPE_TABLE = "table";
	/** 动态SQL sql */
	public static final String DB_TYPE_SQL = "SQL";
	/** java类  clazz */
	public static final String DB_TYPE_CLAZZ = "clazz";
	
	/**
	 * ===============Online代码生成器页面风格=================
	 */
	/** Table风格(form)*/
	public static final String CODE_JSP_MODE_01 = "01";
	/** Div风格(form) */
	public static final String CODE_JSP_MODE_02 = "02";
	/** 详细页面-Table风格（子表） */
	public static final String CODE_JSP_MODE_03 = "03";
	/** 自定义模板 */
	public static final String CODE_JSP_MODE_04 = "04";

	/** online配置表单版本分隔符 */
	public static final String ONLINE_TABLE_SPLIT_STR = "__";

	public static final String BASEPATH = "basePath";
	
}
