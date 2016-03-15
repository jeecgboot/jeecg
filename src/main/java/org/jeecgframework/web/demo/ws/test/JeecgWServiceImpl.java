package org.jeecgframework.web.demo.ws.test;

public class JeecgWServiceImpl implements JeecgWServiceI {

	@Override
	public String say(String context) {
		// TODO Auto-generated method stub
		return "you say context:"+context;
	}

	@Override
	public String sayHello() {
		// TODO Auto-generated method stub
		return "sayHello";
	}

	@Override
	public void sayUI() {
		// TODO Auto-generated method stub
		System.out.println("UI");
	}

}
