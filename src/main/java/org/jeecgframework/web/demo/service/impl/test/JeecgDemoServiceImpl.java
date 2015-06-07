package org.jeecgframework.web.demo.service.impl.test;

import org.jeecgframework.web.demo.service.test.JeecgDemoServiceI;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;


@Service("jeecgDemoService")
@Transactional
public class JeecgDemoServiceImpl extends CommonServiceImpl implements JeecgDemoServiceI {
	
}
