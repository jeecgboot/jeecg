package jeecg.demo.service.impl.test;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jeecg.demo.service.test.JpPersonServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;

@Service("jpPersonService")
@Transactional
public class JpPersonServiceImpl extends CommonServiceImpl implements JpPersonServiceI {
	
}