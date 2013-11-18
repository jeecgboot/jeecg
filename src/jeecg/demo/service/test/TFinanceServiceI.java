package jeecg.demo.service.test;

import jeecg.demo.entity.test.TFinanceEntity;
import jeecg.demo.entity.test.TFinanceFilesEntity;

import org.jeecgframework.core.common.service.CommonService;

public interface TFinanceServiceI extends CommonService{

	void deleteFile(TFinanceFilesEntity file);

	void deleteFinance(TFinanceEntity finance);

}
