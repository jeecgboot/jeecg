package jeecg.rest.example;

import java.io.IOException;
import junit.framework.TestCase;
import org.restlet.data.Form;
import org.restlet.representation.Representation;
import org.restlet.resource.ClientResource;


public class UserQueryResourceTest extends TestCase {

	@org.junit.Test
	public void testGets() {
		ClientResource clientResource = new ClientResource(
				"http://127.0.0.1:8080/jeecg-v3-simple/services/user/getUsers");
		try {
			Representation r = clientResource.post(getRepresentation());
			System.out.println(r.getText());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static Representation getRepresentation() {
		Form form = new Form();
		form.add("output", "json");
		return form.getWebRepresentation();
	}

}
