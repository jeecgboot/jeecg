package org.jeecgframework.core.extend.hqlsearch;

import java.beans.PropertyDescriptor;
import java.util.Date;
import java.util.Map;

import org.apache.commons.beanutils.PropertyUtils;
import org.apache.log4j.Logger;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.util.StringUtil;


public class HqlGenerateUtil {
	
	private static final String SUFFIX_COMMA = ",";
	private static final String SUFFIX_KG = " ";
	/**模糊查询符号*/
	private static final String SUFFIX_ASTERISK = "*";
	private static final String SUFFIX_ASTERISK_VAGUE = "%";
	/**不等于查询符号*/
	private static final String SUFFIX_NOT_EQUAL = "!";
	private static final String SUFFIX_NOT_EQUAL_NULL = "!NULL";
	
	/**时间查询符号*/
	private static final String END = "end";
	private static final String BEGIN = "begin";
	private static final Logger logger = Logger.getLogger(HqlGenerateUtil.class);
	

	
	/**
  	 * 自动生成查询条件HQL
  	 * 模糊查询
  	 * 【只对Integer类型和String类型的字段自动生成查询条件】
  	 * @param hql
  	 * @param values
  	 * @param searchObj
  	 * @throws Exception
  	 */
  	public static void installHql(CriteriaQuery cq,Object searchObj){
  		PropertyDescriptor origDescriptors[] = PropertyUtils.getPropertyDescriptors(searchObj);
  		// 获得对象属性中的name 
  		String descriptorsNames = getDescriptorsNames(origDescriptors);
  		
        for (int i = 0; i < origDescriptors.length; i++) {
            String name = origDescriptors[i].getName();
            String type = origDescriptors[i].getPropertyType().toString();
            
            if ("class".equals(name)||"ids".equals(name)||"page".equals(name)
            		||"rows".equals(name)||"sort".equals(name)||"order".equals(name)) {
                continue; // No point in trying to set an object's class
            }
            try {
            if (PropertyUtils.isReadable(searchObj, name)) {
               if("class java.lang.String".equals(type)){
            	   Object value = PropertyUtils.getSimpleProperty(searchObj, name);
            	   String searchValue = null;
            	   if(value!=null){
            		    searchValue = value.toString().trim();
            	   }else{
            		   continue;
            	   }
            	   if(searchValue!=null&&!"".equals(searchValue)){
            		   //[1].In 多个条件查询{逗号隔开参数}
            		   if(searchValue.indexOf(SUFFIX_COMMA)>=0){
            			   //页面输入查询条件，情况（取消字段的默认条件）
            			   if(searchValue.indexOf(SUFFIX_KG)>=0){
            				   String val = searchValue.substring(searchValue.indexOf(SUFFIX_KG));
            				   cq.eq(name, val);
            			   }else{
            				   String[] vs = searchValue.split(SUFFIX_COMMA);
                			   cq.in(name, vs);
            			   }
            		   }
            		   //[2].模糊查询{带有* 星号的参数}
            		   else if(searchValue.indexOf(SUFFIX_ASTERISK)>=0){
            			   cq.like(name, searchValue.replace(SUFFIX_ASTERISK, SUFFIX_ASTERISK_VAGUE));
            		   }
            		   //[3].不匹配查询{等于！叹号}
            		   //(1).不为空字符串
            		   else if(searchValue.equals(SUFFIX_NOT_EQUAL)){
            			   cq.isNotNull(name);
            		   }
            		   //(2).不为NULL
            		   else if(searchValue.toUpperCase().equals(SUFFIX_NOT_EQUAL_NULL)){
            			   cq.isNotNull(name);
            		   }
            		   //(3).正常不匹配
            		   else if(searchValue.indexOf(SUFFIX_NOT_EQUAL)>=0){
            			   cq.notEq(name, searchValue.replace(SUFFIX_NOT_EQUAL, ""));
            		   }
            		   //[4].全匹配查询{没有特殊符号的参数}
            		   else{
            			   cq.eq(name, searchValue);
            		   }
            	   }
               }else if("class java.lang.Integer".equals(type)){
            	   Object value = PropertyUtils.getSimpleProperty(searchObj, name);
            	   if(value!=null&&!"".equals(value)){
            		   cq.eq(name, value);
            	   }
               } else if("class java.math.BigDecimal".equals(type)){
            	   Object value = PropertyUtils.getSimpleProperty(searchObj, name);
            	   if(value!=null&&!"".equals(value)){
            		   cq.eq(name, value);
            	   }
               }else if("class java.lang.Short".equals(type)){
            	   Object value = PropertyUtils.getSimpleProperty(searchObj, name);
            	   if(value!=null&&!"".equals(value)){
            		   cq.eq(name, value);
            	   }
               }else if("class java.lang.Double".equals(type)){
            	   Object value = PropertyUtils.getSimpleProperty(searchObj, name);
            	   if(value!=null&&!"".equals(value)){
            		   cq.eq(name, value);
            	   }
               }   
               else if("class java.lang.Long".equals(type)){
            	   Object value = PropertyUtils.getSimpleProperty(searchObj, name);
            	   if(value!=null&&!"".equals(value)){
            		   cq.eq(name, value);
            	   }
               }else if ("class java.util.Date".equals(type)) {
					Date value = (Date) PropertyUtils.getSimpleProperty(searchObj, name);
					if (null != value) {
						// 判断开始时间
						if (name.contains(BEGIN)) {
							String realName = StringUtil.firstLowerCase(name.substring(5, name.length()));
							if (!BEGIN.equals(name.substring(0, 5)) || !descriptorsNames.contains(realName)) {
								logger.error("该查询属性 [" + name + "] 命名不规则");
							} else {
								cq.ge(realName, value);
							}
						}
						// 判断结束时间
						else if (name.contains(END)) {
							String realName = StringUtil.firstLowerCase(name.substring(3, name.length()));
							if (!END.equals(name.substring(0, 3)) || !descriptorsNames.contains(realName)) {
								logger.error("该查询属性 [" + name + "] 命名不规则");
							} else {
								cq.le(name, value);
							}
						}
						else {
							  cq.eq(name, value);
						}
					 }
                  }
               }
            } catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
        }
        //添加选择条件
        cq.add();
  	}
  	/*
  	 * 下面的方法是重载 org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(CriteriaQuery, Object)
  	 * 其目的是拓展区间查询功能
  	 * 注：
  	 * 	重载此方法后修改了模版 controllerTemplate.ftl#datagrid()
  	 * 	将第二行<br/>
  	 * 		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, ${entityName?uncap_first});
  	 * 	改为<br/>
  	 * 		org.jeecgframework.core.extend.hqlsearch.HqlGenerateUtil.installHql(cq, ${entityName?uncap_first}, request.getParameterMap());
  	 * 	因模版里不方便注释，故在此处说明
  	 */
  	/**
  	 * 自动生成查询条件HQL（扩展区间查询功能）
  	 * @param cq
  	 * @param searchObj
  	 * @param parameterMap 	request参数集合，封装了所有查询信息
  	 */
  	public static void installHql(CriteriaQuery cq,Object searchObj, Map<String, String[]> parameterMap){
  		installHalJoinAlias(cq, searchObj, "");
  		//添加选择条件
  		cq.add();
  	}
  	
