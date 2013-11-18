package jeecg.rest.example;

import java.io.IOException;

import junit.framework.TestCase;
import org.restlet.Client;
import org.restlet.Request;
import org.restlet.Response;
import org.restlet.data.Method;
import org.restlet.data.Protocol;
import org.restlet.representation.Representation;
import org.restlet.resource.ResourceException;

public class HelloWorldResourceTest extends TestCase {

	@org.junit.Test
	public void testExample() {
		Request request = new Request(Method.GET,
				"http://localhost:8080/jeecg-v3-simple/services/helloWorld");
		try {
			Client client = new Client(Protocol.HTTP);
			Response response = client.handle(request);
			Representation output = response.getEntity();
			output.write(System.out);

		} catch (ResourceException e) {
			System.out.println("Error  status: " + e.getStatus());
			System.out.println("Error message: " + e.getMessage());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

}
