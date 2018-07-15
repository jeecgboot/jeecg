package org.jeecgframework.web.cgform.entity.generate;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.util.List;
import java.util.Map;

import org.jeecgframework.web.cgform.entity.button.CgformButtonEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.entity.enhance.CgformEnhanceJavaEntity;
import org.jeecgframework.web.cgform.entity.enhance.CgformEnhanceJsEntity;

/**
 * 
 * @Title:GenerateEntity
 * @description:代码生成实体
 * @author 赵俊夫
 * @date Sep 7, 2013 1:10:18 PM
 * @version V1.0
 */
public class GenerateEntity implements java.io.Serializable{
	/**
	 * 
	 */
	private static final long serialVersionUID = 7821940124097563556L;
	private String entityPackage;// 包名（小写）
	private String entityName;// 实体名（首字母大写）
	private String tableName; // 表名
	private String ftlDescription;// 功能描述
	private String primaryKeyPolicy = "uuid";// 主键生成策略
	private String[] foreignKeys;// 子表：外键(中间逗号隔开)
	private Integer fieldRowNum;// 一行放几个字段
	private String projectPath;//工程路径
	private String packageStyle;//代码包风格

	private String supportRestful;//是否生成Restful相关代码：1是 0否

	/*
	 * --------------智能表单配置
	 */
	/**
	 * 表单配置抬头
	 */
	private CgFormHeadEntity cgFormHead;
	/**
	 * 按钮配置
	 */
	private List<CgformButtonEntity> buttons;
	/**
	 * 按钮SQL增强配置
	 */
	private Map<String,String[]> buttonSqlMap;
	/**
	 * 列表JS增强
	 */
	private CgformEnhanceJsEntity listJs;
	/**
	 * 表单Js增强
	 */
	private CgformEnhanceJsEntity formJs;
	/**
	 * 表单java增强
	 */
	private Map<String,CgformEnhanceJavaEntity> buttonJavaMap;
	
	public String getEntityPackage() {
		return entityPackage;
	}

	public void setEntityPackage(String entityPackage) {
		this.entityPackage = entityPackage;
	}

	public String getEntityName() {
		return entityName;
	}

	public void setEntityName(String entityName) {
		this.entityName = entityName;
	}

	public String getTableName() {
		return tableName;
	}

	public void setTableName(String tableName) {
		this.tableName = tableName;
	}

	public String getFtlDescription() {
		return ftlDescription;
	}

	public void setFtlDescription(String ftlDescription) {
		this.ftlDescription = ftlDescription;
	}

	public String getPrimaryKeyPolicy() {
		return primaryKeyPolicy;
	}

	public void setPrimaryKeyPolicy(String primaryKeyPolicy) {
		this.primaryKeyPolicy = primaryKeyPolicy;
	}

	public String[] getForeignKeys() {
		return foreignKeys;
	}

	public void setForeignKeys(String[] foreignKeys) {
		this.foreignKeys = foreignKeys;
	}

	public Integer getFieldRowNum() {
		return fieldRowNum;
	}

	public void setFieldRowNum(Integer fieldRowNum) {
		this.fieldRowNum = fieldRowNum;
	}

	public CgFormHeadEntity getCgFormHead() {
		return cgFormHead;
	}

	public void setCgFormHead(CgFormHeadEntity cgFormHead) {
		this.cgFormHead = cgFormHead;
	}

	public List<CgformButtonEntity> getButtons() {
		return buttons;
	}

	public void setButtons(List<CgformButtonEntity> buttons) {
		this.buttons = buttons;
	}

	

	public Map<String, String[]> getButtonSqlMap() {
		return buttonSqlMap;
	}

	public void setButtonSqlMap(Map<String, String[]> buttonSqlMap) {
		this.buttonSqlMap = buttonSqlMap;
	}

	public CgformEnhanceJsEntity getListJs() {
		return listJs==null?new CgformEnhanceJsEntity():listJs;
	}

	public void setListJs(CgformEnhanceJsEntity listJs) {
		this.listJs = listJs;
	}

	public CgformEnhanceJsEntity getFormJs() {
		return formJs==null?new CgformEnhanceJsEntity():formJs;
	}

	public void setFormJs(CgformEnhanceJsEntity formJs) {
		this.formJs = formJs;
	}

	public String getProjectPath() {
		String pt = projectPath;
		if(pt!=null){
			pt = pt.replace("\\", "/");
			if(!pt.endsWith("/")){
				pt = pt+"/";
			}
		}
		return pt;
	}

	public void setProjectPath(String projectPath) {
		this.projectPath = projectPath;
	}

	
	public String getPackageStyle() {
		return packageStyle;
	}

	public void setPackageStyle(String packageStyle) {
		this.packageStyle = packageStyle;
	}

	public Object clone() throws CloneNotSupportedException {
		return super.clone();
	}

	public Map<String, CgformEnhanceJavaEntity> getButtonJavaMap() {
		return buttonJavaMap;
	}

	public void setButtonJavaMap(Map<String, CgformEnhanceJavaEntity> buttonJavaMap) {
		this.buttonJavaMap = buttonJavaMap;
	}
	
	public String getSupportRestful() {
		return supportRestful;
	}

	public void setSupportRestful(String supportRestful) {
		this.supportRestful = supportRestful;
	}

	/**
	 * 深度复制
	 * @return
	 * @throws Exception
	 */
	public GenerateEntity deepCopy() throws Exception{  
        //将该对象序列化成流,因为写在流里的是对象的一个拷贝，而原对象仍然存在于JVM里面。所以利用这个特性可以实现对象的深拷贝  
        ByteArrayOutputStream bos = new ByteArrayOutputStream();  
        ObjectOutputStream oos = new ObjectOutputStream(bos);  
        oos.writeObject(this);  
  
        //将流序列化成对象  
        ByteArrayInputStream bis = new ByteArrayInputStream(bos.toByteArray());  
        ObjectInputStream ois = new ObjectInputStream(bis);  
        return (GenerateEntity) ois.readObject();  
    } 
}
