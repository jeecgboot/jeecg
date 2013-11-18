package jeecg.demo.service.impl.test;

import java.util.Date;

import org.springframework.stereotype.Service;

import jeecg.demo.service.test.TaskDemoServiceI;
@Service("taskDemoService")
public class TaskDemoServiceImpl implements TaskDemoServiceI {

	@Override
	public void work() {
		System.out.println(new Date().getTime());
		System.out.println("----------任务测试-------");
	}

}
