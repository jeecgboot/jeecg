package org.jeecgframework.web.superquery.entity;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 表集合
 * @author onlineGenerator
 * @date 2017-12-04 18:10:17
 * @version V1.0   
 *
 */
@Entity
@Table(name = "super_query_table", schema = "")
@SuppressWarnings("serial")
public class SuperQueryTableEntity implements java.io.Serializable {
	/**主键*/
	private java.lang.String id;
	/**创建人名称*/
	private java.lang.String createName;
	/**创建人登录名称*/
	private java.lang.String createBy;
	/**创建日期*/
	private java.util.Date createDate;
	/**更新人名称*/
	private java.lang.String updateName;
	/**更新人登录名称*/
	private java.lang.String updateBy;
	/**更新日期*/
	private java.util.Date updateDate;
	/**所属部门*/
	private java.lang.String sysOrgCode;
	/**所属公司*/
	private java.lang.String sysCompanyCode;
	/**序号*/
    @Excel(name="序号",width=15)
	private java.lang.String seq;
	/**表名*/
    @Excel(name="表名",width=15)
	private java.lang.String tableName;
    /**说明*/
    @Excel(name="说明",width=15)
    private java.lang.String instruction;
	/**是否是主表*/
    @Excel(name="是否是主表",width=15,dicCode="is_main")
	private java.lang.String isMain;
	/**外键字段*/
    @Excel(name="外键字段",width=15)
	private java.lang.String fkField;
	/**外键id*/
	private java.lang.String mainId;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键
	 */
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	
	@Column(name ="ID",nullable=false,length=36)
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
	
	@Column(name ="CREATE_NAME",nullable=true,length=50)
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
	
	@Column(name ="CREATE_BY",nullable=true,length=50)
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
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建日期
	 */
	
	@Column(name ="CREATE_DATE",nullable=true,length=20)
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
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  更新人名称
	 */
	
	@Column(name ="UPDATE_NAME",nullable=true,length=50)
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
	
	@Column(name ="UPDATE_BY",nullable=true,length=50)
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
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  更新日期
	 */
	
	@Column(name ="UPDATE_DATE",nullable=true,length=20)
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
	 *@return: java.lang.String  所属部门
	 */
	
	@Column(name ="SYS_ORG_CODE",nullable=true,length=50)
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
	
	@Column(name ="SYS_COMPANY_CODE",nullable=true,length=50)
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
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  序号
	 */
	
	@Column(name ="SEQ",nullable=true,length=32)
	public java.lang.String getSeq(){
		return this.seq;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  序号
	 */
	public void setSeq(java.lang.String seq){
		this.seq = seq;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  表名
	 */
	
	@Column(name ="TABLE_NAME",nullable=true,length=32)
	public java.lang.String getTableName(){
		return this.tableName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  表名
	 */
	public void setTableName(java.lang.String tableName){
		this.tableName = tableName;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否是主表
	 */
	
	@Column(name ="IS_MAIN",nullable=true,length=32)
	public java.lang.String getIsMain(){
		return this.isMain;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否是主表
	 */
	public void setIsMain(java.lang.String isMain){
		this.isMain = isMain;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  外键字段
	 */
	
	@Column(name ="FK_FIELD",nullable=true,length=32)
	public java.lang.String getFkField(){
		return this.fkField;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  外键字段
	 */
	public void setFkField(java.lang.String fkField){
		this.fkField = fkField;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  外键id
	 */
	
	@Column(name ="MAIN_ID",nullable=true,length=32)
	public java.lang.String getMainId(){
		return this.mainId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  外键id
	 */
	public void setMainId(java.lang.String mainId){
		this.mainId = mainId;
	}
	@Column(name ="instruction",nullable=true,length=32)
	public java.lang.String getInstruction() {
		return instruction;
	}

	public void setInstruction(java.lang.String instruction) {
		this.instruction = instruction;
	}
	 
	
	
	
}
