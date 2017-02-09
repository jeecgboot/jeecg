package org.jeecgframework.web.graphreport.entity.core;

import java.math.BigDecimal;
import java.util.Date;
import java.lang.String;
import java.lang.Double;
import java.lang.Integer;
import java.math.BigDecimal;
import javax.xml.soap.Text;
import java.sql.Blob;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;
import org.hibernate.annotations.GenericGenerator;
import javax.persistence.SequenceGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 子表
 * @author onlineGenerator
 * @date 2015-06-10 17:19:06
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jform_graphreport_item", schema = "")
@SuppressWarnings("serial")
public class JformGraphreportItemEntity implements java.io.Serializable {
	/**id*/
	private String id;
	/**字段名*/
	@Excel(name="字段名")
	private String fieldName;
	/**字段文本*/
	@Excel(name="字段文本")
	private String fieldTxt;
	/**排序*/
	@Excel(name="排序")
	private Integer orderNum;
	/**字段类型*/
	@Excel(name="字段类型")
	private String fieldType;
	/**是否显示*/
	@Excel(name="是否显示")
	private String isShow;
	/**是否查询*/
	@Excel(name="是否查询")
	private String searchFlag;
	/**查询模式*/
	@Excel(name="查询模式")
	private String searchMode;
	/**字典Code*/
	@Excel(name="字典Code")
	private String dictCode;
	/**显示图表*/
	@Excel(name="显示图表")
	private String isGraph;
	/**图表类型*/
	@Excel(name="图表类型")
	private String graphType;
	/**图表名称*/
	@Excel(name="图表名称")
	private String graphName;
	/**标签名称*/
	@Excel(name="标签名称")
	private String tabName;
	/**字段href*/
	@Excel(name="字段href")
	private String fieldHref;
	/**取值表达式*/
	@Excel(name="取值表达式")
	private String replaceVa;
	/**cgreportHeadId*/
	private String cgreportHeadId;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  id
	 */
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=36)
	public String getId(){
		return this.id;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  id
	 */
	public void setId(String id){
		this.id = id;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  字段名
	 */
	@Column(name ="FIELD_NAME",nullable=true,length=36)
	public String getFieldName(){
		return this.fieldName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  字段名
	 */
	public void setFieldName(String fieldName){
		this.fieldName = fieldName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  字段文本
	 */
	@Column(name ="FIELD_TXT",nullable=true,length=1000)
	public String getFieldTxt(){
		return this.fieldTxt;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  字段文本
	 */
	public void setFieldTxt(String fieldTxt){
		this.fieldTxt = fieldTxt;
	}
	/**
	 *方法: 取得java.lang.Integer
	 *@return: java.lang.Integer  排序
	 */
	@Column(name ="ORDER_NUM",nullable=true,length=10)
	public Integer getOrderNum(){
		return this.orderNum;
	}

	/**
	 *方法: 设置java.lang.Integer
	 *@param: java.lang.Integer  排序
	 */
	public void setOrderNum(Integer orderNum){
		this.orderNum = orderNum;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  字段类型
	 */
	@Column(name ="FIELD_TYPE",nullable=false,length=10)
	public String getFieldType(){
		return this.fieldType;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  字段类型
	 */
	public void setFieldType(String fieldType){
		this.fieldType = fieldType;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否显示
	 */
	@Column(name ="IS_SHOW",nullable=true,length=5)
	public String getIsShow(){
		return this.isShow;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否显示
	 */
	public void setIsShow(String isShow){
		this.isShow = isShow;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否查询
	 */
	@Column(name ="SEARCH_FLAG",nullable=true,length=2)
	public String getSearchFlag(){
		return this.searchFlag;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否查询
	 */
	public void setSearchFlag(String searchFlag){
		this.searchFlag = searchFlag;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  查询模式
	 */
	@Column(name ="SEARCH_MODE",nullable=true,length=10)
	public String getSearchMode(){
		return this.searchMode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  查询模式
	 */
	public void setSearchMode(String searchMode){
		this.searchMode = searchMode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  字典Code
	 */
	@Column(name ="DICT_CODE",nullable=true,length=500)
	public String getDictCode(){
		return this.dictCode;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  字典Code
	 */
	public void setDictCode(String dictCode){
		this.dictCode = dictCode;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  显示图表
	 */
	@Column(name ="IS_GRAPH",nullable=true,length=5)
	public String getIsGraph(){
		return this.isGraph;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  显示图表
	 */
	public void setIsGraph(String isGraph){
		this.isGraph = isGraph;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  图表类型
	 */
	@Column(name ="GRAPH_TYPE",nullable=true,length=50)
	public String getGraphType(){
		return this.graphType;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  图表类型
	 */
	public void setGraphType(String graphType){
		this.graphType = graphType;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  图表名称
	 */
	@Column(name ="GRAPH_NAME",nullable=true,length=100)
	public String getGraphName(){
		return this.graphName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  图表名称
	 */
	public void setGraphName(String graphName){
		this.graphName = graphName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  标签名称
	 */
	@Column(name ="TAB_NAME",nullable=true,length=50)
	public String getTabName(){
		return this.tabName;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  标签名称
	 */
	public void setTabName(String tabName){
		this.tabName = tabName;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  字段href
	 */
	@Column(name ="FIELD_HREF",nullable=true,length=120)
	public String getFieldHref(){
		return this.fieldHref;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  字段href
	 */
	public void setFieldHref(String fieldHref){
		this.fieldHref = fieldHref;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  取值表达式
	 */
	@Column(name ="REPLACE_VA",nullable=true,length=36)
	public String getReplaceVa(){
		return this.replaceVa;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  取值表达式
	 */
	public void setReplaceVa(String replaceVa){
		this.replaceVa = replaceVa;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  cgreportHeadId
	 */
	@Column(name ="CGREPORT_HEAD_ID",nullable=true,length=36)
	public String getCgreportHeadId(){
		return this.cgreportHeadId;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  cgreportHeadId
	 */
	public void setCgreportHeadId(String cgreportHeadId){
		this.cgreportHeadId = cgreportHeadId;
	}
}
