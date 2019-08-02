package org.jeecgframework.core.util;

import java.text.MessageFormat;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import org.jeecgframework.web.system.pojo.base.DynamicDataSourceEntity;

/**
 * Created by 张忠亮 on 2015/6/8.
 */
public class SqlUtil {

    public static final String DATABSE_TYPE_MYSQL ="mysql";
    public static final String DATABSE_TYPE_POSTGRE ="postgresql";
    public static final String DATABSE_TYPE_ORACLE ="oracle";
    public static final String DATABSE_TYPE_SQLSERVER ="sqlserver";

    /**
     * 分页SQL
     */
    public static final String MYSQL_SQL = "select * from ( {0}) sel_tab00 limit {1},{2}";         //mysql
    public static final String POSTGRE_SQL = "select * from ( {0}) sel_tab00 limit {2} offset {1}";//postgresql
    public static final String ORACLE_SQL = "select * from (select row_.*,rownum rownum_ from ({0}) row_ where rownum <= {1}) where rownum_>{2}"; //oracle
    public static final String SQLSERVER_SQL = "select * from ( select row_number() over(order by tempColumn) tempRowNumber, * from (select top {1} tempColumn = 0, {0}) t ) tt where tempRowNumber > {2}"; //sqlserver

    /**
     * 获取所有表的SQL
     */
    public static final String MYSQL_ALLTABLES_SQL = "select distinct table_name from information_schema.columns where table_schema = {0}";         
    public static final String POSTGRE__ALLTABLES_SQL = "SELECT distinct c.relname AS  table_name FROM pg_class c";
    public static final String ORACLE__ALLTABLES_SQL = "select distinct colstable.table_name as  table_name from user_tab_cols colstable"; 
    public static final String SQLSERVER__ALLTABLES_SQL= "select distinct c.name as  table_name from sys.objects c";
    
    /**
     * 获取指定表的所有列名
     */
    public static final String MYSQL_ALLCOLUMNS_SQL = "select column_name from information_schema.columns where table_name = {0} and table_schema = {1}";
    public static final String POSTGRE_ALLCOLUMNS_SQL = "select table_name from information_schema.columns where table_name = {0}";
    public static final String ORACLE_ALLCOLUMNS_SQL = "select column_name from all_tab_columns where table_name ={0}";
    public static final String SQLSERVER_ALLCOLUMNS_SQL = "select name from syscolumns where id={0}";

    /**
     * 获取全sql
     * @param sql
     * @param params
     * @return
     */
    public static String getFullSql(String sql,Map params){
        StringBuilder sqlB =  new StringBuilder();
        sqlB.append("SELECT t.* FROM ( ");
        sqlB.append(sql+" ");
        sqlB.append(") t ");
        if (params!=null&&params.size() >= 1) {
            sqlB.append("WHERE 1=1  ");
            Iterator it = params.keySet().iterator();
            while (it.hasNext()) {
                String key = String.valueOf(it.next());
                String value = String.valueOf(params.get(key));
                if (!StringUtil.isEmpty(value) && !"null".equals(value)) {
                    sqlB.append(" AND ");
                    sqlB.append(" " + key +  value );
                }
            }
        }
        return sqlB.toString();
    }

    /**
     * 获取求数量sql
     * @param sql
     * @param params
     * @return
     */
    public static String getCountSql(String sql, Map params) {
        String querySql = getFullSql(sql,params);

        //若要兼容数据库,SQL中取别名一律用大写
        querySql = "SELECT COUNT(*) COUNT FROM ("+querySql+") t2";

        return querySql;
    }

    /**
     * 生成分页查询sql
     * @param sql
     * @param page
     * @param rows
     * @return
     */
    public static String jeecgCreatePageSql(String sql,Map params, int page, int rows){
        int beginNum = (page - 1) * rows;
        String[] sqlParam = new String[3];
        sqlParam[0] = sql;
        sqlParam[1] = beginNum+"";
        sqlParam[2] = rows+"";
        if(ResourceUtil.getJdbcUrl().indexOf(DATABSE_TYPE_MYSQL)!=-1){
            sql = MessageFormat.format(MYSQL_SQL, sqlParam);
        }else if(ResourceUtil.getJdbcUrl().indexOf(DATABSE_TYPE_POSTGRE)!=-1){
            sql = MessageFormat.format(POSTGRE_SQL, sqlParam);
        }else {
            int beginIndex = (page-1)*rows;
            int endIndex = beginIndex+rows;
            sqlParam[2] = Integer.toString(beginIndex);
            sqlParam[1] = Integer.toString(endIndex);
            if(ResourceUtil.getJdbcUrl().indexOf(DATABSE_TYPE_ORACLE)!=-1) {
                sql = MessageFormat.format(ORACLE_SQL, sqlParam);
            } else if(ResourceUtil.getJdbcUrl().indexOf(DATABSE_TYPE_SQLSERVER)!=-1) {
                sqlParam[0] = sql.substring(getAfterSelectInsertPoint(sql));
                sql = MessageFormat.format(SQLSERVER_SQL, sqlParam);
            }
        }
        return sql;
    }
    
