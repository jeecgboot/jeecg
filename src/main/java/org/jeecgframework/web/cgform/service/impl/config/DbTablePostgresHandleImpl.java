package org.jeecgframework.web.cgform.service.impl.config;

import org.apache.commons.lang.StringUtils;

import org.jeecgframework.web.cgform.exception.BusinessException;
import org.jeecgframework.web.cgform.exception.DBException;
import org.jeecgframework.web.cgform.service.config.DbTableHandleI;
import org.jeecgframework.web.cgform.service.impl.config.util.ColumnMeta;


/**
 * postgres的表工具类
 */
public class DbTablePostgresHandleImpl implements DbTableHandleI {

	
	public String getAddColumnSql(ColumnMeta columnMeta) {
		return " ADD COLUMN "+getAddFieldDesc(columnMeta)+";";
	}

	
	public String getReNameFieldName(ColumnMeta columnMeta) {
		return " RENAME  COLUMN  "+columnMeta.getOldColumnName() +" to "+columnMeta.getColumnName()+";";
	}

	
	public String getUpdateColumnSql(ColumnMeta cgformcolumnMeta,ColumnMeta datacolumnMeta)throws DBException {
		return "  ALTER  COLUMN   "+getUpdateFieldDesc(cgformcolumnMeta,datacolumnMeta)+";";
	}

	
	public String getSpecialHandle(ColumnMeta cgformcolumnMeta,
			ColumnMeta datacolumnMeta) {
		return "  ALTER  COLUMN   "+getUpdateFieldDefault(cgformcolumnMeta,datacolumnMeta)+";";
	}
	
	
	public String getMatchClassTypeByDataType(String dataType,int digits) {
		String result ="";
		if (dataType.equalsIgnoreCase("varchar")) {
			result="string";
		} else if(dataType.equalsIgnoreCase("double")){
			result="double";
		}else if (dataType.contains("int")) {
			result="int";
		}else if (dataType.equalsIgnoreCase("Date")) {
			result="date";
		}else if (dataType.equalsIgnoreCase("timestamp")) {
			result="date";
		}else if (dataType.equalsIgnoreCase("bytea")) {
			result="blob";
		}else if (dataType.equalsIgnoreCase("text")) {
			result="text";
		}else if (dataType.equalsIgnoreCase("decimal")) {
			result="bigdecimal";
		}else if (dataType.equalsIgnoreCase("numeric")) {
			//double和decimal都会返回numeric，先暂时返回bigdecimal
			result="bigdecimal";
		}
		return result;
	}

	
	public String dropTableSQL(String tableName) {
		return " DROP TABLE  "+tableName+" ;";
	}

	
	public String getDropColumnSql(String fieldName) {
		 return " DROP COLUMN "+fieldName+";";
	}
	