  	private static void installHalJoinAlias(CriteriaQuery cq, Object searchObj,
			String alias) {
		PropertyDescriptor origDescriptors[] = PropertyUtils
				.getPropertyDescriptors(searchObj);
		// 获得对象属性中的name
		String descriptorsNames = getDescriptorsNames(origDescriptors);
		for (int i = 0; i < origDescriptors.length; i++) {
			String aliasName = (alias.equals("") ? "" : alias + ".")
					+ origDescriptors[i].getName();
			String name = origDescriptors[i].getName();
			String type = origDescriptors[i].getPropertyType().toString();

			if ("class".equals(name) || "ids".equals(name)
					|| "page".equals(name) || "rows".equals(name)
					|| "sort".equals(name) || "order".equals(name)) {
				continue; // No point in trying to set an object's class
			}
			try {
				if (PropertyUtils.isReadable(searchObj, name)) {
					if ("class java.lang.String".equals(type)) {
						Object value = PropertyUtils.getSimpleProperty(
								searchObj, name);
						String searchValue = null;
						if (value != null) {
							searchValue = value.toString().trim();
						} else {
							continue;
						}
						if (searchValue != null && !"".equals(searchValue)) {
							// [1].In 多个条件查询{逗号隔开参数}
							if (searchValue.indexOf(SUFFIX_COMMA) >= 0) {
								// 页面输入查询条件，情况（取消字段的默认条件）
								if (searchValue.indexOf(SUFFIX_KG) >= 0) {
									String val = searchValue
											.substring(searchValue
													.indexOf(SUFFIX_KG));
									cq.eq(name, val);
								} else {
									String[] vs = searchValue
											.split(SUFFIX_COMMA);
									cq.in(aliasName, vs);
								}
							}
							// [2].模糊查询{带有* 星号的参数}
							else if (searchValue.indexOf(SUFFIX_ASTERISK) >= 0) {
								cq.like(aliasName, searchValue.replace(
										SUFFIX_ASTERISK, SUFFIX_ASTERISK_VAGUE));
							}
							// [3].不匹配查询{等于！叹号}
							// (1).不为空字符串
							else if (searchValue.equals(SUFFIX_NOT_EQUAL)) {
								cq.isNotNull(aliasName);
							}
							// (2).不为NULL
							else if (searchValue.toUpperCase().equals(
									SUFFIX_NOT_EQUAL_NULL)) {
								cq.isNotNull(aliasName);
							}
							// (3).正常不匹配
							else if (searchValue.indexOf(SUFFIX_NOT_EQUAL) >= 0) {
								cq.notEq(name, searchValue.replace(
										SUFFIX_NOT_EQUAL, ""));
							}
							// [4].全匹配查询{没有特殊符号的参数}
							else {
								cq.eq(aliasName, searchValue);
							}
						}
					} else if ("class java.lang.Integer".equals(type)) {
						Object value = PropertyUtils.getSimpleProperty(
								searchObj, name);
						if (StringUtil.isNotEmpty(value)) {
							cq.eq(aliasName, value);
						}
					} else if ("class java.math.BigDecimal".equals(type)) {
						// for：增加对bigDecimal数据的支持
						Object value = PropertyUtils.getSimpleProperty(
								searchObj, name);
						if (StringUtil.isNotEmpty(value)) {
							cq.eq(aliasName, value);
						}
						// for：增加对bigDecimal数据的支持
					} else if ("class java.lang.Short".equals(type)) {
						// #93 增加对SHORT数据的支持
						Object value = PropertyUtils.getSimpleProperty(
								searchObj, name);
						if (StringUtil.isNotEmpty(value)) {
							cq.eq(aliasName, value);
						}
						// #93增加对SHORT数据的支持
					} else if ("class java.lang.Long".equals(type)) {
						// #93 增加对LONG 数据的支持
						Object value = PropertyUtils.getSimpleProperty(
								searchObj, name);
						if (StringUtil.isNotEmpty(value)) {
							cq.eq(aliasName, value);
						}
						// #93 增加对LONG 数据的支持
					} else if ("class java.util.Date".equals(type)) {
						Date value = (Date) PropertyUtils.getSimpleProperty(
								searchObj, name);
						if (null != value) {
							// 判断开始时间
							if (name.contains(BEGIN)) {
								String realName = StringUtil
										.firstLowerCase(name.substring(5,
												name.length()));
								if (!BEGIN.equals(name.substring(0, 5))
										|| !descriptorsNames.contains(realName)) {
									logger.error("该查询属性 [" + name + "] 命名不规则");
								} else {
									cq.ge(realName, value);
								}
							}
							// 判断结束时间
							else if (name.contains(END)) {
								String realName = StringUtil
										.firstLowerCase(name.substring(3,
												name.length()));
								if (!END.equals(name.substring(0, 3))
										|| !descriptorsNames.contains(realName)) {
									logger.error("该查询属性 [" + name + "] 命名不规则");
								} else {
									cq.le(name, value);
								}
							} else {
								cq.eq(name, value);
							}
						}
					} else if (!StringUtil.isJavaClass(origDescriptors[i]
							.getPropertyType())) {
						Object param = PropertyUtils.getSimpleProperty(searchObj,
								name);
						if(itIsNotEmpty(param)){
							// 如果是实体类,创建别名,继续创建查询条件
							cq.createAlias(aliasName, aliasName);
							installHalJoinAlias(cq,param, aliasName);
						}
					}
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

	}
  	
  	/**
	 * 判断这个类是不是所以属性都为空
	 * @param param
	 * @return
	 */
	private static boolean itIsNotEmpty(Object param){
		boolean isNotEmpty = false;
		try{
			PropertyDescriptor origDescriptors[] = PropertyUtils
					.getPropertyDescriptors(param);
			String name;
			for (int i = 0; i < origDescriptors.length; i++) {
				name =  origDescriptors[i].getName();
				if ("class".equals(name)) {
					continue;
				}
				if (PropertyUtils.isReadable(param, name)&&
						StringUtil.isNotEmpty(PropertyUtils.getSimpleProperty(
								param,name))){
					isNotEmpty = true;
					break;
				}
			}
		}catch (Exception e){
			
		}
		return isNotEmpty;
	}
  	
  	
	/**
	 * 得到对象属性中所有name
	 * @param origDescriptors
	 * @return
	 */
  	private static String getDescriptorsNames(PropertyDescriptor origDescriptors[]) {
  		StringBuilder sb = new StringBuilder();
  		for (int i = 0; i < origDescriptors.length; i++) {
  			sb.append(origDescriptors[i].getName() + ",");
  		}
  		return sb.toString();
  	}
  	
  
}


