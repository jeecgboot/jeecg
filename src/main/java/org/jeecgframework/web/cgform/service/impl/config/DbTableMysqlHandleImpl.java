package org.jeecgframework.web.cgform.service.impl.config;

import org.apache.commons.lang.StringUtils;

import org.jeecgframework.web.cgform.service.config.DbTableHandleI;
import org.jeecgframework.web.cgform.service.impl.config.util.ColumnMeta;


/**
 * mysql的表工具类
 */
public class DbTableMysqlHandleImpl implements DbTableHandleI {

	
	public String getAddColumnSql(ColumnMeta columnMeta) {
		return " ADD COLUMN "+getAddFieldDesc(columnMeta)+";";
	}

	
	public String getReNameFieldName(ColumnMeta columnMeta) {
		return "CHANGE COLUMN  "+columnMeta.getOldColumnName() +" "+getRenameFieldDesc(columnMeta)+ " ;";
	}

	
	public String getUpdateColumnSql(ColumnMeta cgformcolumnMeta,ColumnMeta datacolumnMeta) {
		return " MODIFY COLUMN  "+getUpdateFieldDesc(cgformcolumnMeta,datacolumnMeta)+";";
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
		}else if (dataType.equalsIgnoreCase("decimal")){
			result="bigdecimal";
		}else if (dataType.equalsIgnoreCase("text")){
			result="text";
		}else if (dataType.equalsIgnoreCase("blob")){
			result="blob";
		}
		return result;
	}

	
	public String dropTableSQL(String tableName) {
		return " DROP TABLE IF EXISTS "+tableName+" ;";
	}

	
	public String getDropColumnSql(String fieldName) {
		 return " DROP COLUMN "+fieldName+";";
	}
	/**
	 * 将get...FieldDesc这些方法中共同的内容抽出来
	 * @param cgfromcolumnMeta
	 * @param datacolumnMeta
	 * @return
	 */
	private String getFieldDesc(ColumnMeta cgfromcolumnMeta,ColumnMeta datacolumnMeta){
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
			result = cgfromcolumnMeta.getColumnName()+" text "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}else if(cgfromcolumnMeta.getColunmType().equalsIgnoreCase("blob")){
			result = cgfromcolumnMeta.getColumnName()+" blob "+(cgfromcolumnMeta.getIsNullable().equals("Y")?"NULL":"NOT NULL");
		}
		result += (StringUtils.isNotEmpty(cgfromcolumnMeta.getComment())?" COMMENT '"+cgfromcolumnMeta.getComment()+"'":" ");
		result += (StringUtils.isNotEmpty(cgfromcolumnMeta.getFieldDefault())?" DEFAULT "+cgfromcolumnMeta.getFieldDefault():" ");
		String pkType = cgfromcolumnMeta.getPkType();
		if("id".equalsIgnoreCase(cgfromcolumnMeta.getColumnName())&&pkType!=null&&
				("SEQUENCE".equalsIgnoreCase(pkType)||"NATIVE".equalsIgnoreCase(pkType))){
			result += " AUTO_INCREMENT ";
		}
		return result;
	}
	
	private String getUpdateFieldDesc(ColumnMeta cgfromcolumnMeta,ColumnMeta datacolumnMeta) {
		String result = this.getFieldDesc(cgfromcolumnMeta, datacolumnMeta);
		return result;
	}

	private String getAddFieldDesc(ColumnMeta cgfromcolumnMeta) {
		String result = this.getFieldDesc(cgfromcolumnMeta, null);
		return result;
	}
	
	private String getRenameFieldDesc(ColumnMeta cgfromcolumnMeta) {
		String result = this.getFieldDesc(cgfromcolumnMeta, null);
		return result;
	}
	/**
	 * Mysql注释是和修改的sql一起的,所以返回空字符串就可以了
	 */
	
	public String getCommentSql(ColumnMeta columnMeta) {
		return "";
	}

	
	public String getSpecialHandle(ColumnMeta cgformcolumnMeta,
			ColumnMeta datacolumnMeta) {
		return null;
	}

}