	private String getUpdateFieldDesc(ColumnMeta cgfromcolumnMeta,ColumnMeta datacolumnMeta) throws DBException {
		String result ="";
		//TODO 对于非空情况 ，需要特殊增加约束方法，默认是空
		if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("string")){
			result = cgfromcolumnMeta.getColumnName()+"  type character varying("+cgfromcolumnMeta.getColumnSize()+")"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("date")){
			result = cgfromcolumnMeta.getColumnName()+"  type datetime"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("int")){
			//postpres数据库整形没有长度概念
			result = cgfromcolumnMeta.getColumnName()+" type int4 ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("double")){
			result = cgfromcolumnMeta.getColumnName()+" type  numeric("+cgfromcolumnMeta.getColumnSize()+","+cgfromcolumnMeta.getDecimalDigits()+")"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("BigDecimal")){
			result = cgfromcolumnMeta.getColumnName()+" type  decimal("+cgfromcolumnMeta.getColumnSize()+","+cgfromcolumnMeta.getDecimalDigits()+")"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("text")){
			result = cgfromcolumnMeta.getColumnName()+"  type text("+cgfromcolumnMeta.getColumnSize()+")"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("blob")){
//			bytea类型不可修改，修改会报错
			throw new DBException("blob类型不可修改");
		}
		return result;
	}

	private String getUpdateFieldDefault(ColumnMeta cgfromcolumnMeta,ColumnMeta datacolumnMeta) {
		String result ="";
		
		if(!cgfromcolumnMeta.equalsDefault(datacolumnMeta)){
			if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("string")){
				result = cgfromcolumnMeta.getColumnName();
				result += (StringUtils.isNotEmpty(cgfromcolumnMeta.getFieldDefault())?" SET DEFAULT "+cgfromcolumnMeta.getFieldDefault():" DROP DEFAULT");
			}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("date")){
				result = cgfromcolumnMeta.getColumnName();
				result += (StringUtils.isNotEmpty(cgfromcolumnMeta.getFieldDefault())?" SET DEFAULT "+cgfromcolumnMeta.getFieldDefault():" DROP DEFAULT");
			}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("int")){
				result = cgfromcolumnMeta.getColumnName();
				result += (StringUtils.isNotEmpty(cgfromcolumnMeta.getFieldDefault())?" SET DEFAULT "+cgfromcolumnMeta.getFieldDefault():" DROP DEFAULT");
			}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("double")){
				result = cgfromcolumnMeta.getColumnName();
				result += (StringUtils.isNotEmpty(cgfromcolumnMeta.getFieldDefault())?" SET DEFAULT "+cgfromcolumnMeta.getFieldDefault():" DROP DEFAULT");
			}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("bigdecimal")){
				result = cgfromcolumnMeta.getColumnName();
				result += (StringUtils.isNotEmpty(cgfromcolumnMeta.getFieldDefault())?" SET DEFAULT "+cgfromcolumnMeta.getFieldDefault():" DROP DEFAULT");
			}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("text")){
				result = cgfromcolumnMeta.getColumnName();
				result += (StringUtils.isNotEmpty(cgfromcolumnMeta.getFieldDefault())?" SET DEFAULT "+cgfromcolumnMeta.getFieldDefault():" DROP DEFAULT");
			}
			
		}
		return result;
	}
	
	
	private String getAddFieldDesc(ColumnMeta cgfromcolumnMeta) {
		String result ="";
		if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("string")){
			result = cgfromcolumnMeta.getColumnName()+" character varying("+cgfromcolumnMeta.getColumnSize()+")"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("date")){
			result = cgfromcolumnMeta.getColumnName()+" datetime"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("int")){
			result = cgfromcolumnMeta.getColumnName()+" int4";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("double")){
			result = cgfromcolumnMeta.getColumnName()+" numeric("+cgfromcolumnMeta.getColumnSize()+","+cgfromcolumnMeta.getDecimalDigits()+")"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("bigdecimal")){
			result = cgfromcolumnMeta.getColumnName()+" decimal("+cgfromcolumnMeta.getColumnSize()+","+cgfromcolumnMeta.getDecimalDigits()+")"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("blob")){
			result = cgfromcolumnMeta.getColumnName()+" bytea("+cgfromcolumnMeta.getColumnSize()+")"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("text")){
			result = cgfromcolumnMeta.getColumnName()+" text("+cgfromcolumnMeta.getColumnSize()+")"+" ";
		}
		result += (StringUtils.isNotEmpty(cgfromcolumnMeta.getFieldDefault())?" DEFAULT "+cgfromcolumnMeta.getFieldDefault():" ");
		return result;
	}
	
	private String getRenameFieldDesc(ColumnMeta cgfromcolumnMeta) {
		String result ="";
		if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("string")){
			result = cgfromcolumnMeta.getColumnName()+" character varying("+cgfromcolumnMeta.getColumnSize()+")"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("date")){
			result = cgfromcolumnMeta.getColumnName()+" datetime"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("int")){
			result = cgfromcolumnMeta.getColumnName()+" int("+cgfromcolumnMeta.getColumnSize()+")"+" ";
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("double")){
			result = cgfromcolumnMeta.getColumnName()+" numeric("+cgfromcolumnMeta.getColumnSize()+","+cgfromcolumnMeta.getDecimalDigits()+")"+" ";
		}
		return result;
	}

	
	public String getCommentSql(ColumnMeta columnMeta) {
		return "COMMENT ON COLUMN "+columnMeta.getTableName()+"."+columnMeta.getColumnName()+" IS '" +columnMeta.getComment()+"'";
	}


}
