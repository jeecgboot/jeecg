package jeecg.rest.core;

import jeecg.rest.example.HelloWorldResource;
import jeecg.rest.example.UserDeleteResource;
import jeecg.rest.example.UserGetByIdResource;
import jeecg.rest.example.UserInsertResource;
import jeecg.rest.example.UserQueryResource;
import jeecg.rest.example.UserUpdateResource;

import org.restlet.routing.Router;

/**
 * @Title: Action
 * @Description: 设置初始化路由rest 服务
 * @author yankang
 * @date 2013-09-20 22:27:30
 * @version V1.0
 */
public class BaseServiceInit {
	public static void attachResources(Router router) {
		router.attach("/helloWorld", HelloWorldResource.class);
		router.attach("/user/gets/{output}",UserQueryResource.class);
		router.attach("/user/delete/{output}/{userId}",UserDeleteResource.class);
		router.attach("/user/getById/{output}/{userId}",UserGetByIdResource.class);
		router.attach("/user/insert/{output}/{userName}/{password}/{deptId}",UserInsertResource.class);
		router.attach("/user/inserts",UserInsertResource.class);
		router.attach("/user/delById",UserDeleteResource.class);
		router.attach("/user/updateById",UserUpdateResource.class);
		router.attach("/user/getUsers",UserQueryResource.class);
		router.attach("/user/update/{output}/{userName}/{password}/{userId}",UserUpdateResource.class);
	}
}
