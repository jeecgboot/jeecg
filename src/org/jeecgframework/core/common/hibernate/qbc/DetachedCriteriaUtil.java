package org.jeecgframework.core.common.hibernate.qbc;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.hibernate.FetchMode;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Projection;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.transform.Transformers;
import org.jeecgframework.core.util.ContextHolderUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.StringUtil;



/**
 * 拼装Hibernate条件
 */
public class DetachedCriteriaUtil {
	
	/** 小写字母X */
	public static final String MIDDLE_SEPRATOR_CHAR = "x";
	/** 两个空格 */
	public static final String SEPARATOR_TWO_SPACE = "  ";// 两个空格，避免和"日期 时间"中的空格混淆
	/** 此字符串内容为"  <=  x  <=  "，不包括引号 */
	static public ProjectionList projectionList;
		

	public static ProjectionList getProjectionList() {
		return projectionList;
	}

	private DetachedCriteriaUtil(){
		//do not allow to create Object
	}
	
	/**
	 * 自动拼装条件 2008-11-3
	 * 
	 * @author 苍鹰
	 * @param pojoClazz
	 *            实体类名
	 * @param startChar
	 *            参数统一的开始字符
	 * @param alias
	 *            别名
	 * @return DetachedCriteria 组装好的查询条件
	 */
	public static DetachedCriteria createDetachedCriteria(Class<?> pojoClazz,
			String startChar,String alias) {
		return createDetachedCriteria(pojoClazz, startChar, alias,null);
	}
	
	/**
	 * 自动拼装条件 2008-11-3
	 * 
	 * @author 苍鹰
	 * @param pojoClazz
	 *            实体类名
	 * @param startChar
	 *            参数统一的开始字符
	 * @param alias
	 *            别名
	 * @param columnNames
	 *            作为select子句的属性名集合
	 * @return DetachedCriteria 组装好的查询条件
	 */
	public static DetachedCriteria createDetachedCriteria(Class<?> pojoClazz,
			String startChar,String alias,String[] columnNames) {
		return createDetachedCriteria(pojoClazz, startChar, alias, columnNames, null);
	}
	
	/**
	 * 自动拼装条件 2008-11-3
	 * 
	 * @author 苍鹰
	 * @param pojoClazz
	 *            实体类名
	 * @param startChar
	 *            参数统一的开始字符
	 * @param columnNames
	 *            作为select子句的属性名集合
	 * @param excludeParameters
	 *            不作为查询条件的参数
	 * @param alias
	 *            别名
	 * @return DetachedCriteria 组装好的查询条件
	 */
	public static DetachedCriteria createDetachedCriteria(Class<?> pojoClazz,
			String startChar,String alias,String[] columnNames,String[] excludeParameters) {
		DetachedCriteria criteria = DetachedCriteria.forClass(pojoClazz,alias);
		if(columnNames!=null && columnNames.length>0){
			//selectColumn(criteria, columnNames, pojoClazz, false);
		}
		return criteria;
	}
	
	private static final String ALIAS_KEY_IN_REQUEST = "ALIAS_KEY_IN_REQUEST";
	private static final String HAS_JOIN_TABLE_KEY_IN_REQUEST = "HAS_JOIN_TABLE_KEY_IN_REQUEST";
	
	private static void setAliasToRequest(HttpServletRequest request,Set<String> aliases) {
		request.setAttribute(ALIAS_KEY_IN_REQUEST, aliases);
	}
	
	@SuppressWarnings("unchecked")
	private static Set<String> getAliasesFromRequest(){
		Set<String> aliases = (Set<String>) ContextHolderUtils.getRequest().getAttribute(ALIAS_KEY_IN_REQUEST);
		if(aliases==null){
			aliases = new HashSet<String>(5);
			setAliasToRequest(ContextHolderUtils.getRequest(), aliases);
		}
		return aliases;
	}
	
