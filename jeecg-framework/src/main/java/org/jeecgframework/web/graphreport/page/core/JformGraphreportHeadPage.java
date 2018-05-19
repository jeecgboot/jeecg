
package org.jeecgframework.web.graphreport.page.core;

import org.jeecgframework.poi.excel.annotation.ExcelCollection;
import org.jeecgframework.poi.excel.annotation.ExcelEntity;
import org.jeecgframework.poi.excel.annotation.ExcelIgnore;
import org.jeecgframework.poi.excel.annotation.ExcelTarget;
import org.jeecgframework.web.graphreport.entity.core.JformGraphreportHeadEntity;
import org.jeecgframework.web.graphreport.entity.core.JformGraphreportItemEntity;

import java.util.ArrayList;
import java.util.List;


/**   
 * @Title: Entity
 * @Description: 图表配置
 * @author onlineGenerator
 * @date 2015-06-10 17:19:07
 * @version V1.0   
 *
 */
@ExcelTarget("jformGraphreportHeadPage")
public class JformGraphreportHeadPage implements java.io.Serializable {
	/**保存-子表*/
	@ExcelCollection(name="图表配置",orderNum="9")
	private List<JformGraphreportItemEntity> jformGraphreportItemList = new ArrayList<JformGraphreportItemEntity>();
	public List<JformGraphreportItemEntity> getJformGraphreportItemList() {
		return jformGraphreportItemList;
	}
	public void setJformGraphreportItemList(List<JformGraphreportItemEntity> jformGraphreportItemList) {
		this.jformGraphreportItemList = jformGraphreportItemList;
	}
	@ExcelEntity
	private JformGraphreportHeadEntity jformGraphreportHeadEntity;
	/**id*/
	@ExcelIgnore
	private String id;
	/**名称*/
	@ExcelIgnore
	private String name;
	/**编码*/
	@ExcelIgnore
	private String code;
	/**查询数据SQL*/
	@ExcelIgnore
	private String cgrSql;
	/**描述*/
	@ExcelIgnore
	private String content;
	/**y轴文字*/
	@ExcelIgnore
	private String ytext;
	/**x轴数据*/
	@ExcelIgnore
	private String categories;
	/**是否显示明细*/
	@ExcelIgnore
	private String isShowList;
	/**扩展JS*/
	@ExcelIgnore
	private String  xPageJs;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  id
	 */
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
	public String  getXPageJs(){
		return this.xPageJs;
	}

	/**
	 *方法: 设置javax.xml.soap.Text
	 *@param: javax.xml.soap.Text  扩展JS
	 */
	public void setXPageJs(String  xPageJs){
		this.xPageJs = xPageJs;
	}

	public JformGraphreportHeadPage() {
	}

	public JformGraphreportHeadEntity getJformGraphreportHeadEntity() {
		return jformGraphreportHeadEntity;
	}

	public void setJformGraphreportHeadEntity(JformGraphreportHeadEntity jformGraphreportHeadEntity) {
		this.jformGraphreportHeadEntity = jformGraphreportHeadEntity;
	}

	public JformGraphreportHeadPage(List<JformGraphreportItemEntity> jformGraphreportItemList, JformGraphreportHeadEntity jformGraphreportHeadEntity) {
		this.jformGraphreportItemList = jformGraphreportItemList;
		this.jformGraphreportHeadEntity = jformGraphreportHeadEntity;
	}
}
