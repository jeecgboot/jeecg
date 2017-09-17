package org.jeecgframework.web.cgform.service.impl.config.util;

import java.io.IOException;
import java.io.StringWriter;
import java.io.Writer;
import java.sql.Connection;
import java.sql.DatabaseMetaData;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.hibernate.HibernateException;
import org.hibernate.Session;
import org.hibernate.internal.SessionImpl;
import org.hibernate.tool.hbm2ddl.SchemaExport;
import org.jeecgframework.web.cgform.entity.config.CgFormFieldEntity;
import org.jeecgframework.web.cgform.entity.config.CgFormHeadEntity;
import org.jeecgframework.web.cgform.exception.DBException;
import org.jeecgframework.web.cgform.service.config.DbTableHandleI;
import org.springframework.orm.hibernate4.SessionFactoryUtils;

import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;

/**
 * 通过hibernate和脚本来处理来同步数据库
 * 对于修改数据库的字段，考虑各种数据库的情况，字段名称全部、类型修改成大写
 */
public class DbTableProcess {
	private static final Logger logger = Logger.getLogger(DbTableProcess.class);
	private static  DbTableHandleI dbTableHandle;
	
	
	public DbTableProcess(Session session) {
		dbTableHandle = DbTableUtil.getTableHandle(session);
	}
	
	public static void createOrDropTable(CgFormHeadEntity table, Session session) throws IOException, TemplateException, HibernateException, SQLException, DBException  {
		Template t;
		t = getConfig("/org/jeecgframework/web/cgform/engine/hibernate").getTemplate("tableTemplate.ftl");
		Writer out = new StringWriter();
		//模板对于数字超过1000，会自动格式为1,,000(禁止转换)
		t.setNumberFormat("0.#####################");
		t.process(getRootMap(table,DbTableUtil.getDataType(session)), out);
		String xml = out.toString();
		logger.info(xml);
		createTable(xml, table, session);
	}
	
	
	@SuppressWarnings("all")
	private static Object getRootMap(CgFormHeadEntity table,String dataType) {
		Map map = new HashMap();
		for(CgFormFieldEntity field :table.getColumns()){
			field.setFieldDefault(judgeIsNumber(field.getFieldDefault()));
		}
		map.put("entity", table);
		map.put("dataType", dataType);
		return map;
	}

	 
	
