package jeecg.rest.example;

import java.io.IOException;
import jeecg.system.pojo.base.TSUser;
import junit.framework.TestCase;
import org.junit.Test;
import org.restlet.data.Form;
import org.restlet.representation.Representation;
import org.restlet.resource.ClientResource;

public class UserDeleteResourceTest extends TestCase {
	@Test
	public void testDelete() {
		ClientResource clientResource = new ClientResource(
				"http://127.0.0.1:8080/jeecg-v3-simple/services/user/delById");
		TSUser tsUser = new TSUser();
		tsUser.setId("402881e3419752df0141975476490000");
		try {
			Representation r = clientResource.post(getRepresentation(tsUser));
			System.out.println(r.getText());

		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static Representation getRepresentation(TSUser tsUser) {
		Form form = new Form();
		form.add("output", "json");
		form.add("userId", tsUser.getId());
		return form.getWebRepresentation();
	}
}
