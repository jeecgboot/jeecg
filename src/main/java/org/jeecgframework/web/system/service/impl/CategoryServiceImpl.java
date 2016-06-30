package org.jeecgframework.web.system.service.impl;

import java.util.List;
import java.util.Map;

import org.jeecgframework.core.common.dao.jdbc.JdbcDao;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.YouBianCodeUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.system.pojo.base.TSCategoryEntity;
import org.jeecgframework.web.system.service.CategoryServiceI;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("tSCategoryService")
@Transactional
public class CategoryServiceImpl extends CommonServiceImpl implements
		CategoryServiceI {

//	private static final String MAX_SQL = "SELECT MAX(code) FROM t_s_category WHERE parent_code";

	@Override
	public void saveCategory(TSCategoryEntity category) {

		String parentCode = null;
		if(category.getParent()!=null&&oConvertUtils.isNotEmpty(category.getParent().getCode())){
			parentCode = category.getParent().getCode();
			String localMaxCode  = getMaxLocalCode(parentCode);
			category.setCode(YouBianCodeUtil.getSubYouBianCode(parentCode, localMaxCode));
		}else{
			String localMaxCode  = getMaxLocalCode(null);
			category.setParent(null);
			category.setCode(YouBianCodeUtil.getNextYouBianCode(localMaxCode));
		}

		this.save(category);
	}
	
	private synchronized String getMaxLocalCode(String parentCode){
		if(oConvertUtils.isEmpty(parentCode)){
			parentCode = "";
		}
		int localCodeLength = parentCode.length() + YouBianCodeUtil.zhanweiLength;
		StringBuilder sb = new StringBuilder();

		if(ResourceUtil.getJdbcUrl().indexOf(JdbcDao.DATABSE_TYPE_SQLSERVER)!=-1){
			sb.append("SELECT code FROM t_s_category");
			sb.append(" where LEN(code) = ").append(localCodeLength);
		}else{
			sb.append("SELECT code FROM t_s_category");
			sb.append(" where LENGTH(code) = ").append(localCodeLength);
		}

		if(oConvertUtils.isNotEmpty(parentCode)){
			sb.append(" and  code like '").append(parentCode).append("%'");
		}

		sb.append(" ORDER BY code DESC ");
		List<Map<String, Object>> objMapList = this.findForJdbc(sb.toString(), 1, 1);
		String returnCode = null;
		if(objMapList!=null&& objMapList.size()>0){
			returnCode = (String)objMapList.get(0).get("code");
		}

		return returnCode;
	}

//	/**
//	 * 获取类型编码 加锁防止并发问题
//	 * 
//	 * @param category
//	 * @return
//	 */
//	private synchronized String getCategoryCoade(TSCategoryEntity category) {
//		Long maxCode = null;
//		//step 1 顶级code只按照序列增长
//		if (category.getParent() == null
//				|| StringUtils.isEmpty(category.getParent().getCode())) {
//			category.setParent(null);
//			maxCode = this.getCountForJdbc(MAX_SQL + " IS NULL");
//			maxCode = maxCode == 0 ? 1 : maxCode + 1;
//			return String.format(
//					"%0"
//							+ Integer.valueOf(ResourceUtil
//									.getConfigByName("categoryCodeLengthType"))
//							+ "d", maxCode);
//		}
//		//step 2按照下级序列向上排序
//		TSCategoryEntity parent = this.findUniqueByProperty(TSCategoryEntity.class,"code", category
//				.getParent().getCode());
//		//防止hibernate缓存持久化异常
//		category.setParent(parent);
//		maxCode = this.getCountForJdbc(MAX_SQL + " = '"
//				+ category.getParent().getCode()+"' and code like '"+ category.getParent().getCode()+"%'");
//		maxCode = maxCode == 0 ? 1 : Long.valueOf(maxCode.toString()
//				.substring(parent.getCode().length())) + 1;
//		return parent.getCode()
//				+ String.format(
//						"%0"
//								+ Integer.valueOf(ResourceUtil
//										.getConfigByName("categoryCodeLengthType"))
//								+ "d", maxCode);
//	}
}