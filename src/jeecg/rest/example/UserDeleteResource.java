package jeecg.rest.example;


import jeecg.system.pojo.base.TSUser;
import jeecg.system.service.UserService;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ObjectNode;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.restlet.data.Form;
import org.restlet.representation.Representation;
import org.restlet.resource.Delete;
import org.restlet.resource.Get;
import org.restlet.resource.Post;
import org.restlet.resource.ServerResource;
/**
 * @Title: UserDeleteResource
 * @Description: 删除用户信息rest
 * @author yankang
 * @date 2013-09-20 22:27:30
 * @version V1.0
 */
public class UserDeleteResource extends ServerResource {
	private UserService userService = (UserService) ApplicationContextUtil
			.getContext().getBean("userService");

	
	@Post
	@Get
	@Delete
	public ObjectNode deleteUserById(Representation entity) {
		ObjectNode modelNode = null;
		ObjectMapper objectMapper = new ObjectMapper();
		modelNode = objectMapper.createObjectNode();
		 Form form = new Form(entity);
			String output = form.getFirstValue("output");
		String id = form.getFirstValue("userId");
		TSUser tsUser = userService.get(TSUser.class, id);
		try {
			userService.delete(tsUser);
			if (output != null && output.equals("json")) {
				modelNode.put("success", "true");
			}
			if (output != null && output.equals("xml")) {
				modelNode.put("success", "true");
			}
		} catch (Exception e) {
			if (output != null && output.equals("json")) {
				modelNode.put("success", "false");
			}
			if (output != null && output.equals("xml")) {
				modelNode.put("success", "false");
			}
		}
		return modelNode;
	}
}
