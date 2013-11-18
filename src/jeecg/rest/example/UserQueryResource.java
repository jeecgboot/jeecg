package jeecg.rest.example;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jeecg.rest.utils.Utils;
import jeecg.system.pojo.base.TSUser;
import jeecg.system.service.UserService;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ObjectNode;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.restlet.data.Form;
import org.restlet.representation.Representation;
import org.restlet.resource.Post;
import org.restlet.resource.ServerResource;
import org.springframework.beans.factory.annotation.Autowired;
/**
 * @Title: UserDeleteResource
 * @Description: 查询用户信息rest
 * @author yankang
 * @date 2013-09-20 22:27:30
 * @version V1.0
 */
public class UserQueryResource extends ServerResource {
	
	private UserService userService=(UserService)ApplicationContextUtil.getContext().getBean("userService");
	
	@Post
	public ObjectNode getList(Representation entity) {
		ObjectNode modelNode = null;
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			modelNode = objectMapper.createObjectNode();
			List<Object> listUsers=userService.getList(TSUser.class);
			StringBuffer  sb=new StringBuffer();
			Form form = new Form(entity);
			String output = form.getFirstValue("output");
			Map<String, String> exludeProperty=new HashMap<String, String>();
			exludeProperty.put("TSDepart", "TSDepart");
			if(output!=null&&output.equals("json")){
				modelNode.put("result", Utils.toJson(listUsers, TSUser.class,exludeProperty).toString());
				modelNode.put("size", listUsers.size());
			}
			if(output!=null&&output.equals("xml")){
				modelNode.put("result", Utils.toXml(listUsers, TSUser.class,exludeProperty).getText());
				modelNode.put("size", listUsers.size());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

		return modelNode;
	}

	public UserService getUserService() {
		return userService;
	}
	@Autowired
	public void setUserService(UserService userService) {
		this.userService = userService;
	}

//	@Autowired
//	public SystemService getSystemService() {
//		return systemService;
//	}
//
//
//	public void setSystemService(SystemService systemService) {
//		this.systemService = systemService;
//	}

}
