package org.jeecgframework.web.demo.service.test;

import org.jeecgframework.core.common.service.CommonService;
import org.springframework.web.multipart.MultipartFile;

public interface JeecgBlobDataServiceI extends CommonService{
	public void saveObj(String documentTitle, MultipartFile file);

}
