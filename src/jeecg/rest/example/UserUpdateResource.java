package jeecg.rest.example;

import java.util.HashMap;
import java.util.Map;
import jeecg.system.pojo.base.TSUser;
import jeecg.system.service.UserService;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ObjectNode;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.restlet.data.Form;
import org.restlet.representation.Representation;
import org.restlet.resource.Put;
import org.restlet.resource.ServerResource;
/**
 * @Title: UserDeleteResource
 * @Description: 修改用户信息rest
 * @author yankang
 * @date 2013-09-20 22:27:30
 * @version V1.0
 */
public class UserUpdateResource extends ServerResource {
	private UserService userService = (UserService) ApplicationContextUtil
			.getContext().getBean("userService");

	@Put
	public ObjectNode update(Representation entity) {
		ObjectNode modelNode = null;
		ObjectMapper objectMapper = new ObjectMapper();
		modelNode = objectMapper.createObjectNode();
		Form form = new Form(entity);
		String output = form.getFirstValue("output");
		String id = form.getFirstValue("userId");

		TSUser tsUser = userService.get(TSUser.class, id);
		tsUser.setUserName(form.getFirstValue("userName"));
		tsUser.setPassword(form.getFirstValue("password"));
		try {
			userService.updateEntitie(tsUser);
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
		Map<String, String> excludeProperty = new HashMap<String, String>();
		excludeProperty.put("TSDepart", "TSDepart");

		return modelNode;
	}

}
