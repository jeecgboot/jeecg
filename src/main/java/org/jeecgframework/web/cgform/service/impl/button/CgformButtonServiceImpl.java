package org.jeecgframework.web.cgform.service.impl.button;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.jeecgframework.web.cgform.entity.button.CgformButtonEntity;
import org.jeecgframework.web.cgform.service.button.CgformButtonServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;

@Service("cgformButtonService")
@Transactional
public class CgformButtonServiceImpl extends CommonServiceImpl implements CgformButtonServiceI {

	/**
	 * 查询按钮list
	 * @param formId
	 * @return
	 */
	
	public List<CgformButtonEntity> getCgformButtonListByFormId(String formId) {
		StringBuilder hql = new StringBuilder("");
		hql.append(" from CgformButtonEntity t");
		hql.append(" where t.formId=? order by t.orderNum asc");
		List<CgformButtonEntity> list = this.findHql(hql.toString(), formId);
		return list;
	}
	
	/**
	 * 校验按钮唯一性
	 * @param cgformButtonEntity
	 * @return
	 */
	
	public List<CgformButtonEntity> checkCgformButton(CgformButtonEntity cgformButtonEntity) {
		StringBuilder hql = new StringBuilder("");
		hql.append(" from CgformButtonEntity t");
		hql.append(" where t.formId='").append(cgformButtonEntity.getFormId()).append("'");
		hql.append(" and  t.buttonCode ='").append(cgformButtonEntity.getButtonCode()).append("'");
		if(cgformButtonEntity.getId()!=null){
			hql.append(" and t.id !='").append(cgformButtonEntity.getId()).append("'");
		}
		List<CgformButtonEntity> list = this.findHql(hql.toString());
		return list;
	}

}