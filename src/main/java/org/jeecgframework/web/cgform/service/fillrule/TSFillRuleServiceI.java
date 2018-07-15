package org.jeecgframework.web.cgform.service.fillrule;
import org.jeecgframework.web.cgform.entity.fillrule.TSFillRuleEntity;
import org.jeecgframework.core.common.service.CommonService;

import java.io.Serializable;

public interface TSFillRuleServiceI extends CommonService{
	
 	public void delete(TSFillRuleEntity entity) throws Exception;
 	
 	public Serializable save(TSFillRuleEntity entity) throws Exception;
 	
 	public void saveOrUpdate(TSFillRuleEntity entity) throws Exception;
 	
}
