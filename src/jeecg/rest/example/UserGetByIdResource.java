package jeecg.rest.example;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import jeecg.rest.utils.Utils;
import jeecg.system.pojo.base.TSUser;
import jeecg.system.service.UserService;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ObjectNode;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.restlet.resource.Get;
import org.restlet.resource.ServerResource;
/**
 * @Title: UserDeleteResource
 * @Description: 查询用户信息rest
 * @author yankang
 * @date 2013-09-20 22:27:30
 * @version V1.0
 */
public class UserGetByIdResource extends ServerResource {

	private UserService userService = (UserService) ApplicationContextUtil
			.getContext().getBean("userService");

	@Get
	public ObjectNode getById() {
		ObjectNode modelNode = null;
		ObjectMapper objectMapper = new ObjectMapper();
		modelNode = objectMapper.createObjectNode();
		String output = (String) getRequest().getAttributes().get("output");
		String id = (String) getRequest().getAttributes().get("userId");
		TSUser  tsUser=userService.get(TSUser.class, id);
		Map<String, String> excludeProperty=new HashMap<String, String>();
		excludeProperty.put("TSDepart", "TSDepart");
		if (output != null && output.equals("json")) {
			modelNode.put("result",Utils.toSingleJson(tsUser, TSUser.class, excludeProperty).toString() );
		}
		if (output != null && output.equals("xml")) {
			try {
				modelNode.put("result",Utils.toSingleXml(tsUser, TSUser.class, excludeProperty).getText() );
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
		return modelNode;
	}

}
