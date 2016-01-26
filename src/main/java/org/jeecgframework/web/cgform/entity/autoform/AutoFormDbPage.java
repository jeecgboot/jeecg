
package org.jeecgframework.web.cgform.entity.autoform;
import java.util.ArrayList;
import java.util.List;


/**   
 * @Title: Entity
 * @Description: 表单数据源
 * @author onlineGenerator
 * @date 2015-06-17 19:36:59
 * @version V1.0   
 *
 */
public class AutoFormDbPage implements java.io.Serializable {
	/**保存-表单数据源属性*/
	private List<AutoFormDbFieldEntity> autoFormDbFieldList = new ArrayList<AutoFormDbFieldEntity>();
	public List<AutoFormDbFieldEntity> getAutoFormDbFieldList() {
		return autoFormDbFieldList;
	}
	public void setAutoFormDbFieldList(List<AutoFormDbFieldEntity> autoFormDbFieldList) {
		this.autoFormDbFieldList = autoFormDbFieldList;
	}
	/**保存-表单参数*/
	private List<AutoFormParamEntity> autoFormParamList = new ArrayList<AutoFormParamEntity>();
	public List<AutoFormParamEntity> getAutoFormParamList() {
		return autoFormParamList;
	}
	public void setAutoFormParamList(List<AutoFormParamEntity> autoFormParamList) {
		this.autoFormParamList = autoFormParamList;
	}
	
	/**主键*/
	private java.lang.String id;
	/**创建人名称*/
	private java.lang.String createName;
	/**创建人登录名称*/
	private java.lang.String createBy;
	/**更新人名称*/
	private java.lang.String updateName;
	/**更新人登录名称*/
	private java.lang.String updateBy;
	/**所属部门*/
	private java.lang.String sysOrgCode;
	/**所属公司*/
	private java.lang.String sysCompanyCode;
	/**创建日期*/
	private java.util.Date createDate;
	/**更新日期*/
	private java.util.Date updateDate;
	/**数据源名称*/
	private java.lang.String dbName;
	/**数据源类型*/
	private java.lang.String dbType;
	/**数据库表名*/
	private java.lang.String dbTableName;
	/**动态查询SQL*/
	private java.lang.String dbDynSql;
	/**主键字段*/
	private java.lang.String autoFormId;
	/**动态数据源名称*/
	private java.lang.String dbKey;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键
	 */
	public java.lang.String getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  主键
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人名称
	 */
	public java.lang.String getCreateName(){
		return this.createName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人名称
	 */
	public void setCreateName(java.lang.String createName){
		this.createName = createName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人登录名称
	 */
	public java.lang.String getCreateBy(){
		return this.createBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人登录名称
	 */
	public void setCreateBy(java.lang.String createBy){
		this.createBy = createBy;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人名称
	 */
	public java.lang.String getUpdateName(){
		return this.updateName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人名称
	 */
	public void setUpdateName(java.lang.String updateName){
		this.updateName = updateName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人登录名称
	 */
	public java.lang.String getUpdateBy(){
		return this.updateBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  更新人登录名称
	 */
	public void setUpdateBy(java.lang.String updateBy){
		this.updateBy = updateBy;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  所属部门
	 */
	public java.lang.String getSysOrgCode(){
		return this.sysOrgCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  所属部门
	 */
	public void setSysOrgCode(java.lang.String sysOrgCode){
		this.sysOrgCode = sysOrgCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  所属公司
	 */
	public java.lang.String getSysCompanyCode(){
		return this.sysCompanyCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  所属公司
	 */
	public void setSysCompanyCode(java.lang.String sysCompanyCode){
		this.sysCompanyCode = sysCompanyCode;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建日期
	 */
	public java.util.Date getCreateDate(){
		return this.createDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  创建日期
	 */
	public void setCreateDate(java.util.Date createDate){
		this.createDate = createDate;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  更新日期
	 */
	public java.util.Date getUpdateDate(){
		return this.updateDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  更新日期
	 */
	public void setUpdateDate(java.util.Date updateDate){
		this.updateDate = updateDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  数据源名称
	 */
	public java.lang.String getDbName(){
		return this.dbName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  数据源名称
	 */
	public void setDbName(java.lang.String dbName){
		this.dbName = dbName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  数据源类型
	 */
	public java.lang.String getDbType(){
		return this.dbType;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  数据源类型
	 */
	public void setDbType(java.lang.String dbType){
		this.dbType = dbType;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  数据库表名
	 */
	public java.lang.String getDbTableName(){
		return this.dbTableName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  数据库表名
	 */
	public void setDbTableName(java.lang.String dbTableName){
		this.dbTableName = dbTableName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  动态查询SQL
	 */
	public java.lang.String getDbDynSql(){
		return this.dbDynSql;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  动态查询SQL
	 */
	public void setDbDynSql(java.lang.String dbDynSql){
		this.dbDynSql = dbDynSql;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键字段
	 */
	public java.lang.String getAutoFormId(){
		return this.autoFormId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  主键字段
	 */
	public void setAutoFormId(java.lang.String autoFormId){
		this.autoFormId = autoFormId;
	}
	public java.lang.String getDbKey() {
		return dbKey;
	}
	public void setDbKey(java.lang.String dbKey) {
		this.dbKey = dbKey;
	}
}
