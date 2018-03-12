<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE hibernate-mapping PUBLIC "-//Hibernate/Hibernate Mapping DTD 3.0//EN" "http://hibernate.sourceforge.net/hibernate-mapping-3.0.dtd">
<hibernate-mapping>
	<class name="${entity.tableName}" table="${entity.tableName}" optimistic-lock="version">
		<#if entity.columns?exists>
			<#list entity.columns as attr>
				<#if attr.fieldName == "id">
					<#if entity.jformPkType?if_exists?html=='UUID'>
						<id name="id" type="java.lang.String" length="${attr.length}" unsaved-value="null">
							<generator class="uuid" />
						</id>
					<#elseif entity.jformPkType?if_exists?html=='NATIVE'>
						<#if dataType=='MYSQL'>
							<id name="id" type="java.lang.Long" length="${attr.length}" unsaved-value="null">
								<generator class="identity" />
							</id>
						<#elseif dataType=='ORACLE'>
							<id name="id" type="java.lang.Long" length="${attr.length}" unsaved-value="null">
								<generator class="native" />
							</id>
						<#elseif dataType=='SQLSERVER'>	
							<id name="id" type="java.lang.Long" length="${attr.length}" unsaved-value="null">
								<generator class="identity" />
							</id>
						<#elseif dataType=='POSTGRESQL'>
							<id name="id" type="java.lang.Long" length="${attr.length}" unsaved-value="null">
								<generator class="native" />
							</id>
						</#if>
					<#elseif entity.jformPkType?if_exists?html=='SEQUENCE'>
						<#if dataType=='MYSQL'>
							<id name="id" type="java.lang.Long" length="${attr.length}" unsaved-value="null">
								<generator class="identity" />
							</id>
						<#elseif dataType=='ORACLE'>
							<id name="id" type="java.lang.Long" length="${attr.length}" unsaved-value="null">
								<generator class="sequence">
									<param name="sequence">${entity.jformPkSequence}
									</param>
								</generator>
							</id>
						<#elseif dataType=='SQLSERVER'>	
							<id name="id" type="java.lang.Long" length="${attr.length}" unsaved-value="null">
								<generator class="identity" />
							</id>
						<#elseif dataType=='POSTGRESQL'>
							<id name="id" type="java.lang.Long" length="${attr.length}" unsaved-value="null">
								<generator class="native" />
							</id>
						</#if>	
					<#else>
						<id name="id" type="java.lang.String" length="${attr.length}" unsaved-value="null">
							<generator class="uuid" />
						</id>
					</#if>
					
				<#else>
					<property name="${attr.fieldName}"
						<#switch attr.type>
							<#case "string">
								type="java.lang.String"
							<#break>
							<#case "Text">
							<#-- update--begin--author:scott Date:20180227 for:针对oracle情况下text类型采用clob转换 -->
								<#if dataType=='ORACLE'>
									type="clob"
								<#else>
									type="text"
								</#if>
							<#-- update--end--author:scott Date:20180227 for:针对oracle情况下text类型采用clob转换 -->
							<#break>
							<#case "int">
								type="java.lang.Integer"
							<#break>
							<#case "double">
								<#if dataType=='MYSQL'>
									type="java.lang.Double"
								<#elseif dataType=='ORACLE'>
									type="java.math.BigDecimal"
								<#elseif dataType=='POSTGRESQL'>
									type="java.math.BigDecimal"
								<#elseif dataType=='SQLSERVER'>
									type="java.math.BigDecimal"
								</#if>
							<#break>
							<#case "Date">
								<#if dataType=='MYSQL'>
									type="java.util.Date"
								<#elseif dataType=='ORACLE'>
									type="java.sql.Timestamp"
								<#elseif dataType=='POSTGRESQL'>
									type="java.util.Date"
								<#elseif dataType=='SQLSERVER'>
									type="java.util.Date"
								</#if>
							<#break>
							<#case "BigDecimal">
							  	<#if dataType=='MYSQL'>
									type="java.lang.Double"
								<#elseif dataType=='ORACLE'>
									type="java.math.BigDecimal"
								<#elseif dataType=='POSTGRESQL'>
									type="java.math.BigDecimal"
								<#elseif dataType=='SQLSERVER'>
									type="java.math.BigDecimal"
								</#if>
							<#break>
							<#case "Blob">
								<#if dataType=='MYSQL'>
									type="blob"
								<#elseif dataType=='ORACLE'>
							 		type="blob"
								<#elseif dataType=='POSTGRESQL'>
									type="binary"
								<#elseif dataType=='SQLSERVER'>
									type="image"
								</#if>
							<#break>
						</#switch> access="property">
						<column name="${attr.fieldName}" <#if attr.type=='double'||attr.type=='BigDecimal'>
							precision="${attr.length}" scale="${attr.pointLength}"<#else>length="${attr.length}"</#if>
							<#if attr.fieldDefault?exists&&attr.fieldDefault!=''>default="${attr.fieldDefault}"</#if>
							not-null="<#if attr.isNull == "Y">false<#else>true</#if>" unique="false">
							<comment>${attr.content}</comment>
						</column>
					</property>
				</#if>
			</#list>
		</#if>
	</class>
</hibernate-mapping>