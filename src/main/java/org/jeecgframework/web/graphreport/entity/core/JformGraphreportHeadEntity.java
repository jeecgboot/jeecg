package org.jeecgframework.web.graphreport.entity.core;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

/**   
 * @Title: Entity
 * @Description: 图表配置
 * @author onlineGenerator
 * @date 2015-06-10 17:19:07
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jform_graphreport_head", schema = "")
@SuppressWarnings("serial")
public class JformGraphreportHeadEntity implements java.io.Serializable {
	/**id*/
	private String id;
	/**名称*/
	@Excel(name = "名称")
	private String name;
	/**编码*/
	@Excel(name = "编码")
	private String code;
	/**查询数据SQL*/
	@Excel(name = "查询数据SQL")
	private String cgrSql;
	/**描述*/
	@Excel(name = "描述")
	private String content;
	/**y轴文字*/
	@Excel(name = "y轴文字")
	private String ytext;
	/**x轴数据*/
	@Excel(name = "x轴数据")
	private String categories;
	/**是否显示明细*/
	@Excel(name = "是否显示明细")
	private String isShowList;
	/**扩展JS*/
	@Excel(name = "扩展JS")
	private String xpageJs;
	
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
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  id
	 */
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	
	@Column(name ="id",nullable=false,length=36)
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
	 *@return: java.lang.String  名称
	 */
	
	@Column(name ="name",nullable=false,length=100)
	public String getName(){
		return this.name;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  名称
	 */
	public void setName(String name){
		this.name = name;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  编码
	 */
	
	@Column(name ="code",nullable=false,length=36)
	public String getCode(){
		return this.code;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  编码
	 */
	public void setCode(String code){
		this.code = code;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  查询数据SQL
	 */
	
	@Column(name ="cgr_sql",nullable=false,length=2000)
	public String getCgrSql(){
		return this.cgrSql;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  查询数据SQL
	 */
	public void setCgrSql(String cgrSql){
		this.cgrSql = cgrSql;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  描述
	 */
	
	@Column(name ="content",nullable=false,length=1000)
	public String getContent(){
		return this.content;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  描述
	 */
	public void setContent(String content){
		this.content = content;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  y轴文字
	 */
	
	@Column(name ="ytext",nullable=false,length=100)
	public String getYtext(){
		return this.ytext;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  y轴文字
	 */
	public void setYtext(String ytext){
		this.ytext = ytext;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  x轴数据
	 */
	
	@Column(name ="categories",nullable=false,length=1000)
	public String getCategories(){
		return this.categories;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  x轴数据
	 */
	public void setCategories(String categories){
		this.categories = categories;
	}
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  是否显示明细
	 */
	
	@Column(name ="is_show_list",nullable=true,length=5)
	public String getIsShowList(){
		return this.isShowList;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  是否显示明细
	 */
	public void setIsShowList(String isShowList){
		this.isShowList = isShowList;
	}

	/**
	 *方法: 取得javax.xml.soap.Text
	 *@return: javax.xml.soap.Text  扩展JS
	 */
	@Column(name ="x_page_js",nullable=true,length=1000)
	public String getXpageJs() {
		return xpageJs;
	}

	public void setXpageJs(String xpageJs) {
		this.xpageJs = xpageJs;
	}
	
	

}
