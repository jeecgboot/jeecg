package org.jeecgframework.web.cgform.service.impl.config.util;

import org.apache.commons.lang.StringUtils;

public class ColumnMeta {
	private String tableName;
	private String columnId;
	private  String columnName;
	private  int columnSize;
	private  String colunmType;
	private  String comment;//备注
	private  String fieldDefault;//默认值
	private  int decimalDigits;
	private  String isNullable; //Y 是 N 否
	private String pkType;//主键策略
	private String oldColumnName;//原来的字段名
	
	
	public boolean equals(Object obj) {
		 if (obj == this) {
	            return true;
	        }
	        if (!(obj instanceof ColumnMeta)) {
	            return false;
	        }
	        ColumnMeta meta = (ColumnMeta)obj;
	        //时间类型不比较长度
	          if (colunmType.contains("date") || colunmType.contains("blob") || colunmType.contains("text")) {
	        	  return columnName.equals(meta.getColumnName())
	  	        &&isNullable.equals(meta.isNullable)
	  	        &&isEquals(comment,meta.getComment())&&isEquals(fieldDefault,meta.getFieldDefault());
			}
	          /*else if (colunmType.contains("int")) {
				 return columnName.equals(meta.getColumnName())&& colunmType.equals(meta.getColunmType())
		        &&isNullable.equals(meta.isNullable);
			} */
	          
	          else {
				 return colunmType.equals(meta.getColunmType())
			        &&isNullable.equals(meta.isNullable)&&columnSize==meta.getColumnSize()
			        &&isEquals(comment,meta.getComment())&&isEquals(fieldDefault,meta.getFieldDefault());
			}
	}

	/**
	 * 新增对比方法： 针对Sqlserver2008数据库，不对比字段备注和默认值
	 * 
	 * @param obj 对象
	 * @param dataType 数据库类型
	 * @return
	 */
	public boolean equalsByDataType(Object obj,String dataType) {
		 if (obj == this) {
	            return true;
	        }
	        if (!(obj instanceof ColumnMeta)) {
	            return false;
	        }
	        ColumnMeta meta = (ColumnMeta)obj;
	        if("SQLSERVER".equals(dataType)){
	        	  //时间类型不比较长度
		        if (colunmType.contains("date") || colunmType.contains("blob") || colunmType.contains("text")) {
		        	  return columnName.equals(meta.getColumnName()) &&isNullable.equals(meta.isNullable);
				}else {
					 return colunmType.equals(meta.getColunmType()) && isNullable.equals(meta.isNullable)&&columnSize==meta.getColumnSize();
				}
	        }else{
	            if (colunmType.contains("date") || colunmType.contains("blob") || colunmType.contains("text")) {
		        	  return columnName.equals(meta.getColumnName())
		  	        &&isNullable.equals(meta.isNullable)
		  	        &&isEquals(comment,meta.getComment())&&isEquals(fieldDefault,meta.getFieldDefault());
				}else {
					 return colunmType.equals(meta.getColunmType())
				        &&isNullable.equals(meta.isNullable)&&columnSize==meta.getColumnSize()
				        &&isEquals(comment,meta.getComment())&&isEquals(fieldDefault,meta.getFieldDefault());
				}
	        }
	}

	
	public boolean equalsDefault(ColumnMeta meta){
		if (meta == this) {
			return true;
		}
		return isEquals(comment,meta.getComment());
	}
	
	public boolean equalsComment(ColumnMeta meta){
		if (meta == this) {
            return true;
        }
		return isEquals(comment,meta.getComment());
	}
	
	private boolean isEquals(String newS,String oldS){
		boolean booN = StringUtils.isNotEmpty(newS);
		boolean booO = StringUtils.isNotEmpty(oldS);
		if(booN!=booO){return false;}
		if(booN){return newS.equals(oldS);}
		return true;
	}
	
	public String getColumnName() {
		return columnName;
	}
	public int getColumnSize() {
		return columnSize;
	}
	public String getColunmType() {
		return colunmType;
	}
	public String getComment() {
		return comment;
	}
	public int getDecimalDigits() {
		return decimalDigits;
	}
	public String getIsNullable() {
		return isNullable;
	}
	public String getOldColumnName() {
		return oldColumnName;
	}
    public int hashCode() {
        return columnSize + colunmType.hashCode()*columnName.hashCode();
    }
	public void setColumnName(String columnName) {
		this.columnName = columnName;
	}
	public void setColumnSize(int columnSize) {
		this.columnSize = columnSize;
	}
	
	 public void setColunmType(String colunmType) {
		this.colunmType = colunmType;
	}
	public void setComment(String comment) {
		this.comment = comment;
	}
	public void setDecimalDigits(int decimalDigits) {
		this.decimalDigits = decimalDigits;
	}
	public void setIsNullable(String isNullable) {
		this.isNullable = isNullable;
	}
	public void setOldColumnName(String oldColumnName) {
		this.oldColumnName = oldColumnName;
	}
	
	public String toString() {
		return columnName+","+colunmType+","+isNullable+","+columnSize;
	}
	public String getColumnId() {
		return columnId;
	}
	public void setColumnId(String columnId) {
		this.columnId = columnId;
	}
	public String getTableName() {
		return tableName;
	}
	public void setTableName(String tableName) {
		this.tableName = tableName;
	}
	public String getFieldDefault() {
		return fieldDefault;
	}
	public void setFieldDefault(String fieldDefault) {
		this.fieldDefault = fieldDefault;
	}

	public String getPkType() {
		return pkType;
	}

	public void setPkType(String pkType) {
		this.pkType = pkType;
	}
	
	
}