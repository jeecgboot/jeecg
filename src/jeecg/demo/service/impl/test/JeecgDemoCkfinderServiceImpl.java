package jeecg.demo.service.impl.test;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jeecg.demo.service.test.JeecgDemoCkfinderServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;

@Service("jeecgDemoCkfinderService")
@Transactional
public class JeecgDemoCkfinderServiceImpl extends CommonServiceImpl implements
		JeecgDemoCkfinderServiceI {

}