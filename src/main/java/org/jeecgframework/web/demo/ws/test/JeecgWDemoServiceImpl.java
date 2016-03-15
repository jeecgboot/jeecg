package org.jeecgframework.web.demo.ws.test;

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
		System.out.println("UI demo");
	}

}
