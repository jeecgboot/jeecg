package org.jeecgframework.web.cgform.service.migrate;

import java.beans.PropertyDescriptor;
import java.io.BufferedOutputStream;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.OutputStreamWriter;
import java.io.Writer;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Types;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.tools.zip.ZipEntry;
import org.apache.tools.zip.ZipFile;
import org.apache.tools.zip.ZipOutputStream;
import org.jeecgframework.core.common.model.common.DBTable;
import org.jeecgframework.core.util.ReflectHelper;
import org.jeecgframework.web.cgform.entity.button.CgformButtonEntity;
import org.jeecgframework.web.cgform.entity.button.CgformButtonSqlEntity;
import org.jeecgframework.web.cgform.entity.cgformftl.CgformFtlEntity;
import org.jeecgframework.web.cgform.entity.enhance.CgformEnhanceJsEntity;
import org.jeecgframework.web.cgform.entity.upload.CgUploadEntity;
import org.jeecgframework.web.cgform.exception.BusinessException;
import org.jeecgframework.web.cgform.pojo.config.CgFormFieldPojo;
import org.jeecgframework.web.cgform.pojo.config.CgFormHeadPojo;
import org.jeecgframework.web.cgform.pojo.config.CgFormIndexPojo;
import org.jeecgframework.web.cgform.util.PublicUtil;
import org.springframework.beans.BeanUtils;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowCallbackHandler;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.jdbc.support.rowset.SqlRowSet;
import org.springframework.jdbc.support.rowset.SqlRowSetMetaData;
import org.springframework.stereotype.Service;

import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.converters.basic.NullConverter;

/**
 * 迁移表单工具类
 * 
 * @author duanqilu
 * @author Hank
 * @param <T>
 * @date 2013-09-10  
 * @date 2014-01-25 
 */
@Service("MigrateForm")
public class MigrateForm<T> {
	private static final Logger logger = Logger.getLogger(MigrateForm.class);
	static InputStream inStream = null;
	private static String insert = "INSERT INTO";// 插入sql
	private static String values = "VALUES";// values关键字

	private static List<String> insertList = new ArrayList<String>();// 全局存放insertsql文件的数据
	private static String basePath = "";
	

