package jeecg.demo.service.test;

import java.util.List;

import jeecg.demo.entity.test.JeecgOrderCustomEntity;
import jeecg.demo.entity.test.JeecgOrderMainEntity;
import jeecg.demo.entity.test.JeecgOrderProductEntity;

import org.jeecgframework.core.common.service.CommonService;


public interface JeecgOrderMainServiceI extends CommonService{
	/**
	 * 添加一对多
	 * 
	 */
	public void addMain(JeecgOrderMainEntity jeecgOrderMain,List<JeecgOrderProductEntity> jeecgOrderProducList,List<JeecgOrderCustomEntity> jeecgOrderCustomList) ;
	/**
	 * 修改一对多
	 * 
	 */
	public void updateMain(JeecgOrderMainEntity jeecgOrderMain,List<JeecgOrderProductEntity> jeecgOrderProducList,List<JeecgOrderCustomEntity> jeecgOrderCustomList,boolean jeecgOrderCustomShow) ;
	public void delMain (JeecgOrderMainEntity jeecgOrderMain);
}
