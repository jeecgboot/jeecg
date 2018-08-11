<#include "/ui/excel.ftl"/>
<#list subtables as key>
#segment#${subsG['${key}'].entityName}Entity.java
package ${bussiPackage}.${entityPackage}.entity;
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
 * @Description: ${subsG['${key}'].ftlDescription}
 * @author onlineGenerator
 * @date ${ftl_create_time}
 * @version V1.0   
 *
 */
@Entity
@Table(name = "${subsG['${key}'].tableName}", schema = "")
<#if subsG['${key}'].cgFormHead.jformPkType?if_exists?html == "SEQUENCE">
@SequenceGenerator(name="SEQ_GEN", sequenceName="${subsG['${key}'].cgFormHead.jformPkSequence}")  
</#if>
@SuppressWarnings("serial")
public class ${subsG['${key}'].entityName}Entity implements java.io.Serializable {
	<#list subColumnsMap['${key}'] as po>
	/**${po.content}*/
	<#if po.isShow != 'N'>
	<#--update-begin--Author:taoYan  Date:20170807 for：TASK #3021 【代码生成器 - 陶炎】popup配置影响了导出excel功能 -->
    <@excel po = po/>
	<#--update-end--Author:taoYan  Date:20170807 for：TASK #3021 【代码生成器 - 陶炎】popup配置影响了导出excel功能 -->
	</#if>
	<#if po.type == "javax.xml.soap.Text">
	private java.lang.String ${po.fieldName};
	</#if>
	<#if po.type != "javax.xml.soap.Text">
	private <#if po.type=='java.sql.Blob'>byte[]<#else>${po.type}</#if> ${po.fieldName};
	</#if>
	</#list>
	
	<#list subColumnsMap['${key}'] as po>
	/**
	 *方法: 取得${po.type}
	 *@return: ${po.type}  ${po.content}
	 */
	<#if po.fieldName == jeecg_table_id>
	<#if subsG['${key}'].cgFormHead.jformPkType?if_exists?html == "UUID">
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	<#elseif subsG['${key}'].cgFormHead.jformPkType?if_exists?html == "NATIVE">
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	<#elseif subsG['${key}'].cgFormHead.jformPkType?if_exists?html == "SEQUENCE">
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="SEQ_GEN")  
	<#else>
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	</#if>
	</#if>
	
	<#if po.type == "javax.xml.soap.Text">
	@Column(name ="${subFieldMeta[po.fieldName]}",nullable=<#if po.isNull == 'Y'>true<#else>false</#if><#if po.pointLength != 0>,scale=${po.pointLength}</#if>,length=1000)
	public java.lang.String get${po.fieldName?cap_first}(){
		return this.${po.fieldName};
	}

	/**
	 *方法: 设置java.lang.String
	 *@param: java.lang.String  ${po.content}
	 */
	public void set${po.fieldName?cap_first}(java.lang.String ${po.fieldName}){
		this.${po.fieldName} = ${po.fieldName};
	}
	</#if>
	<#if po.type != "javax.xml.soap.Text">
	@Column(name ="${subFieldMeta[po.fieldName]}",nullable=<#if po.isNull == 'Y'>true<#else>false</#if><#if po.pointLength != 0>,scale=${po.pointLength}</#if><#if po.type!='java.sql.Blob'><#if po.length !=0>,length=${po.length?c}</#if></#if>)
	public <#if po.type=='java.sql.Blob'>byte[]<#else>${po.type}</#if> get${po.fieldName?cap_first}(){
		return this.${po.fieldName};
	}

	/**
	 *方法: 设置${po.type}
	 *@param: ${po.type}  ${po.content}
	 */
	public void set${po.fieldName?cap_first}(<#if po.type=='java.sql.Blob'>byte[]<#else>${po.type}</#if> ${po.fieldName}){
		this.${po.fieldName} = ${po.fieldName};
	}
	</#if>
	</#list>
}
</#list>