    /**
     * 生成分页查询sql
     * @param sql
     * @param page
     * @param rows
     * @return
     */
    @SuppressWarnings("rawtypes")
	public static String jeecgCreatePageSql(String dbKey,String sql,Map params, int page, int rows){

    	sql = getFullSql(sql,params);

        int beginNum = (page - 1) * rows;
        String[] sqlParam = new String[3];
        sqlParam[0] = sql;
        sqlParam[1] = beginNum+"";
        sqlParam[2] = rows+"";
        DynamicDataSourceEntity dynamicSourceEntity = ResourceUtil.getCacheDynamicDataSourceEntity(dbKey);
        String databaseType = dynamicSourceEntity.getDbType();
        if(DATABSE_TYPE_MYSQL.equalsIgnoreCase(databaseType)){
            sql = MessageFormat.format(MYSQL_SQL, sqlParam);
        }else if(DATABSE_TYPE_POSTGRE.equalsIgnoreCase(databaseType)){
            sql = MessageFormat.format(POSTGRE_SQL, sqlParam);
        }else {
            int beginIndex = (page-1)*rows;
            int endIndex = beginIndex+rows;
            sqlParam[2] = Integer.toString(beginIndex);
            sqlParam[1] = Integer.toString(endIndex);
            if(DATABSE_TYPE_ORACLE.equalsIgnoreCase(databaseType)) {
                sql = MessageFormat.format(ORACLE_SQL, sqlParam);
            } else if(DATABSE_TYPE_SQLSERVER.equalsIgnoreCase(databaseType)) {
                sqlParam[0] = sql.substring(getAfterSelectInsertPoint(sql));
                sql = MessageFormat.format(SQLSERVER_SQL, sqlParam);
            }
        }
        return sql;
    }
    
    private static int getAfterSelectInsertPoint(String sql) {
        int selectIndex = sql.toLowerCase().indexOf("select");
        int selectDistinctIndex = sql.toLowerCase().indexOf("select distinct");
        return selectIndex + (selectDistinctIndex == selectIndex ? 15 : 6);
    }

    public static String getAllTableSql(String dbType,String ... param){
    	if(StringUtil.isNotEmpty(dbType)){
	    	if(dbType.equals(DATABSE_TYPE_MYSQL)){
	    		return MessageFormat.format(MYSQL_ALLTABLES_SQL, param);
	    	}else if(dbType.equals(DATABSE_TYPE_ORACLE)){
	    		return ORACLE__ALLTABLES_SQL;
	    	}else if(dbType.equals(DATABSE_TYPE_POSTGRE)){
	    		return POSTGRE__ALLTABLES_SQL;
	    	}else if(dbType.equals(DATABSE_TYPE_SQLSERVER)){
	    		return SQLSERVER__ALLTABLES_SQL;
	    	}
    	}
    	return null;
    }
    
    public static String getAllCloumnSql(String dbType,String ... param){
    	if(StringUtil.isNotEmpty(dbType)){
	    	if(dbType.equals(DATABSE_TYPE_MYSQL)){
	    		return MessageFormat.format(MYSQL_ALLCOLUMNS_SQL, param);
	    	}else if(dbType.equals(DATABSE_TYPE_ORACLE)){
	    		return MessageFormat.format(ORACLE_ALLCOLUMNS_SQL, param);
	    	}else if(dbType.equals(DATABSE_TYPE_POSTGRE)){
	    		return MessageFormat.format(POSTGRE_ALLCOLUMNS_SQL, param);
	    	}else if(dbType.equals(DATABSE_TYPE_SQLSERVER)){
	    		return MessageFormat.format(SQLSERVER_ALLCOLUMNS_SQL, param);
	    	}
    	}
    	return null;
    }

}
