package org.jeecgframework.web.cgform.pojo.config;


/**   
 * @Title: Entity
 * @Description: 自动生成表属性
 * @author jueyue
 * @date 2013-06-30 11:36:53
 * @version V1.0   
 *
 */
@SuppressWarnings("serial")
public class CgFormHeadPojo implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**表格名称*/
	private java.lang.String tableName;
	/**dategrid是否为树形*/
	private java.lang.String isTree;
	/**datagrid是否分页*/
	private java.lang.String isPagination;
	/**是否同步了数据库*/
	private java.lang.String isDbsynch;
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
	
	//--author：zhoujf---start------date:20170207--------for:online表单 表单导出字段不全
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
	public java.lang.String getIsDbsynch(){
		return this.isDbsynch;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否同步了数据库
	 */
	public void setIsDbsynch(java.lang.String isDbsynch){
		this.isDbsynch = isDbsynch;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  datagrid是否显示复选框
	 */
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

	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  表单版本号
	 */
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
	public java.lang.String getJformPkSequence() {
		return jformPkSequence;
	}

	public void setJformPkSequence(java.lang.String jformPkSequence) {
		this.jformPkSequence = jformPkSequence;
	}

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
	public Integer getRelationType() {
		return relationType;
	}

	public void setRelationType(Integer relationType) {
		this.relationType = relationType;
	}
	
	public Integer getTabOrder() {
		return tabOrder;
	}

	public void setTabOrder(Integer tabOrder) {
		this.tabOrder = tabOrder;
	}

	public java.lang.String getTreeParentIdFieldName() {
		return treeParentIdFieldName;
	}

	public void setTreeParentIdFieldName(java.lang.String treeParentIdFieldName) {
		this.treeParentIdFieldName = treeParentIdFieldName;
	}

	public java.lang.String getTreeIdFieldname() {
		return treeIdFieldname;
	}

	public void setTreeIdFieldname(java.lang.String treeIdFieldname) {
		this.treeIdFieldname = treeIdFieldname;
	}

	public java.lang.String getTreeFieldname() {
		return treeFieldname;
	}

	public void setTreeFieldname(java.lang.String treeFieldname) {
		this.treeFieldname = treeFieldname;
	}

	public java.lang.String getJformCategory() {
		return jformCategory;
	}

	public void setJformCategory(java.lang.String jformCategory) {
		this.jformCategory = jformCategory;
	}

	public String getFormTemplate() {
		return formTemplate;
	}

	public void setFormTemplate(String formTemplate) {
		this.formTemplate = formTemplate;
	}

	public String getFormTemplateMobile() {
		return formTemplateMobile;
	}

	public void setFormTemplateMobile(String formTemplateMobile) {
		this.formTemplateMobile = formTemplateMobile;
	}

	public String getTableType() {
		return tableType;
	}

	public void setTableType(String tableType) {
		this.tableType = tableType;
	}

	public Integer getTableVersion() {
		return tableVersion;
	}

	public void setTableVersion(Integer tableVersion) {
		this.tableVersion = tableVersion;
	}

	public String getPhysiceId() {
		return physiceId;
	}

	public void setPhysiceId(String physiceId) {
		this.physiceId = physiceId;
	}
	
	
}
