package org.jeecgframework.web.cgform.service.impl.enhance;

import java.util.List;

import org.jeecgframework.web.cgform.entity.enhance.CgformEnhanceJsEntity;
import org.jeecgframework.web.cgform.service.enhance.CgformEnhanceJsServiceI;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service("cgformenhanceJsService")
@Transactional
public class CgformEnhanceJsServiceImpl extends CommonServiceImpl implements CgformEnhanceJsServiceI {

	/**
	 * 根据cgJsType和formId查找数据
	 * @param cgJsType
	 * @param formId
	 * @return
	 */
	
	public CgformEnhanceJsEntity getCgformEnhanceJsByTypeFormId(String cgJsType, String formId) {
		StringBuilder hql = new StringBuilder("");
		hql.append(" from CgformEnhanceJsEntity t");

		hql.append(" where t.formId=?");
		hql.append(" and  t.cgJsType =?");
		List<CgformEnhanceJsEntity> list = this.findHql(hql.toString(),formId,cgJsType);

		if(list!=null&&list.size()>0){
			return list.get(0);
		}
		return null;
	}
	
}