	/**
	 * 拼装查询语句
	 * 
	 * @ids:选中表单的IDs
	 * @return 返回select集合
	 */
	@Deprecated
	public static List<String> createSQL(String ids, JdbcTemplate jdbcTemplate) {
		List<String> listSQL = new ArrayList<String>();// SQL语句列表
		listSQL.clear();
		String[] idList = ids.split(",");// 获得指定的ID数据
		String ls_sql = "";
		String ls_tmpsql = "";
		String ls_subid = "";
		String subTable = "";
		List rowsList = null;
		List subRowsList = null;
		Map sqlMap = null;
		Map subSqlMap = null;
		for (String id : idList) {
			ls_sql = "select * from cgform_head where id='" + id + "'"; // 获得导出表单
			listSQL.add(ls_sql);

			ls_tmpsql = "select * from cgform_field where table_id='" + id + "'"; // 获得导出表单的字段
			listSQL.add(ls_tmpsql);
			// 获得自定义按钮数据
			ls_tmpsql = "select * from cgform_button where form_id ='" + id + "'";
			listSQL.add(ls_tmpsql);
			// 获得JS增强数据
			ls_tmpsql = "select * from cgform_enhance_js where form_id ='" + id + "'";
			listSQL.add(ls_tmpsql);
			// 获得SQL增强数据
			ls_tmpsql = "select * from cgform_button_sql where form_id ='" + id + "'";
			listSQL.add(ls_tmpsql);
			// 获得模板数据
			ls_tmpsql = "select * from cgform_ftl where cgform_id ='" + id + "'";
			listSQL.add(ls_tmpsql);
			// 获得上传文件数据
			ls_tmpsql = "select * from cgform_uploadfiles where cgform_id ='" + id + "'";
			listSQL.add(ls_tmpsql);

			rowsList = jdbcTemplate.queryForList(ls_sql);
			if (rowsList != null && rowsList.size() > 0) {
				sqlMap = (Map) rowsList.get(0);
				subTable = (String) sqlMap.get("sub_table_str"); // 获得子表
				if (subTable != null && !"".equals(subTable)) {
					String[] subs = subTable.split(",");
					for (String sub : subs) {
						// 获得导出子表表单
						ls_tmpsql = "select * from cgform_head where table_name='" + sub + "'";
						listSQL.add(ls_tmpsql);
						subRowsList = jdbcTemplate.queryForList(ls_tmpsql);
						if (subRowsList != null && subRowsList.size() > 0) {
							subSqlMap = (Map) subRowsList.get(0);
							ls_subid = (String) subSqlMap.get("id");
							// 获得导出子表字段
							ls_tmpsql = "select * from cgform_field where table_id='" + ls_subid + "'";
							listSQL.add(ls_tmpsql);
							// 获得子表自定义按钮数据
							ls_tmpsql = "select * from cgform_button where form_id ='" + ls_subid + "'";
							listSQL.add(ls_tmpsql);
							// 获得子表JS增强数据
							ls_tmpsql = "select * from cgform_enhance_js where form_id ='" + ls_subid + "'";
							listSQL.add(ls_tmpsql);
							// 获得子表SQL增强数据
							ls_tmpsql = "select * from cgform_button_sql where form_id ='" + ls_subid + "'";
							listSQL.add(ls_tmpsql);
							// 获得子表模板数据
							ls_tmpsql = "select * from cgform_ftl where cgform_id ='" + ls_subid + "'";
							listSQL.add(ls_tmpsql);
							// 获得子表上传文件数据
							ls_tmpsql = "select * from cgform_uploadfiles where cgform_id ='" + ls_subid + "'";
							listSQL.add(ls_tmpsql);
						}
					}
				}

			}
		}
		return listSQL;
	}
	
	public static List<DBTable> buildExportDbTableList(String ids, JdbcTemplate jdbcTemplate) throws Exception {
		List<DBTable> listTables = new ArrayList<DBTable>();// SQL语句列表
		listTables.clear();
		String ls_sql = "";
		String ls_tmpsql = "";
		String ls_subid = "";
		String subTable = "";
		List rowsList = null;
		List subRowsList = null;
		Map sqlMap = null;
		Map subSqlMap = null;
		String[] idList = ids.split(",");// 获得指定的ID数据
		for (String id : idList) {
			ls_sql = "select * from cgform_head where id='" + id + "'"; // 获得导出表单
			listTables.add(bulidDbTableFromSQL(ls_sql, CgFormHeadPojo.class, jdbcTemplate));

			ls_tmpsql = "select * from cgform_index where table_id='" + id + "'"; // 获得导出索引的字段
			listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgFormIndexPojo.class, jdbcTemplate));



