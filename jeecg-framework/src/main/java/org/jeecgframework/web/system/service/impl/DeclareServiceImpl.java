package org.jeecgframework.web.system.service.impl;

import java.util.List;

import org.jeecgframework.web.system.pojo.base.TSAttachment;
import org.jeecgframework.web.system.service.DeclareService;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service("declareService")
@Transactional
public class DeclareServiceImpl extends CommonServiceImpl implements DeclareService {

	public List<TSAttachment> getAttachmentsByCode(String businessKey,String description)
	{

		String hql="from TSAttachment t where t.businessKey= ? and t.description = ?";
		return commonDao.findHql(hql,businessKey,description);

	}
	
}
