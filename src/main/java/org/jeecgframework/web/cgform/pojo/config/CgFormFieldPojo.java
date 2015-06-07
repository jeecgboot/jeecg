package org.jeecgframework.web.cgform.pojo.config;

/**   
 * @Title: Entity
 * @Description: 自动生成表的列属性
 * @author jueyue
 * @date 2013-06-30 11:37:32
 * @version V1.0   
 *
 */
@SuppressWarnings("serial")
public class CgFormFieldPojo implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**字段名称*/
	private java.lang.String fieldName;
	/**关联的表*/
	private String tableId;
	/**字段长度*/
	private java.lang.Integer length;
	/**小数点长度*/
	private java.lang.Integer pointLength;
	/**字段类型*/
	private java.lang.String type;
	/**是否允许空值*/
	private java.lang.String isNull;
	/**在表中的顺序*/
	private java.lang.Integer orderNum;
	/**是否主键*/
	private java.lang.String isKey;
	/**是否显示*/
	private java.lang.String isShow;
	/**是否在列表上显示*/
	private java.lang.String isShowList;
	/**显示类型*/
	private java.lang.String showType;
	/**是否生产查询字段*/
	private java.lang.String isQuery;
	/**控件长度*/
	private java.lang.Integer fieldLength;
	/**字段Href*/
	private java.lang.String fieldHref;
	/**控件校验*/
	private java.lang.String fieldValidType;
	/**查询类型single(默认：单字段查询),group(范围查询)*/
	private java.lang.String queryMode;
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
	/**修改人ID*/
	private java.lang.String updateBy;
	/**修改人名称*/
	private java.lang.String updateName;
	/**字典Code*/
	private java.lang.String dictField;
	/**字典Table*/
	private java.lang.String dictTable;
	/**字典Text*/
	private java.lang.String dictText;
	/**主表名*/
	private java.lang.String mainTable;
	/**主表字段*/
	private java.lang.String mainField;
	/**旧的字段名称*/
	private java.lang.String oldFieldName;
	/**字段默认值*/
	private java.lang.String fieldDefault;
	
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
	 *@return: java.lang.String  字段名称
	 */
	public java.lang.String getFieldName(){
		return this.fieldName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  字段名称
	 */
	 public void setFieldName(java.lang.String fieldName){
		this.fieldName = fieldName;
	}
	/**
	 *方法: 取得TablePropertyEntity
	 *@return: TablePropertyEntity  关联的表ＩＤ
	 */
	public String getTableId(){
		return this.tableId;
	}

	/**
	 *方法: 设置TablePropertyEntity
	 *@param: TablePropertyEntity  关联的表ID
	 */
	public void setTableId(String tableId){
		this.tableId = tableId;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  字段长度
	 */
	public java.lang.Integer getLength(){
		return this.length;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  字段长度
	 */
	public void setLength(java.lang.Integer length){
		this.length = length;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  小数点长度
	 */
	public java.lang.Integer getPointLength(){
		return this.pointLength;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  小数点长度
	 */
	public void setPointLength(java.lang.Integer pointLength){
		this.pointLength = pointLength;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  字段类型
	 */
	public java.lang.String getType(){
		return this.type;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  字段类型
	 */
	public void setType(java.lang.String type){
		this.type = type;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否允许空值
	 */
	public java.lang.String getIsNull(){
		return this.isNull;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否允许空值
	 */
	public void setIsNull(java.lang.String isNull){
		this.isNull = isNull;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否显示
	 */
	public java.lang.String getIsShow(){
		return this.isShow;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否显示
	 */
	public void setIsShow(java.lang.String isShow){
		this.isShow = isShow;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  显示类型
	 */
	public java.lang.String getShowType(){
		return this.showType;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  显示类型
	 */
	public void setShowType(java.lang.String showType){
		this.showType = showType;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否生产查询字段
	 */
	public java.lang.String getIsQuery(){
		return this.isQuery;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否生产查询字段
	 */
	public void setIsQuery(java.lang.String isQuery){
		this.isQuery = isQuery;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  查询类型single(默认：单字段查询),group(范围查询)
	 */
	public java.lang.String getQueryMode(){
		return this.queryMode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  查询类型single(默认：单字段查询),group(范围查询)
	 */
	public void setQueryMode(java.lang.String queryMode){
		this.queryMode = queryMode;
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
	 *@return: java.lang.String  在表中的顺序
	 */
	public java.lang.Integer getOrderNum() {
		return orderNum;
	}

	public void setOrderNum(java.lang.Integer orderNum) {
		this.orderNum = orderNum;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否为主键
	 */
	public java.lang.String getIsKey() {
		return isKey;
	}

	public void setIsKey(java.lang.String isKey) {
		this.isKey = isKey;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  控件长度
	 */
	public java.lang.Integer getFieldLength() {
		return fieldLength;
	}

	public void setFieldLength(java.lang.Integer field_length) {
		this.fieldLength = field_length;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  字段Href
	 */
	public java.lang.String getFieldHref() {
		return fieldHref;
	}

	public void setFieldHref(java.lang.String field_href) {
		this.fieldHref = field_href;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  控件校验
	 */
	public java.lang.String getFieldValidType() {
		return fieldValidType;
	}

	public void setFieldValidType(java.lang.String field_valid_type) {
		this.fieldValidType = field_valid_type;
	}
	/**
	 * 方法: 取得 java.lang.String
	 * @return  字典Code
	 * */
	public java.lang.String getDictField() {
		return dictField;
	}

	public void setDictField(java.lang.String dictField) {
		this.dictField = dictField;
	}
	/**
	 * 方法: 取得 java.lang.String
	 * @return  字典Table
	 * */
	public java.lang.String getDictTable() {
		return dictTable;
	}

	public void setDictTable(java.lang.String dictTable) {
		this.dictTable = dictTable;
	}
	/**
	 * 方法: 取得 java.lang.String
	 * @return  主表名称
	 * */
	public java.lang.String getMainTable() {
		return mainTable;
	}

	public void setMainTable(java.lang.String mainTable) {
		this.mainTable = mainTable;
	}
	/**
	 * 方法: 取得 java.lang.String
	 * @return  主表名称
	 * */
	public java.lang.String getMainField() {
		return mainField;
	}

	public void setMainField(java.lang.String mainField) {
		this.mainField = mainField;
	}

	/**
	 * 方法: 取得 java.lang.String
	 * @return  主表名称
	 * */
	public java.lang.String getOldFieldName() {
		return oldFieldName;
	}

	public void setOldFieldName(java.lang.String oldFieldName) {
		this.oldFieldName = oldFieldName;
	}
	/**
	 * 方法: 取得 java.lang.String
	 * @return  是否在列表上显示
	 * */
	public java.lang.String getIsShowList() {
		return isShowList;
	}

	public void setIsShowList(java.lang.String isShowList) {
		this.isShowList = isShowList;
	}
	/**
	 * 方法: 取得 java.lang.String
	 * @return  字典文本
	 * */
	public java.lang.String getDictText() {
		return dictText;
	}

	public void setDictText(java.lang.String dictText) {
		this.dictText = dictText;
	}

	public java.lang.String getFieldDefault() {
		if (fieldDefault != null) {
			fieldDefault = fieldDefault.trim();
		}
		return fieldDefault;
	}

	public void setFieldDefault(java.lang.String fieldDefault) {
		this.fieldDefault = fieldDefault;
	}
	
	
}
