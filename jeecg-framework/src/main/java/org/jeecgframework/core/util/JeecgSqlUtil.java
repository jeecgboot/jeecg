package org.jeecgframework.core.util;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.Serializable;
import java.util.ResourceBundle;

import net.sf.ehcache.Cache;
import net.sf.ehcache.CacheManager;
import net.sf.ehcache.Element;

import org.jeecgframework.core.def.ConstantsDefs;

/**
 * 
 * @author  张代浩
 *
 */
public class JeecgSqlUtil {
	
	/**
	 * SQL文件路径获取参数
	 */
	private static final String KEY_01 = "service";
	private static final String KEY_02 = "impl";
	private static final String KEY_03 = "Impl.";
	private static final String PACKAGE_SQL = "sql";
	private static final String SUFFIX_SQL = ".sql";
	private static final String SUFFIX_D = ".";
	private static final String SUFFIX_X = "/";
	
	
	private static final ResourceBundle bundle = java.util.ResourceBundle.getBundle("sysConfig");
	private static Cache dictCache;
	static{
		if (dictCache == null) {
			dictCache = CacheManager.getInstance().getCache("dictCache");
		}
	}
	/** 
	 * 从文件中读取文本内容, 读取时使用平台默认编码解码文件中的字节序列 
	 * @param file 目标文件 
	 * @return 
	 * @throws IOException 
	 */
	private static String loadStringFromFile(File file) throws IOException {
		return loadStringFromFile(file, "UTF-8");
	}

	/** 
	 * 从文件中读取文本内容 
	 * @param file 目标文件 
	 * @param encoding 目标文件的文本编码格式 
	 * @return 
	 * @throws IOException 
	 */
	private static String loadStringFromFile(File file, String encoding)
			throws IOException {
		BufferedReader reader = null;
		try {
			reader = new BufferedReader(new InputStreamReader(
					new FileInputStream(file), encoding));
			StringBuilder builder = new StringBuilder();
			char[] chars = new char[4096];

			int length = 0;

			while (0 < (length = reader.read(chars))) {

				builder.append(chars, 0, length);

			}

			return builder.toString();

		} finally {

			try {

				if (reader != null)
					reader.close();

			} catch (IOException e) {

				throw new RuntimeException(e);

			}

		}

	}

	/**
	 * 读取SQL内容
	 * @param args
	 * @throws IOException 
	 */