			ls_tmpsql = "select * from cgform_field where table_id='" + id + "'"; // 获得导出表单的字段
			listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgFormFieldPojo.class, jdbcTemplate));
			// 获得自定义按钮数据
			ls_tmpsql = "select * from cgform_button where form_id ='" + id + "'";
			listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgformButtonEntity.class, jdbcTemplate));
			// 获得JS增强数据
			ls_tmpsql = "select * from cgform_enhance_js where form_id ='" + id + "'";
			listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgformEnhanceJsEntity.class, jdbcTemplate));
			// 获得SQL增强数据
			ls_tmpsql = "select * from cgform_button_sql where form_id ='" + id + "'";
			listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgformButtonSqlEntity.class, jdbcTemplate));
			// 获得模板数据
			ls_tmpsql = "select * from cgform_ftl where cgform_id ='" + id + "'";
			listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgformFtlEntity.class, jdbcTemplate));
			// 获得上传文件数据
			ls_tmpsql = "select * from cgform_uploadfiles where cgform_id ='" + id + "'";
			listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgUploadEntity.class, jdbcTemplate));

			rowsList = jdbcTemplate.queryForList(ls_sql);
			if (rowsList != null && rowsList.size() > 0) {
				sqlMap = (Map) rowsList.get(0);
				subTable = (String) sqlMap.get("sub_table_str"); // 获得子表
				if (subTable != null && !"".equals(subTable)) {
					String[] subs = subTable.split(",");
					for (String sub : subs) {
						// 获得导出子表表单
						ls_tmpsql = "select * from cgform_head where table_name='" + sub + "'";
						listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgFormHeadPojo.class, jdbcTemplate));
						subRowsList = jdbcTemplate.queryForList(ls_tmpsql);
						if (subRowsList != null && subRowsList.size() > 0) {
							subSqlMap = (Map) subRowsList.get(0);
							ls_subid = (String) subSqlMap.get("id");

							// 获得导出子表索引
							ls_tmpsql = "select * from cgform_index where table_id='" + ls_subid + "'";
							listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgFormIndexPojo.class, jdbcTemplate));


							// 获得导出子表字段
							ls_tmpsql = "select * from cgform_field where table_id='" + ls_subid + "'";
							listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgFormFieldPojo.class, jdbcTemplate));
							// 获得子表自定义按钮数据
							ls_tmpsql = "select * from cgform_button where form_id ='" + ls_subid + "'";
							listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgformButtonEntity.class, jdbcTemplate));
							// 获得子表JS增强数据
							ls_tmpsql = "select * from cgform_enhance_js where form_id ='" + ls_subid + "'";
							listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgformEnhanceJsEntity.class, jdbcTemplate));
							// 获得子表SQL增强数据
							ls_tmpsql = "select * from cgform_button_sql where form_id ='" + ls_subid + "'";
							listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgformButtonSqlEntity.class, jdbcTemplate));
							// 获得子表模板数据
							ls_tmpsql = "select * from cgform_ftl where cgform_id ='" + ls_subid + "'";
							listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgformFtlEntity.class, jdbcTemplate));
							// 获得子表上传文件数据
							ls_tmpsql = "select * from cgform_uploadfiles where cgform_id ='" + ls_subid + "'";
							listTables.add(bulidDbTableFromSQL(ls_tmpsql, CgUploadEntity.class, jdbcTemplate));
						}
					}
				}

			}
		}
		return listTables;
	}

	/**
	 * 执行sql并返回插入sql语句
	 * 
	 * @param sqlRsmd
	 * @param listSQL
	 * @throws SQLException
	 */
	public static void executeSQL(List<String> listSQL, JdbcTemplate jdbcTemplate) throws Exception {
			getColumnNameAndColumeValue(listSQL, jdbcTemplate);
	}

	public static <T> DBTable<T> bulidDbTableFromSQL(String sql, Class<T> clazz, JdbcTemplate jdbcTemplate) throws InstantiationException, IllegalAccessException, Exception {
		DBTable<T> dbTable = new DBTable<T>();
		dbTable.setTableName(PublicUtil.getTableName(sql));
		dbTable.setClass1(clazz);

		List<T> dataList = jdbcTemplate.query(sql, BeanPropertyRowMapper.newInstance(clazz));

		dbTable.setTableData(dataList);
		return dbTable;
	}

	/**
	 * 获取列名和列值
	 * 
	 * @param listSQL
	 * @param sqlRowSet
	 * @param jdbcTemplate
	 * @return
	 * @throws SQLException
	 */
	public static void getColumnNameAndColumeValue(List<String> listSQL, JdbcTemplate jdbcTemplate) throws Exception {
		if (listSQL.size() > 0) {
			insertList.clear();
			insertList.add("SET FOREIGN_KEY_CHECKS=0;");// 取消外键检查
			SqlRowSet sqlRowSet = null;
			String ls_id = "";
			for (int j = 0; j < listSQL.size(); j++) {
				String sql = String.valueOf(listSQL.get(j)); // 逐条获取sql语句
				sqlRowSet = jdbcTemplate.queryForRowSet(sql);
				SqlRowSetMetaData sqlRsmd = sqlRowSet.getMetaData();
				int columnCount = sqlRsmd.getColumnCount(); // 获得表字段个数
				String tableName = sqlRsmd.getTableName(columnCount); // 获得表名称
				if(StringUtils.isEmpty(tableName)){
					tableName = PublicUtil.getTableName(sql);
				}
				String tableId="";
				while (sqlRowSet.next()) {
					StringBuffer ColumnName = new StringBuffer();
					StringBuffer ColumnValue = new StringBuffer();

					for (int i = 1; i <= columnCount; i++) {
						String value = sqlRowSet.getString(i);
						if (value == null || "".equals(value)) {
							value = "";
						}
						Map<String, String> fieldMap = new HashMap<String, String>();
						fieldMap.put("name", sqlRsmd.getColumnName(i));
						fieldMap.put("fieldType", String.valueOf(sqlRsmd.getColumnType(i)));
						// 生成插入数据sql语句
						if (i == 1) {
							// 先生成删除指定ID语句，清除现有冲突数据
							insertList.add("delete from " + tableName + " where " + sqlRsmd.getColumnName(i) + "='" + value + "';");

							ColumnName.append(sqlRsmd.getColumnName(i));
							ls_id = value;
							tableId = value;
							if (Types.CHAR == sqlRsmd.getColumnType(i) || Types.VARCHAR == sqlRsmd.getColumnType(i)) {
								ColumnValue.append("'").append(value).append("',");
							} else if (Types.SMALLINT == sqlRsmd.getColumnType(i) || Types.INTEGER == sqlRsmd.getColumnType(i) || Types.BIGINT == sqlRsmd.getColumnType(i) || Types.FLOAT == sqlRsmd.getColumnType(i) || Types.DOUBLE == sqlRsmd.getColumnType(i) || Types.NUMERIC == sqlRsmd.getColumnType(i) || Types.DECIMAL == sqlRsmd.getColumnType(i)) {
								if ("".equals(value))	value = "0";
								ColumnValue.append(value).append(",");
							} else if (Types.DATE == sqlRsmd.getColumnType(i) || Types.TIME == sqlRsmd.getColumnType(i) || Types.TIMESTAMP == sqlRsmd.getColumnType(i)) {
								if ("".equals(value))
									value = "2000-01-01";
								ColumnValue.append("'").append(value).append("',");
							} else {
								ColumnValue.append(value).append(",");
							}
						} else if (i == columnCount) {
							ColumnName.append("," + sqlRsmd.getColumnName(i));
							if (Types.CHAR == sqlRsmd.getColumnType(i) || Types.VARCHAR == sqlRsmd.getColumnType(i) || Types.LONGVARCHAR == sqlRsmd.getColumnType(i)) {
								ColumnValue.append("'").append(value).append("'");
							} else if (Types.SMALLINT == sqlRsmd.getColumnType(i) || Types.INTEGER == sqlRsmd.getColumnType(i) || Types.BIGINT == sqlRsmd.getColumnType(i) || Types.FLOAT == sqlRsmd.getColumnType(i) || Types.DOUBLE == sqlRsmd.getColumnType(i) || Types.NUMERIC == sqlRsmd.getColumnType(i) || Types.DECIMAL == sqlRsmd.getColumnType(i)) {
								if ("".equals(value))	value = "0";
								ColumnValue.append(value);
							} else if (Types.DATE == sqlRsmd.getColumnType(i) || Types.TIME == sqlRsmd.getColumnType(i) || Types.TIMESTAMP == sqlRsmd.getColumnType(i)) {
								if ("".equals(value))
									value = "2000-01-01";
								ColumnValue.append("'").append(value).append("'");
							} else {
								ColumnValue.append(value).append("");
							}
						} else {
							ColumnName.append("," + sqlRsmd.getColumnName(i));
							if (Types.CHAR == sqlRsmd.getColumnType(i) || Types.VARCHAR == sqlRsmd.getColumnType(i) || Types.LONGVARCHAR == sqlRsmd.getColumnType(i)) {
								ColumnValue.append("'").append(value).append("'").append(",");
							} else if (Types.SMALLINT == sqlRsmd.getColumnType(i) || Types.INTEGER == sqlRsmd.getColumnType(i) || Types.BIGINT == sqlRsmd.getColumnType(i) || Types.FLOAT == sqlRsmd.getColumnType(i) || Types.DOUBLE == sqlRsmd.getColumnType(i) || Types.NUMERIC == sqlRsmd.getColumnType(i) || Types.DECIMAL == sqlRsmd.getColumnType(i)) {
								if ("".equals(value))	value = "0";
								ColumnValue.append(value).append(",");
							} else if (Types.DATE == sqlRsmd.getColumnType(i) || Types.TIME == sqlRsmd.getColumnType(i) || Types.TIMESTAMP == sqlRsmd.getColumnType(i)) {
								if ("".equals(value))
									value = "2000-01-01";
								ColumnValue.append("'").append(value).append("',");
							} else if (Types.BLOB == sqlRsmd.getColumnType(i) || Types.LONGVARCHAR == sqlRsmd.getColumnType(i) || Types.LONGNVARCHAR == sqlRsmd.getColumnType(i) || Types.BINARY == sqlRsmd.getColumnType(i) || Types.LONGVARBINARY == sqlRsmd.getColumnType(i) || Types.VARBINARY == sqlRsmd.getColumnType(i)) {
								String ls_tmp = getBlob(ls_id, tableName, sqlRsmd.getColumnName(i), jdbcTemplate);
								ColumnValue.append(ls_tmp).append(",");
							} else {
								ColumnValue.append(value).append(",");
							}
						}

					}

					insertSQL(tableName, ColumnName, ColumnValue);// 拼装并放到全局list里面
					if(tableName.equals("cgform_head")){
						insertList.add("update cgform_head set is_dbsynch='N' where id='"+tableId+"';");// 设为未同步		
					}

				}
			}
			
		}
	}

	/**
	 * 拼装insertsql 放到全局list里面
	 * 
	 * @param ColumnName
	 * @param ColumnValue
	 */
	public static void insertSQL(String tablename, StringBuffer ColumnName, StringBuffer ColumnValue) {
		StringBuffer insertSQL = new StringBuffer();
		// 拼装sql语句
		insertSQL.append(insert).append(" ").append(tablename).append("(").append(ColumnName.toString()).append(")").append(values).append("(").append(ColumnValue.toString()).append(");");
		insertList.add(insertSQL.toString()); // 放到全局list里面
	}
	
	public static void generateXmlDataOutFlieContent(List<DBTable> dbTables, String parentDir) throws BusinessException{
		File file = new File(parentDir);
		if (!file.exists()) {
			buildFile(parentDir, true);
		}
		try {
			XStream xStream = new XStream();
			xStream.registerConverter(new NullConverter());
			xStream.processAnnotations(DBTable.class);
			FileOutputStream outputStream = new FileOutputStream(buildFile(parentDir+"/migrateExport.xml", false));
			Writer writer = new OutputStreamWriter(outputStream, "UTF-8");
			writer.write("<?xml version=\"1.0\" encoding=\"UTF-8\" ?>\r\n");
			xStream.toXML(dbTables, writer);
		} catch (Exception e) {
			throw new BusinessException(e.getMessage());
		}
	}
	
	/**
	 * 创建insertsql.sql并导出数据
	 */
	public static String createFile(HttpServletRequest request,String ids) {
		String savePath = request.getSession().getServletContext().getRealPath("/") + basePath + "/"+ids+"_migrate.sql";
		File file = new File(savePath);
		if (!file.exists()) {
			try {
				file.createNewFile();
			} catch (IOException e) {
				logger.info("创建文件名失败！！");
				e.printStackTrace();
			}
		}
		FileWriter fw = null;
		BufferedWriter bw = null;
		try {
			fw = new FileWriter(file);
			bw = new BufferedWriter(fw);
			if (insertList.size() > 0) {
				for (int i = 0; i < insertList.size(); i++) {
					bw.append(insertList.get(i));
					bw.append("\n");
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				bw.close();
				fw.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return savePath;
	}

	/**
	 * 以流方式获得blog,image等大数据
	 * 
	 * @param id
	 *            字段主键
	 * @param tableName
	 *            表名
	 * @param ColumnName
	 *            字段名
	 * @param jdbcTemplate
	 */
	public static String getBlob(String id, String tableName, final String columnName, JdbcTemplate jdbcTemplate) {
		String ls_sql = "select " + columnName + " from " + tableName + " where id='" + id + "'";

		// 查询并获得输入流
		jdbcTemplate.query(ls_sql, new RowCallbackHandler() {
			
			public void processRow(ResultSet rs) throws SQLException {
				inStream = rs.getBinaryStream(columnName);
			}
		});

		// 读取流数据并转换成16进制字符串
		if (inStream != null) {
			StringBuffer readInBuffer = new StringBuffer();
			readInBuffer.append("0x");
			byte[] b = new byte[4096];
			try {

				for (; (inStream.read(b)) != -1;) {
					readInBuffer.append(byte2HexStr(b));
				}
			} catch (IOException e) {

				e.printStackTrace();
			}
			String ls_return = readInBuffer.toString().trim();
			if ("0x".equals(ls_return)) {
				ls_return = ls_return + "00";
			}
			return ls_return;
		} else {
			return "0x00";
		}
	}

	/**
	 * 转换byte[]为16进制字符串
	 * 
	 * @param b
	 *            要转换的byte数据
	 */
	public static String byte2HexStr(byte[] b) {
		String hs = "";
		String stmp = "";
		for (int n = 0; n < b.length; n++) {
			if (b[n] == 0)
				break; // 判断数据结束
			stmp = (Integer.toHexString(b[n] & 0XFF));
			if (stmp.length() == 1)
				hs = hs + "0" + stmp;
			else
				hs = hs + stmp;
		}
		return hs.toUpperCase();
	}

	/**
	 * 压缩
	 * 
	 * @param zipFileName
	 *            压缩产生的zip包文件名--带路径,如果为null或空则默认按文件名生产压缩文件名
	 * @param relativePath
	 *            相对路径，默认为空
	 * @param directory
	 *            文件或目录的绝对路径
	 * @throws FileNotFoundException
	 * @throws IOException
	 */
	public static String zip(String zipFileName, String relativePath, String directory) throws FileNotFoundException, IOException {
		String fileName = zipFileName;
		if (fileName == null || fileName.trim().equals("")) {
			File temp = new File(directory);
			if (temp.isDirectory()) {
				fileName = directory + ".zip";
			} else {
				if (directory.indexOf(".") > 0) {
					fileName = directory.substring(0, directory.lastIndexOf(".")) + ".zip";
				} else {
					fileName = directory + ".zip";
				}
			}
		}
		ZipOutputStream zos = new ZipOutputStream(new FileOutputStream(fileName));
		try {
			zip(zos, relativePath, directory);
		} catch (IOException ex) {
			throw ex;
		} finally {
			if (null != zos) {
				zos.close();
			}
		}
		return fileName;
	}

	/**
	 * 压缩
	 * 
	 * @param zos
	 *            压缩输出流
	 * @param relativePath
	 *            相对路径
	 * @param absolutPath
	 *            文件或文件夹绝对路径
	 * @throws IOException
	 */
	private static void zip(ZipOutputStream zos, String relativePath, String absolutPath) throws IOException {
		File file = new File(absolutPath);
		if (file.isDirectory()) {
			File[] files = file.listFiles();
			for (int i = 0; i < files.length; i++) {
				File tempFile = files[i];
				if (tempFile.isDirectory()) {
					String newRelativePath = relativePath + tempFile.getName() + File.separator;
					createZipNode(zos, newRelativePath);
					zip(zos, newRelativePath, tempFile.getPath());
				} else {
					zipFile(zos, tempFile, relativePath);
				}
			}
		} else {
			zipFile(zos, file, relativePath);
		}
	}

	/**
	 * * 压缩文件
	 * 
	 * @param zos
	 *            压缩输出流
	 * @param file
	 *            文件对象
	 * @param relativePath
	 *            相对路径
	 * @throws IOException
	 */
	private static void zipFile(ZipOutputStream zos, File file, String relativePath) throws IOException {
		ZipEntry entry = new ZipEntry(relativePath + file.getName());
		zos.putNextEntry(entry);
		InputStream is = null;
		try {
			is = new FileInputStream(file);
			int BUFFERSIZE = 2 << 10;
			int length = 0;
			byte[] buffer = new byte[BUFFERSIZE];
			while ((length = is.read(buffer, 0, BUFFERSIZE)) >= 0) {
				zos.write(buffer, 0, length);
			}
			zos.flush();
			zos.closeEntry();
		} catch (IOException ex) {
			throw ex;
		} finally {
			if (null != is) {
				is.close();
			}
		}
	}

	/**
	 * 创建目录
	 * 
	 * @param zos
	 *            zip输出流
	 * @param relativePath
	 *            相对路径
	 * @throws IOException
	 */
	private static void createZipNode(ZipOutputStream zos, String relativePath) throws IOException {
		ZipEntry zipEntry = new ZipEntry(relativePath);
		zos.putNextEntry(zipEntry);
		zos.closeEntry();
	}

	/**
	 * 解压缩zip包
	 * 
	 * @param zipFilePath
	 *            zip文件路径
	 * @param targetPath
	 *            解压缩到的位置，如果为null或空字符串则默认解压缩到跟zip包同目录跟zip包同名的文件夹下
	 * @throws IOException
	 */
	public static void unzip(String zipFilePath, String targetPath) throws IOException {
		OutputStream os = null;
		InputStream is = null;
		ZipFile zipFile = null;
		try {
			zipFile = new ZipFile(zipFilePath);
			String directoryPath = "";
			if (null == targetPath || "".equals(targetPath)) {
				directoryPath = zipFilePath.substring(0, zipFilePath.lastIndexOf("."));
			} else {
				directoryPath = targetPath;
			}
			Enumeration entryEnum = zipFile.getEntries();
			if (null != entryEnum) {
				ZipEntry zipEntry = null;
				while (entryEnum.hasMoreElements()) {
					zipEntry = (ZipEntry) entryEnum.nextElement();
					if (zipEntry.isDirectory()) {
						directoryPath = directoryPath + File.separator + zipEntry.getName();
						org.jeecgframework.core.util.LogUtil.info(directoryPath);
						continue;
					}
					if (zipEntry.getSize() > 0) {
						// 文件
						File targetFile = buildFile(directoryPath + File.separator + zipEntry.getName(), false);
						os = new BufferedOutputStream(new FileOutputStream(targetFile));
						is = zipFile.getInputStream(zipEntry);
						byte[] buffer = new byte[4096];
						int readLen = 0;
						while ((readLen = is.read(buffer, 0, 4096)) >= 0) {
							os.write(buffer, 0, readLen);
						}
						os.flush();
						os.close();
					} else {
						// 空目录
						buildFile(directoryPath + File.separator + zipEntry.getName(), true);
					}
				}
			}
		} catch (IOException ex) {
			throw ex;
		} finally {
			if (null != zipFile) {
				zipFile = null;
			}
			if (null != is) {
				is.close();
			}
			if (null != os) {
				os.close();
			}
		}
	}

	/**
	 * 生产文件 如果文件所在路径不存在则生成路径
	 * 
	 * @param fileName
	 *            文件名 带路径
	 * @param isDirectory
	 *            是否为路径
	 */
	public static File buildFile(String fileName, boolean isDirectory) {
		File target = new File(fileName);
		if (isDirectory) {
			target.mkdirs();
		} else {
			if (!target.getParentFile().exists()) {
				target.getParentFile().mkdirs();
				target = new File(target.getAbsolutePath());
			}
		}
		return target;
	}
	
	public static <T> String generateInsertSql(String tableName, Class<T> clazz, List<String> ignores){
		StringBuffer insertSql = new StringBuffer("insert into " + tableName + "(");
		String tableField = "";
		String clazzProperties="";
		PropertyDescriptor[] pds = BeanUtils.getPropertyDescriptors(clazz);
		for (PropertyDescriptor pd : pds) {
			if(null != ignores && ignores.size()>0){
				if(ignores.contains(pd.getName())) continue;
			}
			if (pd.getWriteMethod() != null) {
				if(tableField.length()>0 && clazzProperties.length()>0){
					tableField += ",";
					clazzProperties += ",";
				}
				tableField += underscoreName(pd.getName());
				clazzProperties += ":" + pd.getName();
			}
		}
		insertSql.append(tableField);
		insertSql.append(") values(");
		insertSql.append(clazzProperties);
		insertSql.append(")");
		org.jeecgframework.core.util.LogUtil.info("generate insertSql for "+ clazz.getName() + ":" +insertSql.toString());
		return insertSql.toString();
	}
	
	public static <T> String generateUpdateSql(String tableName, Class<T> clazz, List<String> ignores){
		StringBuffer updateSql = new StringBuffer("update " + tableName + " set ");
		String updateProperties = "";
		PropertyDescriptor[] pds = BeanUtils.getPropertyDescriptors(clazz);
		for (PropertyDescriptor pd : pds) {
			if(null != ignores && ignores.size()>0){
				if(ignores.contains(pd.getName())) continue;
			}
			if(pd.getName().toLowerCase().equals("id")){// || pd.getPropertyType().equals(List.class)
				continue;
			}
			if (pd.getWriteMethod() != null) {
				if(updateProperties.length()>0){
					updateProperties += ",";
				}
				updateProperties += underscoreName(pd.getName()) + "=:" + pd.getName();
			}
		}
		updateSql.append(updateProperties);
		updateSql.append(" where id=:id");
		org.jeecgframework.core.util.LogUtil.info("generate updateSql for "+ clazz.getName() + ":" +updateSql.toString());
		return updateSql.toString();
	}
	
	public static SqlParameterSource generateParameterMap(Object t, List<String> ignores){
		Map<String, Object> paramMap = new HashMap<String, Object>();
		ReflectHelper reflectHelper = new ReflectHelper(t);
		PropertyDescriptor[] pds = BeanUtils.getPropertyDescriptors(t.getClass());
		for (PropertyDescriptor pd : pds) {
			if(null != ignores && ignores.contains(pd.getName())){
				continue;
			}
			paramMap.put(pd.getName(), reflectHelper.getMethodValue(pd.getName()));
		}
		MapSqlParameterSource sqlParameterSource = new MapSqlParameterSource(paramMap);
		return sqlParameterSource;
	}

	private static String underscoreName(String name) {
		StringBuilder result = new StringBuilder();
		if (name != null && name.length() > 0) {
			result.append(name.substring(0, 1).toLowerCase());
			for (int i = 1; i < name.length(); i++) {
				String s = name.substring(i, i + 1);
				if (s.equals(s.toUpperCase())) {
					result.append("_");
					result.append(s.toLowerCase());
				}
				else {
					result.append(s);
				}
			}
		}
		return result.toString();
	}
}
