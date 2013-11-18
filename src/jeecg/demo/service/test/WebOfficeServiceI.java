package jeecg.demo.service.test;

import jeecg.demo.entity.test.WebOfficeEntity;

import org.jeecgframework.core.common.service.CommonService;
import org.springframework.web.multipart.MultipartFile;

public interface WebOfficeServiceI extends CommonService{
	public void saveObj(WebOfficeEntity docObj, MultipartFile file);
}
