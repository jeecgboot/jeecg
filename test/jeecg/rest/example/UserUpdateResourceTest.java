package jeecg.rest.example;

import java.io.IOException;

import javax.resource.ResourceException;

import jeecg.system.pojo.base.TSDepart;
import jeecg.system.pojo.base.TSUser;

import org.junit.Test;
import org.restlet.data.Form;
import org.restlet.representation.Representation;
import org.restlet.resource.ClientResource;

import junit.framework.TestCase;

public class UserUpdateResourceTest extends TestCase {

	@Test
	public void testUpdate() {
		// Define our Restlet client resources.
		ClientResource clientResource = new ClientResource(
				"http://127.0.0.1:8080/jeecg-v3-simple/services/user/updateById");
		TSUser tsUser = new TSUser();
		tsUser.setUserName("ykpb	");
		tsUser.setPassword("ykzy");
		TSDepart tsDepart = new TSDepart();
		tsDepart.setId("4028811e4152ef07014152f0d1dd0016");
		tsUser.setId("402881e3415ed86001415edc916c0002");

		// Consume the response's entity which releases the connection
		try {
			Representation r = clientResource.put(getRepresentation(tsUser));
			System.out.println(r.getText());

		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	public static Representation getRepresentation(TSUser tsUser) {
		// Gathering informations into a Web form.
		Form form = new Form();
		form.add("userName", tsUser.getUserName());
		form.add("password", tsUser.getPassword());
		form.add("output", "json");
		form.add("userId", tsUser.getId());
		return form.getWebRepresentation();
	}

}
