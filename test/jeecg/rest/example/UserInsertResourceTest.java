package jeecg.rest.example;

import java.io.IOException;

import jeecg.system.pojo.base.TSDepart;
import jeecg.system.pojo.base.TSUser;
import junit.framework.TestCase;

import org.junit.Test;
import org.restlet.data.Form;
import org.restlet.representation.Representation;
import org.restlet.resource.ClientResource;

public class UserInsertResourceTest extends TestCase {
	
	@Test
	public void testInsert(){
        ClientResource clientResource = new ClientResource(
                "http://127.0.0.1:8080/jeecg-v3-simple/services/user/inserts");
       TSUser  tsUser=new TSUser();
       tsUser.setUserName("ykpb	");
       tsUser.setPassword("ykzy");
       TSDepart  tsDepart=new TSDepart();
       tsDepart.setId("4028811e4152ef07014152f0d1dd0016");
       tsUser.setTSDepart(tsDepart);
        try {
        	 Representation r = clientResource.put(getRepresentation(tsUser));
     		 System.out.println(r.getText());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	 public static Representation getRepresentation(TSUser tsUser) {
	        Form form = new Form();
	        form.add("userName", tsUser.getUserName());
	        form.add("password", tsUser.getPassword());
	        form.add("output","json");
	        form.add("deptId",tsUser.getTSDepart().getId());
	        return form.getWebRepresentation();
	    }

}