	public  List<String> updateTable(CgFormHeadEntity table,Session session) throws DBException{
		//StringBuilder sb = new StringBuilder();
		String tableName = DbTableUtil.getDataType(session).equals("ORACLE")?table.getTableName().toUpperCase():table.getTableName();
		String alterTable="alter table  "+tableName+" ";
		List<String> strings = new ArrayList<String>();
	       //对表的修改列和删除列的处理，解决hibernate没有该机制
	       try {
			 Map<String, ColumnMeta> dataBaseColumnMetaMap = getColumnMetadataFormDataBase(null ,tableName,session);
			
			 Map<String, ColumnMeta> cgFormColumnMetaMap = getColumnMetadataFormCgForm(table);
			 
			 Map<String,String> newAndOldFieldMap =getNewAndOldFieldName(table);
			
			 
			 for (String columnName : cgFormColumnMetaMap.keySet()) {
				 if(!dataBaseColumnMetaMap.containsKey(columnName)){//表如果不存在该列，则要对表做修改、增加、删除该列动作 此处无法处理删除的列，因为在这个循环中无法获得该列
					//如果旧列中包含这个列名，说明是修改名称的
					 ColumnMeta cgFormColumnMeta = cgFormColumnMetaMap.get(columnName);
					if(newAndOldFieldMap.containsKey(columnName)&&(dataBaseColumnMetaMap.containsKey(newAndOldFieldMap.get(columnName)))){
						ColumnMeta dataColumnMeta = dataBaseColumnMetaMap.get(newAndOldFieldMap.get(columnName));
						if (DbTableUtil.getDataType(session).equals("SQLSERVER")) {
							//sqlserver 修改类名称需要调用存储过程
							strings.add(getReNameFieldName(cgFormColumnMeta));
						}else {
							strings.add(alterTable+getReNameFieldName(cgFormColumnMeta));
						} 
						//执行完成之后修改成一致 fildname和oldfieldname
						 updateFieldName(columnName, cgFormColumnMeta.getColumnId(),session);
						//修改表名之后继续判断值有没有变化,有变化继续修改值
						if (!dataColumnMeta.equals(cgFormColumnMeta)) {
								strings.add(alterTable+getUpdateColumnSql(cgFormColumnMeta,dataColumnMeta));
								if (DbTableUtil.getDataType(session).equals("POSTGRESQL")) {
									strings.add(alterTable + getUpdateSpecialSql(cgFormColumnMeta, dataColumnMeta));
								}
						}
						//判断注释是不是相同,修改注释
						if(!dataColumnMeta.equalsComment(cgFormColumnMeta)){
							strings.add(getCommentSql(cgFormColumnMeta));
						}
					}else{//不包含就是要增加
						strings.add(alterTable+getAddColumnSql(cgFormColumnMeta));
						if(StringUtils.isNotEmpty(cgFormColumnMeta.getComment())){
							strings.add(getCommentSql(cgFormColumnMeta));
						}
					}
				}else {//已经存在的判断是否修改了类型长度。。
					//判断是否类型、长度、是否为空、精度被修改，如果有修改则处理修改
					ColumnMeta dataColumnMeta = dataBaseColumnMetaMap.get(columnName);
					ColumnMeta cgFormColumnMeta = cgFormColumnMetaMap.get(columnName);
					//如果不相同，则表示有变化，则需要修改
					if (!dataColumnMeta.equals(cgFormColumnMeta)) {
						strings.add(alterTable+getUpdateColumnSql(cgFormColumnMeta,dataColumnMeta));
					}
					if(!dataColumnMeta.equalsComment(cgFormColumnMeta)){
						strings.add(getCommentSql(cgFormColumnMeta));
					}
				}
				
			}
			 
			//删除数据库的列
			 //要判断这个列不是修改的
			 for (String columnName : dataBaseColumnMetaMap.keySet()) {
				if ((!cgFormColumnMetaMap.containsKey(columnName.toLowerCase()))&& (!newAndOldFieldMap.containsValue(columnName.toLowerCase()))) {
					strings.add(alterTable+getDropColumnSql(columnName));
				}
			}
			 
		} catch (SQLException e1) {
			throw new RuntimeException();
		}
		logger.info(strings.toString());
		return strings;
	}
	
	private static void createTable(String xml, CgFormHeadEntity table,
			Session session) throws HibernateException, SQLException, DBException {
				
		//FIXME 考虑JNDI的情况
		//重新构建一个Configuration
		org.hibernate.cfg.Configuration newconf=new org.hibernate.cfg.Configuration(); 
		newconf.addXML(xml)
		.setProperty("hibernate.dialect",((SessionImpl)session).getFactory().getDialect().getClass().getName());
//       .setProperty("hibernate.connection.username",propertiesUtil.readProperty("jdbc.username.jeecg"))
//       .setProperty("hibernate.connection.password",propertiesUtil.readProperty("jdbc.password.jeecg"))  
//       .setProperty("hibernate.dialect",propertiesUtil.readProperty("hibernate.dialect"))
//       .setProperty("hibernate.connection.url",propertiesUtil.readProperty("jdbc.url.jeecg"))
//       .setProperty("hibernate.connection.driver_class",propertiesUtil.readProperty("jdbc.driver.class")); 
//       
			SchemaExport dbExport;
			dbExport = new SchemaExport(newconf,SessionFactoryUtils.getDataSource(
					session.getSessionFactory()).getConnection());
			dbExport.execute(true, true, false, true);

			//抛出执行异常，抛出第一个即可  
			@SuppressWarnings("unchecked")
			List<Exception> exceptionList = dbExport.getExceptions();
			for (Exception exception : exceptionList) {
				throw new DBException(exception.getMessage());
			}

	}

