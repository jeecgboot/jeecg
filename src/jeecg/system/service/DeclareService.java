package jeecg.system.service;

import java.util.List;

import jeecg.system.pojo.base.TSAttachment;

import org.jeecgframework.core.common.service.CommonService;


public interface DeclareService extends CommonService{
	
	public List<TSAttachment> getAttachmentsByCode(String businessKey,String description);
	
}
