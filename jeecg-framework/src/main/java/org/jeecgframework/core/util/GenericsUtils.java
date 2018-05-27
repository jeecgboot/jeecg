package org.jeecgframework.core.util;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

/**
 * 泛型工具类
 * 
 * @author <a href="http://www.blogjava.net/lishunli/"
 *         target="_jeecg">ShunLi</a>
 * @notes Created on 2010-1-21<br>
 *        Revision of last commit:$Revision: 1.1 $<br>
 *        Author of last commit:$Author: ghp $<br>
 *        Date of last commit:$Date: 2010-01-25 16:48:17 +0800 (周一, 25 一月 2010)
 *        $<br>
 *        <p>
 */
public class GenericsUtils {
	/**
	 * 通过反射,获得指定类的父类的泛型参数的实际类型. 如BuyerServiceBean extends DaoSupport<Buyer>
	 * 
	 * @param clazz
	 *            clazz 需要反射的类,该类必须继承范型父类
	 * @param index
	 *            泛型参数所在索引,从0开始.
	 * @return 范型参数的实际类型, 如果没有实现ParameterizedType接口，即不支持泛型，所以直接返回
	 *         <code>Object.class</code>
	 */
	@SuppressWarnings("unchecked")
	public static Class getSuperClassGenricType(Class clazz, int index) {
		Type genType = clazz.getGenericSuperclass();// 得到泛型父类
		// 如果没有实现ParameterizedType接口，即不支持泛型，直接返回Object.class
		if (!(genType instanceof ParameterizedType)) {
			return Object.class;
		}
		// 返回表示此类型实际类型参数的Type对象的数组,数组里放的都是对应类型的Class, 如BuyerServiceBean extends
		// DaoSupport<Buyer,Contact>就返回Buyer和Contact类型
		Type[] params = ((ParameterizedType) genType).getActualTypeArguments();
		if (index >= params.length || index < 0) {
			throw new RuntimeException("你输入的索引" + (index < 0 ? "不能小于0" : "超出了参数的总数"));
		}
		if (!(params[index] instanceof Class)) {
			return Object.class;
		}
		return (Class) params[index];
	}

	/**
	 * 通过反射,获得指定类的父类的第一个泛型参数的实际类型. 如BuyerServiceBean extends DaoSupport<Buyer>
	 * 
	 * @param clazz
	 *            clazz 需要反射的类,该类必须继承泛型父类
	 * @return 泛型参数的实际类型, 如果没有实现ParameterizedType接口，即不支持泛型，所以直接返回
	 *         <code>Object.class</code>
	 */
	@SuppressWarnings("unchecked")
	public static Class getSuperClassGenricType(Class clazz) {
		return getSuperClassGenricType(clazz, 0);
	}

	/**
	 * 通过反射,获得方法返回值泛型参数的实际类型. 如: public Map<String, Buyer> getNames(){}
	 * 
	 * @param Method
	 *            method 方法
	 * @param int index 泛型参数所在索引,从0开始.
	 * @return 泛型参数的实际类型, 如果没有实现ParameterizedType接口，即不支持泛型，所以直接返回
	 *         <code>Object.class</code>
	 */
	@SuppressWarnings("unchecked")
	public static Class getMethodGenericReturnType(Method method, int index) {
		Type returnType = method.getGenericReturnType();
		if (returnType instanceof ParameterizedType) {
			ParameterizedType type = (ParameterizedType) returnType;
			Type[] typeArguments = type.getActualTypeArguments();
			if (index >= typeArguments.length || index < 0) {
				throw new RuntimeException("你输入的索引" + (index < 0 ? "不能小于0" : "超出了参数的总数"));
			}
			return (Class) typeArguments[index];
		}
		return Object.class;
	}

	/**
	 * 通过反射,获得方法返回值第一个泛型参数的实际类型. 如: public Map<String, Buyer> getNames(){}
	 * 
	 * @param Method
	 *            method 方法
	 * @return 泛型参数的实际类型, 如果没有实现ParameterizedType接口，即不支持泛型，所以直接返回
	 *         <code>Object.class</code>
	 */
	@SuppressWarnings("unchecked")
	public static Class getMethodGenericReturnType(Method method) {
		return getMethodGenericReturnType(method, 0);
	}

	/**
	 * 通过反射,获得方法输入参数第index个输入参数的所有泛型参数的实际类型. 如: public void add(Map<String,
	 * Buyer> maps, List<String> names){}
	 * 
	 * @param Method
	 *            method 方法
	 * @param int index 第几个输入参数
	 * @return 输入参数的泛型参数的实际类型集合, 如果没有实现ParameterizedType接口，即不支持泛型，所以直接返回空集合
	 */
	@SuppressWarnings("unchecked")
	public static List<Class> getMethodGenericParameterTypes(Method method, int index) {
		List<Class> results = new ArrayList<Class>();
		Type[] genericParameterTypes = method.getGenericParameterTypes();
		if (index >= genericParameterTypes.length || index < 0) {
			throw new RuntimeException("你输入的索引" + (index < 0 ? "不能小于0" : "超出了参数的总数"));
		}
		Type genericParameterType = genericParameterTypes[index];
		if (genericParameterType instanceof ParameterizedType) {
			ParameterizedType aType = (ParameterizedType) genericParameterType;
			Type[] parameterArgTypes = aType.getActualTypeArguments();
			for (Type parameterArgType : parameterArgTypes) {
				Class parameterArgClass = (Class) parameterArgType;
				results.add(parameterArgClass);
			}
			return results;
		}
		return results;
	}

