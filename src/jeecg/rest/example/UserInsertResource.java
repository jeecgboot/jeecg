package jeecg.rest.example;

import java.io.IOException;

import jeecg.system.pojo.base.TSDepart;
import jeecg.system.pojo.base.TSUser;
import jeecg.system.service.UserService;

import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.node.ObjectNode;
import org.jeecgframework.core.util.ApplicationContextUtil;
import org.restlet.data.Form;
import org.restlet.data.MediaType;
import org.restlet.ext.xml.DomRepresentation;
import org.restlet.representation.Representation;
import org.restlet.resource.Put;
import org.restlet.resource.ServerResource;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
/**
 * @Title: UserDeleteResource
 * @Description: 添加用户信息rest
 * @author yankang
 * @date 2013-09-20 22:27:30
 * @version V1.0
 */
public class UserInsertResource extends ServerResource {
	private UserService userService=(UserService)ApplicationContextUtil.getContext().getBean("userService");
	
//	@Get
//	public ObjectNode getById() {
//		ObjectNode modelNode = null;
//		ObjectMapper objectMapper = new ObjectMapper();
//		modelNode = objectMapper.createObjectNode();
//		String output = (String) getRequest().getAttributes().get("output");
//		TSUser tsUser=new TSUser();
//		tsUser.setUserName((String) getRequest().getAttributes().get("userName"));
//		tsUser.setPassword((String) getRequest().getAttributes().get("password"));
//		TSDepart  depart=new TSDepart();
//		depart.setId((String) getRequest().getAttributes().get("deptId"));
//		tsUser.setTSDepart(depart);
//		try{
//			userService.save(tsUser);
//			if (output != null && output.equals("json")) {
//				modelNode.put("success", "true");
//			}
//			if (output != null && output.equals("xml")) {
//				modelNode.put("success", "true");
//			}
//		}
//		catch (Exception e) {
//			if (output != null && output.equals("json")) {
//				modelNode.put("success", "false");
//			}
//			if (output != null && output.equals("xml")) {
//				modelNode.put("success", "false");
//			}
//		}
//		Map<String, String> excludeProperty=new HashMap<String, String>();
//		excludeProperty.put("TSDepart", "TSDepart");
//	
//		return modelNode;
//	}
	
//	@Post
//	@Get
//	public Representation getById(Representation entity) {
//		
//		Representation result = null;
//		ObjectMapper objectMapper = new ObjectMapper();
//		
//		 Form form = new Form(entity);
//	     String itemName = form.getFirstValue("name");
//	        String itemDescription = form.getFirstValue("description");
//		String output = form.getFirstValue("output");
//		TSUser tsUser=new TSUser();
//		tsUser.setUserName(form.getFirstValue("userName"));
//		tsUser.setPassword(form.getFirstValue("password"));
//		TSDepart  depart=new TSDepart();
//		depart.setId(form.getFirstValue("deptId"));
//		tsUser.setTSDepart(depart);
//		
//		try{
//			userService.save(tsUser);
//			if (output != null && output.equals("json")) {
//				return generateJsonRepresentation("true","");
//			}
//			if (output != null && output.equals("xml")) {
//				return generateXmlRepresentation("true","");
//			}
//		}
//		catch (Exception e) {
//			if (output != null && output.equals("json")) {
//				return generateJsonRepresentation("false",e.getMessage());
//			}
//			if (output != null && output.equals("xml")) {
//				return generateXmlRepresentation("false",e.getMessage());
//			}
//		}
//		return result;
//	}
	
	 @Put()
	public ObjectNode insert(Representation entity) {
		ObjectNode modelNode = null;
		ObjectMapper objectMapper = new ObjectMapper();
		 Form form = new Form(entity);
		String output = form.getFirstValue("output");
		TSUser tsUser=new TSUser();
		tsUser.setUserName(form.getFirstValue("userName"));
		tsUser.setPassword(form.getFirstValue("password"));
		TSDepart  depart=new TSDepart();
		depart.setId(form.getFirstValue("deptId"));
		tsUser.setTSDepart(depart);
		modelNode = objectMapper.createObjectNode();
		tsUser.setTSDepart(depart);
		try{
			userService.save(tsUser);
			if (output != null && output.equals("json")) {
				modelNode.put("success", "true");
			}
			if (output != null && output.equals("xml")) {
				modelNode.put("success", "true");
			}
		}
		catch (Exception e) {
			if (output != null && output.equals("json")) {
				modelNode.put("success", "false");
			}
			if (output != null && output.equals("xml")) {
				modelNode.put("success", "false");
			}
		}
		
//	
		return modelNode;
	}
	
    private Representation generateXmlRepresentation(String xmlResult,
            String errorCode) {
        DomRepresentation result = null;
        // This is an error
        // Generate the output representation
        try {
            result = new DomRepresentation(MediaType.TEXT_XML);
            // Generate a DOM document representing the list of
            // items.
            Document d = result.getDocument();

            Element eltResult = d.createElement("result");

            Element eltCode = d.createElement("success");
            eltCode.setTextContent(xmlResult);
            eltResult.appendChild(eltCode);
            
            Element eltMessage = d.createElement("message");
            eltMessage.setTextContent(errorCode);
            eltResult.appendChild(eltMessage);
        } catch (IOException e) {
            e.printStackTrace();
        }

        return result;
    }
//    private Representation generateJsonRepresentation(String jsonResult,
//            String errorCode) {
////        JsonRepresentation result = null;
////        // This is an error
////        // Generate the output representation
////        JSONObject jsonObject = new JSONObject();
////        try {
////           jsonObject.put("success", jsonResult);
////           if(errorCode!=null){
////        	   jsonObject.put("error", errorCode);
////           }
////        } catch (JSONException e) {
////			// TODO Auto-generated catch block
////			e.printStackTrace();
////		}
////
////        return new JsonRepresentation(jsonObject);
//    }

}
