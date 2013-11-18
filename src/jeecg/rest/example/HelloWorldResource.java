package jeecg.rest.example;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ObjectNode;
import org.restlet.resource.Get;
import org.restlet.resource.ServerResource;

/**
 * @Title: HelloWorldResource
 * @Description: rest webService 例子
 * @author yankang
 * @date 2013-09-20 22:27:30
 * @version V1.0
 */
public class HelloWorldResource extends ServerResource {
	@Get
	public ObjectNode represent() {
		ObjectNode modelNode = null;
		try {
			ObjectMapper objectMapper = new ObjectMapper();
			modelNode = objectMapper.createObjectNode();
			modelNode.put("node", "false");
		} catch (Exception e) {
			e.printStackTrace();
		}

		return modelNode;
	}

}
