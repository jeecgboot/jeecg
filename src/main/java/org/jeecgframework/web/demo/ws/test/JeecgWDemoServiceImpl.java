package org.jeecgframework.web.demo.ws.test;

import org.jeecgframework.core.util.LogUtil;

/**
 * cxf客户端请求地址：http://localhost:8080/jeecg/cxf/JeecgWService
 * @author zhangdaihao
 *
 */
public class JeecgWDemoServiceImpl implements JeecgWServiceI {

	@Override
	public String say(String context) {
		// TODO Auto-generated method stub
		return "you say context demo:"+context;
	}

	@Override
	public String sayHello() {
		// TODO Auto-generated method stub
		return "sayHello demo";
	}

	@Override
	public void sayUI() {
		// TODO Auto-generated method stub
		LogUtil.info("UI demo");
	}

}
