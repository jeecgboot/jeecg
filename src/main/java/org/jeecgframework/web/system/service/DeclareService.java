package org.jeecgframework.web.system.service;

import java.util.List;

import org.jeecgframework.web.system.pojo.base.TSAttachment;

import org.jeecgframework.core.common.service.CommonService;

/**
 * 
 * @author  张代浩
 *
 */
public interface DeclareService extends CommonService{
	
	public List<TSAttachment> getAttachmentsByCode(String businessKey,String description);
	
}
