package org.jeecgframework.web.demo.service.impl.test;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import org.jeecgframework.web.demo.service.test.JeecgNoteServiceI;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;

@Service("jeecgNoteService")
@Transactional
public class JeecgNoteServiceImpl extends CommonServiceImpl implements JeecgNoteServiceI {
	
}