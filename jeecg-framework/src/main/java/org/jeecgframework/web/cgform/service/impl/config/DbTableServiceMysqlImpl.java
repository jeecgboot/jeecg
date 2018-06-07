package org.jeecgframework.web.cgform.service.impl.config;

import java.util.Collection;
import java.util.Collections;
import java.util.Iterator;
import java.util.Map;

import org.jeecgframework.web.cgform.entity.config.CgFormFieldEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.service.config.DbTableServiceI;
import org.jeecgframework.web.cgform.service.impl.config.util.DbTableUtil;
import org.jeecgframework.web.cgform.service.impl.config.util.FieldNumComparator;

import org.jeecgframework.codegenerate.util.CodeResourceUtil;
import org.jeecgframework.core.util.StringUtil;
import org.springframework.jdbc.core.JdbcTemplate;


/**
 * mysql的表工具类
 * @author jueyue
 *
 */
public class DbTableServiceMysqlImpl implements DbTableServiceI {
	

	
	public String createTableSQL(CgFormHeadEntity cgFormHead) {
		StringBuilder sb = new StringBuilder();
		sb.append("CREATE TABLE ");
		sb.append(cgFormHead.getTableName()+" (");
		CgFormFieldEntity column,agoColumn = null;
		Collections.sort(cgFormHead.getColumns(), new FieldNumComparator());
		String idField = "";
		Collections.sort(cgFormHead.getColumns(),new FieldNumComparator());
		for(int i = 0;i<cgFormHead.getColumns().size();i++){
			if(i>0){agoColumn = cgFormHead.getColumns().get(i-1);}
			column = cgFormHead.getColumns().get(i);
			sb.append(getColumnPorperty(column,agoColumn,false));
			if(column.getIsKey().equals("Y")){
				idField+=DbTableUtil.translatorToDbField(DbTableUtil.translatorToDbField(column.getFieldName()))+",";
			}
		}
		sb.append(" PRIMARY KEY ("+idField.substring(0, idField.length()-1)+")");
		sb.append(") ENGINE=InnoDB DEFAULT CHARSET=utf8;");
		return sb.toString();
	}

	
	public String dropTableSQL(CgFormHeadEntity tableProperty) {
		return " DROP TABLE IF EXISTS "+tableProperty.getTableName()+" ;";
	}
	
	@Deprecated
	public String updateTableSQL(CgFormHeadEntity cgFormHead, JdbcTemplate jdbcTemplate) {
		String sql = "select column_name,data_type,column_comment,numeric_precision,numeric_scale,character_maximum_length," +
				"is_nullable nullable from information_schema.columns where table_name = ?  and table_schema = ?;";

		Map<String, Object> fieldMap =  DbTableUtil.getColumnMap(jdbcTemplate.queryForList(sql,cgFormHead.getTableName(),CodeResourceUtil.DATABASE_NAME));
		StringBuilder sb = new StringBuilder();
		sb.append(createChangeTableSql(cgFormHead));
		CgFormFieldEntity column,agoColumn = null;
		String idField = "";
		//step1 :对列进行排序
		Collections.sort(cgFormHead.getColumns(),new FieldNumComparator());
		for(int i = 0;i<cgFormHead.getColumns().size();i++){
			if(i>0){agoColumn = cgFormHead.getColumns().get(i-1);}
			column = cgFormHead.getColumns().get(i);
			//step2 :判断是否有这个字段  有 更新  没有 添加
			if(fieldMap.containsKey(DbTableUtil.translatorToDbField(column.getFieldName()))){
				sb.append(createUpdateColumnSql(column,agoColumn));
				fieldMap.remove(DbTableUtil.translatorToDbField(column.getFieldName()));
			}else{
				sb.append(createAddColumnSql(column,agoColumn));
			}
			if(column.getIsKey().equals("Y")){
				idField+=DbTableUtil.translatorToDbField(column.getFieldName())+",";
			}
			
		}
		//step3 :查看还剩余的字段,说明已经被删除了,删除掉
		 Collection<Object> c = fieldMap.values();
	     Iterator<Object> it = c.iterator();
	     for (;it.hasNext();) {
	    	 Map<String, Object> field = (Map<String, Object>) it.next();
	         sb.append(createDropColumn(field.get("column_name").toString()));
	     }
	     sb.append("DROP PRIMARY KEY,ADD PRIMARY KEY ("+idField.substring(0, idField.length()-1)+")");
		return sb.toString();
	}
	
	/**
	 * 创建增加字段的sql
	 * @param column
	 * @param agoColumn 
	 * @return
	 */
	private String createAddColumnSql(CgFormFieldEntity column, CgFormFieldEntity agoColumn) {
		return " ADD COLUMN "+getColumnPorperty(column,agoColumn,true);
	}
	/**
	 * 创建更新字段的sql
	 * @param newColumn
	 * @param agoColumn 
	 * @return
	 */
	private String createUpdateColumnSql(CgFormFieldEntity newColumn, CgFormFieldEntity agoColumn) {
		return " MODIFY COLUMN "+getColumnPorperty(newColumn,agoColumn,true);
	}
	/**
	 * 创建删除字段的sql
	 * @param fieldName
	 * @return
	 */
	private String createDropColumn(String fieldName) {
		return " DROP COLUMN "+fieldName+",";
	}
	
	/**
	 * 获取这个字段的属性
	 * @param column
	 * @param agoColumn 
	 * @param isUpdate
	 * @return
	 */
	private String getColumnPorperty(CgFormFieldEntity column, CgFormFieldEntity agoColumn, boolean isUpdate){
		String result = " " + DbTableUtil.translatorToDbField(column.getFieldName())+" "
				+getFieldType(column)+" ";
		result+=StringUtil.isEmpty(column.getIsNull())?" NOT NULL ":"NULL";
		result+=" COMMENT '"+column.getContent()+"' ";
		if(isUpdate){
			String agoFiled = " FIRST ";
			if(agoColumn!=null){
				agoFiled = " AFTER "+DbTableUtil.translatorToDbField(agoColumn.getFieldName());
			}
			result+=agoFiled;
		}
		return result +", ";
	}
	

	/**
	 * 获取字段类型
	 * @param cloumn
	 * @return
	 */
	private String getFieldType(CgFormFieldEntity cloumn){
		String result ="";
		if(cloumn.getType().equals("string")){
			result = "varchar("+cloumn.getLength()+")";
		}else if(cloumn.getType().equals("Date")){
			result = "datetime";
		}else if(cloumn.getType().equals("int")){
			result = cloumn.getType()+"("+cloumn.getLength()+")";
		}else if(cloumn.getType().equals("double")){
			result = cloumn.getType()+"("+cloumn.getLength()+","+cloumn.getPointLength()+")";
		}
		return result;
	}
	/**
	 * 修改字段的sql
	 * @param table
	 * @return
	 */
	private String createChangeTableSql(CgFormHeadEntity table) {
		return "ALTER TABLE "+table.getTableName()+" ";
	}
	
	
	public String createIsExitSql(String tableName) {
		return "SELECT COUNT(*) FROM information_schema.TABLES WHERE TABLE_NAME='"+tableName+"' and table_schema = '"+CodeResourceUtil.DATABASE_NAME+"';";
	}

	

}