	private static String getFlieTxt(String fileUrl) {
		org.jeecgframework.core.util.LogUtil.info("---------------------------------------sql 路径 :"+fileUrl);
		String sql = null;
		try {
			sql = loadStringFromFile(new File(fileUrl));
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sql;
	}
	
	
	public static String getMethodSql(String methodUrl) {
		
		//[1].开发模式：dev SQL文件每次都加载
		if(ConstantsDefs.MODE_DEVELOP.equals(bundle.getObject("sqlReadMode"))){
			return getMethodSqlLogicJar(methodUrl);
		}
		//[2].发布模式：pub SQL文件只加载一次
		else if(ConstantsDefs.MODE_PUBLISH.equals(bundle.getObject("sqlReadMode"))){
			Element element = dictCache.get(methodUrl);
			if (element == null) {
				element = new Element(methodUrl, (Serializable) getMethodSqlLogicJar(methodUrl));
				//永久缓存
				dictCache.put(element);
			}
			return element.getValue().toString();
		}
		else{
			return "";
		}
	}
	
	/**
	 * 新获取SQL路径方法,并读取文件获取SQL内容
	 * @param methodUrl
	 * @return
	 */
	public static String getMethodSqlLogic(String methodUrl){
		String head = methodUrl.substring(0, methodUrl.indexOf(KEY_01));
		String end = methodUrl.substring(methodUrl.indexOf(KEY_02)+KEY_02.length()).replace(KEY_03, "_");
		String sqlurl = head +PACKAGE_SQL+end;
		sqlurl = sqlurl.replace(SUFFIX_D, SUFFIX_X);
		sqlurl =sqlurl +SUFFIX_SQL;
		
		String projectPath = getAppPath(JeecgSqlUtil.class);
		sqlurl = projectPath + SUFFIX_X+sqlurl;
		org.jeecgframework.core.util.LogUtil.info(sqlurl);
		return getFlieTxt(sqlurl);
	}
	/**
	 * 新获取SQL路径方法,并读取文件获取SQL内容
	 * 扩展可以读取jar中sql
	 * @param methodUrl
	 * @return
	 */
	public static String getMethodSqlLogicJar(String methodUrl){
		StringBuffer sb = new StringBuffer();
		String head = methodUrl.substring(0, methodUrl.indexOf(KEY_01));
		String end = methodUrl.substring(methodUrl.indexOf(KEY_02)+KEY_02.length()).replace(KEY_03, "_");
		String sqlurl = head +PACKAGE_SQL+end;
		sqlurl = sqlurl.replace(SUFFIX_D, SUFFIX_X);
		sqlurl = SUFFIX_X+sqlurl +SUFFIX_SQL;
		
//		返回读取指定资源的输入流   
        InputStream is = JeecgSqlUtil.class.getResourceAsStream(sqlurl);    
        BufferedReader br=new BufferedReader(new InputStreamReader(is));   
        String s="";   
        try {
			while((s=br.readLine())!=null)   
				sb.append(s+" ");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return sb.toString();
	}
	
	
	/**
	 * 旧获取SQL路径方法
	 * @param methodUrl
	 * @return
	 */
	@Deprecated
	public static String getMethodSqlLogicOld(String methodUrl) {
		//从Spring中获取Request
//		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.getRequestAttributes()).getRequest();  
//		String projectPath = ServletActionContext.getServletContext().getRealPath("/");
//		org.jeecgframework.core.util.LogUtil.info(projectPath);
//		String projectPath =  request.getSession().getServletContext().getRealPath("/");
		methodUrl = methodUrl.substring(17).replace("Impl", "").replace(".", "/");
		String[] str = methodUrl.split("/");
		StringBuffer sb = new StringBuffer();
		int num = 2;
		int length = str.length;
		for(String s:str){
			
			if(num<length){
				sb.append(s);
				sb.append("/");
			}else if(num==length){
				sb.append(s);
				sb.append("_");
			}
			else{
				sb.append(s);
			}
			num = num + 1;
		}
		String projectPath = getAppPath(JeecgSqlUtil.class);
		String fileUrl = projectPath+"/sun/sql/" + sb.toString()+".sql";
		return getFlieTxt(fileUrl);
	}
	
	@SuppressWarnings("unchecked")
	public static String getAppPath(Class cls) {
		// 检查用户传入的参数是否为空
		if (cls == null)
			throw new java.lang.IllegalArgumentException("参数不能为空！");
		ClassLoader loader = cls.getClassLoader();
		// 获得类的全名，包括包名
		String clsName = cls.getName() + ".class";
		// 获得传入参数所在的包
		Package pack = cls.getPackage();
		String path = "";
		// 如果不是匿名包，将包名转化为路径
		if (pack != null) {
			String packName = pack.getName();
			// 此处简单判定是否是Java基础类库，防止用户传入JDK内置的类库
			if (packName.startsWith("java.") || packName.startsWith("javax."))
				throw new java.lang.IllegalArgumentException("不要传送系统类！");
			// 在类的名称中，去掉包名的部分，获得类的文件名
			clsName = clsName.substring(packName.length() + 1);
			// 判定包名是否是简单包名，如果是，则直接将包名转换为路径，
			if (packName.indexOf(".") < 0)
				path = packName + "/";
			else {// 否则按照包名的组成部分，将包名转换为路径
				int start = 0, end = 0;
				end = packName.indexOf(".");
				while (end != -1) {
					path = path + packName.substring(start, end) + "/";
					start = end + 1;
					end = packName.indexOf(".", start);
				}
				path = path + packName.substring(start) + "/";
			}
		}
		// 调用ClassLoader的getResource方法，传入包含路径信息的类文件名
		java.net.URL url = loader.getResource(path + clsName);
		// 从URL对象中获取路径信息
		String realPath = url.getPath();
		// 去掉路径信息中的协议名"file:"
		int pos = realPath.indexOf("file:");
		if (pos > -1)
			realPath = realPath.substring(pos + 5);
		// 去掉路径信息最后包含类文件信息的部分，得到类所在的路径
		pos = realPath.indexOf(path + clsName);
		realPath = realPath.substring(0, pos - 1);
		// 如果类文件被打包到JAR等文件中时，去掉对应的JAR等打包文件名
		if (realPath.endsWith("!"))
			realPath = realPath.substring(0, realPath.lastIndexOf("/"));
		/*------------------------------------------------------------ 
		 ClassLoader的getResource方法使用了utf-8对路径信息进行了编码，当路径 
		  中存在中文和空格时，他会对这些字符进行转换，这样，得到的往往不是我们想要 
		  的真实路径，在此，调用了URLDecoder的decode方法进行解码，以便得到原始的 
		  中文及空格路径 
		-------------------------------------------------------------*/
		try {
			realPath = java.net.URLDecoder.decode(realPath, "utf-8");
		} catch (Exception e) {
			throw new RuntimeException(e);
		}
		org.jeecgframework.core.util.LogUtil.info("realPath----->"+realPath);
		return realPath;
	}



	/**
	 * 返回当前执行的方法路径
	 * @return
	 */
	public static String getMethodUrl() {
		StringBuffer sb = new StringBuffer();
		StackTraceElement[] stacks = new Throwable().getStackTrace();
		sb.append(stacks[1].getClassName()).append(".").append(
				stacks[1].getMethodName());
		return sb.toString();
	}
	
	
	public static void main(String[] args) {
		//org.jeecgframework.core.util.LogUtil.info(getAppPath(JeecgSqlUtil.class));
		org.jeecgframework.core.util.LogUtil.info(getCountSqlBySql("SELECT * 	from JEECG_DICT_PARAM WHERE 1=1"));
	}

	/**
	 * 根据当前SQL，拼装出查询总数的SQL
	 * 
	 * @param sql 当前SQL语句
	 * @return
	 */
	public static String getCountSqlBySql(String sql) {
		String countSql = "SELECT COUNT(*)  ";
		
		String upperSql = sql.toUpperCase();
		int fromIndex = upperSql.indexOf("FROM");
		int whereIndex = upperSql.indexOf("WHERE");
		
		if (whereIndex>-1) {
			countSql=countSql + sql.substring(fromIndex, whereIndex);
		}else {
			countSql=countSql + sql.substring(fromIndex);
		}
		return countSql;
		
	}
	
}
