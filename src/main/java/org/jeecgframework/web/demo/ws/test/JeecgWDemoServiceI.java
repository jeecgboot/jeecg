package org.jeecgframework.web.demo.ws.test;

import javax.jws.WebService;

@WebService
public interface JeecgWDemoServiceI {

	public String say(String context);
	
	public String sayHello();
	
	public void sayUI();
	
	
}