	/**
	 * 模版配置
	 * @param resource
	 * @return
	 */
	private static Configuration getConfig(String resource) {

		Configuration cfg = new Configuration();
		cfg.setDefaultEncoding("UTF-8");
		cfg.setClassForTemplateLoading(DbTableProcess.class, resource);
		return cfg;
	}

	
	/**
	 * 获取数据库中列的描述
	 * @param tableName
	 * @param session
	 * @return
	 * @throws SQLException
	 */
	public static Map<String, ColumnMeta> getColumnMetadataFormDataBase(String schemaName, String tableName, Session session) throws SQLException{
		Connection conn = null;

		try {
			conn = SessionFactoryUtils.getDataSource(session.getSessionFactory()).getConnection();
		} catch (Exception e) {
			logger.error(e);
			e.printStackTrace();
		}
		
		DatabaseMetaData dbMetaData = conn.getMetaData();
		ResultSet rs = dbMetaData.getColumns(null, schemaName, tableName, "%");	
		ColumnMeta columnMeta;
		Map<String, ColumnMeta> columnMap = new HashMap<String, ColumnMeta>();
		while (rs.next()){

			columnMeta = new ColumnMeta();
			columnMeta.setTableName(tableName);
			String columnName = rs.getString("COLUMN_NAME").toLowerCase();
			columnMeta.setColumnName(columnName);
			String typeName = rs.getString("TYPE_NAME");
			int decimalDigits = rs.getInt("DECIMAL_DIGITS");
			String colunmType = dbTableHandle.getMatchClassTypeByDataType(typeName,decimalDigits);
			columnMeta.setColunmType(colunmType);
			int columnSize = rs.getInt("COLUMN_SIZE");
			columnMeta.setColumnSize(columnSize);
			columnMeta.setDecimalDigits(decimalDigits);
			String isNullable = rs.getInt("NULLABLE")==1?"Y":"N";
			columnMeta.setIsNullable(isNullable);
			String comment = rs.getString("REMARKS");
			columnMeta.setComment(comment);
			String columnDef = rs.getString("COLUMN_DEF");
			String fieldDefault = judgeIsNumber(columnDef)==null?"":judgeIsNumber(columnDef);
			columnMeta.setFieldDefault(fieldDefault);
			logger.info("getColumnMetadataFormDataBase --->COLUMN_NAME:"+columnName.toUpperCase()+" TYPE_NAME :"+typeName
					+" DECIMAL_DIGITS:"+decimalDigits+" COLUMN_SIZE:"+columnSize);
			columnMap.put(columnName, columnMeta);
			/*columnMeta.setTableName(rs.getString("COLUMN_NAME").toLowerCase());
			columnMeta.setColumnName(rs.getString("COLUMN_NAME").toLowerCase());
			columnMeta.setColunmType(dbTableHandle.getMatchClassTypeByDataType(rs.getString("TYPE_NAME"),rs.getInt("DECIMAL_DIGITS")));
			columnMeta.setColumnSize(rs.getInt("COLUMN_SIZE"));
			columnMeta.setDecimalDigits(rs.getInt("DECIMAL_DIGITS"));
			columnMeta.setIsNullable(rs.getInt("NULLABLE")==1?"Y":"N");
			columnMeta.setComment(rs.getString("REMARKS"));
			columnMeta.setFieldDefault(judgeIsNumber(rs.getString("COLUMN_DEF"))==null?"":judgeIsNumber(rs.getString("COLUMN_DEF")));
			logger.info("getColumnMetadataFormDataBase --->COLUMN_NAME:"+rs.getString("COLUMN_NAME")+" TYPE_NAME :"+rs.getString("TYPE_NAME")
					+" DECIMAL_DIGITS:"+rs.getInt("DECIMAL_DIGITS")+" COLUMN_SIZE:"+rs.getInt("COLUMN_SIZE"));
			columnMap.put(rs.getString("COLUMN_NAME").toLowerCase(), columnMeta);*/
		}
		
		return columnMap;
	}

	/**
	 * 返回cgForm中列的描述信息
	 * @param table
	 * @return
	 */
	public static Map<String, ColumnMeta> getColumnMetadataFormCgForm(CgFormHeadEntity table){
		Map<String, ColumnMeta> map = new HashMap<String, ColumnMeta>();
		List<CgFormFieldEntity> cgFormFieldEntities = table.getColumns();
		ColumnMeta columnMeta;
		for (CgFormFieldEntity cgFormFieldEntity : cgFormFieldEntities) {
			columnMeta = new ColumnMeta();
			columnMeta.setTableName(table.getTableName().toLowerCase());
			columnMeta.setColumnId(cgFormFieldEntity.getId());
			columnMeta.setColumnName(cgFormFieldEntity.getFieldName().toLowerCase());
			columnMeta.setColumnSize(cgFormFieldEntity.getLength());
			columnMeta.setColunmType(cgFormFieldEntity.getType().toLowerCase());
			columnMeta.setIsNullable(cgFormFieldEntity.getIsNull());
			columnMeta.setComment(cgFormFieldEntity.getContent());
			columnMeta.setDecimalDigits(cgFormFieldEntity.getPointLength());
			columnMeta.setFieldDefault(judgeIsNumber(cgFormFieldEntity.getFieldDefault()));
			columnMeta.setPkType(table.getJformPkType()==null?"UUID":table.getJformPkType());
			columnMeta.setOldColumnName(cgFormFieldEntity.getOldFieldName()!=null?cgFormFieldEntity.getOldFieldName().toLowerCase():null);
			logger.info("getColumnMetadataFormCgForm ---->COLUMN_NAME:"+cgFormFieldEntity.getFieldName().toLowerCase()+" TYPE_NAME:"+cgFormFieldEntity.getType().toLowerCase()
					+" DECIMAL_DIGITS:"+cgFormFieldEntity.getPointLength()+" COLUMN_SIZE:"+cgFormFieldEntity.getLength());
			map.put(cgFormFieldEntity.getFieldName().toLowerCase(), columnMeta);
			
		}
		return map;
	}
	
