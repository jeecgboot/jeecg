<#if packageStyle == "service">
package ${bussiPackage}.${entityPackage}.entity;
<#else>
package ${bussiPackage}.entity.${entityPackage};
</#if>
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

/**   
 * @Title: Entity
 * @Description: ${ftl_description}
 * @author onlineGenerator
 * @date ${ftl_create_time}
 * @version V1.0   
 *
 */
@Entity
@Table(name = "${tableName}", schema = "")
<#if cgformConfig.cgFormHead.jformPkType?if_exists?html == "SEQUENCE">
@SequenceGenerator(name="SEQ_GEN", sequenceName="${cgformConfig.cgFormHead.jformPkSequence}")  
</#if>
@SuppressWarnings("serial")
public class ${entityName}Entity implements java.io.Serializable {
	<#list columns as po>
	/**${po.content}*/
	<#if po.type == "javax.xml.soap.Text">
	private java.lang.String ${po.fieldName};
	</#if>
	<#if po.type != "javax.xml.soap.Text">
	private ${po.type} ${po.fieldName};
	</#if>
	</#list>
	
	<#list columns as po>
	/**
	 *方法: 取得${po.type}
	 *@return: ${po.type}  ${po.content}
	 */
	<#if po.fieldName == jeecg_table_id>
	<#if cgformConfig.cgFormHead.jformPkType?if_exists?html == "UUID">
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	<#elseif cgformConfig.cgFormHead.jformPkType?if_exists?html == "NATIVE">
	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	<#elseif cgformConfig.cgFormHead.jformPkType?if_exists?html == "SEQUENCE">
	@Id
	@GeneratedValue(strategy=GenerationType.SEQUENCE,generator="SEQ_GEN")  
	<#else>
	@Id
	@GeneratedValue(generator = "paymentableGenerator")
	@GenericGenerator(name = "paymentableGenerator", strategy = "uuid")
	</#if>
	</#if>
	
	<#if po.type == "javax.xml.soap.Text">
	@Column(name ="${fieldMeta[po.fieldName]}",nullable=<#if po.isNull == 'Y'>true<#else>false</#if><#if po.pointLength != 0>,scale=${po.pointLength}</#if>,length=1000)
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
	@Column(name ="${fieldMeta[po.fieldName]}",nullable=<#if po.isNull == 'Y'>true<#else>false</#if><#if po.pointLength != 0>,scale=${po.pointLength}</#if><#if po.length !=0>,length=${po.length?c}</#if>)
	public ${po.type} get${po.fieldName?cap_first}(){
		return this.${po.fieldName};
	}

	/**
	 *方法: 设置${po.type}
	 *@param: ${po.type}  ${po.content}
	 */
	public void set${po.fieldName?cap_first}(${po.type} ${po.fieldName}){
		this.${po.fieldName} = ${po.fieldName};
	}
	</#if>
	
	</#list>
}
