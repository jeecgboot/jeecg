package org.jeecgframework.web.cgform.service.impl.config;

import org.apache.commons.lang.StringUtils;
import org.jeecgframework.core.util.StringUtil;

import org.jeecgframework.web.cgform.service.config.DbTableHandleI;
import org.jeecgframework.web.cgform.service.impl.config.util.ColumnMeta;


/**
 * SQLSERVER的表工具类
 */
public class TableSQLServerHandleImpl implements DbTableHandleI {

	
	public String getAddColumnSql(ColumnMeta columnMeta) {
		return " ADD  "+getAddFieldDesc(columnMeta)+";";
	}

	
	public String getReNameFieldName(ColumnMeta columnMeta) {
		//sp_rename 'TOA_E_ARTICLE.version','processVersion','COLUMN';  
		return  "  sp_rename '"+columnMeta.getTableName()+"."+columnMeta.getOldColumnName()+"', '"+columnMeta.getColumnName()+"', 'COLUMN';";
		//return "ALTER COLUMN  "+columnMeta.getOldColumnName() +" "+getRenameFieldDesc(columnMeta)+";";
	}

	
	public String getUpdateColumnSql(ColumnMeta cgformcolumnMeta,ColumnMeta datacolumnMeta) {
		return " ALTER COLUMN  "+getUpdateFieldDesc(cgformcolumnMeta,datacolumnMeta)+";";
	}

	
	public String getMatchClassTypeByDataType(String dataType,int digits) {
		String result ="";
		if (dataType.equalsIgnoreCase("varchar")) {
			result="string";
		} else if(dataType.equalsIgnoreCase("double")){
			result="double";
		}else if (dataType.equalsIgnoreCase("int")) {
			result="int";
		}else if (dataType.equalsIgnoreCase("Date")) {
			result="date";
		}else if (dataType.equalsIgnoreCase("Datetime")) {
			result="date";
		}else if (dataType.equalsIgnoreCase("numeric")) {
			result="double";
		}
		return result;
	}

	
	public String dropTableSQL(String tableName) {
		return " DROP TABLE "+tableName+" ;";
	}

	
	public String getDropColumnSql(String fieldName) {
		 return " DROP COLUMN "+fieldName+";";
	}
	
	private String getUpdateFieldDesc(ColumnMeta cgfromcolumnMeta,ColumnMeta datacolumnMeta) {
		String result ="";
		if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("string")){
			result = cgfromcolumnMeta.getColumnName()+" varchar("+cgfromcolumnMeta.getColumnSize()+")"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("date")){
			result = cgfromcolumnMeta.getColumnName()+" datetime"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("int")){
			result = cgfromcolumnMeta.getColumnName()+" int"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("double")){
			result = cgfromcolumnMeta.getColumnName()+" numeric("+cgfromcolumnMeta.getColumnSize()+","+cgfromcolumnMeta.getDecimalDigits()+")"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}
		result += (StringUtils.isNotEmpty(cgfromcolumnMeta.getFieldDefault())?" DEFAULT "+cgfromcolumnMeta.getFieldDefault():" ");
		return result;
	}

	private String getAddFieldDesc(ColumnMeta cgfromcolumnMeta) {
		String result ="";
		if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("string")){
			result = cgfromcolumnMeta.getColumnName()+" varchar("+cgfromcolumnMeta.getColumnSize()+")"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("date")){
			result = cgfromcolumnMeta.getColumnName()+" datetime"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("int")){
			result = cgfromcolumnMeta.getColumnName()+" int("+cgfromcolumnMeta.getColumnSize()+")"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("double")){
			result = cgfromcolumnMeta.getColumnName()+" double("+cgfromcolumnMeta.getColumnSize()+","+cgfromcolumnMeta.getDecimalDigits()+")"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("bigdecimal")){
			result = cgfromcolumnMeta.getColumnName()+" decimal("+cgfromcolumnMeta.getColumnSize()+","+cgfromcolumnMeta.getDecimalDigits()+")"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("text")){
			result = cgfromcolumnMeta.getColumnName()+" text"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("blob")){
			result = cgfromcolumnMeta.getColumnName()+" varbinary("+cgfromcolumnMeta.getColumnSize()+")"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}//update-end--Author:liuht  Date:20131223 
		result += (StringUtils.isNotEmpty(cgfromcolumnMeta.getFieldDefault())?" DEFAULT "+cgfromcolumnMeta.getFieldDefault():" ");
		return result;
	}
	
	private String getRenameFieldDesc(ColumnMeta cgfromcolumnMeta) {
		String result ="";
		if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("string")){
			result = cgfromcolumnMeta.getColumnName()+" varchar("+cgfromcolumnMeta.getColumnSize()+")"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("date")){
			result = cgfromcolumnMeta.getColumnName()+" datetime"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("int")){
			result = cgfromcolumnMeta.getColumnName()+" int("+cgfromcolumnMeta.getColumnSize()+")"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("double")){
			result = cgfromcolumnMeta.getColumnName()+" double("+cgfromcolumnMeta.getColumnSize()+","+cgfromcolumnMeta.getDecimalDigits()+")"+" "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}
		return result;
	}

	
	public String getCommentSql(ColumnMeta columnMeta) {
		StringBuffer commentSql = new StringBuffer("EXECUTE ");
		if(StringUtil.isEmpty(columnMeta.getOldColumnName())){
			commentSql.append("sp_addextendedproperty");
		} else {
			commentSql.append("sp_updateextendedproperty");
		}
		commentSql.append(" N'MS_Description', '");
		commentSql.append(columnMeta.getComment());
		commentSql.append("', N'SCHEMA', N'dbo', N'TABLE', N'");
		commentSql.append(columnMeta.getTableName());
		commentSql.append("', N'COLUMN', N'");
		commentSql.append(columnMeta.getColumnName() +"'");
		return commentSql.toString();
	}

	
	public String getSpecialHandle(ColumnMeta cgformcolumnMeta,
			ColumnMeta datacolumnMeta) {
		return null;
	}

}
