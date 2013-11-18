package jeecg.rest.core;

import org.restlet.Application;
import org.restlet.Restlet;
import org.restlet.routing.Router;

/**
 * @Title: Action
 * @Description: 动态部署rest webService
 * @author yankang
 * @date 2013-09-20 22:27:30
 * @version V1.0
 */
public class BaseRestApplication extends Application {
	/**
	 * 设置路由动态将rest webService 部署到servle容器
	 */
	public synchronized Restlet createInboundRoot() {
		//获取路由
		Router router = new Router(getContext());
		//设置默认路由
        //设置初始服务
		BaseServiceInit.attachResources(router);
		JsonPFilter jsonpFilter = new JsonPFilter(getContext());
		jsonpFilter.setNext(router);
		return jsonpFilter;
	}
	
   
}
