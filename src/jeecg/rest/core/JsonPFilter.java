package jeecg.rest.core;

import org.restlet.routing.Filter;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import org.restlet.Context;
import org.restlet.Request;
import org.restlet.Response;
import org.restlet.data.MediaType;
import org.restlet.data.Status;
import org.restlet.representation.Representation;
import org.restlet.representation.StringRepresentation;

/**
 * @Title: Action
 * @Description: rest json 数据过滤
 * @author yankang
 * @date 2013-09-20 22:27:30
 * @version V1.0
 */
public class JsonPFilter extends Filter {

	public JsonPFilter(Context context) {
		super(context);
	}

	public JsonPFilter() {
	}

	@Override
	protected void afterHandle(Request request, Response response) {
		String jsonp = request.getResourceRef().getQueryAsForm().getFirstValue(
				"callback");

		if (jsonp != null) {
			StringBuilder stringBuilder = new StringBuilder(jsonp);
			stringBuilder.append("(");

			if ((response.getStatus().getCode() >= 300)) {
				stringBuilder.append("{code:");
				stringBuilder.append(response.getStatus().getCode());
				stringBuilder.append(",msg:'");
				stringBuilder.append(response.getStatus().getDescription()
						.replace("'", "\\'"));
				stringBuilder.append("'}");
				response.setStatus(Status.SUCCESS_OK);
			} else {
				Representation representation = response.getEntity();
				if (representation != null) {
					try {
						InputStream is = representation.getStream();
						if (is != null) {
							ByteArrayOutputStream bos = new ByteArrayOutputStream();
							byte[] buf = new byte[0x10000];
							int len;
							while ((len = is.read(buf)) > 0) {
								bos.write(buf, 0, len);
							}
							stringBuilder.append(bos.toString("UTF-8"));
						} else {
							response.setStatus(Status.SERVER_ERROR_INTERNAL,
									"NullPointer in Jsonp filter");
						}
					} catch (IOException e) {
						response.setStatus(Status.SERVER_ERROR_INTERNAL, e
								.getMessage());
					}
				}
			}

			stringBuilder.append(");");
			response.setEntity(new StringRepresentation(stringBuilder
					.toString(), MediaType.TEXT_JAVASCRIPT));
		}
	}

}