	/**
	 * 通过反射,获得方法输入参数第一个输入参数的所有泛型参数的实际类型. 如: public void add(Map<String, Buyer>
	 * maps, List<String> names){}
	 * 
	 * @param Method
	 *            method 方法
	 * @return 输入参数的泛型参数的实际类型集合, 如果没有实现ParameterizedType接口，即不支持泛型，所以直接返回空集合
	 */
	@SuppressWarnings("unchecked")
	public static List<Class> getMethodGenericParameterTypes(Method method) {
		return getMethodGenericParameterTypes(method, 0);
	}

	/**
	 * 通过反射,获得Field泛型参数的实际类型. 如: public Map<String, Buyer> names;
	 * 
	 * @param Field
	 *            field 字段
	 * @param int index 泛型参数所在索引,从0开始.
	 * @return 泛型参数的实际类型, 如果没有实现ParameterizedType接口，即不支持泛型，所以直接返回
	 *         <code>Object.class</code>
	 */
	@SuppressWarnings("unchecked")
	public static Class getFieldGenericType(Field field, int index) {
		Type genericFieldType = field.getGenericType();

		if (genericFieldType instanceof ParameterizedType) {
			ParameterizedType aType = (ParameterizedType) genericFieldType;
			Type[] fieldArgTypes = aType.getActualTypeArguments();
			if (index >= fieldArgTypes.length || index < 0) {
				throw new RuntimeException("你输入的索引" + (index < 0 ? "不能小于0" : "超出了参数的总数"));
			}
			return (Class) fieldArgTypes[index];
		}
		return Object.class;
	}

	/**
	 * 通过反射,获得Field泛型参数的实际类型. 如: public Map<String, Buyer> names;
	 * 
	 * @param Field
	 *            field 字段
	 * @param int index 泛型参数所在索引,从0开始.
	 * @return 泛型参数的实际类型, 如果没有实现ParameterizedType接口，即不支持泛型，所以直接返回
	 *         <code>Object.class</code>
	 */
	@SuppressWarnings("unchecked")
	public static Class getFieldGenericType(Field field) {
		return getFieldGenericType(field, 0);
	}
/**
 * 根据实体得到实体的所有属性
 * @param objClass
 * @return
 * @throws ClassNotFoundException
 */
	public static String[] getColumnNames(String objClass) throws ClassNotFoundException {
		String[] wageStrArray = null;
		if (objClass != null) {
			Class class1 = Class.forName(objClass);
			Field[] field = class1.getDeclaredFields();// 这里便是获得实体Bean中所有属性的方法
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < field.length; i++) {// 这里不多说了

				sb.append(field[i].getName());

				// 这是分割符 是为了去掉最后那个逗号

				// 比如 如果不去最后那个逗号 最后打印出来的结果是 "id,name,"

				// 去了以后打印出来的是 "id,name"
				if (i < field.length - 1) {
					sb.append(",");

				}
			}

			// split(",");这是根据逗号来切割字符串使字符串变成一个数组

			wageStrArray = sb.toString().split(",");
			return wageStrArray;
		} else {
			return wageStrArray;
		}
	}
	public static Object[] field2Value(Field[] f, Object o) throws Exception {
		Object[] value = new Object[f.length];
		for (int i = 0; i < f.length; i++) {
			value[i] = f[i].get(o);
		}
		return value;
	}
	/**
     * returns the current http session object
     * 
     * @return session
     */
    public HttpSession getSession() {   
    	HttpSession session=null;
        ServletRequestAttributes attr = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
        HttpSession contextSess = attr == null ? session : attr.getRequest().getSession(true);
        
        return contextSess; 
    }
    /**
	 * 得到实体类
	 * @param objClass 实体类包含包名
	 * @return
	 */
	 public static  Class getEntityClass(String objClass){
		 Class entityClass = null;
		try {
			entityClass = Class.forName(objClass);
		} catch (ClassNotFoundException e) {			
			e.printStackTrace();
		} 
		 return entityClass;
	 }  
	 
	 /**
		 * 定义字符集
		 * @param 
		 * @return
		 */
	private static char[] chars = { '0', '1', '2', '3', '4', '5', '6', '7', 
		     '8', '9', 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 
		     'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 
		     'y', 'z', 'A', 'B','C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 
		     'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 
		     'Z'};    //72个字符集 

		   /** 
		   * 
		   * @param passLength 
		   *            随机密码长度 
		   * @param count 
		   *            随机密码个数 
		   * @return 随机密码数组 
		   */ 
		   public static String getPasswords(int passLength) { 
		    String passwords = "";// 新建一个长度为指定需要密码个数的字符串数组 
		    Random random = new Random(); 
		    StringBuilder password = new StringBuilder("");// 保存生成密码的变量 
		    for (int m = 1; m <= passLength; m++) {// 内循环 从1开始到密码长度 正式开始生成密码 
		      password.append(chars[random.nextInt(62)]);// 为密码变量随机增加上面字符中的一个 
		    } 
		    passwords = password.toString();// 将生成出来的密码赋值给密码数组 
		    return passwords; 
		   } 


}
