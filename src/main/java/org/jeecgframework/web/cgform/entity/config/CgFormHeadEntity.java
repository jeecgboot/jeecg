package org.jeecgframework.web.cgform.entity.config;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Transient;


import org.apache.commons.lang.StringUtils;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.OrderBy;
import org.jeecgframework.codegenerate.database.JeecgReadTable;

/**   
 * @Title: Entity
 * @Description: 自动生成表属性
 * @author jueyue
 * @date 2013-06-30 11:36:53
 * @version V1.0   
 *
 */
@Entity
@Table(name = "cgform_head", schema = "")
@DynamicUpdate(true)
@DynamicInsert(true)
@SuppressWarnings("serial")
public class CgFormHeadEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**表格名称*/
	private java.lang.String tableName;
	/**dategrid是否为树形*/
	private java.lang.String isTree;
	/**datagrid是否分页*/
	private java.lang.String isPagination;
	/**是否同步了数据库*/
	private java.lang.String isDbSynch;
	/**datagrid是否显示复选框*/
	private java.lang.String isCheckbox;
	/**查询模式：single(单条件查询：默认),group(组合查询)*/
	private java.lang.String querymode;
	/**功能注释*/
	private java.lang.String content;
	/**创建时间*/
	private java.util.Date createDate;
	/**创建人ID*/
	private java.lang.String createBy;
	/**创建人名称*/
	private java.lang.String createName;
	/**修改时间*/
	private java.util.Date updateDate;
	/**修改人*/
	private java.lang.String updateBy;
	/**修改人名称*/
	private java.lang.String updateName;
	/**表单版本*/
	private java.lang.String jformVersion;
	/**表单类型*/
	private Integer jformType;
	/**表单主键策略*/
	private java.lang.String jformPkType;
	/**表单主键策略-序列(针对oracle等数据库)*/
	private java.lang.String jformPkSequence;
	/**附表关联类型*/
	private Integer relationType;
	/**附表清单*/
	private String subTableStr;
	/**一对多Tab顺序*/
	private Integer tabOrder;
	/**
	 * 表格列属性
	 */
	private List<CgFormFieldEntity> columns;
	/**
	 * 索引
	 */
	private List<CgFormIndexEntity> indexes;
	
	/**树形列表 父id列名*/
	private java.lang.String treeParentIdFieldName;
	/**树形列表 id列名*/
	private java.lang.String treeIdFieldname;
	/**树形列表 菜单列名*/
	private java.lang.String treeFieldname;

	/**表单分类*/
	private java.lang.String jformCategory;

	/**表单模板*/
	private String formTemplate;

	/**表单模板样式(移动端)*/
	private String formTemplateMobile;

	/**表单类型，0为物理表，1为配置表*/
	private String tableType;
	/**配置表版本*/
	private Integer tableVersion;
	/**物理表id*/
	private String physiceId;

	
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  id
	 */
	
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="id",nullable=false,length=32)
	public java.lang.String getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  id
	 */
	public void setId(java.lang.String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  表格名称
	 */
	@Column(name ="table_name",nullable=false,length=50)
	public java.lang.String getTableName(){
		return this.tableName;
	}
	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  表格名称
	 */
	public void setTableName(java.lang.String tableName){
		this.tableName = tableName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  dategrid是否为树形
	 */
	@Column(name ="is_tree",nullable=false,length=5)
	public java.lang.String getIsTree(){
		return this.isTree;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  dategrid是否为树形
	 */
	public void setIsTree(java.lang.String isTree){
		this.isTree = isTree;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  datagrid是否分页
	 */
	@Column(name ="is_pagination",nullable=false,length=5)
	public java.lang.String getIsPagination(){
		return this.isPagination;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  datagrid是否分页
	 */
	public void setIsPagination(java.lang.String isPagination){
		this.isPagination = isPagination;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否同步了数据库
	 */
	@Column(name ="is_dbsynch",nullable=false,length=20)
	public java.lang.String getIsDbSynch(){
		return this.isDbSynch;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否同步了数据库
	 */
	public void setIsDbSynch(java.lang.String isDbSynch){
		this.isDbSynch = isDbSynch;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  datagrid是否显示复选框
	 */
	@Column(name ="is_checkbox",nullable=false,length=5)
	public java.lang.String getIsCheckbox(){
		return this.isCheckbox;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  datagrid是否显示复选框
	 */
	public void setIsCheckbox(java.lang.String isCheckbox){
		this.isCheckbox = isCheckbox;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  查询模式：single(单条件查询：默认),group(组合查询)
	 */
	@Column(name ="querymode",nullable=false,length=10)
	public java.lang.String getQuerymode(){
		return this.querymode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  查询模式：single(单条件查询：默认),group(组合查询)
	 */
	public void setQuerymode(java.lang.String querymode){
		this.querymode = querymode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  功能注释
	 */
	@Column(name ="content",nullable=false,length=200)
	public java.lang.String getContent(){
		return this.content;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  功能注释
	 */
	public void setContent(java.lang.String content){
		this.content = content;
	}
	/**
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  创建时间
	 */
	@Column(name ="create_date",nullable=true)
	public java.util.Date getCreateDate(){
		return this.createDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  创建时间
	 */
	public void setCreateDate(java.util.Date createDate){
		this.createDate = createDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人ID
	 */
	@Column(name ="create_by",nullable=true,length=32)
	public java.lang.String getCreateBy(){
		return this.createBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  创建人ID
	 */
	public void setCreateBy(java.lang.String createBy){
		this.createBy = createBy;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  创建人名称
	 */
	@Column(name ="create_name",nullable=true,length=32)
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
	 *方法: 取得java.util.Date
	 *@return: java.util.Date  修改时间
	 */
	@Column(name ="update_date",nullable=true)
	public java.util.Date getUpdateDate(){
		return this.updateDate;
	}

	/**
	 *方法: 设置java.util.Date
	 *@param: java.util.Date  修改时间
	 */
	public void setUpdateDate(java.util.Date updateDate){
		this.updateDate = updateDate;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  修改人ID
	 */
	@Column(name ="update_by",nullable=true,length=32)
	public java.lang.String getUpdateBy(){
		return this.updateBy;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  修改人ID
	 */
	public void setUpdateBy(java.lang.String updateBy){
		this.updateBy = updateBy;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  修改人名称
	 */
	@Column(name ="update_name",nullable=true,length=32)
	public java.lang.String getUpdateName(){
		return this.updateName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  修改人名称
	 */
	public void setUpdateName(java.lang.String updateName){
		this.updateName = updateName;
	}

	@OneToMany(cascade=CascadeType.REMOVE,mappedBy="table")
	@OrderBy(clause="orderNum asc")
	public List<CgFormFieldEntity> getColumns() {
		return columns;
	}

	public void setColumns(List<CgFormFieldEntity> columns) {
		this.columns = columns;
	}
	
	@OneToMany(cascade=CascadeType.REMOVE,mappedBy="table")
	public List<CgFormIndexEntity> getIndexes() {
		return indexes;
	}

	public void setIndexes(List<CgFormIndexEntity> indexes) {
		this.indexes = indexes;
	}

	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  表单版本号
	 */
	@Column(name ="jform_version",nullable=false,length=10)
	public java.lang.String getJformVersion() {
		return jformVersion;
	}

	public void setJformVersion(java.lang.String jformVersion) {
		this.jformVersion = jformVersion;
	}
	/**
	 *方法: 取得Integer
	 *1-单表,2-主表,3-从表
	 *@return: INteger  表单类型
	 */
	@Column(name ="jform_type",nullable=false,length=1)
	public Integer getJformType() {
		return jformType;
	}

	public void setJformType(Integer jformType) {
		this.jformType = jformType;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键策略
	 */
	@Column(name ="jform_pk_type",nullable=true,length=100)
	public java.lang.String getJformPkType() {
		return jformPkType;
	}

	public void setJformPkType(java.lang.String jformPkType) {
		this.jformPkType = jformPkType;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  主键策略-序列
	 */
	@Column(name ="jform_pk_sequence",nullable=true,length=200)
	public java.lang.String getJformPkSequence() {
		return jformPkSequence;
	}

	public void setJformPkSequence(java.lang.String jformPkSequence) {
		this.jformPkSequence = jformPkSequence;
	}

	@Column(name ="sub_table_str",nullable=true,length=1000)
	public String getSubTableStr() {
		return subTableStr;
	}

	public void setSubTableStr(String subTableStr) {
		this.subTableStr = subTableStr;
	}
	
	/**
	 *方法: 取得Integer
	 *0：一对多 1：一对一
	 *@return: INteger  附表关联类型
	 */
	@Column(name ="relation_type",nullable=true,length=1)
	public Integer getRelationType() {
		return relationType;
	}

	public void setRelationType(Integer relationType) {
		this.relationType = relationType;
	}
	
	@Column(name ="tab_order", nullable=true, length=1)
	public Integer getTabOrder() {
		return tabOrder;
	}

	public void setTabOrder(Integer tabOrder) {
		this.tabOrder = tabOrder;
	}
	
	@Column(name ="tree_parentid_fieldname",nullable=true,length=50)
	public java.lang.String getTreeParentIdFieldName() {
		return treeParentIdFieldName;
	}
	
	@Transient
	public java.lang.String getTreeParentIdFieldNamePage() {
		if(StringUtils.isNotEmpty(treeParentIdFieldName)){
			return JeecgReadTable.formatField(treeParentIdFieldName);
		}
		return "";
	}

	public void setTreeParentIdFieldName(java.lang.String treeParentIdFieldName) {
		this.treeParentIdFieldName = treeParentIdFieldName;
	}

	@Column(name ="tree_id_fieldname",nullable=true,length=50)
	public java.lang.String getTreeIdFieldname() {
		return treeIdFieldname;
	}

	public void setTreeIdFieldname(java.lang.String treeIdFieldname) {
		this.treeIdFieldname = treeIdFieldname;
	}

	@Column(name ="tree_fieldname",nullable=true,length=50)
	public java.lang.String getTreeFieldname() {
		return treeFieldname;
	}
	
	@Transient
	public java.lang.String getTreeFieldnamePage() {
		if(StringUtils.isNotEmpty(treeFieldname)){
			return JeecgReadTable.formatField(treeFieldname);
		}
		return "";
	}

	public void setTreeFieldname(java.lang.String treeFieldname) {
		this.treeFieldname = treeFieldname;
	}

	/**
	 *@return: INteger  表单分类
	 */
	@Column(name ="jform_category",nullable=false,length=50)
	public java.lang.String getJformCategory() {
		return jformCategory;
	}

	public void setJformCategory(java.lang.String jformCategory) {
		this.jformCategory = jformCategory;
	}

	@Column(name ="form_template",length=50)
	public String getFormTemplate() {
		return formTemplate;
	}

	public void setFormTemplate(String formTemplate) {
		this.formTemplate = formTemplate;
	}

	@Column(name ="form_template_mobile",length=50)
	public String getFormTemplateMobile() {
		return formTemplateMobile;
	}

	public void setFormTemplateMobile(String formTemplateMobile) {
		this.formTemplateMobile = formTemplateMobile;
	}
	@Column(name ="table_type",length=50)
	public String getTableType() {
		return tableType;
	}

	public void setTableType(String tableType) {
		this.tableType = tableType;
	}
	@Column(name ="table_version",length=11)
	public Integer getTableVersion() {
		return tableVersion;
	}

	public void setTableVersion(Integer tableVersion) {
		this.tableVersion = tableVersion;
	}
	@Column(name ="physice_id",length=32)
	public String getPhysiceId() {
		return physiceId;
	}

	public void setPhysiceId(String physiceId) {
		this.physiceId = physiceId;
	}
	
}