	private static boolean getHasJoinTatleFromRequest(){
		Boolean hasJoin = (Boolean) ContextHolderUtils.getRequest().getAttribute(HAS_JOIN_TABLE_KEY_IN_REQUEST);
		return hasJoin==null?false:hasJoin;
	}
	


	
	/**
	 * 该方法提供DetachedCriteria对查询字段的封装， 2008-9-29
	 * 2009.9.9修改后，可支持无限级联取部分字段，如取如下字段 
	 * user.organization.parentOrganization.parentOrganization.orgName
	 * 但请注意1点 ,连接采用内联，级联越多，结果集可能就越少；
	 * @author
	 * @param columnNames
	 *            字符串数组，以数据的形式接收要查询的字段属性，如String[] column={"属性1","属性2","属性3"};
	 * @param pojoClass
	 *            实体类的Class,如Mobile.class;
	 * @param aials
	 *            为要查询的POJO对象指定一个别名
	 * @return DetachedCriteria 的一个对象，如果需要查询条件，在些对象后追加查询条件。
	 * 
	 * @param forJoinTable 是否多表连接查询
	 */
	public static void selectColumn(DetachedCriteria criteria, String[] columnNames,
			Class<?> pojoClass,boolean forJoinTable) {
		if (null == columnNames) {
			return;
		}
	
		//使用这个临时变量集合，是因为dinstinct关键字要放在最前面，而distinct关键字要在下面才决定放不放，
		List<Projection> tempProjectionList = new ArrayList<Projection>();
		
		Set<String> aliases = getAliasesFromRequest();
		boolean hasJoniTable = false;
		String rootAlias = criteria.getAlias();
		for (String property : columnNames) {
			if(property.contains("_")){
				String[] propertyChain = property.split("_");
				createAlias(criteria,rootAlias,aliases,propertyChain,0);
				tempProjectionList.add(Projections.property(StringUtil.getProperty(property)).as(StringUtil.getProperty(property)));
				hasJoniTable = true;
			}else{
				tempProjectionList.add(Projections.property(rootAlias + POINT + property).as(property));
			}
		}
		
		 projectionList = Projections.projectionList();
		if(hasJoniTable || forJoinTable ||  getHasJoinTatleFromRequest()){//这个一定要放在tempProjectionList的前面，因为distinct要在最前面
			projectionList.add(Projections.distinct(Projections.id()));
		}
		
		for (Projection proj : tempProjectionList) {
			projectionList.add(proj);
		}
		
		criteria.setProjection(projectionList);
		
		
		if(!hasJoniTable){
			criteria.setResultTransformer(Transformers.aliasToBean(pojoClass));
		}else{//下面这个是自定义的结果转换器
			criteria.setResultTransformer(new AliasToBean(pojoClass));
		}
	}
	
	private static final String POINT = ".";
	
	/**
	 * 创建别名
	 * @author 苍鹰
	 * 2009-9-9
	 * @param criteria
	 * @param rootAlais
	 * @param aliases
	 * @param columns
	 * @param currentStep
	 */
	private static void createAlias(DetachedCriteria criteria, String rootAlais, Set<String> aliases,String[] columns,int currentStep){
		if(currentStep<columns.length-1){
			if(!aliases.contains(converArrayToAlias(columns, currentStep))){
				if(currentStep>0){
					criteria.createAlias(converArrayToAlias(columns, currentStep-1) + POINT +columns[currentStep], converArrayToAlias(columns, currentStep)).setFetchMode(columns[currentStep], FetchMode.JOIN);
				}else{
					criteria.createAlias(rootAlais + POINT +columns[currentStep], converArrayToAlias(columns, currentStep)).setFetchMode(columns[currentStep], FetchMode.JOIN);
				}
				aliases.add(converArrayToAlias(columns, currentStep));
			}
			currentStep++;
			createAlias(criteria, rootAlais, aliases, columns, currentStep);
		}
	}
	
	
	/**
	 * 从"organization.parentOrganization.parentOrganization.parentOrganization.id" 得到 
	 * "organization_parentOrganization_parentOrganization_parentOrganization.id"
	 * @author 苍鹰
	 * 2009-9-20
	 * @param property
	 * @return
	 */
	public static String getAliasFromPropertyChainString(String property){
		if(property.contains(".")){
			return property.substring(0, property.lastIndexOf(POINT)).replaceAll("\\.", "_") + property.substring(property.lastIndexOf(POINT));
			
		}
		return property;
	}
	
	/**
	 * 从数组中创建ALIAS
	 * @author 苍鹰
	 * 2009-9-10
	 * @param columns
	 * @param currentStep
	 * @return
	 */
	private static String converArrayToAlias(String[] columns,int currentStep){
		StringBuilder alias = new StringBuilder();
		for (int i = 0; i <= currentStep; i++) {
			if(alias.length()>0){
				alias.append("_");
			}
			alias.append(columns[i]);
		}
		return alias.toString();
	}
	
	
	
	
}