	/**
	 * 返回cgForm中列名的新和旧的对应关系
	 * @param table
	 * @return
	 */
	public static Map<String, String> getNewAndOldFieldName(CgFormHeadEntity table){
		Map<String, String> map = new HashMap<String, String>();
		List<CgFormFieldEntity> cgFormFieldEntities = table.getColumns();
		for (CgFormFieldEntity cgFormFieldEntity : cgFormFieldEntities) {
			map.put(cgFormFieldEntity.getFieldName(), cgFormFieldEntity.getOldFieldName());
		}
		return map;
	}
	
	/**
	 * 创建删除字段的sql
	 * @param fieldName
	 * @return
	 */
	private static  String getDropColumnSql(String fieldName) {
		//ALTER TABLE `test` DROP COLUMN `aaaa`;
		return dbTableHandle.getDropColumnSql(fieldName);
	}
	
	/**
	 * 创建更新字段的sql
	 * @param newColumn
	 * @param agoColumn 
	 * @return
	 */
	private static String getUpdateColumnSql(ColumnMeta cgformcolumnMeta,ColumnMeta datacolumnMeta)throws DBException {
		//modify birthday varchar2(10) not null;
		//return " MODIFY COLUMN  "+getFieldDesc(columnMeta)+",";
		return dbTableHandle.getUpdateColumnSql(cgformcolumnMeta,datacolumnMeta);
	}
	
	/**
	 * 处理特殊sql
	 * @param cgformcolumnMeta
	 * @param datacolumnMeta
	 * @return
	 */
	private static String getUpdateSpecialSql(ColumnMeta cgformcolumnMeta,ColumnMeta datacolumnMeta) {
		return dbTableHandle.getSpecialHandle(cgformcolumnMeta,datacolumnMeta);
	}
	
	/**
	 * 修改列名
	 * @param columnMeta
	 * @return
	 */
	private static String getReNameFieldName(ColumnMeta columnMeta){
		//CHANGE COLUMN `name1` `name2`  varchar(50)  NULL  COMMENT '姓名';
		//return "CHANGE COLUMN  "+columnMeta.getOldColumnName() +" "+getFieldDesc(columnMeta)+",";
		return dbTableHandle.getReNameFieldName(columnMeta);
	}
	
	/**
	 * 创建增加字段的sql
	 * @param column
	 * @param agoColumn 
	 * @return
	 */
	private static String getAddColumnSql(ColumnMeta columnMeta) {
		//return " ADD COLUMN "+getFieldDesc(columnMeta)+",";
		return dbTableHandle.getAddColumnSql(columnMeta);
	}
	
	/**
	 * 添加注释的sql
	 *@Author JueYue
	 *@date   2013年12月1日
	 *@param cgFormColumnMeta
	 *@return
	 */
	private String getCommentSql(ColumnMeta columnMeta) {
		return dbTableHandle.getCommentSql(columnMeta);
	}
	
	private int updateFieldName(String columnName,String id,Session session){
		return   session.createSQLQuery("update cgform_field set old_field_name= '"+columnName+"' where id='"+id+"'").executeUpdate();
	}
	/**
	 * 判断是不数字,不是数字的话加上''
	 *@Author JueYue
	 *@date   2013年11月27日
	 *@param text
	 *@return
	 */
	private static String judgeIsNumber(String text){
		if(StringUtils.isNotEmpty(text)){
			try{
				Double.valueOf(text);
			}catch(Exception e){
				text = "'"+text+"'";
			}
		}
		return text;
	}
}
