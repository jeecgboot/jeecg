package org.jeecgframework.web.cgdynamgraph.page.core;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigItemEntity;
import org.jeecgframework.web.cgdynamgraph.entity.core.CgDynamGraphConfigParamEntity;

/**   
 * @Title: Entity
 * @Description: 动态报表配置抬头
 * @author 张代浩
 * @date 2013-12-07 16:00:21
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jform_cgdynamgraph_head", schema = "")
@SuppressWarnings("serial")
public class CgDynamGraphConfigHeadPage implements java.io.Serializable {
	/**保存-动态报表配置明细*/
	private List<CgDynamGraphConfigItemEntity> cgDynamGraphConfigItemList = new ArrayList<CgDynamGraphConfigItemEntity>();
	/**保存-动态报表参数*/
	private List<CgDynamGraphConfigParamEntity> cgDynamGraphConfigParamList = new ArrayList<CgDynamGraphConfigParamEntity>();
	
	public List<CgDynamGraphConfigItemEntity> getCgDynamGraphConfigItemList() {
		return cgDynamGraphConfigItemList;
	}
	public void setCgDynamGraphConfigItemList(List<CgDynamGraphConfigItemEntity> cgDynamGraphConfigItemList) {
		this.cgDynamGraphConfigItemList = cgDynamGraphConfigItemList;
	}
	public List<CgDynamGraphConfigParamEntity> getCgDynamGraphConfigParamList() {
		return cgDynamGraphConfigParamList;
	}
	public void setCgDynamGraphConfigParamList(
			List<CgDynamGraphConfigParamEntity> cgDynamGraphConfigParamList) {
		this.cgDynamGraphConfigParamList = cgDynamGraphConfigParamList;
	}


	/**主键*/
	private java.lang.String id;
	/**编码*/
	private java.lang.String code;
	/**名称*/
	private java.lang.String name;
	/**查询数据SQL*/
	private java.lang.String cgrSql;
	/**描述*/
	private java.lang.String content;

	/**图表类型*/
	private  String graphType;
	/**数据结构类型*/
	private String dataStructure;
	/**是否分页*/
	private String isPagination;


	
	
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
	 *@return: java.lang.String  编码
	 */
	@Column(name ="CODE",nullable=false,length=36)
	public java.lang.String getCode(){
		return this.code;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  编码
	 */
	public void setCode(java.lang.String code){
		this.code = code;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  名称
	 */
	@Column(name ="NAME",nullable=false,length=100)
	public java.lang.String getName(){
		return this.name;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  名称
	 */
	public void setName(java.lang.String name){
		this.name = name;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  查询数据SQL
	 */
	@Column(name ="CGR_SQL",nullable=false,length=2000)
	public java.lang.String getCgrSql(){
		return this.cgrSql;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  查询数据SQL
	 */
	public void setCgrSql(java.lang.String cgrSql){
		this.cgrSql = cgrSql;
	}
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  描述
	 */
	@Column(name ="CONTENT",nullable=false,length=1000)
	public java.lang.String getContent(){
		return this.content;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  描述
	 */
	public void setContent(java.lang.String content){
		this.content = content;
	}

	@Column(name ="graph_type",length=36)
	public String getGraphType() {
		return graphType;
	}

	public void setGraphType(String graphType) {
		this.graphType = graphType;
	}
	
	@Column(name ="data_structure",length=36)
	public String getDataStructure() {
		return dataStructure;
	}

	public void setDataStructure(String dataStructure) {
		this.dataStructure = dataStructure;
	}

	@Column(name ="is_pagination",length=2)
	public String getIsPagination() {
		return isPagination;
	}

	public void setIsPagination(String isPagination) {
		this.isPagination = isPagination;
	}


}
