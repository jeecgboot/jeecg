package org.jeecgframework.web.demo.entity.test;

import java.math.BigDecimal;
import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Table;

import org.apache.commons.lang.StringUtils;
import org.hibernate.annotations.DynamicInsert;
import org.hibernate.annotations.DynamicUpdate;
import org.hibernate.annotations.GenericGenerator;
import org.jeecgframework.poi.excel.annotation.Excel;

import javax.persistence.SequenceGenerator;

/**   
 * @Title: Entity
 * @Description: 课程老师
 * @author jueyue
 * @date 2013-08-31 22:52:17
 * @version V1.0   
 *
 */
@Entity
@Table(name = "jeecg_demo_teacher", schema = "")
@DynamicUpdate(true)
@DynamicInsert(true)
@SuppressWarnings("serial")
public class TeacherEntity implements java.io.Serializable {
	/**id*/
	private java.lang.String id;
	/**name*/
	@Excel(exportName="老师姓名",orderNum="2",needMerge=true)
	private java.lang.String name;
	
	@Excel(exportName="老师照片",orderNum="3",exportType=2,exportFieldHeight=15,
			exportFieldWidth=20)
	private java.lang.String pic;
	
	/**
	 *方法: 取得java.lang.String
	 *@return: java.lang.String  id
	 */
	
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	@Column(name ="ID",nullable=false,length=32)
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
	 *@return: java.lang.String  name
	 */
	@Column(name ="NAME",nullable=true,length=12)
	public java.lang.String getName(){
		return this.name;
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  name
	 */
	public void setName(java.lang.String name){
		this.name = name;
	}

	public java.lang.String getPic() {
//		if(StringUtils.isEmpty(pic)){
//			pic = "plug-in/login/images/jeecg.png";
//		}
		return pic;
	}

	public void setPic(java.lang.String pic) {
		this.pic = pic;
	}
}
